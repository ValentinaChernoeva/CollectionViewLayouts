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

- (void)prepareLayout {
    [super prepareLayout];
    
    self.layoutAttributes = [NSMutableDictionary dictionary];
    
    NSUInteger numberOfSections = [self.collectionView numberOfSections];
    CGFloat itemWidth = CGRectGetWidth(self.collectionView.frame) / self.itemsQuantity;
    CGSize itemSize = CGSizeMake(itemWidth, itemWidth);
    
    float x = 0;
    float y = 0;
    CGFloat yOffset = 0;
    
    for (int section = 0; section < numberOfSections; section++) {
        NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];

        for (int item = 0; item < numberOfItems; item++) {
            x = sinf(y);

            CGRect transitionRect = self.collectionView.frame;
            transitionRect.size.width -= itemSize.width;
            CGPoint attributCenter = [self transitionCoordinateX:x coordinateY:y inFrame:transitionRect];
            attributCenter.x += itemSize.width/2;
            attributCenter.y += itemSize.height/2;
            yOffset = attributCenter.y;
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.size = itemSize;
            attributes.center = attributCenter;
            
            if (attributCenter.x > itemSize.width/2
                && attributCenter.x < CGRectGetWidth(transitionRect) + itemSize.width/2) {
                attributes.transform = CGAffineTransformMakeRotation(M_PI_4);
            }
            
            NSString *key = [self layoutKeyForIndexPath:indexPath];
            self.layoutAttributes[key] = attributes;
            
            y += M_PI / self.itemsQuantity;
        }
    }
    yOffset += itemSize.height;
    
    self.contentSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), yOffset);
}

#pragma mark - Help methods

- (CGPoint)transitionCoordinateX:(float)x coordinateY:(float)y inFrame:(CGRect)frame {
    CGFloat coordinateCenter = CGRectGetMidX(frame);
    CGFloat deltaX = coordinateCenter + coordinateCenter * x;
    CGFloat deltaY = CGRectGetMaxY(frame) / self.itemsQuantity * y;
    return CGPointMake(deltaX, deltaY);
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
