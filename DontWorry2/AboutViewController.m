//
//  AboutViewController.m
//  DontWorry2
//
//  Created by Liroy Machluf on 10/2/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import "AboutViewController.h"
#import "Messages.h"
#import <MessageUI/MessageUI.h>


@interface AboutViewController () <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *countlbl;
@property (strong, nonatomic) Messages *myMessegase;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myMessegase = [[Messages alloc]init];   // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.myMessegase loadData];
    self.countlbl.text = [NSString stringWithFormat:@"%tu",[self.myMessegase getMessagecounter]];
}
- (IBAction)sendAndRest:(id)sender {
    [self.myMessegase resetMessageCounter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)linkToWeb:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://dontworry.liroym.com"]];
}

- (IBAction)ShowMail:(id)sender {
    NSString *emailTitle = @"DontWorry Support";
    // Email Content
    NSString *messageBody = @"";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"liroyma@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
