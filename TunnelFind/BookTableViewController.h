//
//  BookTableViewController.h
//  TunnelFind
//
//  Created by Marvin BERTRAND on 9/05/15.
//  Copyright (c) 2015 Marvin Bertrand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Store.h"

@interface BookTableViewController : UITableViewController <UITextFieldDelegate, MFMailComposeViewControllerDelegate>


@property (strong, nonatomic) NSString *strDate;

@property (strong, nonatomic) IBOutlet UITextField *textfield1;
@property (strong, nonatomic) IBOutlet UITextField *textfield2;
@property (strong, nonatomic) IBOutlet UITextField *textfield3;
@property (strong, nonatomic) IBOutlet UITextField *textfield4;
@property (strong, nonatomic) IBOutlet UITextField *textfield5;
@property (strong, nonatomic) IBOutlet UITextField *textfield6;
@property (strong, nonatomic) IBOutlet UITextField *textfield7;
@property (strong, nonatomic) IBOutlet UITextField *textfield8;

@property (strong, nonatomic) NSString *string;

@property (weak, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *selectedDate;

@property (strong, nonatomic) Store *store;
@property (nonatomic, strong) NSArray *contatti;

@property (strong, nonatomic) IBOutlet UISwitch *switchOutlet;
@property (strong, nonatomic) IBOutlet UILabel *label;

@end
