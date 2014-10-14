//
//  BackgroundTableViewController.h
//  DontWorry2
//
//  Created by Liroy Machluf on 10/1/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Messages.h"

@interface BackgroundTableViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) Messages *myMessages;

@end
