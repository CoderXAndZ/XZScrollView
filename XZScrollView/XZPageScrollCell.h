//
//  XZPageScrollCell.h
//  XZScrollView
//
//  Created by admin on 2017/10/14.
//  Copyright © 2017年 RongTuoJinRong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XZPageScrollModel;
@interface XZPageScrollCell : UICollectionViewCell

//- (void)setImgName:(NSString *)imgName placeholderImg:(NSString *)placeholderImg;

@property (nonatomic, strong) XZPageScrollModel *modelScroll;

///** 图片大小是否一致 */
//@property (nonatomic, assign) BOOL isSameSize;
@end
