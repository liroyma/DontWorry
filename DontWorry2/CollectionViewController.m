//
//  CollectionViewController.m
//  DontWorry2
//
//  Created by Liroy Machluf on 9/6/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import "CollectionViewController.h"
#import <MessageUI/MessageUI.h>
#import <QuartzCore/QuartzCore.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <iAd/iAd.h>
#import "Messages.h"

@interface CollectionViewController ()  <MFMessageComposeViewControllerDelegate, ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *names;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myMessages = [[Messages alloc]init];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.myMessages loadData];
    [self.collectionView reloadData];
    if([self.myMessages.recipientsNumbers count] > 0)
    {
        self.names.text = [self.myMessages.recipientsNames componentsJoinedByString:@", "];
        self.names.textColor = [UIColor blackColor];
    }
    else
    {
        self.names.text = NSLocalizedString(@"Please select contact", comment: "The Close button title");
        self.names.textColor = [UIColor colorWithRed:105.0f/255 green:202.0f/255 blue:249.0f/255 alpha:1];
    }
        
    

    if(self.myMessages.image)
    {
        self.collectionView.backgroundView = [[UIImageView alloc] initWithImage:[self.myMessages ResizeImageToSize:self.collectionView.bounds.size]];
    }
    else
    {
        self.collectionView.backgroundView = [[UIImageView alloc] initWithImage:[self.myMessages SetEmptyImage]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    if(self.myMessages.showLocationBtn)
         return [self.myMessages.messages count] + 1;
    return [self.myMessages.messages count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MessageCell" forIndexPath:indexPath];
    UILabel *lbl = (UILabel*) [cell viewWithTag:101];
    UIImage *image = [UIImage imageNamed:@"BUBBLE"];
    cell.backgroundColor = [UIColor colorWithPatternImage:image];

    if(indexPath.row == [self.myMessages.messages count])
    {
        [lbl setText:self.myMessages.locationMessageString];
    }
    else
    {
        [lbl setText:self.myMessages.messages[indexPath.row]];
    }
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger num = [collectionView numberOfItemsInSection:0];

    if([ self.myMessages.recipientsNumbers count] > 0)
    {
        NSString *str;
        if(self.myMessages.showLocationBtn && num-1==indexPath.row)
        {
            if(self.myMessages.location)
            {
                NSString *locmessage = NSLocalizedString(@"My location is:", comment: "The Close button title");
                str = [NSString stringWithFormat:@"%@\n\n%@",locmessage , self.myMessages.location];
            }
        }
        else{
            str = self.myMessages.messages[indexPath.row];
        }
        
        if(str)
        {
            [self showSMS:str withRecipients:self.myMessages.recipientsNumbers];
        }
    }
    else
    {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please set who to send in the setting screen!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
     
    }

}

#pragma SMS scope


- (void)showSMS:(NSString*)message withRecipients:(NSMutableArray *)recp {
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recp];
    [messageController setBody:message];
    [self presentViewController:messageController animated:YES completion:^{
        [self.myMessages StopLocationUpdate];
    }];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result {
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            [self.myMessages addCounter];
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

#pragma ad banner scope

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}

@end
