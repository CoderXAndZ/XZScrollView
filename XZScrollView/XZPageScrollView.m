//
//  XZPageScrollView.m
//  XZScrollView
//
//  Created by XZ on 2017/10/12.
//  Copyright © 2016年 XZ. All rights reserved.
//

#import "XZPageScrollView.h"
#import "UIImageView+WebCache.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kImgWidth kScreenWidth * 2 / 3  // 图片宽度
#define kImgHeight kScreenHeight * 2 / 3  // 图片高度
// 随机色
#define XZRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

@interface XZPageScrollView()<UIScrollViewDelegate>
/** imageView的数组 */
@property (nonatomic, strong) NSMutableArray *arrImgView;
@end

@implementation XZPageScrollView {
    UIScrollView *_scrollview;
    /** 图片数组 */
    NSArray *_arrPics;
}

- (id)initWithFrame:(CGRect)frame target:(id<UIScrollViewDelegate>)target {
    self = [super initWithFrame:frame];
    if (self){
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWidth / 6, 0, kImgWidth, kScreenHeight)];
        _scrollview.pagingEnabled = YES;
        _scrollview.clipsToBounds = NO;
        [self addSubview:_scrollview];
        self.clipsToBounds = YES;
        // 添加代理
        _scrollview.delegate = target;
    }
    return self;
}

/** 加载本地图片 */
- (void)loadImages:(NSArray *)array{
    _arrPics = array;
    int index = 0;
    [_scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for(NSString * name in array){
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
        
        imgView.contentMode = UIViewContentModeScaleToFill;
        
        imgView.frame = CGRectMake(kImgWidth * index, kScreenHeight / 6, kImgWidth, kImgHeight);
        
        [_scrollview addSubview:imgView];
        
        index++;
    }
    
    _scrollview.contentSize = CGSizeMake((_scrollview.frame.size.width) * index, 0);
}


/** 加载网络图片 */
- (void)loadImgWithUrls:(NSArray *)urls {
    _arrPics = urls;
    int index = 0;
    [_scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for(NSString *url in urls){
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kImgWidth * index, kScreenHeight / 6, kImgWidth, kImgHeight)];
        imgView.backgroundColor = XZRandomColor;
        if (index != 0) {
            CGRect imgBounds = imgView.bounds;
            imgBounds.size.width =  kImgWidth * 0.2 * (kImgWidth -  fabs(_scrollview.contentOffset.x - kImgWidth * 1) )/ kImgWidth + 0.8 *kImgWidth;
            imgBounds.size.height =  kImgHeight * 0.2 * (kImgWidth -  fabs(_scrollview.contentOffset.x - kImgWidth * 1) )/ kImgWidth + 0.8 *kImgHeight;
            imgView.bounds = imgBounds;
        }
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]] placeholderImage:[UIImage imageNamed:@"占位图"]];
        imgView.contentMode = UIViewContentModeScaleToFill;
        [_scrollview addSubview:imgView];
        [self.arrImgView addObject:imgView];
        imgView.tag = index;
        
        index++;
    }
    _scrollview.contentSize = CGSizeMake((_scrollview.frame.size.width) * index, 0);
}

#pragma mark ---- 滚动时改变大小
- (void)scrollViewDidScrolled {
    int index = _scrollview.contentOffset.x / (kImgWidth);
    if (index == 0) {
        for (int i = 0; i < 2; i++) {
            UIImageView *im = _arrImgView[i];
            CGRect imgBounds = im.bounds;
            CGFloat fabsNum = _scrollview.contentOffset.x - kImgWidth * i;
            imgBounds.size.width =  kImgWidth * 0.2 * (kImgWidth -  fabs(fabsNum) )/ (kImgWidth) + 0.8 * kImgWidth;
            imgBounds.size.height =  kImgHeight * 0.2 * (kImgWidth -  fabs(fabsNum) )/ (kImgWidth) + 0.8 * kImgHeight;
            im.bounds = imgBounds;
        }
    }else if(index == _arrPics.count - 1){
        for (int i = index - 1; i < index + 1; i++) {
            UIImageView *imgView = _arrImgView[i];
            CGRect imgBounds = imgView.bounds;
            CGFloat fabsNum = _scrollview.contentOffset.x - kImgWidth * i;
            imgBounds.size.width =  kImgWidth * 0.2 * (kImgWidth -  fabs(fabsNum) )/ (kImgWidth) + 0.8 * kImgWidth;
            imgBounds.size.height =  kImgHeight * 0.2 * (kImgWidth -  fabs(fabsNum) )/ (kImgWidth) + 0.8 * kImgHeight;
            imgView.bounds = imgBounds;
        }
    }else{
        for (int i = index - 1; i < index + 2; i++) {
            UIImageView *imgView = _arrImgView[i];
            CGRect image = imgView.bounds;
            CGFloat fabsNum = _scrollview.contentOffset.x - kImgWidth * i;
            image.size.width =  kImgWidth * 0.2 * (kImgWidth -  fabs(fabsNum) )/ (kImgWidth) + 0.8 * kImgWidth;
            image.size.height =  kImgHeight * 0.2 * (kImgWidth -  fabs(fabsNum) )/ (kImgWidth) + 0.8 * kImgHeight;
            imgView.bounds = image;
        }
    }
}

#pragma mark ---- 懒加载
- (NSMutableArray *)arrImgView{
    if (!_arrImgView) {
        self.arrImgView = [NSMutableArray array];
    }
    return _arrImgView;
}

//- (UimgViewiew *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    UimgViewiew *view = [super hitTest:point withEvent:event];
//    if ([view isEqual:self])  {
//        for(UimgViewiew *subview in _scrollview.subviews) {
//            CGPoint offset = CGPointMake(point.x - _scrollview.frame.origin.x + _scrollview.contentOffset.x - subview.frame.origin.x, point.y - _scrollview.frame.origin.y + _scrollview.contentOffset.y - subview.frame.origin.y);
//            if ((view = [subview hitTest:offset withEvent:event])){
//                return view;
//            }
//        }
//        return _scrollview;
//    }
//    return view;
//}


@end
