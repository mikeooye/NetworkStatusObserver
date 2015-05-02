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
    
    BPNetworkStatus_None = NotReachable,        ///< 无网络
    BPNetworkStatus_WiFi = ReachableViaWiFi,    ///< Wi-Fi
    BPNetworkStatus_WWAN = ReachableViaWWAN,    ///< 蜂窝移动网络
    BPNetworkStatus_2G,                         ///< 2G网络
    BPNetworkStatus_3G,                         ///< 3G网络
    BPNetworkStatus_4G,                         ///< 4G网络
    BPNetworkStatus_Unknown,                    ///< 未知网络
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
