
//  SettingsViewController.m
//  DontWorry2
//
//  Created by Liroy Machluf on 8/30/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import "SettingsViewController.h"
#import "BackgroundViewController.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface SettingsViewController() <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *sendLocationSwitch;

@property (weak, nonatomic) IBOutlet UIButton *shareBut;
@end

@implementation SettingsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.myMessages = [[Messages alloc]init];
    [self.myMessages loadData];
    self.shareBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.sendLocationSwitch.on = self.myMessages.showLocationBtn;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"background"]) {
        BackgroundViewController *destViewController = segue.destinationViewController;
        destViewController.myMessages = self.myMessages;
    }
}

- (IBAction)switchToggle:(id)sender {
    [self.myMessages ChangeLocationButtonStatus:self.sendLocationSwitch.on];
}

#pragma actionsheet
-(IBAction)showNormalActionSheet:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Tell a friend about DontWorry via..."
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Mail",@"FaceBook", @"Twitter", nil];
     [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Mail"])
    {
        NSLog(@"Send Mail");
        // Email Subject
        NSString *emailTitle = @"Recommended App";
        // Email Content
        NSString *messageBody = @"<h1>I'm using DontWorry Application and it's great! :)</h1> <p>you should try it.</p>";
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:YES];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else if([title isEqualToString:@"FaceBook"])
    {
        NSLog(@"Send FaceBook");
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            [controller setInitialText:@"I'm using DontWorry Application and it's great! :)"];
            //[controller addURL:[NSURL URLWithString:@"http://www.appcoda.com"]];
            [controller addImage:[UIImage imageNamed:@"tradeMark"]];
            [self presentViewController:controller animated:YES completion:Nil];
        }
    }
    else if([title isEqualToString:@"Twitter"])
    {
        NSLog(@"Send Twitter");
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweetSheet = [SLComposeViewController
                                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:@"I'm using DontWorry Application and it's great! :)"];
            [self presentViewController:tweetSheet animated:YES completion:nil];
        }
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
