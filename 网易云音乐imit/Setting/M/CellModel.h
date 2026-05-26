//
//  CellModel.h
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CellType) {
    cellTypeNormal,
    cellTypeDetail,
    cellTypeSwitch,
};

@interface CellModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, assign) CellType type;
@property (nonatomic, assign) BOOL isOn;
@end

NS_ASSUME_NONNULL_END
