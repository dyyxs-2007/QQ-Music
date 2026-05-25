//
//  HomeViewController.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/11.
//

#import "HomeViewController.h"
#import <Masonry/Masonry.h>
#import "SectionViewHeaderFooterView.h"
#import "SongViewCollectionViewCell.h"
#import "SectionTableViewCell.h"
#import "SectionModel.h"
#import "SongModel.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *section;
@property (nonatomic, strong) NSIndexPath *index;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupBar];
    [self setupTableView];
}


- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerClass:[SectionTableViewCell class] forCellReuseIdentifier:@"Section"];
    [self.tableView registerClass:[SectionViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"Header"];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    SectionModel *model = self.section[section];
    [headerView configWithName:model.header];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SectionModel *model = self.section[indexPath.section];
    
    SectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Section" forIndexPath:indexPath];
    cell.section = indexPath.section;
    __weak typeof(self) weakSelf = self;
    cell.changePlay = ^(NSIndexPath * _Nonnull ixP) {
        if (weakSelf.index != nil) {
            SectionModel *sectionModel = weakSelf.section[weakSelf.index.section];
            SongModel *songModel = sectionModel.songs[weakSelf.index.row];
            songModel.isPlay = !songModel.isPlay;
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:weakSelf.index.section];
            [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        }
        if (![weakSelf.index isEqual:ixP]) {
            SectionModel *sectionModel = weakSelf.section[ixP.section];
            SongModel *songModel = sectionModel.songs[ixP.item];
            songModel.isPlay = !songModel.isPlay;
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:ixP.section];
            [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
            weakSelf.index = ixP;
        } else {
            weakSelf.index = nil;
        }
    };
    if (indexPath.section == 0) {
        [cell configWithSong:model.songs CellType:Top];
    } else {
        [cell configWithSong:model.songs CellType:Down];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 160;
    }
    return 240;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.section.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (void)setupBar {
    UISearchBar *search = [[UISearchBar alloc] init];
    search.placeholder = @"🎵周杰伦 偏好歌手";
    search.layer.cornerRadius = 8;
    search.clipsToBounds = YES;
    search.searchBarStyle = UISearchBarStyleMinimal;
    search.frame = CGRectMake(0, 0, self.view.bounds.size.width - 80, 36);
    self.navigationItem.titleView = search;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardDown)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)keyboardDown {
    [self.view.window endEditing:YES];
}

- (void)setupData {
    self.index = nil;
    NSArray *head = @[
        @"Recesses",
        @"大家都在听",
        @"把疲惫放一放，今晚听点治愈的"
    ];
    NSArray *songName = @[
        @"Letter That Writing in the Wind",
        @"江南",
        @"Rain Love",
        @"safe again",
        @"Pure Thoughts",
        @"Lullaby",
        @"Here With Me (Lofi)",
        @"灰烬之前",
        @"Reminiscences",
        @"Natural Cause",
        @"最后告别 (prod by Lyoung)",
        @"说了再见",
        @"time machine (feat. aren park)",
        @"City",
        @"奇妙能力歌",
        @"Cry For Me",
        @"Lullaby"
    ];
    NSArray *master = @[
        @"undefined",
        @"林俊杰",
        @"Timon",
        @"LMNL",
        @"Kondor",
        @"Enzalla",
        @"ZICX",
        @"土土土",
        @"Re:Plus",
        @"Emancipa",
        @"兔团团",
        @"周杰伦",
        @"mj apanay",
        @"羽肿",
        @"陈粒",
        @"Michita",
        @"Enzalla"
    ];
    NSArray *picture = @[
        @"Letter That Writing in the Wind",
        @"江南",
        @"Rain Love",
        @"safe again",
        @"Pure Thoughts",
        @"Lullaby",
        @"Here With Me (Lofi)",
        @"灰烬之前",
        @"Reminiscences",
        @"Natural Cause",
        @"最后告别 (prod by Lyoung)",
        @"说了再见",
        @"time machine (feat. aren park)",
        @"City",
        @"奇妙能力歌",
        @"Cry For Me",
        @"Lullaby"
    ];
    self.section = [NSMutableArray array];
    NSArray *arr = @[@3, @9, @5];
    NSInteger count = 0;
    for (NSInteger i = 0; i < head.count; i++) {
        SectionModel *sectionModel = [[SectionModel alloc] init];
        sectionModel.header = head[i];
        NSMutableArray *songs = [NSMutableArray array];
        for (NSInteger j = 0; j < [arr[i] integerValue]; j++, count++) {
            SongModel *song = [[SongModel alloc] init];
            song.master = master[count];
            song.songName = songName[count];
            song.picture = picture[count];
            song.isPlay = NO;
            [songs addObject:song];
        }
        sectionModel.songs = songs;
        [self.section addObject:sectionModel];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self keyboardDown];
}
@end
