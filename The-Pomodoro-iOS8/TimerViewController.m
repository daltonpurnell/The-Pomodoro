//
//  TimerViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Dalton on 4/14/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TimerViewController.h"
#import "Timer.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *timerButton;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

// This method will trigger the timer
- (IBAction)timerButtonTapped:(id)sender {
    
    [[Timer sharedInstance]startTimer];    
    
}

-(void)updateTimerLabel {
    
    // call startTimer on sharedInstace of Timer.
    [Timer sharedInstance];
}

// Subscribe your TimerViewController to run the update label method on the SecondTickNotification.
-(void)registerForNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTimerLabel) name:secondTickNotification object:nil];
}


-(void) unregisterForNotifications {

    // Unsubscribe your TimerViewController from notifications when instances are deallocated
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void) dealloc {
    
    [self unregisterForNotifications];
}


@end
