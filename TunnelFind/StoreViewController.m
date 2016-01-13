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
#import "MoreTableViewController.h"
#import "MBProgressHUD.h"
#import "DisplayMap.h"
#import "MCSwipeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AHKActionSheet.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+HexString.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "SVProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#import "WebInsideViewController.h"
#import "CountryViewController.h"


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
    
    UIBarButtonItem *_btn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Grid"]
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(country)];
    
    self.navigationItem.leftBarButtonItem=_btn;
    
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    
    
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
    [self.title setFont:[UIFont boldSystemFontOfSize:18]];
    self.title.textAlignment = NSTextAlignmentRight;
    [self.navigationController.navigationBar.topItem setTitleView:self.title];
    

    [super viewDidLoad];
    
    //self.tableView.backgroundColor = [UIColor clearColor];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    
    
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
    
    [self addFooter];
}

- (void)country {
    CountryViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"countryViewController"];
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (void)reload
{
    [SVProgressHUD show];
    
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
    NSSortDescriptor *yearopenedSorter = [[NSSortDescriptor alloc] initWithKey:@"yearopened" ascending:YES];
    NSSortDescriptor *manufacturerSorter = [[NSSortDescriptor alloc] initWithKey:@"manufacturer" ascending:YES];
    NSSortDescriptor *tunneltypeSorter = [[NSSortDescriptor alloc] initWithKey:@"tunneltype" ascending:YES];
    NSSortDescriptor *flightchamberstyleSorter = [[NSSortDescriptor alloc] initWithKey:@"flightchamberstyle" ascending:YES];
    NSSortDescriptor *flightchamberdiameterSorter = [[NSSortDescriptor alloc] initWithKey:@"flightchamberdiameter" ascending:YES];
    NSSortDescriptor *flightchamberheightSorter = [[NSSortDescriptor alloc] initWithKey:@"flightchamberheight" ascending:YES];
    NSSortDescriptor *topwindspeedSorter = [[NSSortDescriptor alloc] initWithKey:@"topwindspeed" ascending:YES];
    NSSortDescriptor *offpeakpricingSorter = [[NSSortDescriptor alloc] initWithKey:@"offpeakpricing" ascending:YES];
    NSSortDescriptor *onpeakpricingSorter = [[NSSortDescriptor alloc] initWithKey:@"onpeakpricing" ascending:YES];
    NSSortDescriptor *hoursSorter = [[NSSortDescriptor alloc] initWithKey:@"hours" ascending:YES];
    NSSortDescriptor *websiteurlSorter = [[NSSortDescriptor alloc] initWithKey:@"websiteurl" ascending:YES];
    NSSortDescriptor *imagetunnelSorter = [[NSSortDescriptor alloc] initWithKey:@"imagetunnel" ascending:YES];
    NSSortDescriptor *flagSorter = [[NSSortDescriptor alloc] initWithKey:@"flag" ascending:YES];
    NSSortDescriptor *priceSorter = [[NSSortDescriptor alloc] initWithKey:@"distancesave" ascending:YES];
    
    json = [json sortedArrayUsingDescriptors:[NSMutableArray arrayWithObjects:nameSorter,priceSorter,bookingSorter,countrySorter,openedSorter,yearopenedSorter,manufacturerSorter,tunneltypeSorter,flightchamberstyleSorter,flightchamberdiameterSorter,flightchamberheightSorter,topwindspeedSorter,offpeakpricingSorter,onpeakpricingSorter,hoursSorter,websiteurlSorter,imagetunnelSorter,flagSorter,nil]];
    
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
        [dictionary setObject:[dict objectForKey:@"yearopened"] forKey:@"yearopened"];
        [dictionary setObject:[dict objectForKey:@"manufacturer"] forKey:@"manufacturer"];
        [dictionary setObject:[dict objectForKey:@"tunneltype"] forKey:@"tunneltype"];
        [dictionary setObject:[dict objectForKey:@"flightchamberstyle"] forKey:@"flightchamberstyle"];
        [dictionary setObject:[dict objectForKey:@"flightchamberdiameter"] forKey:@"flightchamberdiameter"];
        [dictionary setObject:[dict objectForKey:@"flightchamberheight"] forKey:@"flightchamberheight"];
        [dictionary setObject:[dict objectForKey:@"topwindspeed"] forKey:@"topwindspeed"];
        [dictionary setObject:[dict objectForKey:@"offpeakpricing"] forKey:@"offpeakpricing"];
        [dictionary setObject:[dict objectForKey:@"onpeakpricing"] forKey:@"onpeakpricing"];
        [dictionary setObject:[dict objectForKey:@"hours"] forKey:@"hours"];
        [dictionary setObject:[dict objectForKey:@"websiteurl"] forKey:@"websiteurl"];
        [dictionary setObject:[dict objectForKey:@"imagetunnel"] forKey:@"imagetunnel"];
        [dictionary setObject:[dict objectForKey:@"flag"] forKey:@"flag"];

        
        // locationManager update as location
          locationManager = [[CLLocationManager alloc] init];
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //locationManager.distanceFilter = kCLDistanceFilterNone;
        //[locationManager startUpdatingLocation];
        /*
         [mapView setMapType:MKMapTypeStandard];
         [mapView setZoomEnabled:YES];
         [mapView setScrollEnabled:YES];
         [mapView setDelegate:self];
         */
        
        double lat = [[dict objectForKey:@"latitude"] doubleValue];
        double lon = [[dict objectForKey:@"longitude"] doubleValue];
        CLLocationCoordinate2D coord = { lat, lon };
        
        /*
         MKCoordinateRegion region;
         region.center.latitude = lat;
         region.center.longitude = lon;
         region.span.longitudeDelta = 1;
         region.span.latitudeDelta = 1;
         [mapView setRegion:region animated:YES];
         [mapView setCenterCoordinate:region.center animated:YES];
         */
        
        
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
    [SVProgressHUD dismiss];
    
    
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
    
    [self.tableView reloadData];
    
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
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
    
    
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        
        
    }
    

    
    
   
    distance = [NSString stringWithFormat:@"%@ Km", [[contatti objectAtIndex:indexPath.row] objectForKey:@"distancesave"]];
    
    
    cell.name.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.address.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"address"];
    cell.number.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"number"];
    cell.booking.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"booking"];
    cell.country.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"country"];
    //cell.opened.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"opened"];
    [cell.opened setTitle:[[contatti objectAtIndex:indexPath.row] objectForKey:@"opened"] forState:UIControlStateNormal];
    cell.yearopened.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"yearopened"];
    cell.manufacturer.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"manufacturer"];
    cell.tunneltype.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"tunneltype"];
    cell.flightchamberstyle.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"flightchamberstyle"];
    cell.flightchamberdiameter.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"flightchamberdiameter"];
    cell.flightchamberheight.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"flightchamberheight"];
    cell.topwindspeed.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"topwindspeed"];
    cell.offpeakpricing.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"offpeakpricing"];
    cell.onpeakpricing.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"onpeakpricing"];
    cell.hours.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"hours"];
    cell.websiteurl.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"websiteurl"];
    cell.imagetunnel.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"imagetunnel"];
    cell.flag.text = [[contatti objectAtIndex:indexPath.row] objectForKey:@"flag"];
    NSLog(@"%@", [[contatti objectAtIndex:indexPath.row] objectForKey:@"imagetunnel"]);
    cell.distanceLabel.text = distance ;
    
    cell.opened.layer.cornerRadius = 10;
    cell.opened.backgroundColor = [UIColor colorWithHexString:@"#ff002a"];
    if ([cell.opened.currentTitle isEqualToString:@"This tunnel is Open"]) {
        cell.opened.backgroundColor = [UIColor clearColor];
        [cell.opened setTitle:@"" forState:UIControlStateNormal];
    }
    
    /*
    if ([cell.name.text isEqualToString:@"SlidePark Bordeaux"]) {
        cell.hidden = YES;
    }
     */
    
    
        [cell.button setImage:[UIImage imageNamed:@"moreOK.png"] forState:UIControlStateNormal];
        [cell.button addTarget:self action:@selector(basicExampleTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.button.tag = indexPath.row;
    
    
    NSString *imageURL = [NSString stringWithFormat:@"http://www.mbsolution.be/app/tunnelfind/img/%@",[[contatti objectAtIndex:indexPath.row] objectForKey:@"imagetunnel"]];
    
    NSURL *url = [NSURL URLWithString:imageURL];
    
    [cell.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [cell.imageView setClipsToBounds:YES];
    
    [cell.imageView sd_setImageWithURL:url
                    placeholderImage:[UIImage imageNamed:@"backgroundloadingcell.png"]];
    
    [cell.monButtonKM setTitle:distance forState:UIControlStateNormal];
    cell.monButtonKM.layer.cornerRadius = 10;
    cell.monButtonKM.clipsToBounds = YES;
    cell.monButtonKM.backgroundColor = [UIColor colorWithHexString:@"#2ab2e8"];
    
    NSString *imageURL2 = [NSString stringWithFormat:@"http://www.mbsolution.be/app/tunnelfind/img/flag/%@",[[contatti objectAtIndex:indexPath.row] objectForKey:@"flag"]];
    
    NSURL *urldrapeau = [NSURL URLWithString:imageURL2];
    
    [cell.imageFlag sd_setImageWithURL:urldrapeau
                      placeholderImage:[UIImage imageNamed:@""]];
    
    
 
    return cell;
    
}

- (void)basicExampleTapped:(UIButton *)sender
{
    
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:nil];
    
    actionSheet.blurTintColor = [UIColor colorWithWhite:0.0f alpha:0.75f];
    actionSheet.blurRadius = 8.0f;
    actionSheet.buttonHeight = 50.0f;
    actionSheet.cancelButtonHeight = 50.0f;
    actionSheet.animationDuration = 0.5f;
    actionSheet.cancelButtonShadowColor = [UIColor colorWithWhite:0.0f alpha:0.1f];
    actionSheet.separatorColor = [UIColor colorWithWhite:1.0f alpha:0.3f];
    actionSheet.selectedBackgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    UIFont *defaultFont = [UIFont fontWithName:@"Avenir" size:17.0f];
    actionSheet.buttonTextAttributes = @{ NSFontAttributeName : defaultFont,
                                          NSForegroundColorAttributeName : [UIColor whiteColor] };
    actionSheet.disabledButtonTextAttributes = @{ NSFontAttributeName : defaultFont,
                                                  NSForegroundColorAttributeName : [UIColor grayColor] };
    actionSheet.destructiveButtonTextAttributes = @{ NSFontAttributeName : defaultFont,
                                                     NSForegroundColorAttributeName : [UIColor redColor] };
    actionSheet.cancelButtonTextAttributes = @{ NSFontAttributeName : defaultFont,
                                                NSForegroundColorAttributeName : [UIColor whiteColor] };
    
    UIView *headerView = [[self class] fancyHeaderView];
    actionSheet.headerView = headerView;
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Details & Technical Info", nil)
                              image:[UIImage imageNamed:@"Icon1"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                UIButton *button = sender;
                                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
                                
                                MoreTableViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"moreTableViewController"];
                                [self.navigationController pushViewController: myController animated:YES];
                                myController.name2 = [[contatti objectAtIndex:indexPath.row] objectForKey:@"name"];
                                myController.country2 = [[contatti objectAtIndex:indexPath.row] objectForKey:@"country"];
                                myController.yearopened2 = [[contatti objectAtIndex:indexPath.row] objectForKey:@"yearopened"];
                                myController.manufacturer2 = [[contatti objectAtIndex:indexPath.row] objectForKey:@"manufacturer"];
                                myController.tunneltype2 = [[contatti objectAtIndex:indexPath.row] objectForKey:@"tunneltype"];
                                myController.flightchamberstyle2 = [[contatti objectAtIndex:indexPath.row] objectForKey:@"flightchamberstyle"];
                                myController.flightchamberdiameter2 = [[contatti objectAtIndex:indexPath.row] objectForKey:@"flightchamberdiameter"];
                                myController.flightchamberheight2 = [[contatti objectAtIndex:indexPath.row] objectForKey:@"flightchamberheight"];
                                myController.topwindspeed2 = [[contatti objectAtIndex:indexPath.row] objectForKey:@"topwindspeed"];
                                myController.offpeakpricing2 = [[contatti objectAtIndex:indexPath.row] objectForKey:@"offpeakpricing"];
                                myController.onpeakpricing2 = [[contatti objectAtIndex:indexPath.row] objectForKey:@"onpeakpricing"];
                                myController.hours2 = [[contatti objectAtIndex:indexPath.row] objectForKey:@"hours"];
                                myController.imageView = [[contatti objectAtIndex:indexPath.row] objectForKey:@"imagetunnel"];
                                myController.websiteUrl2 = [[contatti objectAtIndex:indexPath.row] objectForKey:@"websiteurl"];
                            }];
    
    //[actionSheet addButtonWithTitle:NSLocalizedString(@"", nil)
                              // type:AHKActionSheetButtonTypeDisabled
                           // handler:^(AHKActionSheet *as) {
                                
                           // }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Share to Facebook", nil)
                              image:[UIImage imageNamed:@"facebookOK.png"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                
                                SLComposeViewController *controller = [SLComposeViewController
                                                                       composeViewControllerForServiceType:SLServiceTypeFacebook];
                                SLComposeViewControllerCompletionHandler myBlock =
                                ^(SLComposeViewControllerResult result){
                                    if (result == SLComposeViewControllerResultCancelled)
                                    {
                                        NSLog(@"Cancelled");
                                    }
                                    else
                                    {
                                        NSLog(@"Done");
                                    }
                                    [controller dismissViewControllerAnimated:YES completion:nil];
                                };
                                controller.completionHandler =myBlock;
                                //Adding the Text to the facebook post value from iOS
                                [controller setInitialText:[NSString stringWithFormat:@""]];
                                //Adding the URL to the facebook post value from iOS
                                [controller addURL:[NSURL URLWithString:@"https://appsto.re/be/UZFp3.i"]];
                                //Adding the Text to the facebook post value from iOS
                                [controller addImage:[UIImage imageNamed:@"logotunnelfindshare.png"]];
                                
                                [self presentViewController:controller animated:YES completion:nil];
                              
                                
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Share to Twitter", nil)
                              image:[UIImage imageNamed:@"twitterOK.png"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                UIButton *button = sender;
                                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
                                
                                SLComposeViewController *tweetSheet = [SLComposeViewController
                                                                       composeViewControllerForServiceType:SLServiceTypeTwitter];
                                [tweetSheet setInitialText: [NSString stringWithFormat:@"I'm flying at %@ with awesome application @TunnelFind Check now!", [[contatti objectAtIndex:indexPath.row] objectForKey:@"name"]]];
                                [tweetSheet addImage:[UIImage imageNamed:@"logotunnelfindshare.png"]];
                                [tweetSheet addURL:[NSURL URLWithString:@"https://appsto.re/be/UZFp3.i"]];
                                [self presentModalViewController:tweetSheet animated:YES];
                                
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Share by Mail", nil)
                              image:[UIImage imageNamed:@"mailOK.png"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                UIButton *button = sender;
                                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
                                // Email Subject
                                NSString *emailTitle = @"Check TunnelFind application on iPhone!";
                                // Email Content
                                NSString *messageBody = [NSString stringWithFormat:@"Hey! :), I'm flying currently at %@ with TunnelFind application on my iPhone! Check & Download right now this awesome App! https://appsto.re/be/UZFp3.i", [[contatti objectAtIndex:indexPath.row] objectForKey:@"name"]];
                                // To address
                                NSArray *toRecipents = [NSArray arrayWithObject:@""];
                                
                                if ([MFMailComposeViewController canSendMail])
                                {
                                    
                                    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
                                    mc.mailComposeDelegate = self;
                                    [mc setSubject:emailTitle];
                                    [mc setMessageBody:messageBody isHTML:NO];
                                    [mc setToRecipients:toRecipents];
                                    
                                    // Present mail view controller on screen
                                    [self presentViewController:mc animated:YES completion:NULL];
                                }
                                else
                                {
                                    NSLog(@"This device cannot send email");
                                    
                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No account" message:@"Please, configure a mail account before use this function!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                    [alertView show];
                                }
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Share by SMS", nil)
                              image:[UIImage imageNamed:@"smsOK.png"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                UIButton *button = sender;
                                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
                                if(![MFMessageComposeViewController canSendText]) {
                                    UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                    [warningAlert show];
                                    return;
                                }
                                
                                NSArray *recipents = @[];
                                NSString *message = [NSString stringWithFormat:@"Hey! :) I'm flying currently at %@ with TunnelFind application on my iPhone! Check & Download right now this awesome App! https://appsto.re/be/UZFp3.i", [[contatti objectAtIndex:indexPath.row] objectForKey:@"name"]];
                                
                                MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
                                messageController.messageComposeDelegate = self;
                                [messageController setRecipients:recipents];
                                [messageController setBody:message];
                                
                                // Present message view controller on screen
                                [self presentViewController:messageController animated:YES completion:nil];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Open Website", nil)
                              image:[UIImage imageNamed:@"urllogo.png"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                UIButton *button = sender;
                                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
                            
                                
                                WebInsideViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"webInsideViewController"];
                                toViewController.string = [NSString stringWithFormat:@"http://%@", [[contatti objectAtIndex:indexPath.row] objectForKey:@"websiteurl"]];
                                [self.navigationController pushViewController:toViewController animated:YES];
                                
                            }];
    
    [actionSheet show];
}

+ (UIView *)fancyHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imageView.frame = CGRectMake(10, 10, 40, 40);
    [headerView addSubview:imageView];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 200, 20)];
    label1.text = @"";
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont fontWithName:@"Avenir" size:17.0f];
    label1.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label1];
    
    return  headerView;
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// When the user starts swiping the cell this method is called
- (void)swipeTableViewCellDidStartSwiping:(MCSwipeTableViewCell *)cell {
    // NSLog(@"Did start swiping the cell!");
}

// When the user ends swiping the cell this method is called
- (void)swipeTableViewCellDidEndSwiping:(MCSwipeTableViewCell *)cell {
    // NSLog(@"Did end swiping the cell!");
}

// When the user is dragging, this method is called and return the dragged percentage from the border
- (void)swipeTableViewCell:(MCSwipeTableViewCell *)cell didSwipeWithPercentage:(CGFloat)percentage {
    // NSLog(@"Did swipe with percentage : %f", percentage);
}

- (UIView *)viewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
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
        c.yearopened          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"yearopened"];
        c.manufacturer          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"manufacturer"];
        c.tunneltype          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"tunneltype"];
        c.flightchamberstyle          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"flightchamberstyle"];
        c.flightchamberdiameter          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"flightchamberdiameter"];
        c.flightchamberheight          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"flightchamberheight"];
        c.topwindspeed          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"topwindspeed"];
        c.offpeakpricing          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"offpeakpricing"];
        c.onpeakpricing          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"onpeakpricing"];
        c.hours          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"hours"];
        c.websiteurl          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"websiteurl"];
        c.imagetunnel          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"imagetunnel"];
        c.flag          = [[self.contatti objectAtIndex:indexPath.row] objectForKey:@"flag"];
        
        
        
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
    NSRange textRange3;
    
    if (searchString != nil && [searchString isEqualToString:@""] == NO) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        if ([sgControlFilter selectedSegmentIndex] == 0) {
            for (int i=0; i<[allContatti count]; i++) {
                NSString *tempName = [[self.allContatti objectAtIndex:i] objectForKey:@"name"];
                NSString *tempPrice = [[self.allContatti objectAtIndex:i] objectForKey:@"address"];
                NSString *tempCountry = [[self.allContatti objectAtIndex:i] objectForKey:@"country"];
                
                textRange1 = [[tempName lowercaseString] rangeOfString:[searchString lowercaseString]];
                textRange2 = [[tempPrice lowercaseString] rangeOfString:[searchString lowercaseString]];
                textRange3 = [[tempCountry lowercaseString] rangeOfString:[searchString lowercaseString]];
                
                if(textRange1.location != NSNotFound || textRange2.location != NSNotFound || textRange3.location != NSNotFound)
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
        }else if ([sgControlFilter selectedSegmentIndex] == 3) {
            for (int i=0; i<[allContatti count]; i++) {
                NSString *tempString = [[self.allContatti objectAtIndex:i] objectForKey:@"country"];
                
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
