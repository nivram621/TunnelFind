//
//  InfoCoachingViewController.m
//  TunnelFind
//
//  Created by Marvin BERTRAND on 9/08/15.
//  Copyright (c) 2015 Marvin Bertrand. All rights reserved.
//

#import "InfoCoachingViewController.h"

@interface InfoCoachingViewController ()

@end

@implementation InfoCoachingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)infoClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
