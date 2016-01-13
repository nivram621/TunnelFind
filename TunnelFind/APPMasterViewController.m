//
//  APPMasterViewController.m
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

// Modifié par :            iPhoneRetro
// Dernière mise à jour :   10/05/2015
// Site Web :               http://iphoneretro.com/
// Chaine YouTube :         https://www.youtube.com/user/theiphoneretro

#import "APPMasterViewController.h"
#import "APPDetailViewController.h"

@interface APPMasterViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *idvideo;
    NSMutableString *mediadescription;
    NSString *element;
}
@end

@implementation APPMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Coaching by Skyradek";
    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/feeds/videos.xml?user=skyradekcom"];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableViewReception cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableViewReception dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
    return cell;

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

    element = elementName;
    
    if ([element isEqualToString:@"entry"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        idvideo = [[NSMutableString alloc] init];
        mediadescription = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"entry"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:idvideo forKey:@"id"];
        [item setObject:mediadescription forKey:@"media:description"];
        
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"id"]) {
        [idvideo appendString:string];
    } else if ([element isEqualToString:@"media:description"]) {
        [mediadescription appendString:string];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *titrevideotransmission = [feeds[indexPath.row] objectForKey: @"title"];
        NSString *idvideotransmission = [feeds[indexPath.row] objectForKey: @"id"];
        NSString *descriptionvideotransmission = [feeds[indexPath.row] objectForKey: @"media:description"];
        [[segue destinationViewController] setTitrevideo:titrevideotransmission];
        [[segue destinationViewController] setIdvideo:idvideotransmission];
        [[segue destinationViewController] setDescriptionvideo:descriptionvideotransmission];
        
    }
}


@end
