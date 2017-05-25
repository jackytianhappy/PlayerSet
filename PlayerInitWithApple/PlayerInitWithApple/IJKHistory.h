//
//  IJKHistory.h
//  PlayerInitWithApple
//
//  Created by Jacky on 2017/5/25.
//  Copyright © 2017年 jacky. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IJKHistoryItem : NSObject<NSCoding>

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSURL *url;

@end


@interface IJKHistory : NSObject

+ (instancetype)instance;

@property (nonatomic,strong) NSArray *list;

- (void)removeAtIndex:(NSUInteger)index;
- (void)add:(IJKHistoryItem *)item;

@end
