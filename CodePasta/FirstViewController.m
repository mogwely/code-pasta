//
//  FirstViewController.m
//  CodePasta
//
//  Created by Mohamed Gwely on 22/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import "FirstViewController.h"
#import <Parse/Parse.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
    
    PFQuery* query = [PFQuery queryWithClassName:@"TestObject2"];
    [query whereKey:@"Username" equalTo:@"mohamed_33"];
    [query findObjectsInBackgroundWithBlock:^(NSArray* objects, NSError* error){
        
        if(!error){
            NSLog(@"successfully retrieved: %@", objects);
        }else{
            NSString* errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"error: %@", errorString);
        }
    
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
