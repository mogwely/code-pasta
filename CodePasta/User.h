//
//  PastaUser.h
//  CodePasta
//
//  Created by Mohamed Gwely on 24/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface User : PFUser <PFSubclassing>

//PFUser is a local representation of a user in parse cloud. it already has a username and password.
@property (copy, nonatomic) NSString* userId;
@property (copy, nonatomic) NSMutableArray* pastas;


@end
