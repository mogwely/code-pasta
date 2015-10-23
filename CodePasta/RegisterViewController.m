//
//  RegisterViewController.m
//  CodePasta
//
//  Created by Mohamed Gwely on 23/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// Assigns a UITapGesture for touches on the view
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
}

-(void)hideKeyBoard {
    [self.view endEditing:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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

/**
 *  registers a new user to the Parse cloud service
 *
 *  @param sender UIButton resgiter btn
 */
- (IBAction)registerBtnClicked:(UIButton *)sender {
    
    
    PFUser *user = [PFUser user];
    
    user.username = self.usernameTextField.text;
    user.password = self.passwordTextField.text;
    
    // registers a new user in a closure and perform the segue on success
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //The registration was successful 
            [self performSegueWithIdentifier: SEGUE_FROM_REGISTER_TO_TAB_BAR_CONTROLLER sender:self];
            
        } else {
            //Something bad has occurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}
@end
