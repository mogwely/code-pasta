//
//  SecondViewController.h
//  CodePasta
//
//  Created by Mohamed Gwely on 22/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutBtn;

- (IBAction)segmentSwitch:(UISegmentedControl *)sender;
- (IBAction)logoutBtnClicked:(UIBarButtonItem *)sender;

@end

