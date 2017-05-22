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

@property (nonatomic,strong) UIProgressView *progressView;//进度条

@property (nonatomic,strong) UISlider *sliderBar;//滑动bar

@end

@implementation AVPlayerDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createAVPlayer];
    
    [self makeControlViews];
    
    //添加播放器监听教程
    [self addProgress];

}




/**
 创建avplayer
 */
- (void)createAVPlayer{
    self.playerVC = [[AVPlayerViewController alloc]init];
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4"]];
    
    self.playerVC.player = [AVPlayer playerWithPlayerItem:item];
    //播放不了rtmp协议
//    rtmp://10.0.114.80/myapp/mystream
//    self.playerVC.player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"rtmp://10.0.114.80/myapp/mystream"]];
    self.playerVC.view.frame = self.view.bounds;
    
    self.playerVC.showsPlaybackControls = NO; //隐藏掉原生界面的控制按钮，接下来可以通过视图进行自定义
    
    self.playerVC.delegate = self; //设置播放器的delegate 进行播放
    
    [self.view addSubview:self.playerVC.view];
    
    [self.playerVC.player play];
    
    
}

- (void)addProgress{
    AVPlayerItem *item = self.playerVC.player.currentItem;
    UIProgressView *progress = self.progressView;
    
    UISlider *slider = self.sliderBar;
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    
    
    [self.playerVC.player addPeriodicTimeObserverForInterval:CMTimeMake(1., 1.) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        //CMTime是视频时间信息的结构体 包含视频时间点、美秒的帧数等信息
        //获取当前的播放到的描述
        float current = CMTimeGetSeconds(time);
        
        //获取总的视频时间长度
        float total = CMTimeGetSeconds(item.duration);
    
        if (current) {
            [progress setProgress:(current/total) animated:YES];
            NSLog(@"开始进行监听了:%f",(current/total));
            
            slider.value = (current/total);
        }
        
    }];
}


- (void)makeControlViews{
    //创建开始暂停按钮
    self.pauseOrStartBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100, 100, 100)];
    [self.pauseOrStartBtn setTitle:@"暂停" forState:UIControlStateNormal];
    self.pauseOrStartBtn.tag = player_start;
    [self.pauseOrStartBtn addTarget:self action:@selector(pauseOrStartAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.pauseOrStartBtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.pauseOrStartBtn];
    
    //创建进度条
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(10, 40, [UIScreen mainScreen].bounds.size.width- 20, 30)];
    self.progressView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.progressView];
    
    //创建控制的的进度条
    self.sliderBar = [[UISlider alloc]initWithFrame:CGRectMake(10, 80, [UIScreen mainScreen].bounds.size.width- 20, 30)];
    self.sliderBar.continuous = YES;
    [self.view addSubview:self.sliderBar];
    [self.sliderBar addTarget:self action:@selector(changeSliderValue:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)changeSliderValue:(id)sender{
    NSLog(@"开始进行拖拽");
    UISlider *slider = (UISlider *)sender;
    
    
    AVPlayerItem *item = self.playerVC.player.currentItem;
    
//    //获取当前的播放到的描述
//    float current = CMTimeGetSeconds(item.duration);
//    
//    //获取总的视频时间长度
//    float total = CMTimeGetSeconds(item.duration);
    
    [self.playerVC.player seekToTime:CMTimeMake(CMTimeGetSeconds(item.duration)*slider.value, 1)];
    
    
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
