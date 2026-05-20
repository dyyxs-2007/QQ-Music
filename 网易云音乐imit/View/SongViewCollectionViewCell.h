//
//  SongViewCollectionViewCell.h
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/14.
//

#import <UIKit/UIKit.h>
#import "SongModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SongViewCollectionViewCell : UICollectionViewCell
- (void)configWithData:(SongModel *)model;
@property (nonatomic, copy) void(^changePlay)(void);
@end

NS_ASSUME_NONNULL_END
