//
//  SectionTableViewCell.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/14.
//

#import "SectionTableViewCell.h"
#import <Masonry/Masonry.h>
#import "SongViewCollectionViewCell.h"
#import "TopSectionCollectionViewCell.h"


@interface SectionTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, assign) CellType cellType;

@end

@implementation SectionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[SongViewCollectionViewCell class] forCellWithReuseIdentifier:@"Collection"];
    [self.collectionView registerClass:[TopSectionCollectionViewCell class] forCellWithReuseIdentifier:@"Top"];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellType == Top) {
        TopSectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Top" forIndexPath:indexPath];
        [cell configWithData:self.songs[indexPath.item]];
        return cell;
    }
    SongViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Collection" forIndexPath:indexPath];
    [cell configWithData:self.songs[indexPath.item]];
    __weak typeof(self) weakSelf = self;
    cell.changePlay = ^{
        if (weakSelf.changePlay) {
            NSIndexPath *ixp = [NSIndexPath indexPathForItem:indexPath.item inSection:self.section];
            weakSelf.changePlay(ixp);
        }
    };
    return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.songs.count;
}

- (void)configWithSong:(NSArray *)songs CellType:(CellType)CellType {
    self.songs = songs;
    self.cellType = CellType;
    if (CellType == Top) {
        self.layout.minimumInteritemSpacing = 16;
        self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView.pagingEnabled = NO;
        self.layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 3 * 2, 152);
        self.layout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4);
    } else {
        self.layout.minimumInteritemSpacing = 0;
        self.layout.minimumLineSpacing = 4;
        self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView.pagingEnabled = YES;
        self.layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 72);
        self.layout.sectionInset = UIEdgeInsetsMake(4, 0, 0, 4);
    }
    [self.collectionView reloadData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)fresh {
    [self.collectionView reloadData];
}

@end
