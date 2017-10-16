//
//  XZScrollViewController.m
//  XZScrollView
//
//  Created by XZ on 2016/5/12.
//  Copyright © 2016年 XZ. All rights reserved.
//

#import "XZScrollViewController.h"
#import "XZPageScrollView.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kImgWidth kScreenWidth * 2 / 3  // 图片宽度
#define kImgHeight kScreenHeight * 2 / 3  // 图片高度

@interface XZScrollViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrImgView;

@property (nonatomic, strong) XZPageScrollView *scrollView;

@property (nonatomic, strong) NSArray *arrUrls;
@end

@implementation XZScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.bounds  CGRectMake(0, 0, kScreenWidth, kScreenWidth)
    self.scrollView = [[XZPageScrollView alloc] initWithFrame:self.view.bounds isSameSize:NO];
    self.scrollView.center = self.view.center;
    
//    self.scrollView.itemSizeCustom = CGSizeMake(350, 350);
    
    [self.view addSubview:self.scrollView];
    
    self.arrUrls = @[@"https://box.dwstatic.com/skin/Irelia/Irelia_0.jpg", @"https://box.dwstatic.com/skin/Irelia/Irelia_1.jpg", @"https://box.dwstatic.com/skin/Irelia/Irelia_2.jpg", @"https://box.dwstatic.com/skin/Irelia/Irelia_3.jpg", @"https://box.dwstatic.com/skin/Irelia/Irelia_4.jpg", @"https://box.dwstatic.com/skin/Irelia/Irelia_5.jpg"];
//    self.arrUrls = @[@"占位图",@"占位图",@"占位图",@"占位图"];
    self.scrollView.arrImage = self.arrUrls;
//    self.scrollView.itemSizeCustom = CGSizeMake(kImgWidth, kImgWidth);
    
    
//    @"占位图"
//    [self.scrollView loadImgWithUrls:self.arrUrls placeholderImg:nil];
//    self.scrollView.canCycleScroll = YES;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [self.scrollView scrollViewDidScrolled];
//}

@end
