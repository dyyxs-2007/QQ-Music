//
//  TopSectionCollectionViewCell.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/15.
//

#import "TopSectionCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface TopSectionCollectionViewCell ()
@property (nonatomic, strong) UIImageView *picture;
@property (nonatomic, strong) UILabel *songName;
@property (nonatomic, strong) UILabel *master;
@end

@implementation TopSectionCollectionViewCell

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
    self.songName = [[UILabel alloc] init];
    [self.contentView addSubview:self.picture];
    [self.contentView addSubview:self.songName];
    self.picture.clipsToBounds = YES;
    self.picture.layer.cornerRadius = 4;
    
    self.songName.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    
    [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(4);
        make.height.width.mas_equalTo(self.contentView.mas_height);
        make.centerY.equalTo(self.contentView);
    }];
    [self.songName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picture.mas_right).offset(16);
        make.centerY.equalTo(self.picture).offset(-8);
    }];
    
    UILabel *word = [[UILabel alloc] init];
    word.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    word.alpha = 0.5;
    word.numberOfLines = 0;
    word.text = @"Daily";
    word.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:word];
    [word mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.centerX.equalTo(self.songName);
        make.left.equalTo(self.picture.mas_right);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(self.contentView.bounds.size.height / 5);
    }];
}

- (void)configWithData:(SongModel *)model {
    self.picture.image = [UIImage imageNamed:model.picture];
    self.songName.text = model.songName;
    self.master.text = model.master;
}
@end
