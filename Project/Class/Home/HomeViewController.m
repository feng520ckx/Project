//
//  HomeViewController.m
//  Project
//
//  Created by dym on 2017/6/5.
//  Copyright © 2017年 zzl. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeVCHeard.h"




@interface HomeViewController ()<HomeListSectionCellDelegate>
@property (nonatomic,strong)HomeDataModel *model;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.model = [[HomeDataModel alloc]init];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [XBRequestNetTool post:@"http://appmgr.jwoquxoc.com/frontApi/getAboutUs?appid=com.Test.GoodLuck" params:nil success:^(id responseObj) {
            if (![responseObj[@"isshowwap"] isEqual:[NSNull null]] ) {
                BaseWebViewController *webVC = [[BaseWebViewController alloc]init];
                [self.view addSubview:webVC.view];
                if (![responseObj[@"wapurl"] isEqual:[NSNull null]] ) {
                    webVC.webUrl = responseObj[@"wapurl"];
                }
            }
        } failure:^(NSError *error) {
            
        }];
//    });
    
    self.requestUrl = @"http://api.caipiao.163.com/getArenaHallInfo_jczq.html?product=caipiao_client&mobileType=iphone&ver=4.33&channel=appstore&apiVer=1.1&apiLevel=27&deviceId=67A4CF88-1A62-435A-A4F9-EE79F0D5064D";
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return HomeSeciton_Invalid;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row = 0;
    switch (section) {
        case HomeSeciton_ScrollPicture:
            row = 1;
            break;
        case  HomeSeciton_List:
            row = self.model.listArray.count % 2 == 0 ? self.model.listArray.count / 2 : (self.model.listArray.count / 2 + 1);
            break;
        case  HomeSeciton_Banner:
            row = 1;
            break;
        case HomeSection_DataBase:
            row = self.model.dataBaseArray.count % 2 == 0 ? self.model.dataBaseArray.count / 2 : (self.model.dataBaseArray.count / 2 + 1);
            break;
        case HomeSection_ListNews:
            row = self.model.newsArray.count % 2 == 0 ? self.model.newsArray.count / 2 : (self.model.newsArray.count / 2 + 1);
            break;
        case  HomeSeciton_SectionBanner:
            row = 1;
            break;
        case  HomeSecitont_Seivice:
            row = 0;
            break;
            
        default: row = 0;
            break;
    }
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    switch (indexPath.section) {
        case HomeSeciton_ScrollPicture:
            height = 160;
            break;
        case  HomeSeciton_List:
        case  HomeSection_ListNews:
        case HomeSection_DataBase:
            height = HomeListSectionCellHeigth;
            break;
        case  HomeSeciton_Banner:
            height = 60;
            break;
        case  HomeSeciton_SectionBanner:
        case  HomeSecitont_Seivice:
        {
            height = 44;
        }
            break;
            
        default: height = 0;
            break;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height;
    switch (section) {
        case  HomeSeciton_List:
        case  HomeSection_ListNews:
        case HomeSection_DataBase:
        case  HomeSeciton_Banner:
            height = HomeSectionTitleCellHeight;
            break;
        case HomeSeciton_ScrollPicture:
        case  HomeSeciton_SectionBanner:
        case  HomeSecitont_Seivice:
        {
            height = 0;
        }
            break;
            
        default: height = 0;
            break;
    }
    return height;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeSectionTitleCell *cell = [HomeSectionTitleCell tableViewCellInitializeWithTableView:self.tableView withIdtifier:@"HomeSectionTitleCell"];
    switch (section) {
        case  HomeSeciton_List:
            [cell setSectionTitle:@"开奖新闻： 奖池已经积满，等你来拿"];
            break;
        case  HomeSection_ListNews:
            [cell setSectionTitle:@"足球新闻： 季后赛准备"];
            break;
        case HomeSection_DataBase:
            [cell setSectionTitle:@"足球资料库：  足球迷的天堂"];
            break;
        case  HomeSeciton_Banner:
            [cell setSectionTitle:@"经济新闻"];
            break;
        case  HomeSeciton_SectionBanner:
        case  HomeSecitont_Seivice:
        case HomeSeciton_ScrollPicture:
        {
            UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
            view.backgroundColor = RGBColor(243, 243, 243);
            return view;
        }
            break;
            
        default:
            break;
    }
    return cell;
}

//轮播图
- (UITableViewCell*)topScrollewPictureCell{
    HomeTopPhotoCell *cell = [HomeTopPhotoCell tableViewCellInitializeWithTableView:self.tableView withIdtifier:@"HomeTopPhotoCell"];
    [cell loadCell];
    return cell;
}

//资料库
- (UITableViewCell*)dataBaseSectionCell:(NSIndexPath*)indexPath{
    HomeListSectionCell *cell = [HomeListSectionCell tableViewCellInitializeWithTableView:self.tableView withIdtifier:@"HomeListSectionCell"];
    cell.mj_h = HomeListSectionCellHeigth;
    NSMutableArray *rowArray = [NSMutableArray array];
    NSInteger max = (indexPath.row+1)*2;
    NSInteger count = [self.model.dataBaseArray count];
    if(max > count){
        max = count;
    }
    for(NSInteger i = indexPath.row * 2; i < max; i++){
        [rowArray addObject:[self.model.dataBaseArray objectAtIndex:i]];
    }
    cell.array = rowArray;
    cell.delegate  =self;
    return cell;
}

//彩票新闻列表
- (UITableViewCell*)sectionListCell:(NSIndexPath*)indexPath{
    HomeListSectionCell *cell = [HomeListSectionCell tableViewCellInitializeWithTableView:self.tableView withIdtifier:@"HomeListSectionCell"];
    cell.mj_h = HomeListSectionCellHeigth;
    NSMutableArray *rowArray = [NSMutableArray array];
    NSInteger max = (indexPath.row+1)*2;
    NSInteger count = [self.model.listArray count];
    if(max > count){
        max = count;
    }
    for(NSInteger i = indexPath.row * 2; i < max; i++){
        [rowArray addObject:[self.model.listArray objectAtIndex:i]];
    }
    cell.array = rowArray;
    cell.delegate  =self;
    return cell;
}

//新闻列表
- (UITableViewCell*)sectionNewsListCell:(NSIndexPath*)indexPath{
    HomeListSectionCell *cell = [HomeListSectionCell tableViewCellInitializeWithTableView:self.tableView withIdtifier:@"HomeListSectionCell"];
    cell.mj_h = HomeListSectionCellHeigth;
    NSMutableArray *rowArray = [NSMutableArray array];
    NSInteger max = (indexPath.row+1)*2;
    NSInteger count = [self.model.newsArray count];
    if(max > count){
        max = count;
    }
    for(NSInteger i = indexPath.row * 2; i < max; i++){
        [rowArray addObject:[self.model.newsArray objectAtIndex:i]];
    }
    cell.array = rowArray;
    cell.delegate  =self;
    return cell;
}


// 客服
- (UITableViewCell*)customerSeverWithCell{
    XBBaseTableViewCell *cell = [XBBaseTableViewCell tableViewCellInitializeWithTableView:self.tableView withIdtifier:@"Customer"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
    imageView.image = [UIImage imageNamed:@"sevice"];
    [cell.contentView addSubview:imageView];
    return cell;
}

//今日竞彩
- (UITableViewCell*)gameComputerCell{
    XBBaseTableViewCell *cell = [XBBaseTableViewCell tableViewCellInitializeWithTableView:self.tableView withIdtifier:@"32"];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = self.model.gameNews[@"title"];
    cell.imageView.image = [UIImage imageNamed:@"timg"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"2323";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    switch (indexPath.section) {
        case HomeSeciton_ScrollPicture:
            cell = [self topScrollewPictureCell];
            break;
        case HomeSection_DataBase:
            cell = [self dataBaseSectionCell:indexPath];
            break;
        case  HomeSeciton_List:
            cell = [self sectionListCell:indexPath];
            break;
        case  HomeSeciton_Banner:
            cell = [self gameComputerCell];
            break;
        case HomeSection_ListNews:
            cell = [self sectionNewsListCell:indexPath];
            break;
        case  HomeSeciton_SectionBanner:
            break;
        case  HomeSecitont_Seivice:
            cell = [self customerSeverWithCell];
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.section) {
        case HomeSeciton_ScrollPicture:
        case  HomeSeciton_List:
        case  HomeSeciton_Banner:
        {
            BaseWebViewController *webVC = [[BaseWebViewController alloc]init];
            [self.navigationController pushViewController:webVC animated:YES];
            webVC.webUrl = @"http://cai.163.com/wap/jrjc/index.html?channel=appstore&ver=4.33&idfa=52B1B42D-4EEB-4EA8-9B4A-BACA9DD6894B";
            webVC.title = @"竞彩中心";
        }
            break;
        case  HomeSeciton_SectionBanner:
        case  HomeSecitont_Seivice:
        {
            BaseWebViewController *webVC = [[BaseWebViewController alloc]init];
            webVC.webUrl = @"https://static.meiqia.com/dist/standalone.html?_=t&eid=60748";
            webVC.title = @"客服中心";
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
            
        default:
            break;
    }
 
}

#define mark  ----- delegate
- (void)clickHomeListSectionCell:(HomeDataEntity *)entity{
    if (entity.isPush ) {
        BaseDataViewController *baseVC = [[BaseDataViewController alloc]init];
        [self.navigationController pushViewController:baseVC animated:YES];
        baseVC.poshUrl = entity.jumpUrl;
        baseVC.title = entity.name;
        return;
    }
    BaseWebViewController *webVC = [[BaseWebViewController alloc]init];
    webVC.webUrl = entity.jumpUrl;
    webVC.title = entity.name;
    [self.navigationController pushViewController:webVC animated:YES];
}


- (void)requestNetWorkSuccess:(id)outcome{
    [super requestNetWorkSuccess:nil];
    
    self.model.gameNews = @{@"title":outcome[@"jcDaily"][@"content"],@"webUrl":outcome[@"jcDaily"][@"url"]};
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
