//
//  BookTableViewController.m
//  TunnelFind
//
//  Created by Marvin BERTRAND on 9/05/15.
//  Copyright (c) 2015 Marvin Bertrand. All rights reserved.
//
#import "BookTableViewController.h"
#import "DetailViewController.h"

@interface BookTableViewController ()
@end
@implementation BookTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"Booking Time";
    
    self.textfield1.delegate = self;
    
    [self.myDatePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.switchOutlet.on = ([[defaults stringForKey:@"switchKey"] isEqualToString:@"need"]) ? (YES) : (NO);
    
    if ([[defaults stringForKey:@"switchKey"] isEqual:@"need"]){
        self.label.text = @"need";
    } else {
        self.label.text = @"don't need";
    }
}
- (IBAction)switchChanged:(UISwitch *)sender{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (sender.on == 0){
        [defaults setObject:@"don't need" forKey:@"switchKey"];
        self.label.text = @"don't need";
    } else if (sender.on == 1){
        [defaults setObject:@"need" forKey:@"switchKey"];
        self.label.text = @"need";
    }

    
    [defaults synchronize];
    
}
- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    self.strDate = [dateFormatter stringFromDate:datePicker.date];
    self.selectedDate.text = self.strDate;
}
- (IBAction)sendMail {
    
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate  = self;
    
    // Email Subject
    NSString *emailTitle = @"Booking Indoor Session" ;
    [picker setSubject:@"Booking Indoor Session"];
    
    NSLog(@"le string = %@", self.string);
    
    NSArray *usersTo = [NSArray arrayWithObject:self.string];
    [picker setToRecipients:usersTo];
    
    // Email Content
    NSString *string = [NSString stringWithFormat:@"Hi! This is a reservation from %@\n\nFirst Name: %@ \nLast Name: %@ \nNationality: %@ \nBirthday Date: %@ \nPhone Number: %@ \nI would like book %@ minutes for %@.\n I %@ a coaching (%@) \n\n Thanks so much for your response in my mail: %@  \n__ \n Booking request sent from TunnelFind App \n https://appsto.re/be/UZFp3.i \n Website: www.tunnelfind.com", self.textfield1.text, self.textfield1.text, self.textfield2.text, self.textfield3.text, self.textfield4.text, self.textfield5.text, self.textfield6.text, self.strDate, self.label.text, self.textfield8.text, self.textfield7.text ];
    
    if ([MFMailComposeViewController canSendMail])
    {
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:string isHTML:NO];
        [mc setToRecipients:usersTo];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This device cannot send email");
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No account" message:@"Please, configure a mail account before making reservation!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end