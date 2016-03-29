//
//  CollectionDataSourse.h
//  CollectionViewLayout
//
//  Created by Valentina Chernoeva on 29.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CollectionDataSourse : NSObject <UICollectionViewDataSource>

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
                        cellIdentifier:(NSString *)cellIdentifier;

@end
