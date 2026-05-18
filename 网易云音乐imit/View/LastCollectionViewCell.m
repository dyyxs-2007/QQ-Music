//
//  LastCollectionViewCell.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/18.
//

#import "LastCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface LastCollectionViewCell ()
@property (nonatomic, strong) GroupSong *song;
@property (nonatomic, strong) UIImageView *picture;
@property (nonatomic, strong) UILabel *name;
@end

@implementation LastCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.picture = [[UIImageView alloc] init];
    self.name = [[UILabel alloc] init];
    self.picture.clipsToBounds = YES;
    self.picture.layer.cornerRadius = 4;
    self.name.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    self.name.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.picture];
    [self.contentView addSubview:self.name];
    
    [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView).offset(-16);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.top.equalTo(self.picture.mas_bottom);
        make.left.equalTo(self.picture);
    }];
}


- (void)configWithModel:(GroupSong *)model {
    self.song = model;
    self.picture.image = [UIImage imageNamed:model.picture];
    self.name.text = model.title;
}
@end
