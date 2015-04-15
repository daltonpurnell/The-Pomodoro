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
    
    [self registerForNotifications];

}

// This method will trigger the timer
- (IBAction)timerButtonTapped:(id)sender {
    
    [[Timer sharedInstance]startTimer];    
    
}

-(void)updateTimerLabel {
    
    // call startTimer on sharedInstace of Timer.
    NSInteger minutes = [Timer sharedInstance].minutes;
    NSInteger seconds = [Timer sharedInstance].seconds;
    
    self.timerLabel.text = [self timerStringWithMinutes:minutes andSeconds:seconds];
}


// I DON'T UNDERSTAND THIS METHOD AT ALL
-(NSString *)timerStringWithMinutes:(NSInteger)minutes andSeconds:(NSInteger)seconds {
    
    NSString *timerString;
    
    if (minutes >=10)
    {
        timerString = [NSString stringWithFormat:@"0%li:", (long)minutes];
    }
    else {
        timerString = [NSString stringWithFormat:@"0%li:", (long)minutes];
    }
    if (seconds >= 10) {
        timerString = [timerString stringByAppendingString:[NSString stringWithFormat:@"%li", (long)seconds]];
    }
    else {
        timerString = [timerString stringByAppendingString:[NSString stringWithFormat:@"%li", (long)seconds]];
    }
    
    return timerString;
}

// Subscribe your TimerViewController to run the update label method on the SecondTickNotification.
-(void)registerForNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTimerLabel) name:secondTickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound) name:newRoundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound) name:roundCompleteNotification object:nil];
}

-(void)newRound {
    
    [self updateTimerLabel];
    self.timerButton.enabled = YES;
}


-(void) unregisterForNotifications {

    // Unsubscribe your TimerViewController from notifications when instances are deallocated
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void) dealloc {
    
    // Don't forget to register in the init and unregister in the dealloc
    [self unregisterForNotifications];
}


@end
