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
#import "ProfileGroupSongTableViewCell.h"
#import "ProfileHeader.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *section;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupBar];
    [self setupTableView];
}

- (void)setupData {
    self.section = [NSMutableArray array];
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
}

- (UIView *)setHeaderView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 344)];
    
    UIView *search = [[UIView alloc] init];
    [header addSubview:search];
    search.clipsToBounds = YES;
    search.layer.cornerRadius = 15;
    search.backgroundColor = [UIColor systemBackgroundColor];
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
    holder.textColor = [UIColor blackColor];
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
    
    UIImageView *avator = [[UIImageView alloc] init];
    avator.image = [UIImage imageNamed:@"HeadPicture"];
    avator.clipsToBounds = YES;
    avator.layer.cornerRadius = 26;
    [back addSubview:avator];
    [avator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(52);
        make.top.left.equalTo(back).offset(16);
    }];
    
    UILabel *name = [[UILabel alloc] init];
    name.text = @"𝓡𝓮𝓬𝓮𝓼𝓼𝓮𝓼";
    name.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    [back addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avator.mas_right).offset(16);
        make.bottom.equalTo(avator.mas_centerY);
    }];
    
    UIImageView *VIP = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VIP"]];
    [back addSubview:VIP];
    [VIP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avator.mas_right).offset(16);
        make.top.equalTo(avator.mas_centerY).offset(-2);
        make.bottom.equalTo(avator).offset(2);
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
        make.top.bottom.equalTo(avator);
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
        img.tintColor = [UIColor blackColor];
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
        return self.section.count;
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
    [cell configWithModel:self.section[indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ProfileHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ProfileHeader"];
    if (section == 0) {
        [header configWithType:Last];
    } else {
        [header configWithType:Myself];
    }
    return header;
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = [self setHeaderView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    my.tintColor = [UIColor blackColor];
    UIBarButtonItem *enve = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"envelope"] style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"line.3.horizontal"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = my;
    self.navigationItem.rightBarButtonItems = @[enve, setting];
    self.navigationController.navigationBar.translucent = NO;
}

@end
