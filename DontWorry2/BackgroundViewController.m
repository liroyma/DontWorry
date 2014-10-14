//
//  BackgroundViewController.m
//  DontWorry2
//
//  Created by Liroy Machluf on 10/14/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import "BackgroundViewController.h"

@interface BackgroundViewController ()

@end

@implementation BackgroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetBackground:(id)sender {
    if([UIAlertController class])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"איפוס תמונת רקע"
                                      message:@"האם ברצונך לאפס הגדרות רקע?"
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
                                                       message:@"האם ברצונך לאפס הגדרות רקע?"
                                                       delegate:self
                                              cancelButtonTitle:@"ביטול"
                                              otherButtonTitles:@"אפס", nil];
        [alert show];
    }
}


- (IBAction)openAlbum:(id)sender {
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
    
    [self.myMessages setImagebackground:chosenImage];
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
