//
//  WMRecorder.h
//  WMRecorder
//
//  Created by WangMing on 2016/10/12.
//  Copyright © 2016年 WangMing. All rights reserved.
//

#import <AVFoundation/AVCaptureVideoPreviewLayer.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WMRecordConfiguration;

@class WMRecorder;
@protocol WMVideoRecordDelegate <NSObject>

@optional
-(void)recordVideo:(WMRecorder *)record withProgress:(CGFloat)progress;
-(void)recordVideo:(WMRecorder *)record withBeyondMaxRecordTime:(NSUInteger)recordTime;
-(void)recordVideo:(WMRecorder *)record withRecordError:(NSString *)error;
@end

@interface WMRecorder : NSObject

@property(atomic, assign, readonly) BOOL isCapturing;//正在录制
@property(atomic, assign, readonly) BOOL isPaused;//是否暂停
@property(nonatomic, weak) id <WMVideoRecordDelegate> delegate;
@property(nonatomic, strong) AVCaptureDevice *captureDevice;
-(instancetype)initWithRecordConfiguration:(WMRecordConfiguration *)configuration;

#pragma mark 捕获到的视频呈现的layer
- (AVCaptureVideoPreviewLayer *)previewLayer;
#pragma mark 启动录制功能
- (void)startPreview;
#pragma mark 关闭录制功能
- (void)closePreview;
#pragma mark 开始录制
- (void)startRecording;
#pragma mark 暂停录制
- (void)pauseRecording;
#pragma mark 停止录制
- (void)stopRecordingVideo:(void (^)(UIImage *movieImage,NSDictionary *videoInfo))handler;
#pragma mark 继续录制
- (void)resumeRecording;
#pragma mark 开启闪光灯
- (void)switchFlashLight;
#pragma mark 设置聚焦点  手动聚焦
- (void)setFocusCursorWithPoint:(CGPoint)tapPoint;
#pragma mark 切换前后置摄像头
- (void)switchCamera;
#pragma mark 设置静音
- (void)setMute:(BOOL)bEnable;


@end
