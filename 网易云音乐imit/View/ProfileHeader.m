//
//  ProfileHeader.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/17.
//

#import "ProfileHeader.h"
#import <Masonry/Masonry.h>

@interface ProfileHeader ()
@property (nonatomic, assign) SectionType type;
@property (nonatomic, strong) UILabel *label;
@end

@implementation ProfileHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.contentView.backgroundColor = [UIColor systemBackgroundColor];
    self.label = [[UILabel alloc] init];
    
    self.label.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    UIImageView *right = [[UIImageView alloc] init];
    right.image = [UIImage systemImageNamed:@"chevron.right"];
    [self.contentView addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-8);
    }];
}

- (void)configWithType:(SectionType)type {
    self.type = type;
    if (self.type == Last) {
        self.label.text = @"最近播放";
    } else {
        self.label.text = @"自建歌单";
    }
}
@end
