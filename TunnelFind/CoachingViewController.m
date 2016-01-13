//
//  CoachingViewController.m
//  TunnelFind
//
//  Created by Marvin BERTRAND on 9/08/15.
//  Copyright (c) 2015 Marvin Bertrand. All rights reserved.
//

#import "CoachingViewController.h"
#import "WebInsideViewController.h"

@interface CoachingViewController ()

@end

@implementation CoachingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"skyradeklogo.png"]];

    

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)radekwebsite:(id)sender
{
    WebInsideViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"webInsideViewController"];
    toViewController.string = @"http://skyradek.com";
    [self.navigationController pushViewController:toViewController animated:YES];
}

-(IBAction)radekvideo:(id)sender
{
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString: @"http://skyradek.com/video-coaching/"]];
}

- (IBAction)infoOpen
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:[NSBundle mainBundle]];
    
    UIViewController *myController = [storyboard instantiateViewControllerWithIdentifier:@"infocoaching"];
    [self presentViewController:myController animated:YES completion:nil];
}

-(void)openASAppbtn
{
    WebInsideViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"webInsideViewController"];
    toViewController.string = @"http://www.airspace.be";
    [self.navigationController pushViewController:toViewController animated:YES];
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
