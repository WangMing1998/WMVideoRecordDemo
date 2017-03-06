//
//  RootViewController.m
//  WMRecordVideoDemo
//
//  Created by Heato on 2017/3/6.
//  Copyright © 2017年 wangming深圳市希顿科技. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"
#import "LandSpaceRecordVideo.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"加载");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)landscapeRecord:(UIButton *)sender {
    LandSpaceRecordVideo *lanSpaceVC = [[LandSpaceRecordVideo alloc] init];
    
    [self.navigationController pushViewController:lanSpaceVC animated:YES];
}


- (IBAction)portraitRecord:(UIButton *)sender
{
    ViewController *VC = [[ViewController alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
}

@end
