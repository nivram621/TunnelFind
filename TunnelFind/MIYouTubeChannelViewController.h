//
//  MIYouTubeChannelViewController.h
//  YoutubeChannel
//
//  Created by Istvan Szabo on 2013.04.22..
//  Copyright (c) 2013 Istvan Szabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MIYouTubeChannelViewController : UITableViewController

@property (strong, nonatomic) NSArray *readArray;
@property (nonatomic, strong) NSURL *qualityString;
@property (nonatomic, strong) MPMoviePlayerViewController *moviePlayerController;
- (void) fetchEntries;



@end
