//
//  RoundsController.h
//  The-Pomodoro-iOS8
//
//  Created by Dalton on 4/14/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//




#import <Foundation/Foundation.h>

@interface RoundsController : NSObject

@property (nonatomic, readonly) NSArray *roundTimes;
@property (nonatomic, assign) NSInteger currentRound;

+ (RoundsController *)sharedInstance;

// add a public, void method, roundSelected
-(void)roundSelected;

@end
