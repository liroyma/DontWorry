//
//  BackgroundViewController.h
//  DontWorry2
//
//  Created by Liroy Machluf on 10/14/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Messages.h"

@interface BackgroundViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>


@property (nonatomic,strong) Messages *myMessages;


@end
