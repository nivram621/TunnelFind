//
//  MapViewController.m
//  TunnelFind
//
//  Created by Marvin BERTRAND on 28/10/14.
//  Copyright (c) 2014 Marvin BERTRAND. All rights reserved.
//
#import "MBProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#import "MapViewController.h"
#import "DisplayMap.h"
#import "WebInsideViewController.h"
#import "SVProgressHUD.h"


// This is the link of the php, which will serve to recall the data of MySQL.
#define phpLink @"http://www.mbsolution.be/app/tunnelfind/store.php"




@implementation MapViewController
@synthesize indicazioni,contatti;
@synthesize mapView;
@synthesize locationManager;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 10; // or whatever
    [self.locationManager startUpdatingLocation];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	
	HUD.delegate = self;
	HUD.labelText = @"Loading";
	
    [SVProgressHUD show];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:phpLink]];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
        
    });
    
    
    
    img.layer.cornerRadius = 10.0;
    img.clipsToBounds = YES;
    img.layer.borderColor = [[UIColor blackColor] CGColor];
    img.layer.borderWidth = 1.0;
	
	[mapView setMapType:MKMapTypeStandard];
	[mapView setZoomEnabled:YES];
	[mapView setScrollEnabled:YES];
    [mapView setDelegate:self];
   
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
}

- (void)fetchedData:(NSData *)responseData {
    NSArray* json = [NSJSONSerialization
                     JSONObjectWithData:responseData //1
                     options:kNilOptions error:nil];
    
    
    
    NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSSortDescriptor *priceSorter = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
    
    json = [json sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSorter,priceSorter,nil]];
    
    // NSMutableArray *contattiTMP = [[NSMutableArray alloc] initWithCapacity:[json count]]; //2
    
    int counter = 0;
    NSMutableArray *json2 = [[NSMutableArray alloc] init];
    int Info;
    for (Info = 0; Info < json.count; Info++) {
        NSDictionary *dict = (NSDictionary *)[json objectAtIndex:Info];
        
   // for (NSDictionary *dict in json) { //3
        
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        
        [dictionary setObject:[dict objectForKey:@"name"] forKey:@"name"];
        [dictionary setObject:[dict objectForKey:@"number"] forKey:@"number"];
        [dictionary setObject:[dict objectForKey:@"address"] forKey:@"address"];
        [dictionary setObject:[dict objectForKey:@"latitude"] forKey:@"latitude"];
        [dictionary setObject:[dict objectForKey:@"longitude"] forKey:@"longitude"];
        
        
        [json2 addObject:dictionary];
        
        counter++;
        
        double lat = [[dict valueForKey:@"latitude"] doubleValue];
        double lon = [[dict valueForKey:@"longitude"] doubleValue];
        CLLocationCoordinate2D coord = { lat, lon };
        
        
        MKCoordinateRegion region;
        region.center.latitude = mapView.userLocation.coordinate.latitude;
        region.center.longitude = mapView.userLocation.coordinate.longitude;
        region.span.longitudeDelta =  1;
        region.span.latitudeDelta =  1;
        [mapView setRegion:region animated:YES];
        [mapView setCenterCoordinate:mapView.userLocation.location.coordinate animated:YES];
        
            CLLocation *userloc = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
        
        CLLocationDistance distance2 = [userloc distanceFromLocation:loc]/ 1000;
        
        NSString *str = [NSString stringWithFormat:@"Distance: %.2f km", distance2];
        
        DisplayMap *ann = [[DisplayMap alloc] init];
        ann.title = [NSString stringWithFormat: @"%@", [dict valueForKey:@"name"]];
        ann.subtitle = str;
        ann.coordinate = coord;
        
        [mapView addAnnotation:ann];
        
         mapView.showsUserLocation = YES;
        
        
    }
 
    self.contatti = [json2 copy]; //6
    
    [SVProgressHUD dismiss];
    
}
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
    for(MKAnnotationView *annotationView in views) {
        if(annotationView.annotation == mv.userLocation) {
            MKCoordinateRegion region;
            MKCoordinateSpan span;
            
            span.latitudeDelta=10;
            span.longitudeDelta=10;
            
            CLLocationCoordinate2D location=mv.userLocation.coordinate;
            
            region.span=span;
            region.center=location;
            
            [mv setRegion:region animated:TRUE];
            [mv regionThatFits:region];
        }
    }
}

-(IBAction)buttonPressed:(id)sender
{
    // locationManager update as location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    
    // Configure the new event with information from the location
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    NSLog(@"%@", latitude);
    NSLog(@"%@",longitude);
    
    CLLocationCoordinate2D destination = { 0, 0 };
    
    NSString *googleMapsURLString = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%1.6f,%1.6f&daddr=%1.6f,%1.6f",
                                     coordinate.latitude, coordinate.longitude, destination.latitude, destination.longitude];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:googleMapsURLString]];
    
    
}
-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:
(id <MKAnnotation>)annotation {
	MKPinAnnotationView *pinView = nil;
	if(annotation != mapView.userLocation)
	{
		static NSString *defaultPinID = @"com.invasivecode.pin";
		pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        
        
		pinView.pinColor = MKPinAnnotationColorRed;
		pinView.canShowCallout = YES;
		pinView.animatesDrop = YES;
    }
	else {
		[mapView.userLocation setTitle:@"I'm here"];
	}
	return pinView;
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


-(void)openASAppbtn
{
    WebInsideViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"webInsideViewController"];
    toViewController.string = @"http://www.airspace.be/";
    [self.navigationController pushViewController:toViewController animated:YES];
}




@end