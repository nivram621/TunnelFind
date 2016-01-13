//
//  ContactViewController.m
//  TunnelFind
//
//  Created by Marvin BERTRAND on 28/10/14.
//  Copyright (c) 2014 Marvin BERTRAND. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController


- (IBAction)contactus:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Contact TunnelFind of iOS App";
    // Email Content
    NSString *messageBody = @"\n \n __ \n Sent from TunnelFind App \n https://appsto.re/be/UZFp3.i \n Website: www.tunnelfind.com";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"contact@tunnelfind.com"];
    
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

- (IBAction)reportproblem:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Report problem TunnelFind of iOS App";
    // Email Content
    NSString *messageBody = @"\n \n __ \n Sent from TunnelFind App \n https://appsto.re/be/UZFp3.i \n Website: www.tunnelfind.com";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"contact@tunnelfind.com"];
    
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
    
}

- (IBAction)requestaddtunnel:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Request add Tunnel, TunnelFind of iOS App";
    // Email Content
    NSString *messageBody = @"Hi, It's possible to add this Tunnel? Thanks!:) \n\nName of Tunnel: \nAddress: \nPhone: \nCountry: \n \n __ \n Sent from TunnelFind App \n https://appsto.re/be/UZFp3.i \n Website: www.tunnelfind.com";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"contact@tunnelfind.com"];
    
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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
