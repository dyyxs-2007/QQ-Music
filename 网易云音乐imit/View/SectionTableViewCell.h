//
//  SectionTableViewCell.h
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/14.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Top,
    Down,
} CellType;

NS_ASSUME_NONNULL_BEGIN

@interface SectionTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray* songs;
- (void)configWithSong:(NSArray *)songs CellType:(CellType)CellType;
@property (nonatomic,copy) void(^changePlay)(NSIndexPath *ixP);
@property (nonatomic, assign) NSInteger section;

- (void)fresh;
@end

NS_ASSUME_NONNULL_END
