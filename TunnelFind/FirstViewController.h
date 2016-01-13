//
//  FirstViewController.h
//  TunnelFind
//
//  Created by Marvin BERTRAND on 28/10/14.
//  Copyright (c) 2014 Marvin BERTRAND. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FirstViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>{
    
    CLLocationManager *locationManager;
    IBOutlet UIImageView *img1;
    IBOutlet UIImageView *img2;
    IBOutlet UIImageView *img3;
    IBOutlet UIScrollView *scroll;
    UITextView *descText;
    BOOL openDesc;
    UIButton *openButton;
    UIScrollView *scrollview;
    UIImageView *descUI;
    UIScrollView *pageScrollView;
}
- (IBAction)moveDescription;
- (IBAction)infoOpen;
- (IBAction)ShareonFacebook:(id)sender;
- (IBAction)ShareonTwitter:(id)sender;
- (IBAction)followusfb;
- (IBAction)followustwitter;
@property (weak, nonatomic) IBOutlet UIImageView *imagepub;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) IBOutlet UITabBar *tabbar;

@end
