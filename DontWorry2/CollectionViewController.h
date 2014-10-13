//
//  CollectionViewController.h
//  DontWorry2
//
//  Created by Liroy Machluf on 9/6/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Messages.h"


@interface CollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) Messages *myMessages;

@end
