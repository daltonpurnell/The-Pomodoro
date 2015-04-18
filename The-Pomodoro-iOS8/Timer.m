//
//  Timer.m
//  The-Pomodoro-iOS8
//
//  Created by Dalton on 4/14/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Timer.h"
#import<UIKit/UIKit.h>


@interface Timer()

@property (assign, nonatomic) BOOL isOn;
@property (nonatomic, strong) NSDate *expirationDate;

@end


@implementation Timer


// Shared instance method
+ (Timer *)sharedInstance {
    static Timer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Timer alloc] init];
        
//        sharedInstance.minutes = 5;
//        sharedInstance.seconds = 10;
        
    });
    
    // next time we call this method, this is the only code that will do anything
    return sharedInstance;
}


-(void)startTimer {
    
    self.isOn = YES;
    
// In the startTimer method, set expirationDate to the date (time) when the timer will expire
    // I DON'T UNERSTAND HOW WE SET THIS PART
    NSTimeInterval timerLength = self.minutes * 60 + self.seconds;
    self.expirationDate = [NSDate dateWithTimeIntervalSinceNow:timerLength];
    
    
    UILocalNotification *timerExpiredNotification = [UILocalNotification new];
    
    // set properties for notification
    timerExpiredNotification.fireDate = self.expirationDate;
    timerExpiredNotification.timeZone = [NSTimeZone defaultTimeZone];
    timerExpiredNotification.soundName = UILocalNotificationDefaultSoundName;
    timerExpiredNotification.alertBody = @"Round complete. Go to next round?";
    
    // Schedule notification
    [[UIApplication sharedApplication] scheduleLocalNotification:timerExpiredNotification];
    
    [self checkActive];
}

-(void)endTimer {
    
    self.isOn = NO;
    
    // send a RoundCompleteNotification that the timer has finished
    [[NSNotificationCenter defaultCenter] postNotificationName:roundCompleteNotification object:nil];

}

-(void)decreaseSecond {
    
    if (self.seconds > 0) {
        
        // decrease one second from the remaining time
        self.seconds --;
        
        // and send a SecondTickNotification notification that one second passed
        [[NSNotificationCenter defaultCenter] postNotificationName:secondTickNotification object:nil];
    }
    
    else if (self.seconds == 0 && self.minutes > 0) {
        
        // change minutes, if necessary
        self.minutes --;
        self.seconds = 59;
        
        // and send a SecondTickNotification notification that one second passed
        [[NSNotificationCenter defaultCenter] postNotificationName:secondTickNotification object:nil];
        
    }
        
    else {
        // if the timer has elpased, then call endTimer
        [self endTimer];
    }
}


-(void)checkActive {
    // before the if statement, make sure you cancel previous perform requests
    
    if (self.isOn) {
        [self decreaseSecond];
        // then it should call itself in one second
        [self performSelector:@selector(checkActive) withObject:nil afterDelay:1.0];
    }
}

-(void)cancelTimer {
    
    self.isOn = NO;
    
    // Cancel all local notifications
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // cancel previous perform requests
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}


-(void)prepareForBackground {
    
    [[NSUserDefaults standardUserDefaults] setObject:self.expirationDate forKey:expirationDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void)loadFromBackground {
    
    self.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:expirationDate];
    NSTimeInterval seconds = [self.expirationDate timeIntervalSinceNow];
    self.minutes = seconds / 60;
    self.seconds = seconds - (self.minutes * 60);
}




@end
