//
//  InfoViewController.m
//  TunnelFind
//
//  Created by Marvin BERTRAND on 28/10/14.
//  Copyright (c) 2014 Marvin BERTRAND. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    //NSString *robots = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.mbsolution.be/app/tunnelfind/pub.txt"] encoding:NSUTF8StringEncoding error:nil];
    //self.label1.text = robots;
    
}
-(IBAction)infoClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)facebookurl:(id)sender
{
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString: @"https://www.facebook.com/tunnelfind"]];
}

-(IBAction)twitterurl:(id)sender
{
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString: @"https://www.twitter.com/tunnelfind"]];
}

-(IBAction)youtubeurl:(id)sender
{
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString: @"https://www.youtube.com/user/rapb2oster621/videos"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openASApp
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/be/app/airspace-indoor-skydiving/id929573877?l=fr&mt=8"]]];
}

-(void)openASAppbtn
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.airspace.be"]]];
}


@end
