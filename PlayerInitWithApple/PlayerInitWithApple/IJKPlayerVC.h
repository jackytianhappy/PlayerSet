//
//  IJKPlayerVC.h
//  PlayerInitWithApple
//
//  Created by Jacky on 2017/5/25.
//  Copyright © 2017年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface IJKPlayerVC : UIViewController<IJKMediaUrlOpenDelegate>

@property (nonatomic,strong) NSURL *url;
@property (nonatomic,retain) id<IJKMediaPlayback> player;


- (id)initWithUrl:(NSURL *)url;

+ (void)presentFromViewController:(UIViewController *)viewController withTitle:(NSString *)title URL:(NSString *)url completion:(void(^)())completion;

@end
