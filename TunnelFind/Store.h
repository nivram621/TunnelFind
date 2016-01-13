//
//  Store.h
//  TunnelFind
//
//  Created by Marvin BERTRAND on 28/10/14.
//  Copyright (c) 2014 Marvin BERTRAND. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *booking;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *opened;
@property (strong, nonatomic) NSString *yearopened;
@property (strong, nonatomic) NSString *manufacturer;
@property (strong, nonatomic) NSString *tunneltype;
@property (strong, nonatomic) NSString *flightchamberstyle;
@property (strong, nonatomic) NSString *flightchamberdiameter;
@property (strong, nonatomic) NSString *flightchamberheight;
@property (strong, nonatomic) NSString *topwindspeed;
@property (strong, nonatomic) NSString *offpeakpricing;
@property (strong, nonatomic) NSString *onpeakpricing;
@property (strong, nonatomic) NSString *hours;
@property (strong, nonatomic) NSString *websiteurl;
@property (strong, nonatomic) NSString *imagetunnel;
@property (strong, nonatomic) NSString *flag;

@end
