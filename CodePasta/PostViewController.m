//
//  PostViewController.m
//  CodePasta
//
//  Created by Mohamed Gwely on 26/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import "PostViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "GithubAPIClient.h"
#import "Pasta.h"
#import "User.h"

@interface PostViewController ()

@end

@implementation PostViewController
{
    GithubAPIClient* _client;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

#pragma mark - Posting method


- (IBAction)postBtnClicked:(UIButton *)sender {
    if(self.nameTextField.text.length==0 || self.descriptionTextField.text.length==0){
        NSString *errorString = @"One of the fields appears to be empty, please fill 'em all!";
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Ooooops" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlertView show];
        
        return;
    }
    //TODO: check if it's a real file code.
    if(![self.urlTextField.text containsString:@"github.com/"]){
        NSString *errorString = @"Please provide the file's link on Github!";
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Ooooops" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlertView show];
        
        return;
    }
    Pasta* newPasta = [Pasta object];
    newPasta.desc = self.descriptionTextField.text;
    newPasta.programmingLanguage = self.programmingLanguageTextField.text;
    newPasta.title = self.nameTextField.text;
    newPasta.url = self.urlTextField.text;
    User* currentUser = [User currentUser];
    newPasta.uploader = currentUser;
    
    [newPasta saveInBackgroundWithBlock:^(bool succeeded, NSError* error){
        
        if(succeeded){
            NSLog(@"pasta uploaded!");
        }else{
            NSString* errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"error: %@", errorString);
        }
        
    }];
    
    
}

@end
