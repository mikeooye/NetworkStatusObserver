//
//  ViewController.m
//  NetworkStatusObserver
//
//  Created by LiHaozhen on 15/5/2.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "ViewController.h"
#import "Reachability+bpStatusDescription.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) Reachability *internetReachability;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _internetReachability = [Reachability reachabilityForInternetConnection];
    [_internetReachability startNotifier];
    _statusLabel.text = [_internetReachability currentReachabilityStatusDescription];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kReachabilityChangedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        _statusLabel.text = [_internetReachability currentReachabilityStatusDescription];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
