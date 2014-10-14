//
//  AddMessageViewController.m
//  DontWorry2
//
//  Created by Liroy Machluf on 9/4/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import "AddMessageViewController.h"
#import "ButtonsTableViewController.h"

@interface AddMessageViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textlbl;

@end

@implementation AddMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)DismissUI:(id)sender {    if (self.textlbl.text && self.textlbl.text.length > 0)
    {
        [self.myMessages AddMessage:self.textlbl.text];
    }
    [self dismissViewControllerAnimated:YES completion:Nil];}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
