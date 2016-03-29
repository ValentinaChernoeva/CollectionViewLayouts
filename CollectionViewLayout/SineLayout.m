//
//  SineLayout.m
//  CollectionViewLayout
//
//  Created by Valentina Chernoeva on 29.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import "SineLayout.h"

@interface SineLayout()

    @property (strong, nonatomic) NSMutableDictionary *layoutAttributes;
    @property (assign, nonatomic) CGSize contentSize;

@end

@implementation SineLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.layoutAttributes = [NSMutableDictionary dictionary];
    
    NSUInteger numberOfSections = [self.collectionView numberOfSections];
    CGFloat baseWidth = CGRectGetWidth(self.collectionView.frame) - self.horizontalInset * (self.itemsQuantity + 1);
    CGFloat itemWidth = baseWidth / self.itemsQuantity;
    CGSize itemSize = CGSizeMake(itemWidth, itemWidth);
    CGFloat yOffset = 0;
    for (int section = 0; section < numberOfSections; section++) {
        NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        CGFloat xOffset = self.horizontalInset;
        
        BOOL isIncrease = YES;
        for (int item = 0, itemCounter = 1; item < numberOfItems; item++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height));
            NSString *key = [self layoutKeyForIndexPath:indexPath];
            self.layoutAttributes[key] = attributes;
            
            if (itemCounter == self.itemsQuantity) {
                isIncrease = !isIncrease;
                itemCounter = 2;
            } else {
                itemCounter++;
            }
            if (isIncrease) {
                xOffset += itemSize.width + self.horizontalInset;
            } else {
                xOffset -= itemSize.width + self.horizontalInset;
            }
            yOffset += itemSize.height + self.verticalInset;
        }
    }
    
    yOffset += itemSize.height;
    
    self.contentSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), yOffset + self.verticalInset);
}

- (NSString *)layoutKeyForIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%ld_%ld", (long)indexPath.section, (long)indexPath.row];
}

#pragma mark - Required methods

- (CGSize)collectionViewContentSize {
    return self.contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [self layoutKeyForIndexPath:indexPath];
    return self.layoutAttributes[key];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
        UICollectionViewLayoutAttributes *layoutAttribute = self.layoutAttributes[evaluatedObject];
        return CGRectIntersectsRect(rect, [layoutAttribute frame]);
    }];
    
    NSArray *matchingKeys = [[self.layoutAttributes allKeys] filteredArrayUsingPredicate:predicate];
    return [self.layoutAttributes objectsForKeys:matchingKeys notFoundMarker:[NSNull null]];
}


@end
