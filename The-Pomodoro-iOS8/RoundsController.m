//
//  RoundsController.m
//  The-Pomodoro-iOS8
//
//  Created by Dalton on 4/14/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsController.h"

@implementation RoundsController

// Shared instance method
+ (RoundsController *)sharedInstance {
    static RoundsController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RoundsController alloc] init];
    });
    
    // next time we call this method, this is the only code that will do anything
    return sharedInstance;
}

@end
