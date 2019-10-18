//
//
//  SSBDCollectionViewWaterLayout.m
//  Demo
//
//  代码千万行，注释第一行！
//  编码不规范，同事泪两行。
//
//  Created by fqs on 2019/10/18.
//  Copyright © 2019 fqs. All rights reserved.
//
    

#import "SSBDCollectionViewWaterLayout.h"

@interface SSBDCollectionViewWaterLayout()
@property (nonatomic, strong) NSMutableArray <UICollectionViewLayoutAttributes *>*attriArray;
@property (nonatomic, strong) NSMutableArray <NSNumber *>*columnHeights;
@property (nonatomic, assign) CGFloat contentHeight;
@end

@implementation SSBDCollectionViewWaterLayout

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attriArray {
    if (_attriArray == nil) {
        _attriArray = [NSMutableArray array];
    }
    return _attriArray;
}

- (NSMutableArray<NSNumber *> *)columnHeights {
    if (_columnHeights == nil) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    self.contentHeight = 0;
    
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    [self.attriArray removeAllObjects];
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attriArray addObject:attri];
    }
}

- (NSArray <UICollectionViewLayoutAttributes *>*)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attriArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionW = self.collectionView.frame.size.width;
    CGFloat collectionH = self.collectionView.frame.size.height;
    CGFloat contentW = self.scrollDirection == UICollectionViewScrollDirectionHorizontal ? collectionH : collectionW;
    
    CGFloat cellW = (contentW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    id <SSBDCollectionViewWaterLayoutDelegate>delegate = (id)self.collectionView.delegate;
    CGFloat cellH = [delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:indexPath cellWidth:cellW];
    
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        CGFloat curColumnHeight = [self.columnHeights[i] doubleValue];
        if (curColumnHeight < minColumnHeight) {
            minColumnHeight = curColumnHeight;
            destColumn = i;
        }
    }
    
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        CGFloat cellY = self.edgeInsets.right + destColumn * (cellW + self.columnMargin);
        CGFloat cellX = minColumnHeight;
        if (cellX != self.edgeInsets.top) {
            cellX += self.rowMargin;
        }
        
        attri.frame = CGRectMake(cellX, cellY, cellH, cellW);
        
        CGFloat columnHeight = CGRectGetMaxX(attri.frame);
        self.columnHeights[destColumn] = @(columnHeight);
        
        if (self.contentHeight < columnHeight) {
            self.contentHeight = columnHeight;
        }
    } else {
        CGFloat cellX = self.edgeInsets.left + destColumn * (cellW + self.columnMargin);
        CGFloat cellY = minColumnHeight;
        if (cellY != self.edgeInsets.top) {
            cellY += self.rowMargin;
        }
        
        attri.frame = CGRectMake(cellX, cellY, cellW, cellH);
        
        CGFloat columnHeight = CGRectGetMaxY(attri.frame);
        self.columnHeights[destColumn] = @(columnHeight);
        
        if (self.contentHeight < columnHeight) {
            self.contentHeight = columnHeight;
        }
    }
    
    return attri;
}

- (CGSize)collectionViewContentSize {
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        return CGSizeMake(self.contentHeight + self.edgeInsets.bottom, 0);
    } else {
        return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
    }
}

@end
