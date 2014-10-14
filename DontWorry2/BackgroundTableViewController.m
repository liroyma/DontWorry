//
//  BackgroundTableViewController.m
//  DontWorry2
//
//  Created by Liroy Machluf on 10/1/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import "BackgroundTableViewController.h"

@interface BackgroundTableViewController () 

@end

@implementation BackgroundTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reset:(id)sender {
    if([UIAlertController class])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"איפוס תמונת רקע"
                                      message:@"האם אתה בטוח שאתה רוצה לאפס הרקע?"
                                      preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"אפס"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self.myMessages setImagebackground:nil];
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"ביטול"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];

        [alert addAction:ok];
        [alert addAction:cancel];

        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"איפוס תמונת רקע"
                                                        message:@"האם אתה בטוח שאתה רוצה לאפס הרקע?"
                                                        delegate:self
                                               cancelButtonTitle:@"ביטול"
                                               otherButtonTitles:@"אפס", nil];
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        [self.myMessages setImagebackground:nil];
    }
}

- (IBAction)open {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    CGSize newSize = CGSizeMake(200.0f, 240.0f);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [chosenImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.myMessages setImagebackground:newImage];
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
