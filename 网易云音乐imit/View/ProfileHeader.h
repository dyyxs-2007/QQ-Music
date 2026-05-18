//
//  ProfileHeader.h
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    Last,
    Myself,
} SectionType;

@interface ProfileHeader : UITableViewHeaderFooterView
- (void)configWithType:(SectionType)type;
@end

NS_ASSUME_NONNULL_END
