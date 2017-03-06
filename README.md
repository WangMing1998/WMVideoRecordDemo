# WMVideoRecordDemo
#
#import <WMRecordLibrary/WMRecordLibrary.h>

@property(nonatomic,strong) WMRecorder *recordVideoManager;
@property(nonatomic,strong) WMRecordConfiguration *recordVideoConfiguration;

// 初始化配置参数
self.recordVideoConfiguration = [[WMRecordConfiguration alloc] init];
self.recordVideoConfiguration.videoSaveType = systemPhotoAlbum;
self.recordVideoConfiguration.videoRecordFps = 30;
self.recordVideoConfiguration.videoRecordSize = CGSizeMake(720, 1080);
self.recordVideoConfiguration.videoRecordType = videoRecordType_720P;
self.recordVideoConfiguration.cameraPosition = cameraPositionBack;
self.recordVideoConfiguration.videoRecordBitRate = 800000;
self.recordVideoConfiguration.audioBitRate = 64000;
self.recordVideoConfiguration.recordOrientation = videoRecordOrientationLandscapeRight;
self.recordVideoConfiguration.videoRecordMaxTime = 7200;

self.recordVideoManager = [[WMRecorder alloc] initWithRecordConfiguration:self.self.recordVideoConfiguration];
// 设置预览窗口大小
self.recordVideoManager.previewLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
// 开启预览
[self.view.layer insertSublayer:self.recordVideoManager.previewLayer atIndex:0];
[self.recordVideoManager startPreview];

// 开始录制
[self.recordVideoManager startRecording];

// 结束录制
[self.recordVideoManager stopRecordingVideo:^(UIImage *movieImage, NSDictionary *videoInfo) {
  NSLog(@"返回视频截图以及录制参数,视频输出信息");
}];


