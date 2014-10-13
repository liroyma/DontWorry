//
//  AboutViewController.m
//  DontWorry2
//
//  Created by Liroy Machluf on 10/2/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import "AboutViewController.h"
#import "Messages.h"


@interface AboutViewController ()
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
