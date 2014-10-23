//
//  BubblelsViewController.m
//  DontWorry2
//
//  Created by Liroy Machluf on 10/17/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import "BubblelsViewController.h"
#import "STBubbleTableViewCell.h"

@interface BubblelsViewController () <UITableViewDelegate,UITableViewDataSource, STBubbleTableViewCellDataSource, STBubbleTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *receptians;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic,strong) NSMutableArray *array;

@end

@implementation BubblelsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [[NSMutableArray alloc]initWithObjects:
                  @"hello world",
                  @"i waht to go home"
                  ,@"please see mnbkjkb mgkjgkbjk  kjhkhkjh kjhkhkjhkjn  ljhklhlhjlkn lnljthis attuched file"
                  , nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Bubble Cell";
    
    STBubbleTableViewCell *cell = (STBubbleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[STBubbleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataSource = self;
        cell.delegate = self;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.text = self.array[indexPath.row];
    
    // Put your own logic here to determine the author
    /*if(indexPath.row % 2 != 0 || indexPath.row == 4)
    {
        cell.authorType = STBubbleTableViewCellAuthorTypeSelf;
        cell.bubbleColor = STBubbleTableViewCellBubbleColorGreen;
    }
    else
    {
        cell.authorType = STBubbleTableViewCellAuthorTypeOther;
        cell.bubbleColor = STBubbleTableViewCellBubbleColorGray;
    }*/
    
    return cell;

}


#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *message = [self.array objectAtIndex:indexPath.row];
    
    CGSize size;
    
    
    size = [message sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(self.table.frame.size.width - [self minInsetForCell:nil atIndexPath:indexPath] - STBubbleWidthOffset, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    
    // This makes sure the cell is big enough to hold the avatar
   /* if(size.height + 15.0f < STBubbleImageSize + 4.0f && message.avatar)
    {
        return STBubbleImageSize + 4.0f;
    }*/
    
    return size.height + 15.0f;
}

#pragma mark - STBubbleTableViewCellDataSource methods

- (CGFloat)minInsetForCell:(STBubbleTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
    {
        return 100.0f;
    }
    
    return 50.0f;
}

#pragma mark - STBubbleTableViewCellDelegate methods

- (void)tappedImageOfCell:(STBubbleTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSString *message = [self.array objectAtIndex:indexPath.row];
    NSLog(@"%@", message);
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}


@end
