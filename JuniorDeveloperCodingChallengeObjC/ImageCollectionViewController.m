//
//  ImageCollectionViewController.m
//  JuniorDeveloperCodingChallengeObjC
//
//  Created by Daniel Wickes on 3/26/15.
//  Copyright (c) 2015 danielwickes. All rights reserved.
//

#import "ImageCollectionViewController.h"
#import "ImageCollectionViewCell.h"
#import <Dropbox/Dropbox.h>
#import "DBSyncManager.h"

@interface ImageCollectionViewController() <UICollectionViewDataSource>

@property NSArray *images;

@end

@implementation ImageCollectionViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    self.images = [[DBSyncManager getSharedInstance] getImages];
    self.collectionView.dataSource = self;
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.images = nil;
}

// MARK: UICollectionViewDataSource

-(NSInteger) numberOfSectionsInCollectionView: (UICollectionView*) collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.images count];
}



- (UICollectionViewCell*)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell* cell = [cv dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];    // Configure the cell
    cell.imageView.image = [self.images objectAtIndex:indexPath.item];
    return cell;
    
}

@end
