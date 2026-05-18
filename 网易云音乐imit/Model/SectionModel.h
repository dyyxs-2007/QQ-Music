//
//  SectionModel.h
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SectionModel : NSObject
@property (nonatomic, strong) NSArray *songs;
@property (nonatomic, copy) NSString *header;
@end

NS_ASSUME_NONNULL_END
