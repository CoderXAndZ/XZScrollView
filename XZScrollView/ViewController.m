//
//  ViewController.m
//  XZScrollView
//
//  Created by XZ on 2016/5/12.
//  Copyright © 2016年 XZ. All rights reserved.
//

#import "ViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(kScreenWidth * 3, kScreenHeight);
}


@end
