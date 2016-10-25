//
//  ViewController.m
//  XVRDemo
//
//  Created by weige on 16/10/24.
//  Copyright © 2016年 Wei. All rights reserved.
//

#import "ViewController.h"
#import "PlayControlBar.h"
#import "GCSVideoView.h"

@interface ViewController ()<GCSVideoViewDelegate>
@property (weak, nonatomic) IBOutlet GCSVideoView *VRPlayerView;
@property (weak, nonatomic) IBOutlet UITextField *URLText;
@property (weak, nonatomic) IBOutlet UISwitch *URLSwitch;
@end

@implementation ViewController{
    BOOL _isPaused;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.VRPlayerView addSubview:[[PlayControlBar alloc] initWithFrame:self.VRPlayerView.frame]];
    [self initWithVideo];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 初始化播放器
 */
- (void)initWithVideo{
    _isPaused = NO;
    _VRPlayerView.delegate = self;
    _VRPlayerView.enableCardboardButton = YES;
    _VRPlayerView.enableFullscreenButton = YES;
//    [_VRPlayerView loadFromUrl:[NSURL   URLWithString:@"http://120.25.246.21/vrMobile/travelVideo/zhejiang_xuanchuanpian.mp4"]];
    // @"http://120.25.246.21/vrMobile/travelVideo/beijing_congzhenwaibozishu.mp4"
}

- (IBAction)ChangedURLSwitch:(UISwitch *)sender {
    
    if (sender.on) {
        if ([_URLText.text length] <= 0) {
            sender.on = NO;
        }else{
            [_URLText setEnabled:NO];
            [_VRPlayerView loadFromUrl:[NSURL   URLWithString:_URLText.text]];
        }
    }else{
        [_URLText setEnabled:YES];
        [_VRPlayerView stop];
    }
    
}


#pragma mark ----GCSVideoViewDelegate----
/**
 GCSVideoView的点击事件

 @param widgetView 播放器对象
 */
-(void)widgetViewDidTap:(GCSWidgetView *)widgetView{
    if (_isPaused) {
        [_VRPlayerView resume];
    }else{
        [_VRPlayerView pause];
    }
    _isPaused = !_isPaused;
}


/**
 视频播放到某个位置时触发事件

 @param videoView 播放器对象
 @param position  但前进度 单位：s
 */
-(void)videoView:(GCSVideoView *)videoView didUpdatePosition:(NSTimeInterval)position{
    
//    [_durationlabel setText:[NSString stringWithFormat:@"%@/%@",[ViewController TimeformatFromSeconds:position],[ViewController TimeformatFromSeconds:videoView.duration]]];
    
    if (position == videoView.duration) {
        [_VRPlayerView seekTo:0];
        [_VRPlayerView resume];
    }
}


/**
 视频播放失败

 @param widgetView   播放器对象
 @param content      未知
 @param errorMessage 错误信息
 */
-(void)widgetView:(GCSWidgetView *)widgetView didFailToLoadContent:(id)content withErrorMessage:(NSString *)errorMessage{
    NSLog(@"播放错误:%@",errorMessage);
}

#pragma mark - 旋转屏幕适配
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
//    [self.VRPlayerView setCenter:self.view.center];
    
    return UIInterfaceOrientationMaskAll;
    
}
@end
