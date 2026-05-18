//
//  SongModel.h
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SongModel : NSObject
@property (nonatomic, copy) NSString *songName;
@property (nonatomic, copy) NSString *master;
@property (nonatomic, copy) NSString *picture;
@end

NS_ASSUME_NONNULL_END
