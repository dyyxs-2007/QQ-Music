//
//  SettingTableViewCell.h
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/26.
//

#import <UIKit/UIKit.h>

#import "CellModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SettingTableViewCell : UITableViewCell
@property (nonatomic, copy) void(^switchLight)(CellModel *model, BOOL isOn);
- (void)configWithModel:(CellModel *)model;
@end

NS_ASSUME_NONNULL_END
