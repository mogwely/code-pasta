//
//  CodeFileViewController.m
//  CodePasta
//
//  Created by Mohamed Gwely on 26/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import "CodeFileViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "GithubAPIClient.h"


@interface CodeFileViewController ()

@end

@implementation CodeFileViewController
{
    GithubAPIClient* _client;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Hides the TabBar
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    
    _client = [GithubAPIClient sharedClient];
    [_client getCodeFileByUrl:self.fileUrl
                      success:^(NSURLSessionDataTask* task, id responseObject)
     {
         NSLog(@"success: %@",responseObject);
         NSString* urlString = responseObject[@"html_url"];
         [self.htmlWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
     }
     
                      failure:^(NSURLSessionDataTask* task, NSError* error) {
                          NSLog(@"Failure -- %@", error);
                      }];
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

@end
