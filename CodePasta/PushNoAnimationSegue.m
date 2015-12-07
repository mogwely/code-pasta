//
//  PushNoAnimationSegue.m
//  CodePasta
//
//  Created by Mohamed Gwely on 25/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import "PushNoAnimationSegue.h"

@implementation PushNoAnimationSegue

-(void) perform{
    [[[self sourceViewController] navigationController] pushViewController:[self   destinationViewController] animated:NO];
}


@end
