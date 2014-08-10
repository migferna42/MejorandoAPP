//
//  ViewController.h
//  Demo3
//
//  Created by Kirbo on 08/08/14.
//  Copyright (c) 2014 es.ujaen.es. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *CollectionView;
@property (strong, nonatomic) NSMutableArray *items;


@end
