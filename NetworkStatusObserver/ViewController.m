//
//  ViewController.m
//  NetworkStatusObserver
//
//  Created by LiHaozhen on 15/5/2.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "ViewController.h"
#import "NetworkStatusObserver.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [[NetworkStatusObserver defaultObserver] startNotifier];
    
    _statusLabel.text = [[NetworkStatusObserver defaultObserver] currentNetworkStatusDescription];
    [[NSNotificationCenter defaultCenter] addObserverForName:kNetworkStatusChangedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
       
        _statusLabel.text = [note.userInfo objectForKey:kNetworkStatusDescriptionKey];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
