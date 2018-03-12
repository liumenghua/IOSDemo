//
//  DeviceInfo.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/8.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "DeviceInfo.h"
#import <UIKit/UIKit.h> // idfv
#import <AdSupport/ASIdentifierManager.h> // idfa
#import <sys/sysctl.h>// device model
#import <sys/utsname.h>// device model
#import <CoreTelephony/CTTelephonyNetworkInfo.h> // CTCarrier
#import <CoreTelephony/CTCarrier.h> // CTCarrier

#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <CoreFoundation/CoreFoundation.h>

static NSString * const DEMO_UUID = @"DEMO_UUID";

@implementation DeviceInfo

+ (NSString *)getRandomUUID
{
    return [NSUUID UUID].UUIDString;
}

+ (NSString *)getIDFA
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)getIDFV
{
   return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString *)getDeviceID
{
    return [self getUUIDfromKeychain];
}

+ (NSString *)getUUIDfromKeychain
{
    NSString * uuid = NULL;
    uuid = [KeychainWrapper searchDateWithService:DEMO_UUID];
    if (uuid) {
        return uuid;
    }else{
        uuid = [self getRandomUUID];
        if([KeychainWrapper saveDate:uuid withService:DEMO_UUID]){
            return uuid;
        }else{
            return NULL;
        }
    }
}

#pragma mark - DeviceModel

+ (NSString *)getDeviceName
{
    return [[UIDevice currentDevice] name];
}

+ (NSString *)getDeviceSystemName
{
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)getSystemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

#pragma mark - CTCarrier
+ (NSString *)getCarrier
{
    CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier * carrier = [info subscriberCellularProvider];
    
    NSString * mobile;
    if (!carrier.isoCountryCode) {
        NSLog(@"没有SIM卡");
        mobile = @"无运营商";
    }else{
        mobile = [carrier carrierName];
    }
    
    return mobile;
}

#pragma mark - NetworkType
+ (NSString *)getNetworkType
{
    
    Reachability * reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    NSString * networkType = @"";
    
    switch (netStatus) {
        case ReachableViaWiFi:
            networkType = @"WIFI";
            break;
            
        case ReachableViaWWAN:
        {
            // 判断蜂窝移动类型
            CTTelephonyNetworkInfo * networkInfo = [[CTTelephonyNetworkInfo alloc]init];
            if ([networkInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]) {
                networkType = @"2G";
            } else if ([networkInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge]) {
                networkType = @"2G";
            } else if ([networkInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyWCDMA]) {
                networkType = @"3G";
            } else if ([networkInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSDPA]) {
                networkType = @"3G";
            } else if ([networkInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSUPA]) {
                networkType = @"3G";
            } else if ([networkInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
                networkType = @"3G";
            } else if ([networkInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]) {
                networkType = @"3G";
            } else if ([networkInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]) {
                networkType = @"3G";
            } else if ([networkInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]) {
                networkType = @"3G";
            } else if ([networkInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyeHRPD]) {
                networkType = @"3G";
            } else if ([networkInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
                networkType = @"4G";
            }
        }
            break;
            
        case NotReachable:
            networkType = @"当前无网络连接";
            break;
    }
   
    return networkType;
}

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 在Framework/Security/Secitem.h里面
/** item 类型
 kSecClassInternetPassword Specifies Internet password items.
 kSecClassGenericPassword Specifies generic password items.
 kSecClassCertificate Specifies certificate items.
 kSecClassKey Specifies key items.
 kSecClassIdentity Specifies identity items.
 */

/** 提供的API
 1. SecItemCopyMatching(CFDictionaryRef query, CFTypeRef * __nullable CF_RETURNS_RETAINED result)
 Returns one or more items which match a search query. 查询已存在的item/items
 
 2. SecItemAdd(CFDictionaryRef attributes, CFTypeRef * __nullable CF_RETURNS_RETAINED result)
 Add one or more items to a keychain. 添加 item/items到keychain
 
 3. SecItemUpdate(CFDictionaryRef query, CFDictionaryRef attributesToUpdate)
 Modify zero or more items which match a search query. 更新已存在的item/items
 
 4. SecItemDelete(CFDictionaryRef query)
 Delete zero or more items which match a search query. 删除已存在的 item/items
 */
@implementation KeychainWrapper

// 根据特定的Service创建一个用于操作KeyChain的Dictionary
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service
{
    // 添加的字典不懂？
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)(kSecClassGenericPassword), kSecClass,
            service, kSecAttrService,
            service, kSecAttrAccount,
            kSecAttrAccessibleAfterFirstUnlock, kSecAttrAccessible,
            nil];
}

+ (BOOL)saveDate:(id)date withService:(NSString *)service
{
    // 1. 创建dictonary
    NSMutableDictionary * keychainQuery = [self getKeychainQuery:service];
    // 2. 先删除
    SecItemDelete((CFDictionaryRef)keychainQuery);
    // 3. 添加到date到query中
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:date] forKey:(id<NSCopying>)kSecValueData];
    // 4. 存储到到keychain中
    OSStatus status = SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
    
    return status == noErr ? YES : NO;
}

+ (id)searchDateWithService:(NSString *)service
{
    id retsult = nil;
    NSMutableDictionary * keychainQuery = [self getKeychainQuery:service];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id<NSCopying>)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id<NSCopying>)kSecMatchLimit];
    
    CFTypeRef resultDate = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, &resultDate)== noErr) {
        @try{
            retsult = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)resultDate];
        }
        @catch(NSException *e){
            NSLog(@"查找数据不存在");
        }
        @finally{
            
        }
    }
    if (resultDate) {
        CFRelease(resultDate);
    }
    return retsult;
}

+ (BOOL)updateDate:(id)date withService:(NSString *)service
{
    NSMutableDictionary * searchDictonary = [self getKeychainQuery:service];
    
    if (!searchDictonary) {return  NO;}
    
    NSMutableDictionary * updateDictonary = [NSMutableDictionary dictionary];
    [updateDictonary setObject:[NSKeyedArchiver archivedDataWithRootObject:date] forKey:(id<NSCopying>)kSecValueData];
    OSStatus status = SecItemUpdate((CFDictionaryRef)searchDictonary, (CFDictionaryRef)updateDictonary);
    return status == noErr ? YES : NO;
}

+ (BOOL)deleteDateiWithService:(NSString *)service
{
    NSMutableDictionary * keychainQuery = [self getKeychainQuery:service];
    OSStatus status = SecItemDelete((CFDictionaryRef)keychainQuery);
    return status == noErr ? YES : NO;
}

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark IPv6 Support
//Reachability fully support IPv6.  For full details, see ReadMe.md.


NSString *kReachabilityChangedNotification = @"kNetworkReachabilityChangedNotification";


#pragma mark - Supporting functions

#define kShouldPrintReachabilityFlags 1

static void PrintReachabilityFlags(SCNetworkReachabilityFlags flags, const char* comment)
{
#if kShouldPrintReachabilityFlags
    
    NSLog(@"Reachability Flag Status: %c%c %c%c%c%c%c%c%c %s\n",
          (flags & kSCNetworkReachabilityFlagsIsWWAN)                ? 'W' : '-',
          (flags & kSCNetworkReachabilityFlagsReachable)            ? 'R' : '-',
          
          (flags & kSCNetworkReachabilityFlagsTransientConnection)  ? 't' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionRequired)   ? 'c' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic)  ? 'C' : '-',
          (flags & kSCNetworkReachabilityFlagsInterventionRequired) ? 'i' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionOnDemand)   ? 'D' : '-',
          (flags & kSCNetworkReachabilityFlagsIsLocalAddress)       ? 'l' : '-',
          (flags & kSCNetworkReachabilityFlagsIsDirect)             ? 'd' : '-',
          comment
          );
#endif
}


static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
#pragma unused (target, flags)
    NSCAssert(info != NULL, @"info was NULL in ReachabilityCallback");
    NSCAssert([(__bridge NSObject*) info isKindOfClass: [Reachability class]], @"info was wrong class in ReachabilityCallback");
    
    Reachability* noteObject = (__bridge Reachability *)info;
    // Post a notification to notify the client that the network reachability changed.
    [[NSNotificationCenter defaultCenter] postNotificationName: kReachabilityChangedNotification object: noteObject];
}


#pragma mark - Reachability implementation

@implementation Reachability
{
    SCNetworkReachabilityRef _reachabilityRef;
}

+ (instancetype)reachabilityWithHostName:(NSString *)hostName
{
    Reachability* returnValue = NULL;
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
    if (reachability != NULL)
    {
        returnValue= [[self alloc] init];
        if (returnValue != NULL)
        {
            returnValue->_reachabilityRef = reachability;
        }
        else {
            CFRelease(reachability);
        }
    }
    return returnValue;
}


+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress
{
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, hostAddress);
    
    Reachability* returnValue = NULL;
    
    if (reachability != NULL)
    {
        returnValue = [[self alloc] init];
        if (returnValue != NULL)
        {
            returnValue->_reachabilityRef = reachability;
        }
        else {
            CFRelease(reachability);
        }
    }
    return returnValue;
}


+ (instancetype)reachabilityForInternetConnection
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    return [self reachabilityWithAddress: (const struct sockaddr *) &zeroAddress];
}

#pragma mark reachabilityForLocalWiFi
//reachabilityForLocalWiFi has been removed from the sample.  See ReadMe.md for more information.
//+ (instancetype)reachabilityForLocalWiFi



#pragma mark - Start and stop notifier

- (BOOL)startNotifier
{
    BOOL returnValue = NO;
    SCNetworkReachabilityContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    
    if (SCNetworkReachabilitySetCallback(_reachabilityRef, ReachabilityCallback, &context))
    {
        if (SCNetworkReachabilityScheduleWithRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode))
        {
            returnValue = YES;
        }
    }
    
    return returnValue;
}


- (void)stopNotifier
{
    if (_reachabilityRef != NULL)
    {
        SCNetworkReachabilityUnscheduleFromRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    }
}


- (void)dealloc
{
    [self stopNotifier];
    if (_reachabilityRef != NULL)
    {
        CFRelease(_reachabilityRef);
    }
}


#pragma mark - Network Flag Handling

- (NetworkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags
{
    PrintReachabilityFlags(flags, "networkStatusForFlags");
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
    {
        // The target host is not reachable.
        return NotReachable;
    }
    
    NetworkStatus returnValue = NotReachable;
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        /*
         If the target host is reachable and no connection is required then we'll assume (for now) that you're on Wi-Fi...
         */
        returnValue = ReachableViaWiFi;
    }
    
    if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
         (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
    {
        /*
         ... and the connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs...
         */
        
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            /*
             ... and no [user] intervention is needed...
             */
            returnValue = ReachableViaWiFi;
        }
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        /*
         ... but WWAN connections are OK if the calling application is using the CFNetwork APIs.
         */
        returnValue = ReachableViaWWAN;
    }
    
    return returnValue;
}


- (BOOL)connectionRequired
{
    NSAssert(_reachabilityRef != NULL, @"connectionRequired called with NULL reachabilityRef");
    SCNetworkReachabilityFlags flags;
    
    if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags))
    {
        return (flags & kSCNetworkReachabilityFlagsConnectionRequired);
    }
    
    return NO;
}


- (NetworkStatus)currentReachabilityStatus
{
    NSAssert(_reachabilityRef != NULL, @"currentNetworkStatus called with NULL SCNetworkReachabilityRef");
    NetworkStatus returnValue = NotReachable;
    SCNetworkReachabilityFlags flags;
    
    if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags))
    {
        returnValue = [self networkStatusForFlags:flags];
    }
    
    return returnValue;
}


@end


