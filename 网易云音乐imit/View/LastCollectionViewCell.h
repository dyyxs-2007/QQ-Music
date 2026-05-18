//
//  LastCollectionViewCell.h
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/18.
//

#import <UIKit/UIKit.h>
#import "GroupSong.h"

NS_ASSUME_NONNULL_BEGIN

@interface LastCollectionViewCell : UICollectionViewCell
- (void)configWithModel:(GroupSong *)model;
@end

NS_ASSUME_NONNULL_END
