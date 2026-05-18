//
//  SectionViewHeaderFooterView.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/14.
//

#import "SectionViewHeaderFooterView.h"
#import <Masonry/Masonry.h>

@interface SectionViewHeaderFooterView ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *image;
@end

@implementation SectionViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.label = [[UILabel alloc] init];
    self.label.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    self.image = [[UIImageView alloc] init];
    self.image.tintColor = [UIColor systemGrayColor];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.image];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label.mas_right).offset(8);
        make.centerY.equalTo(self.label);
    }];
}

- (void)configWithName:(NSString *)name {
    self.label.text = name;
    self.image.image = [UIImage systemImageNamed:@"play"];
}

@end
