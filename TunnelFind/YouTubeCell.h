//
//  YouTubeCell.h
//  YouTubePlayer
//
//  Created by Istvan Szabo on 2012.08.08..
//  Copyright (c) 2012 Istvan Szabo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouTubeCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *ytTitle;
@property (strong, nonatomic) IBOutlet UILabel *ytAuthor;
@property (strong, nonatomic) IBOutlet UILabel *ytDate;
@property (strong, nonatomic) IBOutlet UIImageView *ytThumbnail;

@end
