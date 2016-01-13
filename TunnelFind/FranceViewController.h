//
//  CarViewController.h
//  TunnelFind
//
//  Created by Marvin BERTRAND on 28/10/14.
//  Copyright (c) 2014 Marvin BERTRAND. All rights reserved.
//
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>

@class DisplayMap;

@interface FranceViewController : UITableViewController <MBProgressHUDDelegate,UISearchBarDelegate,MKMapViewDelegate> {
    MBProgressHUD *HUD;
    MKMapView *mapView;
    CLLocationManager *locationManager;
    NSString *iconURL;
    UIImageView *icon;
    UIImageView *icon2;
    NSString *distance;
    
    UIImage *image1;
    
    // search function
    IBOutlet UISegmentedControl *sgControlFilter;
    IBOutlet UISegmentedControl *sgControlSort;
    IBOutlet UISearchBar *searchBarUI;
    NSString *searchString;
    
}

- (IBAction)onFilterChanged:(id)sender;

@property (nonatomic, strong) NSMutableArray *contatti;
@property (nonatomic, strong) NSMutableArray *allContatti;
@property (nonatomic, retain) IBOutlet UISegmentedControl *sgControlFilter;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBarUI;
@property (nonatomic, retain) NSString *searchString;

@property (strong, nonatomic) NSString *franceString;

@end
