//
//  EditTableViewController.m
//  DontWorry2
//
//  Created by Liroy Machluf on 9/2/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import "EditTableViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface EditTableViewController () <ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate>

@property (nonatomic, strong) ABPeoplePickerNavigationController *addressBookController;

@end

@implementation EditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myMessages = [[Messages alloc]init];
    [self.myMessages loadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.myMessages loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.myMessages.recipientsNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    NSInteger row = [indexPath row];
    cell.textLabel.text = self.myMessages.recipientsNames[row];
    cell.detailTextLabel.text = self.myMessages.recipientsNumbers[row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {        [self.myMessages RemoveContactAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


- (IBAction)OpenContacts{
    
    _addressBookController = [[ABPeoplePickerNavigationController alloc] init];
    [_addressBookController setPeoplePickerDelegate:self];
    [self presentViewController:_addressBookController animated:YES completion:nil];
    
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
   /* NSString *firstname = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    NSString *lastname = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
    
    NSString *tempnumber;
    ABMultiValueRef phonesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    for (int i=0; i<ABMultiValueGetCount(phonesRef); i++) {
        CFStringRef currentPhoneLabel = ABMultiValueCopyLabelAtIndex(phonesRef, i);
        CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phonesRef, i);
        if (CFStringCompare(currentPhoneLabel, kABHomeLabel, 0) == kCFCompareEqualTo) {
            tempnumber = (__bridge NSString *)currentPhoneValue;
        }
        if (CFStringCompare(currentPhoneLabel, kABWorkLabel, 0) == kCFCompareEqualTo) {
            tempnumber = (__bridge NSString *)currentPhoneValue;
        }
        if (CFStringCompare(currentPhoneLabel, kABPersonPhoneIPhoneLabel, 0) == kCFCompareEqualTo) {
            tempnumber = (__bridge NSString *)currentPhoneValue;
        }
        if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
            tempnumber = (__bridge NSString *)currentPhoneValue;
        }
        if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMainLabel, 0) == kCFCompareEqualTo) {
            tempnumber = (__bridge NSString *)currentPhoneValue;
        }
        if (CFStringCompare(currentPhoneLabel, kABOtherLabel , 0) == kCFCompareEqualTo) {
            tempnumber = (__bridge NSString *)currentPhoneValue;
        }
        CFRelease(currentPhoneLabel);
        CFRelease(currentPhoneValue);
        if(tempnumber)
            break;
    }
    CFRelease(phonesRef);
    NSString *fullNameString =[NSString stringWithFormat:@"%@ %@",firstname ? firstname : @"",lastname ? lastname : @""];
    if(![self.myMessages.recipientsNumbers containsObject:tempnumber])
    {
        [self.myMessages AddContactWithName:fullNameString AndNumber:tempnumber];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Phone already exsist"
                                                       message: [NSString stringWithFormat:@"You alrady add %@.",fullNameString]
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:@"OK",nil];
        [alert show];
    }
    [self.tableView reloadData];
    
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];*/
    ABPersonViewController *controller = [[ABPersonViewController alloc] init];
    controller.displayedPerson = person;
    controller.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];
    controller.personViewDelegate = self;
    [peoplePicker pushViewController:controller animated:YES];
    return NO;
    
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person{
    /*NSString *firstname = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    NSString *lastname = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
    
    NSString *tempnumber;
    ABMultiValueRef phonesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    for (int i=0; i<ABMultiValueGetCount(phonesRef); i++) {
        CFStringRef currentPhoneLabel = ABMultiValueCopyLabelAtIndex(phonesRef, i);
        CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phonesRef, i);
        if (CFStringCompare(currentPhoneLabel, kABHomeLabel, 0) == kCFCompareEqualTo) {
            tempnumber = (__bridge NSString *)currentPhoneValue;
        }
        if (CFStringCompare(currentPhoneLabel, kABWorkLabel, 0) == kCFCompareEqualTo) {
            tempnumber = (__bridge NSString *)currentPhoneValue;
        }
        if (CFStringCompare(currentPhoneLabel, kABPersonPhoneIPhoneLabel, 0) == kCFCompareEqualTo) {
            tempnumber = (__bridge NSString *)currentPhoneValue;
        }
        if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
            tempnumber = (__bridge NSString *)currentPhoneValue;
        }
        if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMainLabel, 0) == kCFCompareEqualTo) {
            tempnumber = (__bridge NSString *)currentPhoneValue;
        }
        if (CFStringCompare(currentPhoneLabel, kABOtherLabel , 0) == kCFCompareEqualTo) {
            tempnumber = (__bridge NSString *)currentPhoneValue;
        }
        CFRelease(currentPhoneLabel);
        CFRelease(currentPhoneValue);
        if(tempnumber)
            break;
    }
    if(phonesRef)
    {
        CFRelease(phonesRef);
    }
    else{
        tempnumber = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonEmailProperty));
        
    }
    NSString *fullNameString =[NSString stringWithFormat:@"%@ %@",firstname ? firstname : @"",lastname ? lastname : @""];
    if(![self.myMessages.recipientsNumbers containsObject:tempnumber])
    {
        
        [self.myMessages AddContactWithName:fullNameString AndNumber:tempnumber];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Phone already exsist"
                                                       message: [NSString stringWithFormat:@"You alrady add %@.",fullNameString]
                                                      delegate: self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:@"OK",nil];
        [alert show];
    }
    
    [self.tableView reloadData];
    */
    ABPersonViewController *controller = [[ABPersonViewController alloc] init];
    controller.displayedPerson = person;
    controller.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];
    controller.personViewDelegate = self;
    [peoplePicker pushViewController:controller animated:YES];

    
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier {
    return NO;
}

-(BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    //ABMutableMultiValueRef multi = ABRecordCopyValue(person, property);
    NSString *firstname = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    NSString *lastname = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
    //CFStringRef phone = ABMultiValueCopyValueAtIndex(multi, identifierForValue);
    //CFRelease(phone);
    
    ABPeoplePickerNavigationController *peoplePicker = (ABPeoplePickerNavigationController *)personViewController.navigationController;
    //[peoplePicker dismissModalViewControllerAnimated:YES];
    return NO;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];
}

@end
