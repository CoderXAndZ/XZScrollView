//
//  XZScrollView.h
//  XZScrollView
//
//  Created by XZ on 2016/5/12.
//  Copyright © 2016年 XZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZScrollView : UIView

/** 加载本地图片 */
- (void)loadImgsWithLocalArray:(NSArray *)array;
#pragma mark ---- 滚动时改变图片的尺寸
- (void)scrollViewDidScrolled;
/** 加载网络图片 */
- (void)loadImgWithUrls:(NSArray *)urls;

- (instancetype)initWithFrame:(CGRect)frame target:(id)target;
@end
