//
//  SongViewCollectionViewCell.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/14.
//

#import "SongViewCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface SongViewCollectionViewCell ()
@property (nonatomic, strong) UIImageView *picture;
@property (nonatomic, strong) UILabel *songName;
@property (nonatomic, strong) UILabel *master;
@end

@implementation SongViewCollectionViewCell

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
    self.master = [[UILabel alloc] init];
    [self.contentView addSubview:self.picture];
    [self.contentView addSubview:self.songName];
    [self.contentView addSubview:self.master];
    
    self.picture.clipsToBounds = YES;
    self.picture.layer.cornerRadius = 4;
    
    self.songName.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    
    self.master.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    self.master.textColor = [UIColor systemGrayColor];
    
    [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(8);
        make.width.equalTo(self.contentView.mas_height);
    }];
    [self.songName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picture.mas_right).offset(24);
        make.centerY.equalTo(self.picture).offset(-2);
    }];
    [self.master mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-8);
        make.left.equalTo(self.picture.mas_right).offset(32);
    }];
}

- (void)configWithData:(SongModel *)model {
    self.picture.image = [UIImage imageNamed:model.picture];
    self.songName.text = model.songName;
    self.master.text = model.master;
}

@end
