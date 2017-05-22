//
//  JMediaPlayerVC.m
//  PlayerInitWithApple
//
//  Created by Jacky on 2017/5/19.
//  Copyright © 2017年 jacky. All rights reserved.
//

#import "JMediaPlayerVC.h"
#import <MediaPlayer/MediaPlayer.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
@interface JMediaPlayerVC ()

@property (nonatomic,strong) MPMoviePlayerController *moviewPlayer;// iOS 9之后废弃了这个方法

@end

@implementation JMediaPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"开始进行播放" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showMPMovieMediaController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self initPlayer];

    [self addNotification];
}

- (void)initPlayer{
    //rtmp://10.0.114.80/myapp/mystream
    self.moviewPlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@"http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4"]];
    //不支持RTMP的播放
//    self.moviewPlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@"rtmp://10.0.114.80/myapp/mystream"]];
    
    self.moviewPlayer.view.frame = CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, 300);
    self.moviewPlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
//    self.moviewPlayer.backgroundView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.moviewPlayer.view];
    
    [self.moviewPlayer prepareToPlay];

}


//attention 获取正确的监听装填进行监听播放状态
- (void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayerLoadStateDidChange) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
}

- (void)moviePlayerLoadStateDidChange{
    NSLog(@"点击到我了");
    
    switch (self.moviewPlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviewPlayer.playbackState);
            break;
    }
}


- (void)showMPMovieMediaController{
    
    [self.moviewPlayer play];
}
#pragma clang diagnostic pop


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
