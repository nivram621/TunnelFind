//
//  APPDetailViewController.h
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

// Modifié par :            iPhoneRetro
// Dernière mise à jour :   10/05/2015
// Site Web :               http://iphoneretro.com/
// Chaine YouTube :         https://www.youtube.com/user/theiphoneretro

#import <UIKit/UIKit.h>

@interface APPDetailViewController : UIViewController {
    
    NSString *stringyoutube;
    NSString *videoid;
    
}

@property(nonatomic, strong) IBOutlet UIWebView *lecteuryoutube;
@property(nonatomic, strong) IBOutlet UITextView *description;
@property (copy, nonatomic) NSString *titrevideo;
@property (copy, nonatomic) NSString *idvideo;
@property (copy, nonatomic) NSString *descriptionvideo;

@end
