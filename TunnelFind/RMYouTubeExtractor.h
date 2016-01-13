//
//  RMYouTubeExtractor.h
//

@import AVFoundation;



typedef NS_ENUM (NSUInteger, RMYouTubeExtractorAttemptType) {
	RMYouTubeExtractorAttemptTypeEmbedded = 0,
	RMYouTubeExtractorAttemptTypeDetailPage,
    RMYouTubeExtractorAttemptTypeVevo,
    RMYouTubeExtractorAttemptTypeBlank,
    RMYouTubeExtractorAttemptTypeError
};

typedef NS_ENUM (NSUInteger, RMYouTubeExtractorVideoQuality) {
	RMYouTubeExtractorVideoQualitySmall240  = 36,
	RMYouTubeExtractorVideoQualityMedium360 = 18,
	RMYouTubeExtractorVideoQualityHD720     = 22,
	RMYouTubeExtractorVideoQualityHD1080    = 37,
};

@interface RMYouTubeExtractor : NSObject

+(RMYouTubeExtractor*)sharedInstance;

-(void)extractVideoForIdentifier:(NSString*)videoIdentifier completion:(void (^)(NSDictionary *videoDictionary, NSError *error))completion;

-(NSArray*)preferredVideoQualities;

@end
