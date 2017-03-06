//
//  ViewController.m
//  WMRecordVideoDemo
//
//  Created by Heato on 2017/3/3.
//  Copyright © 2017年 wangming深圳市希顿科技. All rights reserved.
//

#import "ViewController.h"
#import <WMRecordLibrary/WMRecordLibrary.h>
#import "BBFlashCtntLabel.h"
@interface ViewController ()
@property(nonatomic,strong) WMRecorder *recordVideoManager;
@property(nonatomic,strong) WMRecordConfiguration *recordVideoConfiguration;
@property(nonatomic,strong) BBFlashCtntLabel *autoScrollLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.recordVideoConfiguration = [[WMRecordConfiguration alloc] init];
    self.recordVideoConfiguration.videoSaveType = systemPhotoAlbum;
    self.recordVideoConfiguration.videoRecordFps = 30;
    self.recordVideoConfiguration.videoRecordSize = CGSizeMake(720, 1080);
    self.recordVideoConfiguration.videoRecordType = videoRecordType_720P;
    self.recordVideoConfiguration.cameraPosition = cameraPositionBack;
    self.recordVideoConfiguration.videoRecordBitRate = 800000;
    self.recordVideoConfiguration.audioBitRate = 64000;
    self.recordVideoConfiguration.recordOrientation = videoRecordOrientationPortrait;
    self.recordVideoConfiguration.videoRecordMaxTime = 7200;
    
    self.recordVideoManager = [[WMRecorder alloc] initWithRecordConfiguration:self.self.recordVideoConfiguration];
    
    self.recordVideoManager.previewLayer.frame = self.view.bounds;

    [self.view.layer insertSublayer:self.recordVideoManager.previewLayer atIndex:0];
    [self.recordVideoManager startPreview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)videoRecordTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.selected)
    {
        [self.recordVideoManager startRecording];
    }else
    {
        [self.recordVideoManager stopRecordingVideo:^(UIImage *movieImage, NSDictionary *videoInfo) {
            NSLog(@"%@,%@",videoInfo,movieImage);
            
        }];
    }
}

@end
