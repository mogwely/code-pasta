//
//  PostViewController.h
//  CodePasta
//
//  Created by Mohamed Gwely on 26/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UITextField *programmingLanguageTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;

@property (weak, nonatomic) IBOutlet UIButton *postBtn;

- (IBAction)postBtnClicked:(UIButton *)sender;


@end
