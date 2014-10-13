
//  SettingsViewController.m
//  DontWorry2
//
//  Created by Liroy Machluf on 8/30/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import "SettingsViewController.h"
#import "BackgroundTableViewController.h"
#import <Social/Social.h>

@interface SettingsViewController() <UIActionSheetDelegate>

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
        BackgroundTableViewController *destViewController = segue.destinationViewController;
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

@end
