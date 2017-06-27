//
//  StoreInfoViewController.m
//  Project
//
//  Created by dym on 2017/6/27.
//  Copyright © 2017年 zzl. All rights reserved.
//

#import "StoreInfoViewController.h"

@interface StoreInfoViewController ()
@property (nonatomic, strong) UIImageView *iconimage;
@property (nonatomic, strong) UILabel *timeL;
@property (nonatomic, strong) UILabel *shopNameL;
@property (nonatomic, strong) UIView *listView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *levelView;
@end

@implementation StoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"店铺详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _contentView = [[UIView alloc]initWithFrame:self.view.bounds];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    view.backgroundColor = XBAPPBaseColor;
    [_contentView addSubview:view];
//    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//    effectView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
//    [view addSubview:effectView];
    
    
    CGFloat imgWidth = 80;
    _iconimage = [[UIImageView alloc]initWithFrame:CGRectMake((_contentView.mj_w - imgWidth) / 2, (view.mj_h - imgWidth) / 2, imgWidth,imgWidth)];
    _iconimage.layer.masksToBounds = YES;
    _iconimage.layer.cornerRadius = _iconimage.mj_w / 2;
    _iconimage.layer.borderWidth  = 2;
    _iconimage.layer.borderColor = [UIColor whiteColor].CGColor;
    [view addSubview:self.iconimage];
    
    
    
    
    
    CGFloat offsetY = view.mj_h + 20;
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, offsetY, 20, 20)];
    icon.image = [UIImage imageNamed:@"shopSelected"];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    [_contentView addSubview:icon];
    
    self.shopNameL = [[UILabel alloc]initWithFrame:CGRectMake(icon.mj_w + 20, offsetY, _contentView.mj_w - icon.mj_w - 20, icon.mj_h)];
    self.shopNameL.font = [UIFont systemFontOfSize:15];
    [_contentView addSubview:self.shopNameL];
    
    offsetY += icon.mj_h + 12;
    UIImageView *icon1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, offsetY, 20, 20)];
    icon1.image = [UIImage imageNamed:@"oederSelected"];
    icon1.contentMode = UIViewContentModeScaleAspectFit;
    [_contentView addSubview:icon1];
    
    self.timeL = [[UILabel alloc]initWithFrame:CGRectMake(icon1.mj_w + 20, offsetY, _contentView.mj_w - icon1.mj_w - 20, icon1.mj_h)];
    self.timeL.font = [UIFont systemFontOfSize:15];
    self.timeL.textColor = RGBColor(180, 180, 180);
    [_contentView addSubview:self.timeL];
    
    offsetY += _timeL.mj_h + 12;
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, offsetY, 66, 20)];
    lable.text = @"店铺等级:";
    lable.font = [UIFont systemFontOfSize:14];
    lable.textColor = RGBColor(180, 180, 180);
    [_contentView addSubview:lable];
    
    self.levelView = [[UIView alloc]initWithFrame:CGRectMake(lable.mj_w + 20, offsetY, _contentView.mj_w - lable.mj_w, lable.mj_h)];
    [_contentView addSubview:self.levelView];
    
    int level = arc4random()%6 < 4 ? 4 : 5;
    for (int i = 0; i < level; i++) {
        UIImageView *levImgView = [[UIImageView alloc]initWithFrame:CGRectMake((lable.mj_h + 6) * i, 0, lable.mj_h , lable.mj_h )];
        levImgView.image = [UIImage imageNamed:@"grade"];
        [_levelView addSubview:levImgView];
    }
    
    offsetY += lable.mj_h + 12;
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, offsetY, _contentView.mj_w, 10)];
    [_contentView addSubview:lable1];
    lable1.text = @"店铺彩种:";
    lable1.textColor = RGBColor(180, 180, 180);
    lable1.font = [UIFont systemFontOfSize:14];
    
    
    offsetY += lable1.mj_h + 15;
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, offsetY, _contentView.mj_w, _contentView.mj_h - offsetY)];
    [_contentView addSubview:scrollView];
    
    CGFloat margin = 5;
    NSInteger index = 5;
    CGFloat width = (_contentView.mj_w - margin * (index + 1)) / index;
    CGFloat height = width + 3;
    
    NSArray *iconArray = @[@"logo_任9场",@"logo_江西时时彩",@"logo_北京单场",@"logo_福彩3D",@"logo_江西时时彩",@"logo_江西时时彩",@"logo_广西快3",@"logo_贵州11选5",@"logo_贵州11选5",@"logo_贵州11选5",@"logo_快乐十分",@"logo_快乐十分",@"logo_快乐十分"];
    NSInteger count = arc4random()%(iconArray.count) >7 ? arc4random()%(iconArray.count) : 9;
    for (int i = 0; i < count; i++) {
        CGFloat row = i % index;
        CGFloat col = i / index;
        CGFloat x = row * (margin + width)+ margin;
        CGFloat y = col * (margin + height);
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
        [scrollView addSubview:btn];
        
        [btn setBackgroundImage:[UIImage imageNamed:iconArray[i]] forState:UIControlStateNormal];
        //        [btn setTitle:entity.shop.nameArray[i] forState:UIControlStateNormal];
        //        [btn setTitleColor:XBAPPBaseColor forState:UIControlStateNormal];
        //        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn buttonImageTitleAlignment:topImageBottomTitle WithSpace:0];
        btn.userInteractionEnabled = NO;
        
        [scrollView setContentSize:CGSizeMake(scrollView.mj_w,y + height + margin)];
    }
    
    [_iconimage sd_setImageWithURL:[NSURL URLWithString:self.iconName] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
    _shopNameL.text = self.shopName;
    _timeL.text = [NSString stringWithFormat:@"营业时间: %@",self.time];
}



- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
