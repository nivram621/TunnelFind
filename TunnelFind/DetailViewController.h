//
//  DetailViewController.h
//  TunnelFind
//
//  Created by Marvin BERTRAND on 28/10/14.
//  Copyright (c) 2014 Marvin BERTRAND. All rights reserved.
//
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "Store.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <Social/Social.h>

@class DisplayMap;

@interface DetailViewController : UIViewController<MFMailComposeViewControllerDelegate,MKMapViewDelegate>
{

IBOutlet UIScrollView *scroll;
    NSString *telNumber;
    NSString *bookingMail;
    NSString *countryName;
    NSString *openedText;
    NSString *yearopenedText;
    NSString *manufacturerText;
    NSString *tunneltypeText;
    NSString *flightchamberstyleText;
    NSString *flightchamberdiameterText;
    NSString *flightchamberheightText;
    NSString *topwindspeedText;
    NSString *offpeakpricingText;
    NSString *onpeakpricingText;
    NSString *hoursText;
    NSString *websiteurlText;
    NSString *imagetunnelText;
    NSString *flagText;
    NSArray *_photos;
    MKMapView *mapView;
    CLLocationManager *locationManager;
    NSString *latitude2;
    NSString *longitude2;
    

}
@property (strong, nonatomic) Store *store;
@property (nonatomic, strong) NSArray *contatti;

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
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;


- (IBAction)call;
- (IBAction)postToFacebook:(id)sender;
- (IBAction)bookingemail;
- (IBAction)showPicker:(id)sender;
-(void)displayComposerSheet;
@end
