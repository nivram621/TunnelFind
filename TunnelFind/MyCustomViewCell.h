//
//  MyCustomViewCell.h
//  TunnelFind
//
//  Created by Marvin BERTRAND on 28/10/14.
//  Copyright (c) 2014 Marvin BERTRAND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MyCustomViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *booking;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *opened;
@property (weak, nonatomic) IBOutlet UILabel *yearopened;
@property (weak, nonatomic) IBOutlet UILabel *manufacturer;
@property (weak, nonatomic) IBOutlet UILabel *tunneltype;
@property (weak, nonatomic) IBOutlet UILabel *flightchamberstyle;
@property (weak, nonatomic) IBOutlet UILabel *flightchamberdiameter;
@property (weak, nonatomic) IBOutlet UILabel *flightchamberheight;
@property (weak, nonatomic) IBOutlet UILabel *topwindspeed;
@property (weak, nonatomic) IBOutlet UILabel *offpeakpricing;
@property (weak, nonatomic) IBOutlet UILabel *onpeakpricing;
@property (weak, nonatomic) IBOutlet UILabel *hours;
@property (weak, nonatomic) IBOutlet UILabel *websiteurl;
@property (weak, nonatomic) IBOutlet UILabel *imagetunnel;
@property (weak, nonatomic) IBOutlet UILabel *flag;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@end
