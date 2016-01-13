//
//  InfoViewController.h
//  TunnelFind
//
//  Created by Marvin BERTRAND on 28/10/14.
//  Copyright (c) 2014 Marvin BERTRAND. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController
-(IBAction)infoClose:(id)sender;
-(IBAction)openASApp;
-(IBAction)openASAppbtn;

@property (strong, nonatomic) IBOutlet UILabel *label1;

@end
