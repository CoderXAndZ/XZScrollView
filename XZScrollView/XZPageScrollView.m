//
//  XZPageScrollView.m
//  XZScrollView
//
//  Created by XZ on 2017/10/12.
//  Copyright © 2016年 XZ. All rights reserved.
//

#import "XZPageScrollView.h"
#import "UIImageView+WebCache.h"
#import "XZPageScrollCell.h"
#import "XZPageScrollModel.h"
#import "XZFlowLayout.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

#define kViewWidth self.bounds.size.width
#define kViewHeight self.bounds.size.height

// 随机色
#define XZRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

NSString *const collectionId = @"cycleCell";

@interface XZPageScrollView()<UICollectionViewDelegate,UICollectionViewDataSource>
/** imageView的数组 */
@property (nonatomic, strong) NSMutableArray *arrImgView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/** 图片数组 */
@property (nonatomic, strong) NSMutableArray *arrPics;
@end

@implementation XZPageScrollView {
    CGFloat _kImgHeight; // 图片高度
    CGFloat _kImgWidth; // 图片宽度
    /** 图片大小是否一致 */
    BOOL _isSameSize;
//    NSInteger _currentIndex;
}

// 可不可以轮播，只有图片时，占位图
- (instancetype)initWithFrame:(CGRect)frame isSameSize:(BOOL)isSameSize {
    self = [super initWithFrame:frame];
    if (self){
        _isSameSize = isSameSize;
        //
        [self setUpImageSize];
        //
        [self setUpPageScrollView];
       
    }
    return self;
}

#pragma mark ---- UICollectionView的代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrPics.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XZPageScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionId forIndexPath:indexPath];
    cell.modelScroll = _arrPics[indexPath.item];
    return cell;
}

- (void)setItemSizeCustom:(CGSize)itemSizeCustom {
    _itemSizeCustom = itemSizeCustom;
    
    _flowLayout.itemSize = itemSizeCustom;
    
    CGRect rect = _collection.frame;
    rect.size.width = kScreenWidth;
    rect.size.height = itemSizeCustom.height;
    
    _collection.frame = rect;
    _collection.center = CGPointMake(self.center.x, self.center.y);
    _collection.collectionViewLayout = _flowLayout;
}

- (void)setArrImage:(NSArray *)arrImage {
    _arrImage = arrImage;
    for (int i = 0;i < arrImage.count; i++) {
        XZPageScrollModel *modelScroll = [[XZPageScrollModel alloc] init];
        if (self.placeHolderImg) {
            modelScroll.placeHolder = self.placeHolderImg;
        }else {
            modelScroll.placeHolder = @"0";
        }
        modelScroll.imgName = arrImage[i];
        [self.arrPics addObject:modelScroll];
    }
    [self.collection reloadData];
    
//    [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

/** 初始化view */
- (void)setUpPageScrollView {
    if (_isSameSize) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout = flowLayout;
    }else {
        XZFlowLayout *flowLayout = [[XZFlowLayout alloc] init];
        _flowLayout = flowLayout;
    }
    
    NSLog(@"_flowLayout ===== %@",_flowLayout);
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
    collection.backgroundColor = [UIColor greenColor];
    //    collection.showsHorizontalScrollIndicator = NO;
    //    collection.showsVerticalScrollIndicator = NO;
    [collection registerClass:[XZPageScrollCell class] forCellWithReuseIdentifier:collectionId];
    collection.dataSource = self;
    collection.delegate = self;
    collection.scrollsToTop = NO;
    [self addSubview:collection];
    _collection = collection;
    
    if (_isSameSize) {
        _flowLayout.itemSize = CGSizeMake(_kImgWidth, _kImgHeight);
        collection.pagingEnabled = YES;
    }else {
        _flowLayout.itemSize = CGSizeMake(_kImgWidth, _kImgHeight);
    }
}

- (void)setUpImageSize {
    if (_isSameSize) {
        _kImgWidth = kViewWidth;
        _kImgHeight = kViewHeight;
    }else {
        _kImgWidth = kViewWidth * 2 / 3;
        _kImgHeight = kViewHeight * 2 / 3;
    }
}

#pragma mark ---- 懒加载
- (NSMutableArray *)arrPics {
    if (!_arrPics) {
        _arrPics = [NSMutableArray array];
    }
    return _arrPics;
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    int index = scrollView.contentOffset.x / (_kImgWidth);
//
//    NSLog(@"\n scrollview.contentOffset.x:%f ===== index:%d",scrollView.contentOffset.x,index);
//}

@end
