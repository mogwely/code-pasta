//
//  LoginViewController.m
//  CodePasta
//
//  Created by Mohamed Gwely on 22/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import "LoginViewController.h"
#import "Constants.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// Assigns a UITapGesture for touches on the view
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideKeyBoard {
    [self.view endEditing:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)loginBtnClicked:(UIButton *)sender {
    
    [PFUser logInWithUsernameInBackground:self.userNameTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error) {
        if (user) {
            if(self.presentingViewController == nil){
                self.navigationItem.hidesBackButton = YES;
                [self performSegueWithIdentifier: SEGUE_FROM_LOGIN_TO_TAB_BAR_CONTROLLER sender:self];
            }else{
                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            }

        } else {
            //Something bad has ocurred
            //TODO: analyze error response code to identify the error.
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    
}

@end

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
