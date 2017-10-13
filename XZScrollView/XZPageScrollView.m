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

// 随机色
#define XZRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

@interface XZPageScrollView()<UIScrollViewDelegate>
/** imageView的数组 */
@property (nonatomic, strong) NSMutableArray *arrImgView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation XZPageScrollView {
    UIScrollView *_scrollview;
    CGFloat _kImgHeight; // 图片高度
    CGFloat _kImgWidth; // 图片宽度
    /** 图片数组 */
    NSArray *_arrPics;
    /** 图片大小是否一致 */
    BOOL _isSameSize;
}

- (instancetype)initWithFrame:(CGRect)frame target:(id<UIScrollViewDelegate>)target isSameSize:(BOOL)isSameSize {
    self = [super initWithFrame:frame];
    if (self){
        _isSameSize = isSameSize;
        if (isSameSize) {
            _kImgWidth = self.bounds.size.width;
            _kImgHeight = self.bounds.size.height;
            _scrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
        }else {
            _kImgWidth = kScreenWidth * 2 / 3;
            _kImgHeight = kScreenHeight * 2 / 3;
            _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWidth / 6, 0, _kImgWidth, kScreenHeight)];
        }
        _scrollview.pagingEnabled = YES;
        _scrollview.clipsToBounds = NO;
        [self addSubview:_scrollview];
        self.clipsToBounds = YES;
        
        // 添加代理
        _scrollview.delegate = target;
        
        // 默认不可轮播
        _canCycleScroll = NO;
    }
    return self;
}

/**
 * 加载图片
 */
- (void)loadImgWithUrls:(NSArray *)urls placeholderImg:(NSString *)placeholderImg {
    _arrPics = urls;
    int index = 0;
    
    [_scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for(NSString *url in urls){
        UIImageView *imgView = [[UIImageView alloc] init];
        if (_isSameSize) {
            imgView.frame = CGRectMake(kScreenWidth * index, self.bounds.origin.y, kScreenWidth, kScreenHeight);
        }else {
            imgView.frame = CGRectMake(_kImgWidth * index, kScreenHeight / 6, _kImgWidth, _kImgHeight);
        }
        imgView.backgroundColor = XZRandomColor;
        if (!_isSameSize && index != 0) {
            CGRect imgBounds = imgView.bounds;
            CGFloat fabsNum = _scrollview.contentOffset.x - _kImgWidth * 1;
            //  _kImgWidth - 50 / 375.0 * kScreenWidth
            imgBounds.size.width = _kImgWidth * 0.2 * (_kImgWidth -  fabs(fabsNum))/ _kImgWidth + 0.8 * _kImgWidth;
            //  _kImgHeight - 108 / 812.0 * kScreenHeight
            imgBounds.size.height = _kImgHeight * 0.2 * (_kImgWidth -  fabs(fabsNum))/ _kImgWidth + 0.8 * _kImgHeight;
            imgView.bounds = imgBounds;
        }
        if ([url hasPrefix:@"https://"] || [url hasPrefix:@"http://"]) {
            if (!placeholderImg) {
                placeholderImg = @"0";
            }
            [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]] placeholderImage:[UIImage imageNamed:placeholderImg]];
        }else {
            imgView.image = [UIImage imageNamed:url];
        }
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
    int index = _scrollview.contentOffset.x / (_kImgWidth);
    
    void(^changeImgSize)(int i) = ^(int i) {
        UIImageView *im = _arrImgView[i];
        CGRect imgBounds = im.bounds;
        // 如果是当前i==index，fabsNum等于0；否则，fabsNum等于_kImgWidth
        CGFloat fabsNum = _scrollview.contentOffset.x - _kImgWidth * i;
        imgBounds.size.width =  _kImgWidth * 0.2 * (_kImgWidth -  fabs(fabsNum))/ (_kImgWidth) + 0.8 * _kImgWidth;
        imgBounds.size.height =  _kImgHeight * 0.2 * (_kImgWidth -  fabs(fabsNum))/ (_kImgWidth) + 0.8 * _kImgHeight;
        im.bounds = imgBounds;
    };
    
    if (_isSameSize) {
        
    }else {
        // 如果当前显示是第一张图片，将第二张图片的宽高缩小为原来的0.8倍
        if (index == 0) {
            for (int i = 0; i < 2; i++) {
                changeImgSize(i);
            }
        }else if(index == _arrPics.count - 1){
            // 如果当前显示是最后一张图片，将倒数第二张图片的宽高缩小为原来的0.8倍
            for (int i = index - 1; i < index + 1; i++) {
                changeImgSize(i);
            }
        }else{
            // 如果当前显示是中间的一张图片，将这张图片的左边和右边的图片的宽高缩小为原来的0.8倍
            for (int i = index - 1; i < index + 2; i++) {
                changeImgSize(i);
            }
        }
        
        if (self.canCycleScroll) { // 可以轮播
//            // 添加数据
//            [self CreateImgData];
            
            float offSetX = _scrollview.contentOffset.x;
            if (offSetX > (_kImgWidth) * (_arrPics.count - 2)) { // 最后一个
                _scrollview.contentOffset = CGPointMake(_kImgWidth, 0);
//                _x = 0;
//                _pageControl.currentPage = _x;
            }else if (offSetX <= 0 ) { // 第一个
                _scrollview.contentOffset = CGPointMake((_kImgWidth) * (_arrPics.count - 2) ,0);
//                _x = (int)(_arrPics.count - 2);
//                _pageControl.currentPage = _x;
            }else {
//                // 获取当前偏移量
//                _x = scrollView.contentOffset.x / (_kImgWidth) - 1;
//                _pageControl.currentPage = _x;
            }
        }
    }
}

/** 可以轮播 */
- (void)setCanCycleScroll:(BOOL)canCycleScroll {
    _canCycleScroll = canCycleScroll;
}

/** 添加数据 */
- (void)CreateImgData {
    if (_arrPics.count > (_arrPics.count + 2)) {
        return;
    }
    NSMutableArray *arrTemp = [NSMutableArray array];
    [arrTemp addObject:_arrPics[_arrPics.count - 1]];
    
    for (int i = 0; i < _arrPics.count; i++) {
        [arrTemp addObject:_arrPics[i]];
    }
    
    [arrTemp addObject:_arrPics[0]];
    _arrPics = [NSArray arrayWithArray:arrTemp];
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
