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
 * isSameSize:YES 每张图片的大小相同，NO当前显示的图片最大
 **/
- (instancetype)initWithFrame:(CGRect)frame target:(id<UIScrollViewDelegate>)target isSameSize:(BOOL)isSameSize;

/**
 * 加载图片
 */
- (void)loadImgWithUrls:(NSArray *)urls placeholderImg:(NSString *)placeholderImg;

/**
 * 滑动时抽屉效果
 **/
- (void)scrollViewDidScrolled;

/** 可以轮播 */ 
@property (nonatomic, assign) BOOL canCycleScroll;

@end
