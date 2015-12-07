//
//  Pasta.m
//  CodePasta
//
//  Created by Mohamed Gwely on 24/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import "Pasta.h"
#import <Parse/PFObject+Subclass.h>
#import <DateTools/NSDate+DateTools.h>

//Local constants
NSString* const UPLOAD_DATE_FORMAT = @"EEE, MMM d, h:mm a";

@implementation Pasta

@dynamic title;
@dynamic desc;
@dynamic uploadDate;
@dynamic programmingLanguage;
@dynamic uploader;
@dynamic url;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    
    return NSStringFromClass([self class]);
}

/**
 *  formats the returned date of the PFobject and transforms it to NSString
 *
 *  @param date NSDate
 *
 *  @return dateString NSString
 */
- (NSString *) formatPFdate:(NSDate *)date{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: UPLOAD_DATE_FORMAT];
    [dateFormat setTimeZone:[NSTimeZone defaultTimeZone]];
    NSString* dateString = [dateFormat stringFromDate:date];

    return dateString;
}

/**
 *  modifies an NSDate to a fuzzy date string 'ex: 5 minutes ago'
 *
 *  @param date NSDate
 *
 *  @return NSString
 */
- (NSString *) dateAgo:(NSDate *)date{
    
    NSString* dateAgoString = date.timeAgoSinceNow;

    return dateAgoString;
}

@end
