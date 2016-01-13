//
//  MIYouTubeChannelViewController.m
//  YoutubeChannel 
//
//  Created by Istvan Szabo on 2013.04.22..
//  Copyright (c) 2013 Istvan Szabo. All rights reserved.
//

#import "MIYouTubeChannelViewController.h"

#import "YouTubeCell.h"
#import "Reachability.h"
#import "ISCache.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "RMYouTubeExtractor.h"


#define CHANNEL_TITLE @"Coaching videos"
#define ACCESSORY_COLOR [UIColor greenColor]
#define ACCESSORY_COLOR_HIGHLIGHTED [UIColor whiteColor]

/*
 
 YouTube v3 api, create api key in Google Developer Consol
 
 How to find the channel videos: https://www.youtube.com/watch?v=RjUlmco7v2M
 
 Link format: https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId={CHANNEL_UPLOAD_ID}&key={YOUR_API_KEY}
 
 */


#define API_V3_CHANNEL_URL @"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=UURMuURAjbzBaQKcfWw5ZC6A&key=AIzaSyDLGIH6-AFbAopcvBZUqA0uBZx0ph-xrDg"


@interface MIYouTubeChannelViewController ()



@end

@implementation MIYouTubeChannelViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchEntries];
     self.title = CHANNEL_TITLE;
    [self.refreshControl addTarget:self action:@selector(refreshInvoked:forState:) forControlEvents:UIControlEventValueChanged];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)fetchEntries
{
        NSString *searchURL = [API_V3_CHANNEL_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSData *searchData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL]];
        NSDictionary *searchDict =[NSJSONSerialization JSONObjectWithData:searchData options:NSJSONReadingMutableContainers error:nil];
        self.readArray = [searchDict objectForKey:@"items"];

}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.readArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    
    YouTubeCell *cell = (YouTubeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    NSDictionary *searchResult = [self.readArray objectAtIndex:indexPath.row];
    
    cell.ytTitle.text = [[searchResult objectForKey:@"snippet"] valueForKey:@"title"];
    
    NSString *imageHD = [[[[searchResult objectForKey:@"snippet"] objectForKey:@"thumbnails"] objectForKey:@"high"] valueForKey:@"url"];
   
    
    NSURL *imageURL = [NSURL URLWithString:imageHD];
	NSString *key = imageHD;
	NSData *data = [ISCache objectForKey:key];
	if (data) {
		UIImage *image = [UIImage imageWithData:data];
		cell.ytThumbnail.image = image;
	} else {
		cell.ytThumbnail.image = [UIImage imageNamed:@"hqdefault.jpg"];
		dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
		dispatch_async(queue, ^{
			NSData *data = [NSData dataWithContentsOfURL:imageURL];
			[ISCache setObject:data forKey:key];
			UIImage *image = [UIImage imageWithData:data];
			dispatch_sync(dispatch_get_main_queue(), ^{
				cell.ytThumbnail.image = image;
			});
		});
	}
    
    NSString *dateString = [[searchResult objectForKey:@"snippet"] valueForKey:@"publishedAt"];
    cell.ytDate.text = [dateString substringToIndex:([[[searchResult objectForKey:@"snippet"] valueForKey:@"publishedAt"] length] - 14)];
    cell.ytAuthor.text = CHANNEL_TITLE;
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *searchResult = [self.readArray objectAtIndex:indexPath.row];
    NSString *videoID =[[[searchResult objectForKey:@"snippet"] objectForKey:@"resourceId"] valueForKey:@"videoId"];
    
    [[RMYouTubeExtractor sharedInstance] extractVideoForIdentifier:videoID
                                                        completion:^(NSDictionary *videoDictionary, NSError *error) {
                                                            if (!error) {
                                                                NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[[videoDictionary allKeys] count]];
                                                                for (NSString *key in videoDictionary) {
                                                                    if (videoDictionary[key] != [NSNull null]) {
                                                                        [mutableArray addObject:@{ @"quality" : key, @"url" : videoDictionary[key] }];
                                                                        
                                                                          }
                                                                    
                                                                    }
                                                                
                                                                _qualityString = [[[mutableArray copy] objectAtIndex:1] valueForKey:@"url"];
                                                                [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(loadPlayer) userInfo:nil repeats:NO];
                                                                
                                                               
                                                            } else {
                                                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An Error Occurred"
                                                                                                                    message:[error localizedFailureReason]
                                                                                                                   delegate:nil
                                                                                                          cancelButtonTitle:nil
                                                                                                          otherButtonTitles:@"OK", nil];
                                                                [alertView show];
                                                            }
                                                        }];
    
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    NSError *setCategoryError = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    if (setCategoryError) {  }
    
    NSError *activationError = nil;
    [audioSession setActive:YES error:&activationError];
    if (activationError) {  }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

- (void) loadPlayer {
    
    
    _moviePlayerController = [[MPMoviePlayerViewController new]
                              initWithContentURL: _qualityString];
    
    [self presentMoviePlayerViewControllerAnimated:_moviePlayerController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    NSError *setCategoryError = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    if (setCategoryError) {  }
    
    NSError *activationError = nil;
    [audioSession setActive:YES error:&activationError];
    if (activationError) {  }
    
}

-(void)videoPlayBackDidFinish:(NSNotification*)notification  {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait]; [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    [self dismissMoviePlayerViewControllerAnimated];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KeyID"];
}


-(void) refreshInvoked:(id)sender forState:(UIControlState)state {
    // Refresh table here...
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self fetchEntries];
    [self.tableView reloadData];
    [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(endRefresh) userInfo:nil repeats:NO];
}

- (void)endRefresh
{
    [self.refreshControl endRefreshing];
    // show in the status bar that network activity is stoping
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"You must have an active network connection in order to Video" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
