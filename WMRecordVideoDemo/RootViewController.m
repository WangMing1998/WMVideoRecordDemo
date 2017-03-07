//
//  RootViewController.m
//  WMRecordVideoDemo
//
//  Created by Heato on 2017/3/6.
//  Copyright © 2017年 wangming深圳市希顿科技. All rights reserved.
//

#import "RootViewController.h"
#import "PortraitSpaceRecordVideo.h"
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
    LandSpaceRecordVideo *lanSpaceVC = [[UIStoryboard storyboardWithName:@"LandSpace" bundle:[NSBundle mainBundle]]
                                        instantiateViewControllerWithIdentifier:@"LandSpaceRecordVideo"];
    
    [self.navigationController pushViewController:lanSpaceVC animated:YES];
}


- (IBAction)portraitRecord:(UIButton *)sender
{
    PortraitSpaceRecordVideo *VC = [[UIStoryboard storyboardWithName:@"PortraitSpace" bundle:[NSBundle mainBundle]]
                                    instantiateViewControllerWithIdentifier:@"PortraitSpaceRecordVideo"];;
    
    [self.navigationController pushViewController:VC animated:YES];
}

@end
