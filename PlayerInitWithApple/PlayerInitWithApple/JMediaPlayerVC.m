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
    [btn setTitle:@"点击我进行网络加载我进行网络加载" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showMPMovieMediaController) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];

    
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkMovieStatus:) name:MPMoviePlayerLoadStateDidChangeNotification object:self.moviewPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkMovieStatus:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviewPlayer];
}

- (void)checkMovieStatus:(NSNotification *)notification{
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
    self.moviewPlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@"http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4"]];
    self.moviewPlayer.view.frame = self.view.bounds;
    self.moviewPlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    self.moviewPlayer.backgroundView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.moviewPlayer.view];
    
    
    [self addNotification];
    
    
    [self.moviewPlayer play];
}
#pragma clang diagnostic pop


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
