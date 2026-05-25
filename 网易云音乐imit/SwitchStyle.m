//
//  SwitchStyle.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/25.
//

#import "SwitchStyle.h"
@interface SwitchStyle ()

@end

@implementation SwitchStyle

+ (instancetype)sharedInstance {
    static SwitchStyle *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return self;
}
- (instancetype)mutableCopyWithZone:(NSZone *)zone {
    return self;
}

@end
