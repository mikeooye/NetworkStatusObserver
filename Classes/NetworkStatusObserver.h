//
//  NetworkStatusObserver.h
//  NetworkStatusObserver
//
//  Created by LiHaozhen on 15/5/2.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

typedef NS_ENUM(NSInteger, BPNetworkStatus) {
    
    BPNetworkStatus_None = NotReachable,
    BPNetworkStatus_WiFi = ReachableViaWiFi,
    BPNetworkStatus_WWAN = ReachableViaWWAN,
    BPNetworkStatus_2G,
    BPNetworkStatus_3G,
    BPNetworkStatus_4G,
    BPNetworkStatus_Unknown,
};

extern NSString *kNetworkStatusChangedNotification;
extern NSString *kNetworkStatusKey;
extern NSString *kNetworkStatusDescriptionKey;


NS_CLASS_AVAILABLE_IOS(7_0) @interface NetworkStatusObserver : NSObject

@property (assign, nonatomic) BPNetworkStatus currentNetworkStatus;
@property (strong, nonatomic) NSString *currentNetworkStatusDescription;

+ (instancetype)defaultObserver;

- (void)startNotifier;
- (void)stopNotifier;
@end
