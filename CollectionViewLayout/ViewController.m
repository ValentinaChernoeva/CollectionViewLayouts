//
//  ViewController.m
//  CollectionViewLayout
//
//  Created by Valentina Chernoeva on 29.03.16.
//  Copyright © 2016 Valentina Chernoeva. All rights reserved.
//

#import "ViewController.h"
#import "CollectionDataSourse.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) CollectionDataSourse *collectionDataSourse;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionDataSourse = [[CollectionDataSourse alloc] initWithCollectionView:self.collectionView cellIdentifier:@"CollectionViewCell"];
}

@end
