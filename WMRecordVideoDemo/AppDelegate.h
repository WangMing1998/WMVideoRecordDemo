//
//  AppDelegate.h
//  WMRecordVideoDemo
//
//  Created by Heato on 2017/3/3.
//  Copyright © 2017年 wangming深圳市希顿科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property  BOOL isForceLandscape;
/**
 *  是否强制竖屏
 */
@property  BOOL isForcePortrait;
@end

