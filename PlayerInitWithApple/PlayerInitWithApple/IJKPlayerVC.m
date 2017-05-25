//
//  IJKPlayerVC.m
//  PlayerInitWithApple
//
//  Created by Jacky on 2017/5/25.
//  Copyright © 2017年 jacky. All rights reserved.
//

#import "IJKPlayerVC.h"

@interface IJKPlayerVC ()

@end

@implementation IJKPlayerVC

- (id)initWithUrl:(NSURL *)url{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

+ (void)presentFromViewController:(UIViewController *)viewController withTitle:(NSString *)title URL:(NSString *)url completion:(void (^)())completion{
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
