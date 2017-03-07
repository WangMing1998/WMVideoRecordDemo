//
//  ViewController.m
//  WMRecordVideoDemo
//
//  Created by Heato on 2017/3/3.
//  Copyright © 2017年 wangming深圳市希顿科技. All rights reserved.
//

#import "PortraitSpaceRecordVideo.h"
#import <WMRecordLibrary/WMRecordLibrary.h>

@interface PortraitSpaceRecordVideo ()
@property(nonatomic,strong) WMRecorder *recordVideoManager;
@property(nonatomic,strong) WMRecordConfiguration *recordVideoConfiguration;
@property (weak, nonatomic) IBOutlet UIButton *buttonSetting;
@property (weak, nonatomic) IBOutlet UIButton *buttonSwitchCamera;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonRecord;
@property (weak, nonatomic) IBOutlet UIButton *buttonAudioMute;
@property (weak, nonatomic) IBOutlet UISlider *zoomValueSlider;
@property (weak, nonatomic) IBOutlet UIView *viewSetting;
@property (nonatomic,strong) NSTimer *timerCounter;
@end

@implementation PortraitSpaceRecordVideo

{
    NSUInteger _hour;
    NSUInteger _min;
    NSUInteger _sec;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UI初始化
    self.navigationController.navigationBar.hidden = YES;
    [self.zoomValueSlider setThumbImage:[UIImage imageNamed:@"picker_slider_thumb.png"] forState:UIControlStateNormal];
    self.timeLabel.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:16];
    self.zoomValueSlider.transform = CGAffineTransformMakeRotation(M_PI/2);
    self.viewSetting.layer.cornerRadius = 10;
    self.viewSetting.layer.masksToBounds = YES;
    self.viewSetting.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    // 初始化录制参数
    self.recordVideoConfiguration = [[WMRecordConfiguration alloc] init];
    self.recordVideoConfiguration.videoSaveType = systemPhotoAlbum;
    self.recordVideoConfiguration.videoRecordFps = 30;
    self.recordVideoConfiguration.videoRecordSize = CGSizeMake(640,480);
    self.recordVideoConfiguration.videoRecordType = videoRecordType_480P;
    self.recordVideoConfiguration.cameraPosition = cameraPositionBack;
    self.recordVideoConfiguration.videoRecordBitRate = 800000;
    self.recordVideoConfiguration.audioBitRate = 64000;
    self.recordVideoConfiguration.recordOrientation = videoRecordOrientationPortrait;
    self.recordVideoConfiguration.videoRecordMaxTime = 7200;
    self.recordVideoManager = [[WMRecorder alloc] initWithRecordConfiguration:self.self.recordVideoConfiguration];
    
    // 开启预览
    self.recordVideoManager.previewLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view.layer insertSublayer:self.recordVideoManager.previewLayer atIndex:0];
    [self.recordVideoManager startPreview];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (IBAction)backButtonTapped:(UIButton *)sender {
    if(self.recordVideoManager.isCapturing){
        NSLog(@"正在录制，先停止录制再返回");
        [self.recordVideoManager stopRecordingVideo:^(UIImage *movieImage, NSDictionary *videoInfo) {
            [self stopTimeCountTimer];
            NSLog(@"视频截图:%@\n视频信息:%@\n",movieImage,videoInfo);
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

// 开关闪光灯
- (IBAction)switchFlashLightButtonTapped:(UIButton *)sender {
    if(self.recordVideoManager.isFrontCamera)
        return;// 前置摄像头不开启闪光灯
    sender.selected = !sender.selected;
    [self.recordVideoManager switchFlashLight];
}


- (IBAction)setVideoLevelButtonTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.selected){
        [self isHideSettingView:NO];
    }else{
        
        [self isHideSettingView:YES];
    }
}


-(void)isHideSettingView:(BOOL)isHide
{
    if(isHide){
        [UIView animateWithDuration:1 animations:^{
            self.viewSetting.hidden = YES;
        }];
        self.buttonSetting.selected = NO;
    }else{
        [UIView animateWithDuration:1 animations:^{
            self.viewSetting.hidden = NO;
        }];
    }
}

- (IBAction)buttonSDTapped:(UIButton *)sender {
    //
    [self.recordVideoManager setVideoRecordLevel:videoRecordType_480P withAudioBitRate:0 withVideoBitRate:0 withVideoFps:25];
    [self isHideSettingView:YES];
    [self.buttonSetting setTitle:sender.titleLabel.text forState:UIControlStateNormal];
}


- (IBAction)buttonHDTapped:(UIButton *)sender {
    [self.recordVideoManager setVideoRecordLevel:videoRecordType_720P withAudioBitRate:0 withVideoBitRate:0 withVideoFps:25];
    [self isHideSettingView:YES];
    [self.buttonSetting setTitle:sender.titleLabel.text forState:UIControlStateNormal];
}


- (IBAction)buttonMDTapped:(UIButton *)sender {
    [self.recordVideoManager setVideoRecordLevel:videoRecordType_1080P withAudioBitRate:0 withVideoBitRate:0 withVideoFps:25];
    [self isHideSettingView:YES];
    [self.buttonSetting setTitle:sender.titleLabel.text forState:UIControlStateNormal];
}

- (IBAction)switchCamera:(UIButton *)sender {
    
    [self.recordVideoManager switchCamera];
}


- (IBAction)SettingAudioMute:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.recordVideoManager.isAudioMute = sender.selected;
}


- (IBAction)recordButtonTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.selected)
    {
        [self.recordVideoManager startRecording];
        [self starTimeCountTimer];
    }else{
        
        [self stopTimeCountTimer];
        [self.recordVideoManager stopRecordingVideo:^(UIImage *movieImage, NSDictionary *videoInfo) {
            NSLog(@"视频截图大小:%@\n视频祥细信息:%@",movieImage,videoInfo);
        }];
        
    }
}

- (IBAction)setZoomValue:(UISlider *)sender {
    [self.recordVideoManager adjustCameraZoomValue:sender.value];
}


-(void)starTimeCountTimer
{
    self.timerCounter = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                         target:self
                                                       selector:@selector(timeCount)
                                                       userInfo:nil
                                                        repeats:YES];
    self.timeLabel.text = @"00:00:00";
    self.timeLabel.hidden = NO;
    self.buttonAudioMute.hidden = YES;
    self.buttonSetting.enabled = NO;
    [self isHideSettingView:YES];
    self.buttonSetting.selected = NO;
    self.buttonSwitchCamera.hidden = YES;
}

-(void)stopTimeCountTimer
{
    [self.timerCounter setFireDate:[NSDate distantFuture]];
    [self.timerCounter invalidate];
    self.timerCounter = nil;
    self.timeLabel.hidden = YES;
    self.timeLabel.text = nil;
    self.buttonAudioMute.hidden = NO;
    self.buttonSetting.enabled = YES;
    self.buttonSwitchCamera.hidden = NO;
    _sec = _min = _hour = 0;
}

-(void)timeCount
{
    if(_sec >= 59){
        _sec = 0;
        _min++;
        if(_min >=59){
            _min = 0;
            _hour ++;
        }if (_hour >= 23){
            _hour = 0;
            _sec = 0;
            _min = 0;
        }
    }else{
        _sec++;
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd:%02zd",_hour,_min,_sec];
}

@end
