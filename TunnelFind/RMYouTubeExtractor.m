//
//  RMYouTubeExtractor.m
//


#import "RMYouTubeExtractor.h"
#import <AVFoundation/AVFoundation.h>

@interface RMYouTubeExtractor ()

@property (nonatomic, assign) RMYouTubeExtractorAttemptType attemptType;

@end

static NSDictionary *DictionaryWithQueryString(NSString *string, NSStringEncoding encoding) {
	NSMutableDictionary *dictionary = [NSMutableDictionary new];
	NSArray *fields = [string componentsSeparatedByString:@"&"];
	for (NSString *field in fields) {
		NSArray *pair = [field componentsSeparatedByString:@"="];
		if ([pair count] == 2) {
			NSString *key = pair[0];
			NSString *value = [pair[1] stringByReplacingPercentEscapesUsingEncoding:encoding];
			value = [value stringByReplacingOccurrencesOfString:@"+" withString:@" "];
			dictionary[key] = value;
		}
	}
	return dictionary;
}

static NSString *ApplicationLanguageIdentifier(void)
{
	static NSString *applicationLanguageIdentifier;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		applicationLanguageIdentifier = @"en";
		NSArray *preferredLocalizations = [[NSBundle mainBundle] preferredLocalizations];
		if (preferredLocalizations.count > 0)
			applicationLanguageIdentifier = [NSLocale canonicalLanguageIdentifierFromString:preferredLocalizations[0]] ?: applicationLanguageIdentifier;
	});
	return applicationLanguageIdentifier;
}

@implementation RMYouTubeExtractor

+ (RMYouTubeExtractor *)sharedInstance {
    static RMYouTubeExtractor *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [RMYouTubeExtractor new];
    });
    return _sharedInstance;
}

-(NSArray*)preferredVideoQualities {
    return @[ @(RMYouTubeExtractorVideoQualityHD1080), 
              @(RMYouTubeExtractorVideoQualityHD720),
              @(RMYouTubeExtractorVideoQualityMedium360),
              @(RMYouTubeExtractorVideoQualitySmall240) ];
}

-(void)extractVideoForIdentifier:(NSString*)videoIdentifier completion:(void (^)(NSDictionary *videoDictionary, NSError *error))completion {
    if (videoIdentifier && [videoIdentifier length] > 0) {
        if (self.attemptType == RMYouTubeExtractorAttemptTypeError) {
            NSError *error = [NSError errorWithDomain:@"com.theappboutique.rmyoutubeextractor" code:404 userInfo:@{ NSLocalizedFailureReasonErrorKey : @"Unable to find playable content" }];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            self.attemptType = RMYouTubeExtractorAttemptTypeEmbedded;
            return;
        }
        NSMutableDictionary *parameters = [@{} mutableCopy];
        switch (self.attemptType) {
            case RMYouTubeExtractorAttemptTypeEmbedded:
                parameters[@"el"] = @"embedded";
                break;
            case RMYouTubeExtractorAttemptTypeDetailPage:
                parameters[@"el"] = @"detailpage";
                break;
            case RMYouTubeExtractorAttemptTypeVevo:
                parameters[@"el"] = @"vevo";
                break;
            case RMYouTubeExtractorAttemptTypeBlank:
                parameters[@"el"] = @"";
                break;
            default:
                break;
        }
        parameters[@"video_id"] = videoIdentifier;
        parameters[@"ps"] = @"default";
        parameters[@"eurl"] = @"";
        parameters[@"gl"] = @"US";
        parameters[@"hl"] = ApplicationLanguageIdentifier();
        
        NSString *urlString = [self addQueryStringToUrlString:@"https://www.youtube.com/get_video_info" withParamters:parameters];
        
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithURL:[NSURL URLWithString:urlString]
               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                   if (!error) {
                       NSString *videoQuery = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                       NSStringEncoding queryEncoding = NSUTF8StringEncoding;
                       NSDictionary *video = DictionaryWithQueryString(videoQuery, queryEncoding);
                       NSMutableArray *streamQueries = [[video[@"url_encoded_fmt_stream_map"] componentsSeparatedByString:@","] mutableCopy];
                       [streamQueries addObjectsFromArray:[video[@"adaptive_fmts"] componentsSeparatedByString:@","]];
                       
                       NSMutableDictionary *streamURLs = [NSMutableDictionary new];
                       for (NSString *streamQuery in streamQueries) {
                           NSDictionary *stream = DictionaryWithQueryString(streamQuery, queryEncoding);
                           NSString *type = stream[@"type"];
                           NSString *urlString = stream[@"url"];
                           if (urlString && [AVURLAsset isPlayableExtendedMIMEType:type]) {
                               NSURL *streamURL = [NSURL URLWithString:urlString];
                               NSString *signature = stream[@"sig"];
                               if (signature) {
                                   streamURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@&signature=%@", urlString, signature]];
                               }
                               if ([[DictionaryWithQueryString(streamURL.query, queryEncoding) allKeys] containsObject:@"signature"]) {
                                   streamURLs[@([stream[@"itag"] integerValue])] = streamURL;
                               }
                           }
                       }
                       
                       BOOL contentIsAvailable = NO;
                       
                       NSMutableDictionary *videoDictionary = [@{} mutableCopy];
                       for (NSNumber *videoQuality in [self preferredVideoQualities]) {
                           videoDictionary[videoQuality] = [NSNull null];
                           NSURL *streamURL = streamURLs[videoQuality];
                           if (streamURL) {
                               videoDictionary[videoQuality] = streamURL;
                               contentIsAvailable = YES;
                           }
                       }
                       
                       self.attemptType++;
                       
                       if (!contentIsAvailable) {
                           [self extractVideoForIdentifier:videoIdentifier completion:completion];
                       } else {
                           dispatch_async(dispatch_get_main_queue(), ^{
                               completion(videoDictionary, nil);
                           });
                       }
                       
                   } else {
                       dispatch_async(dispatch_get_main_queue(), ^{
                           completion(nil, error);
                       });
                   }
               }
         ] resume];
    } else {
        NSError *error = [NSError errorWithDomain:@"com.mactech.YouTubeChannel" code:400 userInfo:@{ NSLocalizedFailureReasonErrorKey : @"Invalid or missing YouTube video identifier" }];
        completion(nil, error);
    }
}

- (NSString*)urlEscapeString:(NSString *)unencodedString {
    CFStringRef originalStringRef = (__bridge_retained CFStringRef)unencodedString;
    NSString *string = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,originalStringRef, NULL, NULL,kCFStringEncodingUTF8);
    CFRelease(originalStringRef);
    return string;
}


- (NSString*)addQueryStringToUrlString:(NSString *)urlString withParamters:(NSDictionary *)dictionary {
    NSMutableString *urlWithQuerystring = [[NSMutableString alloc] initWithString:urlString];
    for (id key in dictionary) {
        NSString *keyString = [key description];
        NSString *valueString = [[dictionary objectForKey:key] description];
        
        if ([urlWithQuerystring rangeOfString:@"?"].location == NSNotFound) {
            [urlWithQuerystring appendFormat:@"?%@=%@", [self urlEscapeString:keyString], [self urlEscapeString:valueString]];
        } else {
            [urlWithQuerystring appendFormat:@"&%@=%@", [self urlEscapeString:keyString], [self urlEscapeString:valueString]];
        }
    }
    return urlWithQuerystring;
}

@end
