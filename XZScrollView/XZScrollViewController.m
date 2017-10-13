//
//  XZScrollViewController.m
//  XZScrollView
//
//  Created by XZ on 2016/5/12.
//  Copyright © 2016年 XZ. All rights reserved.
//

#import "XZScrollViewController.h"
#import "XZPageScrollView.h"

//#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//// 随机色
//#define XZRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//
//#define kImgWidth kScreenWidth * 2 / 3

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
    
    self.scrollView = [[XZPageScrollView alloc] initWithFrame:self.view.bounds target:self];
    [self.view addSubview:self.scrollView];
    
    //
    self.arrUrls = @[@"https://box.dwstatic.com/skin/Irelia/Irelia_0.jpg", @"https://box.dwstatic.com/skin/Irelia/Irelia_1.jpg", @"https://box.dwstatic.com/skin/Irelia/Irelia_2.jpg", @"https://box.dwstatic.com/skin/Irelia/Irelia_3.jpg", @"https://box.dwstatic.com/skin/Irelia/Irelia_4.jpg", @"https://box.dwstatic.com/skin/Irelia/Irelia_5.jpg"];
    [self.scrollView loadImgWithUrls:self.arrUrls];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.scrollView scrollViewDidScrolled];
}


@end
