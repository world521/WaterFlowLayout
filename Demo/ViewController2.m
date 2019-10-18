//
//
//  ViewController2.m
//  Demo
//
//  代码千万行，注释第一行！
//  编码不规范，同事泪两行。
//
//  Created by fqs on 2019/7/1.
//  Copyright © 2019 fqs. All rights reserved.
//
    

#import "ViewController2.h"
#import "SSBDCollectionViewWaterLayout.h"

@interface ViewController2() <UICollectionViewDataSource, UICollectionViewDelegate, SSBDCollectionViewWaterLayoutDelegate>
@property (nonatomic, strong) UICollectionView *ctV;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation ImageItem

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.array = [NSMutableArray array];
    for (NSInteger i = 0; i < 50; i++) {
        ImageItem *item = [ImageItem new];
        item.size = CGSizeMake(100 + arc4random() % 50, 150 + arc4random() % 50);
        item.color = [UIColor colorWithRed:arc4random() % 10 / 10.0 green:arc4random() % 10 / 10.0 blue:arc4random() % 10 / 10.0 alpha:1];
        [self.array addObject:item];
    }
    
    SSBDCollectionViewWaterLayout *water = [[SSBDCollectionViewWaterLayout alloc] init];
    water.columnCount = 3;
    water.columnMargin = 10;
    water.rowMargin = 10;
    water.edgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
//    water.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.ctV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, 375, 667 - 64 - 49) collectionViewLayout:water];
    self.ctV.dataSource = self;
    self.ctV.delegate = self;
    [self.view addSubview:self.ctV];
    [self.ctV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark - UICollectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ImageItem *item = self.array[indexPath.item];
    cell.contentView.backgroundColor = item.color;
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(SSBDCollectionViewWaterLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath cellWidth:(CGFloat)cellWidth {
    ImageItem *item = self.array[indexPath.item];
    return cellWidth / item.size.width * item.size.height;
}

@end
