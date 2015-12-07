//
//  FirstViewController.m
//  CodePasta
//
//  Created by Mohamed Gwely on 22/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import "FirstViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "Constants.h"
#import "GithubAPIClient.h"
#import "Pasta.h"
#import "User.h"
@interface FirstViewController ()

@end

@implementation FirstViewController
{
    GithubAPIClient* _client;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //self.navigationItem.hidesBackButton = YES;
    
    NSLog(@"hahahaa");
    /*PFObject *testObject = [PFObject objectWithClassName:@"TestObject2"];
    testObject[@"Username"] = @"sara";
    testObject[@"password"] = @"iterr";
    [testObject saveInBackgroundWithBlock:^(bool succeeded, NSError* error){
        
        if(succeeded){
            NSLog(@"object uploaded!");
        }else{
            NSString* errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"error: %@", errorString);
        }
    
    }];*/
    
    /*PFQuery* query = [PFQuery queryWithClassName:@"TestObject2"];
    [query whereKey:@"Username" equalTo:@"mohamed_33"];
    [query findObjectsInBackgroundWithBlock:^(NSArray* objects, NSError* error){
        
        if(!error){
            NSLog(@"successfully retrieved: %@", objects);
        }else{
            NSString* errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"error: %@", errorString);
        }
    
    }];*/
    
   /* _client = [GithubAPIClient sharedClient];
    [_client getCodeFileByUrl:@"https://github.com/mogwely/dig-trakt/blob/master/DigTrakt/SearchViewController.m"
                      success:^(NSURLSessionDataTask* task, id responseObject)
     {
         NSLog(@"success: %@",responseObject);
         NSString* urlString = responseObject[@"html_url"];
         [self.htmlWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
     }
     
                      failure:^(NSURLSessionDataTask* task, NSError* error) {
                          NSLog(@"Failure -- %@", error);
                      }];*/
    
    /*for(int i = 0; i<20; i++){
        //TODO: fetch current user information and keep him logged in.
        Pasta* newPasta = [Pasta object];
        newPasta.desc = [NSString stringWithFormat:@"CHECK DATE %d",i];
        newPasta.programmingLanguage = @"Objective-c";
        User* currentUser = [User currentUser];
        //[newPasta.uploader addObject:currentUser];
        newPasta.uploader = currentUser;
        
        [newPasta saveInBackgroundWithBlock:^(bool succeeded, NSError* error){
            
            if(succeeded){
                NSLog(@"pasta uploaded!");
            }else{
                NSString* errorString = [[error userInfo] objectForKey:@"error"];
                NSLog(@"error: %@", errorString);
            }
            
        }];
        
        
    }*/
    
    
    //[self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseUrl];

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutBtnClicked:(UIButton *)sender {
    
    //Deletes user credentials from the property currentUser on PFUser
    [PFUser logOutInBackgroundWithBlock:^(NSError *error){
        if (!error) {
            //Logout Successful
            [self performSegueWithIdentifier: SEGUE_FROM_SECOND_VIEW_CONTROLLER_TO_LOGIN sender:self];
            
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }

    
    }];

}

@end
