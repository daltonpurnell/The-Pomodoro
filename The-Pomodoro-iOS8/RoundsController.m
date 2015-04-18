//
//  RoundsController.m
//  The-Pomodoro-iOS8
//
//  Created by Dalton on 4/14/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsController.h"
#import "Timer.h"

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


// override the roundTimes getter method and return this array
-(NSArray *)roundTimes
{
    return @[@25, @5, @25, @5, @25, @5, @25, @15];

}

-(void)roundSelected {
    
    // update the minutes and seconds on the [Timer sharedInstance] from the currentRound property
    // I don't understand how this code works
    [Timer sharedInstance].minutes = [[self roundTimes][self.currentRound] integerValue];
    [Timer sharedInstance].seconds = 0;
    
    
    // send a NewRoundNotification notification
    [[NSNotificationCenter defaultCenter] postNotificationName:newRoundNotification object:nil];
}






@end
