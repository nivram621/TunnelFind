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

@interface StoreViewController : UITableViewController <MBProgressHUDDelegate,UISearchBarDelegate,MKMapViewDelegate> {
	MBProgressHUD *HUD;
    MKMapView *mapView;
    CLLocationManager *locationManager;
    NSString *iconURL;
    UIImageView *icon;
    NSString *distance;
    
    UIImage *image1;
    
    // search function
    IBOutlet UILabel *title;
    IBOutlet UISegmentedControl *sgControlFilter;
    IBOutlet UISegmentedControl *sgControlSort;
    IBOutlet UISearchBar *searchBarUI;
    NSString *searchString;

}

- (IBAction)onFilterChanged:(id)sender;

@property (nonatomic, strong) NSArray *contatti;
@property (nonatomic, strong) NSArray *allContatti;
@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UISegmentedControl *sgControlFilter;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBarUI;
@property (nonatomic, retain) NSString *searchString;

@end
