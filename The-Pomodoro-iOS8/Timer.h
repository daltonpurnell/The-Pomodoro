//
//  Timer.h
//  The-Pomodoro-iOS8
//
//  Created by Dalton on 4/14/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const secondTickNotification = @"Second tick notification";

static NSString *const roundCompleteNotification = @"Round complete notification";

static NSString *const newRoundNotification = @"New round notification";

@interface Timer : NSObject

@property (nonatomic, assign) NSInteger minutes;
@property (nonatomic, assign) NSInteger seconds;

-(void)startTimer;

-(void)cancelTimer;

+ (Timer *)sharedInstance;

@end
