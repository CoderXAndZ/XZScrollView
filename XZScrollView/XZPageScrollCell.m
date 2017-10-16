//
//  XZPageScrollCell.m
//  XZScrollView
//
//  Created by admin on 2017/10/14.
//  Copyright © 2017年 RongTuoJinRong. All rights reserved.
//

#import "XZPageScrollCell.h"
#import "UIImageView+WebCache.h"
#import "XZPageScrollModel.h"
// 随机色
#define XZRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

@interface XZPageScrollCell ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation XZPageScrollCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpPageScrollCell];
    }
    return self;
}

- (void)setUpPageScrollCell {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.bounds];
    imgView.backgroundColor = XZRandomColor;
    [self.contentView addSubview:imgView];
    
    self.imgView = imgView;
}

- (void)setModelScroll:(XZPageScrollModel *)modelScroll {
    _modelScroll = modelScroll;
//    self.imgView.center = CGPointMake(self.contentView.center.x, self.contentView.center.y);
    
    self.imgView.backgroundColor = XZRandomColor;
    
    if ([modelScroll.imgName hasPrefix:@"https://"] || [modelScroll.imgName hasPrefix:@"http://"]) {
        
//        [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",modelScroll.imgName]] placeholderImage:[UIImage imageNamed:modelScroll.placeHolder]];
    }else {
//        self.imgView.image = [UIImage imageNamed:modelScroll.imgName];
    }
}

//- (void)setImgName:(NSString *)imgName placeholderImg:(NSString *)placeholderImg {
//    if ([imgName hasPrefix:@"https://"] || [imgName hasPrefix:@"http://"]) {
//        if (!placeholderImg) {
//            placeholderImg = @"0";
//        }
//        [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgName]] placeholderImage:[UIImage imageNamed:placeholderImg]];
//    }else {
//        self.imgView.image = [UIImage imageNamed:imgName];
//    }
//}

@end
