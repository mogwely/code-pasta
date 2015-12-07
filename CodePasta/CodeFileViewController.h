//
//  CodeFileViewController.h
//  CodePasta
//
//  Created by Mohamed Gwely on 26/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CodeFileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *htmlWebView;

@property (assign, nonatomic) NSString* fileUrl;

@end
