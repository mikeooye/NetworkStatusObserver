//
//  Reachability+bpStatusDescription.m
//  NetworkStatusObserver
//
//  Created by LiHaozhen on 15/5/2.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "Reachability+bpStatusDescription.h"

@implementation Reachability (bpStatusDescription)


- (NSString *)currentReachabilityStatusDescription
{
    NetworkStatus status = self.currentReachabilityStatus;
    switch (status) {
        case NotReachable: return @"无网络";
        case ReachableViaWiFi: return @"无线局域网络";
        case ReachableViaWWAN: return @"蜂窝移动网络";
        default: return nil;
    }
}
@end
