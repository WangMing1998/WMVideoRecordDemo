//
//  LandSpaceRecordVideo.m
//  WMRecordVideoDemo
//
//  Created by Heato on 2017/3/6.
//  Copyright © 2017年 wangming深圳市希顿科技. All rights reserved.
//

#import "LandSpaceRecordVideo.h"
#import "AppDelegate.h"
#import <WMRecordLibrary/WMRecordLibrary.h>
@interface LandSpaceRecordVideo ()
@property(nonatomic,strong) WMRecorder *recordVideoManager;
@property(nonatomic,strong) WMRecordConfiguration *recordVideoConfiguration;
@end

@implementation LandSpaceRecordVideo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    [self viewOrientation:self.view withOritentation:UIInterfaceOrientationLandscapeRight];
    
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
    
    self.recordVideoManager.previewLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    [self.view.layer insertSublayer:self.recordVideoManager.previewLayer atIndex:0];
    [self.recordVideoManager startPreview];

}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self viewOrientation:self.view withOritentation:UIInterfaceOrientationPortrait];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*默认全屏控制器 旋转配置**/
-(void)viewOrientation:(UIView *)view withOritentation:(UIInterfaceOrientation)orientation {
    
    switch (orientation) {
        case UIInterfaceOrientationPortrait: {
            AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
            appdelegate.isForcePortrait=YES;
            appdelegate.isForceLandscape = NO;
            [UIView animateWithDuration:0.3 animations:^{
                view.window.transform = CGAffineTransformMakeRotation(M_PI*2);
                
            }];
            [self deviceOrientation:UIInterfaceOrientationPortrait annimation:YES];
        }
            break;
        case UIInterfaceOrientationLandscapeRight: {
            AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
            appdelegate.isForceLandscape=YES;
            [UIView animateWithDuration:0.3 animations:^{
                NSLog(@"view存在%@",view);
                view.window.transform = CGAffineTransformMakeRotation(M_PI/2);
                [self deviceOrientation:UIInterfaceOrientationLandscapeRight annimation:YES];
            }];
        }
            break;
        default:
            break;
    }
    view.window.bounds = [[UIScreen mainScreen] bounds];
    view.bounds = view.window.bounds;
}


- (void)deviceOrientation:(UIInterfaceOrientation)orientation annimation:(BOOL)annimation{
    
    NSTimeInterval an = annimation?0.3:0;
    [UIView animateWithDuration:an
                     animations:^{
                         NSNumber *value = [NSNumber numberWithInt:orientation];
                         [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
                     }];
}


@end
