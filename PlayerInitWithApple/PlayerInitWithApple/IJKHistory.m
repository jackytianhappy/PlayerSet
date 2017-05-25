//
//  IJKHistory.m
//  PlayerInitWithApple
//
//  Created by Jacky on 2017/5/25.
//  Copyright © 2017年 jacky. All rights reserved.
//

#import "IJKHistory.h"

@implementation IJKHistoryItem

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.url forKey:@"IJKPlayer_IJKHistoryItem_url"];
    [aCoder encodeObject:self.title forKey:@"IJKPlayer_IJKHistoryItem_title"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"IJKPlayer_IJKHistoryItem_title"];
        self.url = [aDecoder decodeObjectForKey:@"IJKPlayer_IJKHistoryItem_url"];
    }
    return  self;
}

@end

@implementation IJKHistory{
    NSMutableArray *_list;
}

+ (instancetype)instance{
    static IJKHistory *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[IJKHistory alloc]init];
    });
    
    return obj;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _list = [NSKeyedUnarchiver unarchiveObjectWithFile:[self dbfilePath]];
        if (_list == nil) {
            _list = [NSMutableArray alloc];
        }
    }
    return self;
}

- (NSArray *)list{
    return _list;
}

- (void)removeAtIndex:(NSUInteger)index{
    [_list removeObjectAtIndex:index];
    
    [NSKeyedArchiver archiveRootObject:_list toFile:[self dbfilePath]];
}


- (void)add:(IJKHistoryItem *)item{
    __block NSUInteger findIdx = NSNotFound;
    
    [_list enumerateObjectsUsingBlock:^(IJKHistoryItem *enumItem, NSUInteger idx, BOOL *stop) {
        if ([enumItem.url isEqual:item.url]) {
            findIdx = idx;
            *stop = YES;
        }
    }];
    
    if (NSNotFound != findIdx) {
        [_list removeObjectAtIndex:findIdx];
    }
    
    [_list insertObject:item atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_list toFile:[self dbfilePath]];
    
}


- (NSString *)dbfilePath{
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSAllDomainsMask, YES) firstObject];
    libraryPath = [libraryPath stringByAppendingString:@"IJKHistor.plist"];
    
    return libraryPath;
}



@end
