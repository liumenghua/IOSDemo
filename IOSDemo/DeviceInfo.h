//
//  DeviceInfo.h
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/8.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Security/Security.h>

#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

@interface DeviceInfo : NSObject

/**
 *  获取某一刻的UUID
 */
+ (NSString *)getRandomUUID;

/**
 *  获取IDFA，如果用户关闭此功能，就会存在娶不到的情况
 */
+ (NSString *)getIDFA;

/**
 *  获取IDFV
 */
+ (NSString *)getIDFV;

/**
 *  获取设备唯一标识,先从keychain里面加载uuid 如果没有 就获取uuid并加载到keychain中
 */
+ (NSString *)getDeviceID;

/**
 *  获取设备名字
 */
+ (NSString *)getDeviceName;

/**
 *  获取设备系统版本号
 */
+ (NSString *)getSystemVersion;

/**
 *  获取设备系统名称
 */
+ (NSString *)getDeviceSystemName;

/**
 *  获取设备运营商
 */
+ (NSString *)getCarrier;

/**
 *  判断当前网络类型
 */
+ (NSString *)getNetworkType;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface KeychainWrapper : NSObject

/**
 *  @method
 *
 *  @abstract
 *  保存数据到keychain中
 *
 *  @param date       要存储的数据
 *  @param service    服务
 */
+ (BOOL)saveDate:(id)date withService:(NSString *)service;

/**
 *  @method
 *
 *  @abstract
 *  查找keychain中的数据
 *
 *  @param service       服务
 */
+ (id)searchDateWithService:(NSString *)service;

/**
 *  @method
 *
 *  @abstract
 *  更新keychain中的数据
 *
 *  @param date       新的数据
 *  @param service    服务
 */
+ (BOOL)updateDate:(id)date withService:(NSString *)service;

/**
 *  @method
 *
 *  @abstract
 *  删除keychain中的数据
 *
 *  @param service    服务
 */
+ (BOOL)deleteDateiWithService:(NSString *)service;

@end



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
typedef enum : NSInteger {
    NotReachable = 0,
    ReachableViaWiFi,
    ReachableViaWWAN
} NetworkStatus;

#pragma mark IPv6 Support
//Reachability fully support IPv6.  For full details, see ReadMe.md.


extern NSString *kReachabilityChangedNotification;


@interface Reachability : NSObject

/*!
 * Use to check the reachability of a given host name.
 */
+ (instancetype)reachabilityWithHostName:(NSString *)hostName;

/*!
 * Use to check the reachability of a given IP address.
 */
+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;

/*!
 * Checks whether the default route is available. Should be used by applications that do not connect to a particular host.
 */
+ (instancetype)reachabilityForInternetConnection;


#pragma mark reachabilityForLocalWiFi
//reachabilityForLocalWiFi has been removed from the sample.  See ReadMe.md for more information.
//+ (instancetype)reachabilityForLocalWiFi;

/*!
 * Start listening for reachability notifications on the current run loop.
 */
- (BOOL)startNotifier;
- (void)stopNotifier;

- (NetworkStatus)currentReachabilityStatus;

/*!
 * WWAN may be available, but not active until a connection has been established. WiFi may require a connection for VPN on Demand.
 */
- (BOOL)connectionRequired;

@end

