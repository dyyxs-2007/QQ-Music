//
//  ProfileSectionTableViewCell.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/17.
//

#import "ProfileSectionTableViewCell.h"//嵌套
#import "LastCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface ProfileSectionTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ProfileSectionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 8;
    layout.itemSize = CGSizeMake(180, 180);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[LastCollectionViewCell class] forCellWithReuseIdentifier:@"Last"];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LastCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Last" forIndexPath:indexPath];
    [cell configWithModel:self.data[indexPath.item]];
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configWithModels:(NSArray *)data {
    self.data = data;
    [self.collectionView reloadData];
}



@end
