//
//  TopSectionCollectionViewCell.h
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/15.
//

#import <UIKit/UIKit.h>
#import "SongModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopSectionCollectionViewCell : UICollectionViewCell
- (void)configWithData:(SongModel *)model;
@end

NS_ASSUME_NONNULL_END
