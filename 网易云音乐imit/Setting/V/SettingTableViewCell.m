//
//  SettingTableViewCell.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/26.
//

#import "SettingTableViewCell.h"
#import <Masonry/Masonry.h>

@interface SettingTableViewCell ()
@property (nonatomic, strong) CellModel *model;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UIImageView *right;
@end

@implementation SettingTableViewCell


- (void)configWithModel:(CellModel *)model {
    self.model = model;
    self.title.text = model.title;
    self.detail.text = model.detail;
    self.switchView.on = model.isOn;
    switch (model.type) {
        case cellTypeNormal:
            self.switchView.hidden = YES;
            self.detail.hidden = YES;
            break;
        case cellTypeSwitch:
            self.right.hidden = YES;
            self.detail.hidden = YES;
            break;
        case cellTypeDetail:
            self.switchView.hidden = YES;
            break;
        default:
            break;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.title = [[UILabel alloc] init];
    self.title.textColor = [UIColor labelColor];
    self.title.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.right = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.right"]];
    self.right.tintColor = [UIColor systemGray3Color];
    [self.contentView addSubview:self.right];
    [self.right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-16);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(16);
    }];
    
    self.detail = [[UILabel alloc] init];
    self.detail.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    self.detail.textColor = [UIColor secondaryLabelColor];
    [self.contentView addSubview:self.detail];
    [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right.mas_left).offset(-4);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.switchView = [[UISwitch alloc] init];
    self.switchView.on = self.model.isOn;
    [self.switchView addTarget:self action:@selector(changeSwitch) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.switchView];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-16);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)changeSwitch {
    if (self.switchLight) {
        self.switchLight(self.model, self.switchView.isOn);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
