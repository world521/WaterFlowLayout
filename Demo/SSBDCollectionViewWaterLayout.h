//
//
//  SSBDCollectionViewWaterLayout.h
//  Demo
//
//  代码千万行，注释第一行！
//  编码不规范，同事泪两行。
//
//  Created by fqs on 2019/10/18.
//  Copyright © 2019 fqs. All rights reserved.
//
    

#import <UIKit/UIKit.h>
@class SSBDCollectionViewWaterLayout;

NS_ASSUME_NONNULL_BEGIN

@protocol SSBDCollectionViewWaterLayoutDelegate <UICollectionViewDelegate>
@required
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(SSBDCollectionViewWaterLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath cellWidth:(CGFloat)cellWidth;
@end

@interface SSBDCollectionViewWaterLayout : UICollectionViewLayout
@property (nonatomic, assign) NSInteger columnCount;
@property (nonatomic, assign) CGFloat columnMargin;
@property (nonatomic, assign) CGFloat rowMargin;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@property (nonatomic) UICollectionViewScrollDirection scrollDirection;
@end

NS_ASSUME_NONNULL_END
