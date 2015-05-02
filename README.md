# NetworkStatusObserver
监听网络变化(Network status changed notification: (WWAN)2G,3G,4G,Wi-Fi,Not reachable)

####Requirements
Minimum iOS Target iOS 7

#####添加 Framework
 -  `CoreTelephony.framework`

#####添加下面这些文件：
  - `Reachability.h`
  - `Reachability.m`
  - `NetworkStatusObserver.h`
  - `NetworkStatusObserver.m`
  - `NetworkStatus.strings`
  
####网络状态
```Objective-C
typedef NS_ENUM(NSInteger, BPNetworkStatus) {
    
    BPNetworkStatus_None = NotReachable,        ///< 无网络
    BPNetworkStatus_WiFi = ReachableViaWiFi,    ///< Wi-Fi
    BPNetworkStatus_WWAN = ReachableViaWWAN,    ///< 蜂窝移动网络
    BPNetworkStatus_2G,                         ///< 2G网络
    BPNetworkStatus_3G,                         ///< 3G网络
    BPNetworkStatus_4G,                         ///< 4G网络
    BPNetworkStatus_Unknown,                    ///< 未知网络
};
```
  
####使用方法
```Objective-C
[[NetworkStatusObserver defaultObserver] startNotifier];
[[NSNotificationCenter defaultCenter] addObserverForName:kNetworkStatusChangedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
    //do sth.
}];
```

####本地化
所有的网络状态描述在`NetworkStatus.strings`文件中，这里有中文(zn)和英文(en)两个版本，如果需要修改描述文字，修改这个文件中对应的版本即可。
