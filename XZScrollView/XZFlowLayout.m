//
//  XZFlowLayout.m
//  XZScrollView
//
//  Created by admin on 2017/10/16.
//  Copyright © 2017年 RongTuoJinRong. All rights reserved.
//

#import "XZFlowLayout.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#define ZOOM_SCALE 0.1
#define ACTIVE_DISTANCE 200

@implementation XZFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
//        self.itemSize = CGSizeMake(250, 350);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 设置item的间隔
        self.minimumLineSpacing = 25;
        self.sectionInset = UIEdgeInsetsMake(64, 25, 0, 25);
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    NSArray *array = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    CGRect collectRect;
    collectRect.origin = self.collectionView.contentOffset;
    collectRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (CGRectIntersectsRect(attrs.frame, rect)) {
            CGFloat distance = CGRectGetMidX(collectRect) - attrs.center.x;
            
            distance = ABS(distance);
            
            if (distance < (kScreenWidth / 2 + self.itemSize.width)) {
                CGFloat zoom = 1 + ZOOM_SCALE * (1 - distance / ACTIVE_DISTANCE);
                attrs.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                attrs.transform3D = CATransform3DTranslate(attrs.transform3D, 0, -zoom * 25, 0);
                attrs.alpha = zoom - ZOOM_SCALE;
            }
        }
    }
    
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat offsetAdjust = MAXFLOAT;
    CGFloat horizonCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
//    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    NSArray *array = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:targetRect] copyItems:YES];
    
    for (UICollectionViewLayoutAttributes *layoutAttrs in array) {
        CGFloat itemHorizonCenter = layoutAttrs.center.x;
        if (ABS(itemHorizonCenter - horizonCenter) < ABS(offsetAdjust)) {
            offsetAdjust = itemHorizonCenter - horizonCenter;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjust, proposedContentOffset.y);
}

@end
