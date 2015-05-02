//
//  NetworkStatusObserver.m
//  NetworkStatusObserver
//
//  Created by LiHaozhen on 15/5/2.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "NetworkStatusObserver.h"
#import "Reachability+bpStatusDescription.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

NSString *kNetworkStatusChangedNotification = @"kNetworkStatusChangedNotification";
NSString *kNetworkStatusKey = @"kNetworkStatusKey";
NSString *kNetworkStatusDescriptionKey = @"kNetworkStatusDescriptionKey";


@implementation NetworkStatusObserver{
    
    Reachability *_reachability;
    CTTelephonyNetworkInfo *_telephonyNetworkInfo;
}

+ (instancetype)defaultObserver
{
    static NetworkStatusObserver *_defaultInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultInstance = [[super allocWithZone:NULL] init];
    });
    return _defaultInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self defaultObserver];
}

- (void)startNotifier
{
    //注册监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged:) name:kReachabilityChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged:) name:CTRadioAccessTechnologyDidChangeNotification object:nil];
    
    //实例化 Reachability
    if (_reachability == nil) {
        _reachability = [Reachability reachabilityForInternetConnection];
    }
    
    //实例化 TelephonyNetworkInfo
    if (_telephonyNetworkInfo == nil) {
        _telephonyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
    }
    
    [_reachability startNotifier];
}

- (void)stopNotifier
{
    if (_reachability) {
        [_reachability stopNotifier];
    }
    
    //解除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTRadioAccessTechnologyDidChangeNotification object:nil];
}

- (void)networkStatusChanged:(NSNotification *)notification
{
    //发送通知
    
    NSDictionary *userInfo = @{kNetworkStatusKey:               @(self.currentNetworkStatus),
                               kNetworkStatusDescriptionKey:    self.currentNetworkStatusDescription};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkStatusChangedNotification
                                                        object:self
                                                      userInfo:userInfo];
}

- (BPNetworkStatus)currentNetworkStatus
{
    return [self statusWithRadioAccessTechnology:_telephonyNetworkInfo.currentRadioAccessTechnology];
}

- (NSString *)currentNetworkStatusDescription
{
    return [self statusDescription:self.currentNetworkStatus];
}

- (BPNetworkStatus)statusWithRadioAccessTechnology:(NSString *)accessTechnology
{
    BPNetworkStatus _reachStatus = (BPNetworkStatus)[_reachability currentReachabilityStatus];
    if (_reachStatus == BPNetworkStatus_WWAN &&
        accessTechnology != nil) {
        
        if ([accessTechnology isEqualToString:CTRadioAccessTechnologyEdge] ||
            [accessTechnology isEqualToString:CTRadioAccessTechnologyGPRS])
            
            return BPNetworkStatus_2G;
        else if ([accessTechnology isEqualToString:CTRadioAccessTechnologyHSDPA] ||    //3.5G
                 [accessTechnology isEqualToString:CTRadioAccessTechnologyWCDMA] ||    //3G
                 [accessTechnology isEqualToString:CTRadioAccessTechnologyHSUPA] ||
                 [accessTechnology isEqualToString:CTRadioAccessTechnologyCDMA1x] ||
                 [accessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0] ||
                 [accessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] ||
                 [accessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB] ||
                 [accessTechnology isEqualToString:CTRadioAccessTechnologyeHRPD])  //3.75G
            
            return BPNetworkStatus_3G;
        else if ([accessTechnology isEqualToString:CTRadioAccessTechnologyLTE])    //3.9G
            
            return BPNetworkStatus_4G;
    }
    
    return _reachStatus;
}

#define BPLocalizedString(key) NSLocalizedStringFromTable(key, @"NetworkStatus", nil)

- (NSString *)statusDescription:(BPNetworkStatus)status
{
    NSString *desc = @"";
    switch (status) {
        case BPNetworkStatus_None: {
            desc = BPLocalizedString(@"network.status.none");
            break;
        }
        case BPNetworkStatus_WiFi: {
            desc = BPLocalizedString(@"network.status.wifi");
            break;
        }
        case BPNetworkStatus_WWAN: {
            desc = BPLocalizedString(@"network.status.wwan");
            break;
        }
        case BPNetworkStatus_2G: {
            desc = BPLocalizedString(@"network.status.2g");
            break;
        }
        case BPNetworkStatus_3G: {
            desc = BPLocalizedString(@"network.status.3g");
            break;
        }
        case BPNetworkStatus_4G: {
            desc = BPLocalizedString(@"network.status.4g");
            break;
        }
        case BPNetworkStatus_Unknown: {
            desc = BPLocalizedString(@"network.status.unknown");
            break;
        }
        default: {
            break;
        }
    }
    return desc;
}
@end
