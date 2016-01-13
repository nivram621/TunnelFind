//
//  WebInsideViewController.m
//  TunnelFind
//
//  Created by Marvin BERTRAND on 10/09/15.
//  Copyright (c) 2015 Marvin Bertrand. All rights reserved.
//

#import "WebInsideViewController.h"

@interface WebInsideViewController ()

@end

@implementation WebInsideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *string2 = self.string;
    NSURL *url = [NSURL URLWithString:string2];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
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
