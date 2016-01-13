//
//  APPDetailViewController.m
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

// Modifié par :            iPhoneRetro
// Dernière mise à jour :   10/05/2015
// Site Web :               http://iphoneretro.com/
// Chaine YouTube :         https://www.youtube.com/user/theiphoneretro

#import "APPDetailViewController.h"

@implementation APPDetailViewController
@synthesize description;

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"UIWindowDidRotateNotification" object:nil queue:nil usingBlock:^(NSNotification *note) {
        if ([note.userInfo[@"UIWindowOldOrientationUserInfoKey"] intValue] >= 3) {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = _titrevideo;
    description.text = _descriptionvideo;

    [self.lecteuryoutube setAllowsInlineMediaPlayback:YES];
    [self.lecteuryoutube setMediaPlaybackRequiresUserAction:NO];
    
    [self.view addSubview:self.lecteuryoutube];
    
    //ON OBTIENT ICI L'IDENTIFIANT DE LA VIDEO
    NSArray *videoURLSplit = [_idvideo componentsSeparatedByString:@"yt:video:"];
    NSArray *videoURLSplit2 = [[videoURLSplit objectAtIndex:1] componentsSeparatedByString:@"\n  "];
    
    videoid = [videoURLSplit2 objectAtIndex:0];
    
    NSString* embedHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <body style='margin:0px;padding:0px;'>\
                           <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                           <script type='text/javascript'>\
                           function onYouTubeIframeAPIReady()\
                           {\
                           ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                           }\
                           function onPlayerReady(a)\
                           { \
                           a.target.playVideo(); \
                           }\
                           </script>\
                           <center><iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'></center>\
                           </body>\
                           </html>", 300, 200, videoid];
    [self.lecteuryoutube loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
    
    //Design
    description.font = [UIFont fontWithName:@"Heiti SC Light" size:30];
    description.textColor = [UIColor blackColor];
    [description setTextAlignment:NSTextAlignmentCenter];
    
}



@end
