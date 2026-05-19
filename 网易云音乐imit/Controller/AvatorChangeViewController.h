//
//  AvatorChangeViewController.h
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/19.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AvatorChangeDelegate <NSObject>

- (void)changePictureWithImage:(UIImage *)image;

@end

@interface AvatorChangeViewController : ViewController
@property (nonatomic,copy) UIImage *avatorImage;
@property (nonatomic, weak) id<AvatorChangeDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
