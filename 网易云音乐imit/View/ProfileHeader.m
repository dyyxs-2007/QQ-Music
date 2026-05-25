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
@property (nonatomic, strong) UISegmentedControl *segmentControl;
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
    
    UIImageView *right = [[UIImageView alloc] init];
    right.image = [UIImage systemImageNamed:@"chevron.right"];
    [self.contentView addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-8);
    }];
    
    self.segmentControl = [[UISegmentedControl alloc] init];
    [self.segmentControl addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventValueChanged];
    
    [self.segmentControl setBackgroundImage:[UIImage new]
        forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.segmentControl setBackgroundImage:[UIImage new]
        forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self.segmentControl setDividerImage:[UIImage new]
        forLeftSegmentState:UIControlStateNormal
        rightSegmentState:UIControlStateNormal
        barMetrics:UIBarMetricsDefault];
    [self.segmentControl setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [UIColor secondaryLabelColor],
        NSFontAttributeName: [UIFont systemFontOfSize:16]
    } forState:UIControlStateNormal];

    [self.segmentControl setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [UIColor labelColor],
        NSFontAttributeName: [UIFont boldSystemFontOfSize:16]
    } forState:UIControlStateSelected];

    
    [self.contentView addSubview:self.segmentControl];
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.mas_height).offset(-8);
    }];
}

- (void)changeValue {
    if (self.type == Last) {
        return;
    }
    if (self.changeSeg) {
        SectionType t = self.segmentControl.selectedSegmentIndex == 0 ? Last : Myself;
        self.changeSeg(t);
    }
}

- (void)configWithType:(SectionType)type andIndex:(NSInteger)index{
    self.type = type;
    [self.segmentControl removeAllSegments];
    if (type == Last) {
        [self.segmentControl insertSegmentWithTitle:@"最近播放" atIndex:0 animated:NO];
        self.segmentControl.selectedSegmentIndex = 0;
    } else {
        [self.segmentControl insertSegmentWithTitle:@"经常收听" atIndex:0 animated:NO];
        [self.segmentControl insertSegmentWithTitle:@"收藏歌单" atIndex:1 animated:NO];
        self.segmentControl.selectedSegmentIndex = index;
    }
}
@end
