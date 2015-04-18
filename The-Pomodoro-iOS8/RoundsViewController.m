//
//  RoundsViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Dalton on 4/14/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsViewController.h"
#import "RoundsController.h"
#import "Timer.h"
#import "AppearanceController.h"

@interface RoundsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation RoundsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self registerForNotifications];
    
    [AppearanceController initializeAppearanceDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView DataSource Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // The cell should display the number of minutes in the round (which can be retieved from the RoundsController)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSArray *roundsArray = [RoundsController sharedInstance].roundTimes;
    NSNumber *minutes = roundsArray[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%li minutes", (long)[minutes integerValue]];
    
    
    // set the image of the imageView of the cell to a UIImage with file named
    cell.imageView.image = [UIImage imageNamed:[AppearanceController imageNames][indexPath.row]];
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [RoundsController sharedInstance].roundTimes.count;
}


#pragma mark - TableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    set the currentRound property of ```[RoundsViewController sharedInstance] to the indexPath.row
    [RoundsController sharedInstance].currentRound = indexPath.row;
    
//    and call roundSelected
    [[RoundsController sharedInstance]roundSelected];
    
//    and call cancelTimer
    [[Timer sharedInstance]cancelTimer];
    
}


#pragma mark - Notification Methods

-(void)registerForNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(roundComplete) name:roundCompleteNotification object:nil];
    
}

- (void)roundComplete {
    
    // If the current round is not the last round
    if ([RoundsController sharedInstance].currentRound < [RoundsController sharedInstance].roundTimes.count - 1) {
       
        // increment the currentRounds property
        [RoundsController sharedInstance].currentRound++;
        
        // select the correct row on the tableview
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[RoundsController sharedInstance].currentRound inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        // call roundSelected
        [[RoundsController sharedInstance] roundSelected];
    }
    else {
        
        // Set currentRound property to 0
        [RoundsController sharedInstance].currentRound = 0;
        
        // select the correct row on the tableView
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[RoundsController sharedInstance].currentRound inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        // Call roundSelected
        [[RoundsController sharedInstance] roundSelected];
        
    }
}

-(void)unregisterForNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


-(void)dealloc {
    
    [self unregisterForNotifications];
}

@end
