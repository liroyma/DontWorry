//
//  Messages.h
//  DontWorry2
//
//  Created by Liroy Machluf on 8/30/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Messages : NSObject <CLLocationManagerDelegate>

@property (nonatomic,strong) NSMutableArray *messages;
@property (nonatomic, strong) NSMutableArray *recipientsNames;
@property (nonatomic, strong) NSMutableArray *recipientsNumbers;
@property (nonatomic) BOOL showLocationBtn;
@property (strong, nonatomic)NSString *locationMessageString;
@property (strong, nonatomic)NSString *location;
@property (strong, nonatomic) UIImage *image;
@property (nonatomic, strong)  CLLocationManager *locationManager;

-(void) loadData;

-(void) AddMessage:(NSString*)message;

-(void) RemoveMessage: (NSString*)message;

-(void) AddContactWithName:(NSString*)name AndNumber:(NSString*)number;

-(void) RemoveContactAtIndex:(NSInteger) index;

-(void) RemoveContactWithName:(NSString*)name;

-(void) RemoveMessageAtIndex:(NSInteger)index;

-(void) ChangeLocationButtonStatus:(BOOL)status;

-(void) StopLocationUpdate;

-(void) setImagebackground:(UIImage *)image;

-(NSInteger)getMessagecounter;

-(void)addCounter;

-(void)resetMessageCounter;

-(UIImage*)ResizeImageToSize:(CGSize)size;

-(UIImage*)SetEmptyImage;

@end
