//
//  SecondViewController.m
//  CodePasta
//
//  Created by Mohamed Gwely on 22/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import "SecondViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "Pasta.h"
#import "PastaCell.h"
#import <FontAwesome/NSString+FontAwesome.h>
#import "CodeFileViewController.h"

//Local constants
NSInteger const QUERY_RESULTS_LIMIT = 20;

@interface SecondViewController ()

@end

@implementation SecondViewController

{
    NSMutableArray* _pastas;
    NSString* codeFileUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 190.0;

    //Register Nibs for custom cells
    UINib* cellNib = [UINib nibWithNibName: PASTA_CELL_NIB bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier: PASTA_CELL_IDENTIFIER];
    
    cellNib = [UINib nibWithNibName:LOADING_CELL_NIB bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:LOADING_CELL_IDENTIFIER];
    
    _pastas = [NSMutableArray arrayWithCapacity:20];
    NSLog(@"pastas count: %d",(int)[_pastas count]);
    [self loadRecentPastas];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"count is: %d",(int)[_pastas count]);
    return [_pastas count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Fetching results
    //NSLog(@"indexpath is : %@",indexPath);
    if(indexPath.row<[_pastas count]) {
        
        PastaCell* cell = [tableView dequeueReusableCellWithIdentifier:PASTA_CELL_IDENTIFIER forIndexPath:indexPath];
        
        Pasta* pasta = _pastas[indexPath.row];
        cell.usernameLabel.text = [NSString stringWithFormat:@"%@", pasta.uploader.username];
        cell.descriptionLabel.text = pasta.desc;
        cell.dateLabel.text = pasta.uploadDate;
        NSLog(@"uploader: %@ and desc: %@ and pl is: %@",cell.usernameLabel.text,pasta.desc,pasta.programmingLanguage);
        
        /*if(movie.posterUrl){
            dispatch_async(kBgQueue, ^{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",movie.posterUrl]]];
                if (imgData) {
                    UIImage *image = [UIImage imageWithData:imgData];
                    if (image) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            SearchResultCell* updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                            if (updateCell)
                                updateCell.posterImageView.image = image;
                        });
                    }
                }
            });
            
        }*/
        
        //[cell layoutIfNeeded];
        return cell;
        
    }
    return [tableView dequeueReusableCellWithIdentifier: LOADING_CELL_IDENTIFIER];
}



- (NSIndexPath*) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([_pastas count] == 0){
        return  nil;
        
    }else{
        return indexPath;
    }
    
}

/*- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    

}
*/

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Pasta* pasta = _pastas[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:SEGUE_FROM_SECOND_VIEW_CONTROLLER_TO_CODE sender:pasta.url];
}

#pragma - 

-(void) loadRecentPastas{
    
    PFQuery* query = [Pasta query];
    //[query whereKey:@"Username" equalTo:@"mohamed_33"];
    
    // Retrieve the most recent ones
    [query orderByDescending:@"createdAt"];
    
    // Only retrieve the last 20
    query.limit = QUERY_RESULTS_LIMIT;
    
    // Include the user data with each post
    [query includeKey:@"uploader"];

    [query findObjectsInBackgroundWithBlock:^(NSArray* objects, NSError* error){
        
        if(!error){
            
            //NSLog(@"successfully retrieved: %@", objects);
            
            for(Pasta* pasta in objects){

                pasta.uploadDate = [pasta dateAgo:[pasta createdAt]];
                [_pastas addObject:pasta];
            }
            NSLog(@"pastas: %@",_pastas);
            [self.tableView reloadData];
            
        }else{
            NSString* errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"error: %@", errorString);
        }
        
    }];

    
}

-(void) loadOwnPastas{
    
    PFQuery* query = [Pasta query];
    //[query whereKey:@"Username" equalTo:@"mohamed_33"];
    
    // Retrieve the most recent ones
    [query orderByDescending:@"createdAt"];
    
    
    // Include the user data with each post
    [query includeKey:@"uploader"];
    User* user = [User currentUser];
    [query whereKey:@"uploader" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray* objects, NSError* error){
        
        if(!error){
            
            //NSLog(@"successfully retrieved: %@", objects);
            
            for(Pasta* pasta in objects){
                
                pasta.uploadDate = [pasta dateAgo:[pasta createdAt]];
                [_pastas addObject:pasta];
            }
            NSLog(@"pastas: %@",_pastas);
            [self.tableView reloadData];
            
        }else{
            NSString* errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"error: %@", errorString);
        }
        
    }];
    
    
}

- (IBAction)segmentSwitch:(UISegmentedControl *)sender {
    //Scroll back to top
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    
    if (self.segmentedControl.selectedSegmentIndex == 0){
        _pastas = [NSMutableArray arrayWithCapacity:20];
        [self loadOwnPastas];
    }else{
        _pastas = [NSMutableArray arrayWithCapacity:20];
        [self loadRecentPastas];
    }
}

- (IBAction)logoutBtnClicked:(UIBarButtonItem *)sender {
    
    //Deletes user credentials from the property currentUser on PFUser
    [PFUser logOutInBackgroundWithBlock:^(NSError *error){
        if (!error) {
            //Logout Successful
            NSLog(@"%@",SEGUE_FROM_SECOND_VIEW_CONTROLLER_TO_CODE);
            [self performSegueWithIdentifier: SEGUE_FROM_SECOND_VIEW_CONTROLLER_TO_LOGIN sender:self];
            
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
        
        
    }];
}

 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     CodeFileViewController* CodeFileVC = [segue destinationViewController];
     CodeFileVC.fileUrl = sender;
     CodeFileVC.hidesBottomBarWhenPushed = YES;
 }



@end
