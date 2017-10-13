//
//  XZScrollView.m
//  XZScrollView
//
//  Created by XZ on 2016/5/12.
//  Copyright © 2016年 XZ. All rights reserved.
//

#import "XZScrollView.h"
#import "UIImageView+WebCache.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kImgWidth kScreenWidth * 2 / 3
#define kImgHeight kScreenHeight * 2 / 3
// 随机色
#define XZRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

@interface XZScrollView()<UIScrollViewDelegate>
/** imgView的数组 */
@property (nonatomic, strong) NSMutableArray *arrImgView;

@end

@implementation XZScrollView{
    UIScrollView *_scrollView;
    /** 图片数据的数组 */
    NSArray *_arrPics;
}

- (instancetype)initWithFrame:(CGRect)frame target:(id)target {
    if (self == [super initWithFrame:frame]) {
//        CGRectMake(kScreenWidth / 6, 0, kImgWidth, kScreenHeight)
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        [self addSubview:_scrollView];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        self.clipsToBounds = YES;
    }
    return self;
}

/** 加载网络图片 */
- (void)loadImgWithUrls:(NSArray *)urls {
    _arrPics = urls;
    int index = 0;
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for(NSString *name in urls){
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * 2 / 3 * index, kScreenHeight / 6, kScreenWidth * 2 / 3, kScreenHeight * 2 / 3)];
        iv.backgroundColor = XZRandomColor;
        if (index != 0) {
            CGRect image = iv.bounds;
            image.size.width =  kScreenWidth * 2 / 3 * 0.2 * (kScreenWidth * 2 / 3 -  fabs(_scrollView.contentOffset.x - kScreenWidth * 2 / 3 * 1) )/ kScreenWidth * 2 / 3 + 0.8 *kScreenWidth * 2 / 3;
            image.size.height =  kScreenHeight * 2 / 3 * 0.2 * (kScreenWidth * 2 / 3 -  fabs(_scrollView.contentOffset.x - kScreenWidth * 2 / 3 * 1) )/ kScreenWidth * 2 / 3 + 0.8 *kScreenHeight * 2 / 3;
            iv.bounds = image;
        }
        
        [iv sd_setImageWithURL:[NSURL URLWithString:name] placeholderImage:[UIImage imageNamed:@"0"]];
        iv.contentMode = UIViewContentModeScaleToFill;
        [_scrollView addSubview:iv];
        [self.arrImgView addObject:iv];
        iv.tag = index;
        
        index++;
    }
    
//    for (NSString *url in urls) {
////        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(index * kImgWidth, kScreenHeight / 6, kImgWidth, kImgHeight)];
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * 2 / 3 * index, kScreenHeight / 6, kScreenWidth * 2 / 3, kScreenHeight * 2 / 3)];
//        imgView.backgroundColor = XZRandomColor;
//        if (index != 0) {
//            CGFloat current = _scrollView.contentOffset.x - kScreenWidth * 2 / 3 * 1;
//            CGRect imgBounds = imgView.bounds;
//            imgBounds.size.width = kScreenWidth * 2 / 3 * 0.2 * (kScreenWidth * 2 / 3 - fabs(current)) / kScreenWidth * 2 / 3 + 0.8 * kScreenWidth * 2 / 3;
//
//            imgBounds.size.height = kScreenHeight * 2 / 3 * 0.2 * (kScreenWidth * 2 / 3 - fabs(current) / kScreenWidth * 2 / 3 + 0.8 * kScreenHeight * 2 / 3);
////            CGFloat current = _scrollView.contentOffset.x - kImgWidth * 1;
////            CGRect imgBounds = imgView.bounds;
//////            NSLog(@"kImgWidth ============ %f",kImgWidth);
////            imgBounds.size.width = kImgWidth * 0.2 * (kImgWidth - fabs(current)) / kImgWidth + 0.8 * kImgWidth;
////
////            imgBounds.size.height = kImgHeight * 0.2 * (kImgWidth - fabs(current) / kImgWidth + 0.8 * kImgHeight);
//            imgView.bounds = imgBounds;
//        }
////        [imgView sd_setImageWithURL:[NSURL URLWithString:@"http://box.dwstatic.com/skin/Irelia/Irelia_0.jpg"] placeholderImage:[UIImage imageNamed:@"占位图"]];
//        imgView.contentMode = UIViewContentModeScaleToFill;
//        [_scrollView addSubview:imgView];
//        [self.arrImgView addObject:imgView];
//        imgView.tag = index;
//        index++;
//    }
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * index, 0);
}

#pragma mark ---- 滚动时改变图片的尺寸
- (void)scrollViewDidScrolled {
    int index = _scrollView.contentOffset.x / (kScreenWidth * 2 / 3);
    if (index == 0) {
        for (int i = 0; i < 2; i++) {
            UIImageView *im = _arrImgView[i];
            CGRect image = im.bounds;
            image.size.width =  kScreenWidth * 2 / 3 * 0.2 * (kScreenWidth * 2 / 3 -  fabs(_scrollView.contentOffset.x - kScreenWidth * 2 / 3 * i) )/ (kScreenWidth * 2 / 3) + 0.8 * kScreenWidth * 2 / 3;
            image.size.height =  kScreenHeight * 2 / 3 * 0.2 * (kScreenWidth * 2 / 3 -  fabs(_scrollView.contentOffset.x - kScreenWidth * 2 / 3 * i) )/ (kScreenWidth * 2 / 3) + 0.8 * kScreenHeight * 2 / 3;
            im.bounds = image;
        }
    }else if(index == _arrPics.count - 1){
        for (int i = index - 1; i < index + 1; i++) {
            UIImageView *im = _arrImgView[i];
            CGRect image = im.bounds;
            image.size.width =  kScreenWidth * 2 / 3 * 0.2 * (kScreenWidth * 2 / 3 -  fabs(_scrollView.contentOffset.x - kScreenWidth * 2 / 3 * i) )/ (kScreenWidth * 2 / 3) + 0.8 * kScreenWidth * 2 / 3;
            image.size.height =  kScreenHeight * 2 / 3 * 0.2 * (kScreenWidth * 2 / 3 -  fabs(_scrollView.contentOffset.x - kScreenWidth * 2 / 3 * i) )/ (kScreenWidth * 2 / 3) + 0.8 * kScreenHeight * 2 / 3;
            im.bounds = image;
        }
    }else{
        for (int i = index - 1; i < index + 2; i++) {
            UIImageView *im = _arrImgView[i];
            CGRect image = im.bounds;
            image.size.width =  kScreenWidth * 2 / 3 * 0.2 * (kScreenWidth * 2 / 3 -  fabs(_scrollView.contentOffset.x - kScreenWidth * 2 / 3 * i) )/ (kScreenWidth * 2 / 3) + 0.8 * kScreenWidth * 2 / 3;
            image.size.height =  kScreenHeight * 2 / 3 * 0.2 * (kScreenWidth * 2 / 3 -  fabs(_scrollView.contentOffset.x - kScreenWidth * 2 / 3 * i) )/ (kScreenWidth * 2 / 3) + 0.8 * kScreenHeight * 2 / 3;
            im.bounds = image;
        }
    }
    
//    int index = _scrollView.contentOffset.x / (kImgWidth);
//    if (index == 0) { // 滑动到第1张图片
//        for (int i =0;i < 2; i++) {
//            CGFloat current = _scrollView.contentOffset.x - kImgWidth * i;
//            UIImageView *imgView = _arrImgView[i];
//            CGRect imgBounds = imgView.bounds;
//            imgBounds.size.width = kImgWidth * 0.2 * (kImgWidth - fabs(current) / kImgWidth) + 0.8 * kImgWidth;
//            imgBounds.size.height = kImgHeight *  0.2 * (kImgWidth - fabs(current)) / kImgWidth + 0.8 * kImgHeight;
//            imgView.bounds = imgBounds;
//        }
//    }else if (index == _arrPics.count - 1){
//        for (int i = index - 1; i < index + 1; i++) {
//            CGFloat current = _scrollView.contentOffset.x - kImgWidth * i;
//            UIImageView *imgView = _arrImgView[i];
//            CGRect imgBounds = imgView.bounds;
//            imgBounds.size.width = kImgWidth * 0.2 * (kImgWidth - fabs(current) / kImgWidth) + 0.8 * kImgWidth;
//            imgBounds.size.height = kImgHeight * 0.2 * (kImgWidth - fabs(current)) / kImgWidth + 0.8 * kImgHeight;
//            imgView.bounds = imgBounds;
//        }
//    }else {
//        for (int i = index - 1; i < index + 2; i++) {
//            CGFloat current = _scrollView.contentOffset.x - kImgWidth * i;
//            UIImageView *imgView = _arrImgView[i];
//            CGRect imgBounds = imgView.bounds;
//            imgBounds.size.width = kImgWidth * 0.2 * (kImgWidth - fabs(current) / kImgWidth) + 0.8 * kImgWidth;
//            imgBounds.size.height = kImgHeight * 0.2 * (kImgWidth - fabs(current)) / kImgWidth + 0.8 * kImgHeight;
//            imgView.bounds = imgBounds;
//        }
//    }
}

/** 加载本地图片 */
- (void)loadImgsWithLocalArray:(NSArray *)array {
    _arrPics = array;
    int index = 0;
//    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for(NSString *imgName in array){
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
        
        imgView.contentMode = UIViewContentModeScaleToFill;
        
        imgView.frame = CGRectMake(kImgWidth * index, kScreenHeight / 6, kImgWidth, kImgHeight);
        
        [_scrollView addSubview:imgView];
        
        index++;
    }
    
    _scrollView.contentSize = CGSizeMake((_scrollView.frame.size.width) * index, 0);
}

@end
