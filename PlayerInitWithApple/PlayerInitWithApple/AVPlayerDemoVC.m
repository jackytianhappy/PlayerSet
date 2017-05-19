//
//  AVPlayerDemoVC.m
//  PlayerInitWithApple
//
//  Created by Jacky on 2017/5/19.
//  Copyright © 2017年 jacky. All rights reserved.
//

#import "AVPlayerDemoVC.h"
#import <AVFoundation/AVFoundation.h>//基于AVFoundation,通过实例化的控制器来设置player属性
#import <AVKit/AVKit.h>  //iOS 9新增

typedef NS_ENUM(NSUInteger,isPauseOrStart){
    player_pause,
    player_start
};

@interface AVPlayerDemoVC ()<AVPlayerViewControllerDelegate>

@property (nonatomic,strong) UIButton *pauseOrStartBtn;

@property (nonatomic,strong) AVPlayerViewController *playerVC;

@end

@implementation AVPlayerDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createAVPlayer];
    
    [self makeControlViews];
}


/**
 创建avplayer
 */
- (void)createAVPlayer{
    self.playerVC = [[AVPlayerViewController alloc]init];
    self.playerVC.player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4"]];
    self.playerVC.view.frame = self.view.bounds;
    
    self.playerVC.showsPlaybackControls = NO; //隐藏掉原生界面的控制按钮，接下来可以通过视图进行自定义
    
    self.playerVC.delegate = self; //设置播放器的delegate 进行播放
    
    [self.view addSubview:self.playerVC.view];
    
    [self.playerVC.player play];
}

- (void)makeControlViews{
    self.pauseOrStartBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100, 100, 100)];
    [self.pauseOrStartBtn setTitle:@"暂停" forState:UIControlStateNormal];
    self.pauseOrStartBtn.tag = player_start;
    [self.pauseOrStartBtn addTarget:self action:@selector(pauseOrStartAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.pauseOrStartBtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.pauseOrStartBtn];
}

- (void)pauseOrStartAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == player_start) {//暂停
        [self.pauseOrStartBtn setTitle:@"播放" forState:UIControlStateNormal];
        btn.tag = player_pause;
        [self.playerVC.player pause];
        
    }else{//播放啦
        btn.tag = player_start;
        [self.playerVC.player play];
        [self.pauseOrStartBtn setTitle:@"暂停" forState:UIControlStateNormal];
        
    }
}

#pragma mark -AVPlayerDelegate
/*!
	@method		playerViewControllerWillStartPictureInPicture:
	@param		playerViewController
 The player view controller.
	@abstract	Delegate can implement this method to be notified when Picture in Picture will start.
 */
- (void)playerViewControllerWillStartPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"playerViewControllerWillStartPictureInPicture");
}

/*!
	@method		playerViewControllerDidStartPictureInPicture:
	@param		playerViewController
 The player view controller.
	@abstract	Delegate can implement this method to be notified when Picture in Picture did start.
 */
- (void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"playerViewControllerDidStartPictureInPicture");
}

/*!
	@method		playerViewController:failedToStartPictureInPictureWithError:
	@param		playerViewController
 The player view controller.
	@param		error
 An error describing why it failed.
	@abstract	Delegate can implement this method to be notified when Picture in Picture failed to start.
 */
- (void)playerViewController:(AVPlayerViewController *)playerViewController failedToStartPictureInPictureWithError:(NSError *)error{
    NSLog(@"failedToStartPictureInPictureWithError");
}

/*!
	@method		playerViewControllerWillStopPictureInPicture:
	@param		playerViewController
 The player view controller.
	@abstract	Delegate can implement this method to be notified when Picture in Picture will stop.
 */
- (void)playerViewControllerWillStopPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"playerViewControllerWillStopPictureInPicture");
}

/*!
	@method		playerViewControllerDidStopPictureInPicture:
	@param		playerViewController
 The player view controller.
	@abstract	Delegate can implement this method to be notified when Picture in Picture did stop.
 */
- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"playerViewControllerDidStopPictureInPicture");
}

/*!
	@method		playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:
	@param		playerViewController
 The player view controller.
	@abstract	Delegate can implement this method and return NO to prevent player view controller from automatically being dismissed when Picture in Picture starts.
 */
//- (BOOL)playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:(AVPlayerViewController *)playerViewController{
//    
//}

/*!
	@method		playerViewController:restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:
	@param		playerViewController
 The player view controller.
	@param		completionHandler
 The completion handler the delegate needs to call after restore.
	@abstract	Delegate can implement this method to restore the user interface before Picture in Picture stops.
 */
- (void)playerViewController:(AVPlayerViewController *)playerViewController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL restored))completionHandler{
    NSLog(@"restoreUserInterfaceForPictureInPictureStopWithCompletionHandler");
}


@end
