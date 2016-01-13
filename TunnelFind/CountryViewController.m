//
//  CountryViewController.m
//  TunnelFind
//
//  Created by Victor Pierre on 03/11/2015.
//  Copyright © 2015 Marvin Bertrand. All rights reserved.
//

#import "CountryViewController.h"
#import "FranceViewController.h"

@interface CountryViewController ()

@end

@implementation CountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

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

- (IBAction)france:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"FRANCE";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)belgique:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"BELGIUM";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)spain:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"SPAIN";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)unitedstates:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"UNITED STATES";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)germany:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"GERMANY";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)netherlands:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"NETHERLANDS";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)switzerland:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"SWITZERLAND";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)czechrepublic:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"CZECH REPUBLIC";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)slovakia:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"SLOVAKIA";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)serbie:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"SERBIE";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)denmark:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"DENMARK";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)unitedkingdom:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"UNITED KINGDOM";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)russie:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"RUSSIE";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)unitedarabemirates:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"UNITED ARAB EMIRATES";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)kualalumpur:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"KUALA LUMPUR";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)singapore:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"SINGAPORE";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)guam:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"GUAM";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)australia:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"AUSTRALIA";
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (IBAction)canada:(id)sender {
    FranceViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"franceViewController"];
    toViewController.franceString = @"CANADA";
    [self.navigationController pushViewController:toViewController animated:YES];
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
