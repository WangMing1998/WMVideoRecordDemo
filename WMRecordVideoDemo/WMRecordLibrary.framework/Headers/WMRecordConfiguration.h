//
//  WMRecordConfiguration.h
//  WMRecordLibrary
//
//  Created by Heato on 2017/3/3.
//  Copyright © 2017年 wangming深圳市希顿科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AVFoundation/AVFoundation.h>
@interface WMRecordConfiguration : NSObject

/*!
 *  录制清晰度
 */
typedef NS_ENUM(NSUInteger,videoRecordType){
    videoRecordType_480P,
    videoRecordType_720P,
    videoRecordType_1080P
};
/*!
 *  录制头方向
 */
typedef NS_ENUM(NSUInteger,videoRecordOrientation){
    videoRecordOrientationPortrait,// 竖屏录制
    videoRecordOrientationPortraitUpsideDown,
    videoRecordOrientationLandscapeRight,
    videoRecordOrientationLandscapeLeft
};
/*!
 *  摄像头方向
 */
typedef NS_ENUM(NSUInteger,cameraPosition){
    cameraPositionUnspecified         = 0,
    cameraPositionBack                = 1,
    cameraPositionFront               = 2
};

/*!
 *  录制视频保存位置类型 自定义路径或(沙盒)/系统相册
 *  默认保存系统相册
 */
typedef NS_ENUM(NSUInteger,videoSavePathType){
    systemPhotoAlbum         = 0,
    customSavePath           = 1
};

/*!
 *  视频大小
 *  默认 高清
 */
@property(nonatomic,assign) CGSize videoRecordSize;
/*!
 *  帧率
 *  默认 20
 */
@property (nonatomic, assign) CGFloat videoRecordFps;
/*!
 *  默认码率，在最大码率和最小码率之间
 *  默认 600 * 1000
 */
@property (nonatomic, assign) NSUInteger videoRecordBitRate;

/*!
 *  音频码率
 *  默认 64 * 1000
 */
@property (nonatomic, assign) NSUInteger audioBitRate;
/*!
 *  手机方向 横屏or竖屏
 *  默认 videoRecordOrientation 横屏
 */
@property (nonatomic, assign) videoRecordOrientation recordOrientation;

/*!
 *  摄像头方向 前置或后置
 *  默认 后置摄像头
 */
@property (nonatomic, assign) cameraPosition cameraPosition;

/*!
 *  视频录制清晰度设置
 *  默认 高请设置
 */
@property (nonatomic, assign) videoRecordType videoRecordType;

/*!
 *  视频保存路径类型 系统相册 or 自定义路径
 *  默认 保存在系统相册
 */
@property (nonatomic, assign) videoSavePathType videoSaveType;

/*!
 *  视频录制最大时间（单位：秒）
 *  默认 2小时
 */
@property (nonatomic, assign) NSInteger videoRecordMaxTime;

@end
