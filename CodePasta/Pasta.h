//
//  Pasta.h
//  CodePasta
//
//  Created by Mohamed Gwely on 24/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "User.h"

@interface Pasta : PFObject <PFSubclassing>

@property (copy, nonatomic) NSString* title;
@property (copy, nonatomic) NSString* desc;
@property (copy, nonatomic) NSString* uploadDate;
@property (copy, nonatomic) NSString* programmingLanguage;
@property (copy, nonatomic) NSString* url;

//Pointer to the User object of the uploader
@property (retain, nonatomic) User* uploader;

//return class name
+ (NSString *)parseClassName;

//Formats the date returned from the PFobject and returns a string
-(NSString *) formatPFdate:(NSDate *)date;

- (NSString *) dateAgo:(NSDate *)date;


@end
