//
//  CarViewController.m
//  TunnelFind
//
//  Created by Marvin BERTRAND on 28/10/14.
//  Copyright (c) 2014 Marvin BERTRAND. All rights reserved.
//
#import "Store.h"
#import "StoreViewController.h"
#import "MyCustomViewCell.h"
#import "DetailViewController.h"
#import "MBProgressHUD.h"
#import "DisplayMap.h"

// This is the link of the php, which will serve to recall the data of MySQL.
#define phpLink @"http://www.mbsolution.be/app/tunnelfind/store.php"

@implementation StoreViewController

@synthesize contatti,allContatti,title;
@synthesize sgControlFilter;
@synthesize searchString,searchBarUI;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload)];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"All", @"Name", @"Address", nil];
    self.sgControlFilter = [[UISegmentedControl alloc] initWithItems:itemArray];
    self.sgControlFilter.frame = CGRectMake(150, 8, 180, 30);
    self.sgControlFilter.segmentedControlStyle  = UISegmentedControlStylePlain;
    self.sgControlFilter.segmentedControlStyle  = UISegmentedControlStyleBar;
    self.sgControlFilter.tintColor              = [UIColor grayColor];
    self.sgControlFilter.selectedSegmentIndex   = 0;
    [self.sgControlFilter addTarget:self action:(@selector(onFilterChanged:)) forControlEvents:UIControlEventValueChanged];
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0,8,50,30)];
    self.title.text = @"Wind Tunnel";
    self.title.textAlignment = NSTextAlignmentCenter;
    [self.title setTextColor:[UIColor blackColor]];
    [self.title setBackgroundColor:[UIColor clearColor]];
    [self.title setFont:[UIFont boldSystemFontOfSize:20]];
    self.title.textAlignment = NSTextAlignmentRight;
    [self.navigationController.navigationBar.topItem setTitleView:self.title];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    

    [super viewDidLoad];
 

    
    
    //self.tableView.backgroundColor = [UIColor clearColor];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	
	HUD.delegate = self;
	HUD.labelText = @"Loading";
	
	[HUD show:TRUE];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:phpLink]];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
        
    });
    
    [self addFooter];
}

- (void)reload
{
    [HUD show:TRUE];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:phpLink]];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
        
        
    });
    [self.tableView reloadData];
}

- (void)fetchedData:(NSData *)responseData {
    NSArray* json = [NSJSONSerialization
                     JSONObjectWithData:responseData //1
                     options:kNilOptions error:nil];
    
    

    NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSSortDescriptor *bookingSorter = [[NSSortDescriptor alloc] initWithKey:@"booking" ascending:YES];
    NSSortDescriptor *countrySorter = [[NSSortDescriptor alloc] initWithKey:@"country" ascending:YES];
    NSSortDescriptor *openedSorter = [[NSSortDescriptor alloc] initWithKey:@"opened" ascending:YES];
    NSSortDescriptor *priceSorter = [[NSSortDescriptor alloc] initWithKey:@"distancesave" ascending:YES];
    
    json = [json sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSorter,priceSorter,bookingSorter,countrySorter,openedSorter,nil]];
    
    // NSMutableArray *contattiTMP = [[NSMutableArray alloc] initWithCapacity:[json count]]; //2
    
    int counter = 0;
    NSMutableArray *json2 = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in json) { //3
        
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        
        [dictionary setObject:[dict objectForKey:@"name"] forKey:@"name"];
        [dictionary setObject:[dict objectForKey:@"number"] forKey:@"number"];
        [dictionary setObject:[dict objectForKey:@"address"] forKey:@"address"];
        [dictionary setObject:[dict objectForKey:@"latitude"] forKey:@"latitude"];
        [dictionary setObject:[dict objectForKey:@"longitude"] forKey:@"longitude"];
        [dictionary setObject:[dict objectForKey:@"booking"] forKey:@"booking"];
        [dictionary setObject:[dict objectForKey:@"country"] forKey:@"country"];
        [dictionary setObject:[dict objectForKey:@"opened"] forKey:@"opened"];

        // locationManager update as location
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
        
        [mapView setMapType:MKMapTypeStandard];
        [mapView setZoomEnabled:YES];
        [mapView setScrollEnabled:YES];
        [mapView setDelegate:self];
        
        
        double lat = [[dict objectForKey:@"latitude"] doubleValue];
        double lon = [[dict objectForKey:@"longitude"] doubleValue];
        CLLocationCoordinate2D coord = { lat, lon };
        
        
        MKCoordinateRegion region;
        region.center.latitude = lat;
        region.center.longitude = lon;
        region.span.longitudeDelta = 1;
        region.span.latitudeDelta = 1;
        [mapView setRegion:region animated:YES];
        [mapView setCenterCoordinate:region.center animated:YES];
        
        
        DisplayMap *ann = [[DisplayMap alloc] init];
        ann.coordinate = coord;
        [mapView addAnnotation:ann];
        mapView.showsUserLocation= YES;
        
        
        CLLocation *userloc = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:ann.coordinate.latitude longitude:ann.coordinate.longitude];
        
        CLLocationDistance distance2 = [userloc distanceFromLocation:loc]/ 1000;
      
        
        distance = [NSString stringWithFormat:@"%.2f", distance2];
        
        [dictionary setObject:distance forKey:@"distancesave"];
        
        
        [json2 addObject:dictionary];
       
        counter++;
        
        

    }
    self.contatti = [json2 copy]; //6
    self.allContatti = [json2 copy];
    [self onSortChanged];
    [self.tableView reloadData];
    [HUD hide:TRUE];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contatti count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MyCustomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    distance = [NSString stringWithFormat:@"%@ Km", [[contatti objectAtIndex:indexPath.row] objectForKey:@"distancesave"]];
    
    cell.name.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.address.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"address"];
    cell.number.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"number"];
    cell.booking.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"booking"];
    cell.country.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"country"];
    cell.opened.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"opened"];
    cell.distanceLabel.text = distance ;
    cell.icon.image = [UIImage imageNamed:@"logotunnelfind.png"];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    // Store *c = [self.contatti objectAtIndex:indexPath.row];
    DetailViewController *dvc = (DetailViewController *)[segue destinationViewController];
    
    Store *c = [[Store alloc] init]; //4
    
    c.name              = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"name"];
    c.number            = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"number"];
    c.address           = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"address"];
    c.longitude         = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"longitude"];
    c.latitude          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"latitude"];
    c.booking          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"booking"];
    c.country          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"country"];
    c.opened          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"opened"];
    
    
    // c.icon = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.contatti objectAtIndex:indexPath.row] objectForKey:@"icon"]]]];

    
    [dvc setStore:c];
}
- (void) addFooter
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    [self.tableView setTableFooterView:v];
    
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.navigationController.navigationBar.topItem setTitleView:self.sgControlFilter];
    
    [searchBar setShowsCancelButton:YES animated:YES];
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
}

- (void)updateSearchString:(NSString*)aSearchString
{
    searchString = [[NSString alloc]initWithString:aSearchString];
    
    [self onFilter];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationController.navigationBar.topItem setTitleView:self.title];
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
    searchBar.text=@"";
    [self updateSearchString:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
    [self updateSearchString:searchBar.text];
}

- (IBAction)onFilterChanged:(id)sender{
    [self onFilter];
    
    [self.tableView reloadData];
}


-(void)onFilter{
    NSRange textRange1;
    NSRange textRange2;
    
    if (searchString != nil && [searchString isEqualToString:@""] == NO) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        if ([sgControlFilter selectedSegmentIndex] == 0) {
            for (int i=0; i<[allContatti count]; i++) {
                NSString *tempName = [[self.allContatti objectAtIndex:i] objectForKey:@"name"];
                NSString *tempPrice = [[self.allContatti objectAtIndex:i] objectForKey:@"address"];
                
                textRange1 = [[tempName lowercaseString] rangeOfString:[searchString lowercaseString]];
                textRange2 = [[tempPrice lowercaseString] rangeOfString:[searchString lowercaseString]];
                
                if(textRange1.location != NSNotFound || textRange2.location != NSNotFound)
                {
                    [tempArray addObject:[self.allContatti objectAtIndex:i]];
                }
            }
        }else if ([sgControlFilter selectedSegmentIndex] == 1) {
            for (int i=0; i<[allContatti count]; i++) {
                NSString *tempString = [[self.allContatti objectAtIndex:i] objectForKey:@"name"];
                
                textRange1 =[[tempString lowercaseString] rangeOfString:[searchString lowercaseString]];
                
                if(textRange1.location != NSNotFound)
                {
                    [tempArray addObject:[self.allContatti objectAtIndex:i]];
                }
            }
        }else if ([sgControlFilter selectedSegmentIndex] == 2) {
            for (int i=0; i<[allContatti count]; i++) {
                NSString *tempString = [[self.allContatti objectAtIndex:i] objectForKey:@"address"];
                
                textRange1 =[[tempString lowercaseString] rangeOfString:[searchString lowercaseString]];
                
                if(textRange1.location != NSNotFound)
                {
                    [tempArray addObject:[self.allContatti objectAtIndex:i]];
                }
            }
        }
        
        self.contatti = [tempArray copy];
    }else{
        self.contatti = self.allContatti;
    }
    
    [self.tableView reloadData];
}
- (void)onSortChanged{

        
        NSSortDescriptor *aSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"distancesave" ascending:YES comparator:^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        
        self.contatti = [self.contatti sortedArrayUsingDescriptors:[NSArray arrayWithObjects:aSortDescriptor,nil]];
        self.allContatti = [self.allContatti sortedArrayUsingDescriptors:[NSArray arrayWithObjects:aSortDescriptor,nil]];
        
    
    [self.tableView reloadData];
}




@end
