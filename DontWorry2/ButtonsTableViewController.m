//
//  ButtonsTableViewController.m
//  DontWorry2
//
//  Created by Liroy Machluf on 9/4/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import "ButtonsTableViewController.h"
#import "AddMessageViewController.h"

@interface ButtonsTableViewController () <UIPopoverControllerDelegate>

@end

@implementation ButtonsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myMessages = [[Messages alloc]init];
    [self.myMessages loadData];
    [self setModalPresentationStyle:UIModalPresentationCurrentContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.myMessages loadData];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {    return self.myMessages.messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell" forIndexPath:indexPath];
    cell.textLabel.text = self.myMessages.messages[[indexPath row] ];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //
    if ([segue.identifier isEqualToString:@"addMessage"]) {
        AddMessageViewController *destViewController = segue.destinationViewController;
        destViewController.myMessages = self.myMessages;
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.myMessages RemoveMessageAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
@end
