//
//  XZPageScrollView.h
//  XZScrollView
//
//  Created by XZ on 2017/10/12.
//  Copyright © 2016年 XZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZPageScrollView : UIView

/**
 * 自定义初始化方法
 **/
- (id)initWithFrame:(CGRect)frame target:(id<UIScrollViewDelegate>)target;

/**
 * 加载本地图片
 **/
- (void)loadImages:(NSArray *)array;

/**
 * 加载网络图片
 **/
- (void)loadImgWithUrls:(NSArray *)urls;

/**
 * 滑动时抽屉效果
 **/
- (void)scrollViewDidScrolled;

@end
