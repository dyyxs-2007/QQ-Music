//
//  ProfileGroupSongTableViewCell.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/17.
//

#import "ProfileGroupSongTableViewCell.h"
#import <Masonry/Masonry.h>

@interface ProfileGroupSongTableViewCell ()
@property (nonatomic, strong) GroupSong *model;
@property (nonatomic, strong) UIImageView *picture;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *detail;
@end

@implementation ProfileGroupSongTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.picture = [[UIImageView alloc] init];
    self.title = [[UILabel alloc] init];
    self.detail = [[UILabel alloc] init];
    
    [self.contentView addSubview: self.picture];
    [self.contentView addSubview: self.title];
    [self.contentView addSubview: self.detail];
    
    
    self.picture.clipsToBounds = YES;
    self.picture.layer.cornerRadius = 4;
    
    self.title.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];

    self.detail.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    self.detail.textColor = [UIColor systemGrayColor];
    
    [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(2);
        make.bottom.equalTo(self.contentView).offset(-2);
        make.left.equalTo(self.contentView).offset(16);
        make.width.equalTo(self.contentView.mas_height).offset(-4);
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picture.mas_right).offset(24);
        make.centerY.equalTo(self.picture).offset(-2);
    }];
    [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-8);
        make.left.equalTo(self.picture.mas_right).offset(32);
    }];
}

- (void)configWithModel:(GroupSong *)model {
    self.model = model;
    self.picture.image = [UIImage imageNamed:model.picture];
    self.title.text = model.title;
    self.detail.text = model.detail;
}

@end
