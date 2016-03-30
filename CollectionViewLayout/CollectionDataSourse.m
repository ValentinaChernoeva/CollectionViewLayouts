//
//  CollectionDataSourse.m
//  CollectionViewLayout
//
//  Created by Valentina Chernoeva on 29.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import "CollectionDataSourse.h"

@interface CollectionDataSourse ()

@property (copy, nonatomic) NSString *cellIdentifier;

@end

@implementation CollectionDataSourse

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
                        cellIdentifier:(NSString *)cellIdentifier {
    self = [super init];
    if (self) {
        collectionView.dataSource = self;
        self.cellIdentifier = [cellIdentifier copy];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    return cell;
}
@end
