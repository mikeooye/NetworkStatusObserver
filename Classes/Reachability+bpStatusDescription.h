//
//  Reachability+bpStatusDescription.h
//  NetworkStatusObserver
//
//  Created by LiHaozhen on 15/5/2.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "Reachability.h"

@interface Reachability (bpStatusDescription)

@property (readonly, nonatomic) NSString *currentReachabilityStatusDescription;
@end
