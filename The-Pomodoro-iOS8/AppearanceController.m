//
//  AppearanceController.m
//  The-Pomodoro-iOS8
//
//  Created by Dalton on 4/15/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "AppearanceController.h"
#import <UIKit/UIKit.h>
#import "TimerViewController.h"
#import "RoundsViewController.h"

@implementation AppearanceController

+ (void)initializeAppearanceDefaults {
//
    [[UINavigationBar appearance] setBackgroundColor:[UIColor brownColor]];
//
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor greenColor],
//                                                           NSFontAttributeName: [UIFont fontWithName: @"Avenir Next" size:17]}];
    [[UITabBar appearance] setBackgroundColor:[UIColor brownColor]];
    
    [[UITabBar appearance] setTintColor:[UIColor darkGrayColor]];
//
//    
//                                                           
//                                                           
}

+ (NSArray *)imageNames {
    
    return @[@"Work.png", @"Play.png", @"Work.png", @"Play.png", @"Work.png", @"Play.png", @"Work.png", @"Nap.png"];
}

@end
