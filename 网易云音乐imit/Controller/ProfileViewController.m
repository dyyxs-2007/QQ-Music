//
//  ProfileViewController.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/11.
//

#import "ProfileViewController.h"
#import "GroupSong.h"
#import <Masonry/Masonry.h>
#import "ProfileSectionTableViewCell.h"
#import "AvatorChangeViewController.h"
#import "ProfileGroupSongTableViewCell.h"
#import "ProfileHeader.h"
#import "STViewController.h"
#import "CellModel.h"
#import "SectionSettingModel.h"


@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource, AvatorChangeDelegate>
@property (nonatomic, assign) NSInteger judge;//0自建1喜欢
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *section;
@property (nonatomic, strong) NSMutableArray *loveSection;
@property (nonatomic, strong) UIImageView *avator;

@property (nonatomic, strong) NSMutableArray *settingSection;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupBar];
    [self setupTableView];
}

- (void)setupData {
    self.judge = 0;
    self.section = [NSMutableArray array];
    self.loveSection = [NSMutableArray array];
    NSArray *title = @[
        @"Rain Love",
        @"safe again",
        @"Pure Thoughts",
        @"Lullaby",
        @"灰烬之前",
        @"Reminiscences",
        @"最后告别 (prod by Lyoung)",
        @"说了再见",
        @"time machine (feat. aren park)",
        @"City",
        @"奇妙能力歌",
    ];
    NSArray *detail = @[
        @"undefined",
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
    ];
    NSArray *picture = @[
        @"Rain Love",
        @"safe again",
        @"Pure Thoughts",
        @"Lullaby",
        @"灰烬之前",
        @"Reminiscences",
        @"最后告别 (prod by Lyoung)",
        @"说了再见",
        @"time machine (feat. aren park)",
        @"City",
        @"奇妙能力歌",
    ];
    
    for (NSInteger i = 0; i < detail.count; i++) {
        GroupSong *model = [[GroupSong alloc] init];
        model.picture = picture[i];
        model.title = title[i];
        model.detail = detail[i];
        [self.section addObject:model];
    }
    
    NSArray *loveTitle = @[
        @"𝓡𝓮𝓬𝓮𝓼𝓼𝓮𝓼的每日三十首",
        @"Solitude",
        @"有声节目"
    ];
    NSArray *loveDesc = @[
        @"30首 来自QQ音乐官方歌单",
        @"1首 奇妙能力歌 - 陈粒",
        @"自然疗愈场｜雨声助眠白噪音｜雨打芭蕉"
    ];
    NSArray *lovePicture = @[
        @"Flower",
        @"奇妙能力歌",
        @"Forest"
    ];
    
    for (NSInteger i = 0; i < loveDesc.count; i++) {
        GroupSong *model = [[GroupSong alloc] init];
        model.title = loveTitle[i];
        model.detail = loveDesc[i];
        model.picture = lovePicture[i];
        [self.loveSection addObject:model];
    }

    self.settingSection = [NSMutableArray array];
    
    NSArray *headerTitle = @[@"账号", @"歌词", @"播放与下载"];
    
    NSArray *titles = @[
        
        @[@"个人资料", @"推送设置", @"消息设置", @"隐私设置", @"黑名单设置"],
        
        @[@"桌面歌词", @"黑夜模式"],
        
        @[@"播放设置", @"音效设置", @"在线试听品质", @"歌曲下载品质",
          @"允许多应用同时播放", @"播放页动态封面", @"播放页旋转自动进入横屏模式",
          @"仅Wi-Fi联网", @"流量提醒", @"视频自动播放", @"边听边存",
          @"音乐缓存上限", @"最近播放列表设置"],
    ];
    
    NSArray *details = @[
        @[@"", @"", @"", @"", @""],
        
        @[@"未开启", @""],
        
        @[@"", @"", @"", @"HQ高品质",
          @"", @"", @"",
          @"", @"", @"Wi-Fi下开启", @"未开启",
          @"自动设置", @"跟随账号展示"],
    ];
    NSArray *types = @[
        
        @[@(cellTypeNormal), @(cellTypeNormal), @(cellTypeNormal),
          @(cellTypeNormal), @(cellTypeNormal)],
        
        @[@(cellTypeDetail), @(cellTypeSwitch)],
        
        @[@(cellTypeNormal), @(cellTypeNormal), @(cellTypeNormal),
          @(cellTypeDetail), @(cellTypeSwitch), @(cellTypeSwitch),
          @(cellTypeSwitch), @(cellTypeSwitch), @(cellTypeSwitch),
          @(cellTypeDetail), @(cellTypeDetail),
          @(cellTypeDetail), @(cellTypeDetail)],
    ];
    
    // switchOn 状态，只有 Switch 类型的有效，其余随便填 NO 占位
    NSArray *switchStates = @[
        // 账号
        @[@NO, @NO, @NO, @NO, @NO],
        // 歌词
        @[@NO, @NO],
        // 播放与下载
        @[@NO, @NO, @NO, @NO,
          @NO, @NO, @NO,
          @NO, @NO, @NO, @NO,
          @NO, @NO],
    ];
    
    for (int s = 0; s < headerTitle.count; s++) {
        NSMutableArray *cells = [NSMutableArray array];
        
        for (int i = 0; i < [titles[s] count]; i++) {
            CellModel *model = [[CellModel alloc] init];
            model.title = titles[s][i];
            model.detail = details[s][i];
            model.type = [types[s][i] integerValue];
            model.isOn = [switchStates[s][i] boolValue];
            [cells addObject:model];
        }
        
        SectionSettingModel *sectionModel = [[SectionSettingModel alloc] init];
        sectionModel.title = headerTitle[s];
        sectionModel.cell = cells;
        [self.settingSection addObject:sectionModel];
    }
}

- (UIView *)setHeaderView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 344)];
    
    UIView *search = [[UIView alloc] init];
    [header addSubview:search];
    search.clipsToBounds = YES;
    search.layer.cornerRadius = 15;
    search.backgroundColor = [UIColor systemFillColor];
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.left.equalTo(header).offset(16);
        make.centerX.equalTo(header).offset(-16);
        make.top.equalTo(header).offset(4);
    }];
    
    UIView *cycle = [[UIView alloc] init];
    [search addSubview:cycle];
    cycle.backgroundColor = [UIColor systemCyanColor];
    cycle.clipsToBounds = YES;
    cycle.layer.cornerRadius = 12;
    [cycle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.left.equalTo(search).offset(8);
        make.centerY.equalTo(search);
    }];
    
    UILabel *holder = [[UILabel alloc] init];
    holder.text = @"郁郁 正在热搜";
    holder.font = [UIFont systemFontOfSize:16 weight:UIFontWeightThin];
    holder.textColor = [UIColor labelColor];
    [search addSubview:holder];
    [holder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cycle.mas_right).offset(8);
        make.centerY.equalTo(search);
    }];
    
    UIView *right = [[UIView alloc] init];
    [header addSubview:right];
    right.backgroundColor = [UIColor systemGreenColor];
    right.clipsToBounds = YES;
    right.layer.cornerRadius = 15;
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.left.equalTo(search.mas_right).offset(4);
        make.centerY.equalTo(search);
    }];
    
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [UIColor systemBackgroundColor];
    back.clipsToBounds = YES;
    back.layer.cornerRadius = 4;
    [header addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(search);
        make.right.equalTo(right);
        make.top.equalTo(search.mas_bottom).offset(16);
        make.height.mas_equalTo(160);
    }];
    
    self.avator = [[UIImageView alloc] init];
    self.avator.image = [UIImage imageNamed:@"HeadPicture"];
    self.avator.clipsToBounds = YES;
    self.avator.layer.cornerRadius = 26;
    self.avator.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatorTapped)];
    [self.avator addGestureRecognizer:tap];
    [back addSubview:self.avator];
    [self.avator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(52);
        make.top.left.equalTo(back).offset(16);
    }];
    
    UILabel *name = [[UILabel alloc] init];
    name.text = @"𝓡𝓮𝓬𝓮𝓼𝓼𝓮𝓼";
    name.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    [back addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avator.mas_right).offset(16);
        make.bottom.equalTo(self.avator.mas_centerY);
    }];
    
    UIImageView *VIP = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VIP"]];
    [back addSubview:VIP];
    [VIP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avator.mas_right).offset(16);
        make.top.equalTo(self.avator.mas_centerY).offset(-2);
        make.bottom.equalTo(self.avator).offset(2);
        make.centerX.equalTo(back);
    }];
    
    UILabel *looker = [[UILabel alloc] init];
    looker.text = @"17 关注";
    looker.numberOfLines = 2;
    looker.textAlignment = NSTextAlignmentCenter;
    looker.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    [back addSubview:looker];
    [looker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(back).offset(-16);
        make.width.mas_equalTo(40);
        make.top.bottom.equalTo(self.avator);
    }];
    
    CGFloat width = (self.view.bounds.size.width - 32) / 4;
    NSArray *arr = @[
        @"💰 提现",
        @"💎 会员",
        @"👔 装扮",
        @"✅ 日签"
    ];
    UILabel *prev = nil;
    for (int i = 0; i < 4; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = arr[i];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
        label.textAlignment = NSTextAlignmentCenter;
        [back addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(VIP.mas_bottom).offset(4);
            make.bottom.equalTo(back);
            if (prev == nil) {
                make.left.equalTo(back);
            } else {
                make.left.equalTo(prev.mas_right);
            }
            make.width.mas_equalTo(width);
        }];
        prev = label;
    }
    
    NSArray *pic = @[
       @"heart.fill",
       @"square.and.arrow.down.fill",
       @"microphone.fill",
       @"bag.fill"
    ];
    NSArray *titles = @[
        @"收藏",
        @"本地",
        @"有声",
        @"已购"
    ];
    NSArray *number = @[
       @"358",
       @"历史151",
       @"23",
       @"487"
    ];
    UIView *last = nil;
    for (int i = 0; i < 4; i++) {
        UIView *showBack = [[UIView alloc] init];
        [header addSubview:showBack];
        [showBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(header).offset(-16);
            make.top.equalTo(back.mas_bottom).offset(16);
            make.width.mas_equalTo((self.view.bounds.size.width - 32) / 4);
            if (last == nil) {
                make.left.equalTo(header).offset(16);
            } else {
                make.left.equalTo(last.mas_right);
            }
        }];
        
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:pic[i]]];
        UILabel *tit = [[UILabel alloc] init];
        UILabel *num = [[UILabel alloc] init];
        img.tintColor = [UIColor labelColor];
        tit.text = titles[i];
        tit.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        num.text = number[i];
        num.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
        [showBack addSubview: img];
        [showBack addSubview: tit];
        [showBack addSubview: num];
        
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(showBack.mas_height).offset(-72);
            make.centerX.equalTo(showBack);
            make.top.equalTo(showBack).offset(8);
        }];
        
        [tit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img.mas_bottom);
            make.centerX.equalTo(img);
        }];
        
        [num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tit.mas_bottom).offset(4);
            make.centerX.equalTo(img);
        }];
        
        last = showBack;
    }
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        if (self.judge == 0) {
            return self.section.count;
        }
        return self.loveSection.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return 180;
    } else {
        return 72;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ProfileSectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileSection" forIndexPath:indexPath];
        [cell configWithModels:self.section];
        return cell;
    }
    ProfileGroupSongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileGroup" forIndexPath:indexPath];
    if (self.judge == 0) {
        [cell configWithModel:self.section[indexPath.row]];
    } else {
        [cell configWithModel:self.loveSection[indexPath.row]];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ProfileHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ProfileHeader"];
    if (section == 0) {
        [header configWithType:Last andIndex:self.judge];
    } else {
        [header configWithType:Myself andIndex:self.judge];
    }
    __weak typeof(self) weakSelf = self;
    header.changeSeg = ^(SectionType type) {
        if (type == Last) {
            weakSelf.judge = 0;
        } else {
            weakSelf.judge = 1;
        }
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
        [weakSelf.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationLeft];
    };
    return header;
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = [self setHeaderView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerClass:[ProfileSectionTableViewCell class] forCellReuseIdentifier:@"ProfileSection"];
    [self.tableView registerClass:[ProfileGroupSongTableViewCell class] forCellReuseIdentifier:@"ProfileGroup"];
    [self.tableView registerClass:[ProfileHeader class] forHeaderFooterViewReuseIdentifier:@"ProfileHeader"];
}

- (void)setupBar {
    UIBarButtonItem *my = [[UIBarButtonItem alloc] initWithTitle:@"我的" style:UIBarButtonItemStylePlain target:nil action:nil];
    my.tintColor = [UIColor labelColor];
    UIBarButtonItem *enve = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"envelope"] style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"line.3.horizontal"] style:UIBarButtonItemStylePlain target:self action:@selector(selectedSetting)];
    self.navigationItem.leftBarButtonItem = my;
    self.navigationItem.rightBarButtonItems = @[enve, setting];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor systemBackgroundColor];
}

- (void)avatorTapped {
    AvatorChangeViewController *avatorChange = [[AvatorChangeViewController alloc] init];
    avatorChange.title = @"头像修改";
    avatorChange.avatorImage = self.avator.image;
    avatorChange.delegate = self;
    [self.navigationController pushViewController:avatorChange animated:YES];
}

- (void)changePictureWithImage:(UIImage *)image {
    self.avator.image = image;
}

- (void)selectedSetting {
    STViewController *Setting = [[STViewController alloc] init];
    Setting.section = self.settingSection;
    [self.navigationController pushViewController:Setting animated:YES];
}

@end
