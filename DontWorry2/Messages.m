//
//  Messages.m
//  DontWorry
//
//  Created by Liroy Machluf on 6/21/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import "Messages.h"
#import <CoreLocation/CoreLocation.h>

@interface Messages()

@property (nonatomic) NSInteger messageCounter;

@end

@implementation Messages{
    CLLocationManager *locationManager;
}

-(NSMutableArray *)messages
{
    if(!_messages) _messages =[[NSMutableArray alloc]init];
    return _messages;
}

-(NSMutableArray *)recipientsNames
{
    if(!_recipientsNames) _recipientsNames =[[NSMutableArray alloc]init];
    return _recipientsNames;
}

-(NSMutableArray *)recipientsNumbers
{
    if(!_recipientsNumbers) _recipientsNumbers =[[NSMutableArray alloc]init];
    return _recipientsNumbers;
}

-(void)addCounter
{
    self.messageCounter++;
    [self saveData];
}

-(NSInteger)getMessagecounter
{
    return self.messageCounter;
}

-(void)resetMessageCounter
{
    self.messageCounter = 0;
}

-(instancetype)init
{
    self = [super init];
    
    if(self)
    {
        self.locationMessageString = @"שלח מיקום";
        self.messageCounter = 0;
        [self loadData];
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
        }
        [locationManager startUpdatingLocation];
    }
    
    return self;
}


-(NSString *)addLocationMessage
{
    return self.locationMessageString;
}

-(void) setImagebackground:(UIImage *)image
{
    self.image = image;
    [self saveData];
}

-(void)AddContactWithName:(NSString *)name AndNumber:(NSString*)number;
{
    [self.recipientsNames addObject:name];
    [self.recipientsNumbers addObject:number];
    [self saveData];

}

-(void)RemoveContactWithName:(NSString *)name
{
    NSInteger index = [self.recipientsNames indexOfObject:name];
    [self.recipientsNames removeObject:name];
    [self.recipientsNumbers removeObjectAtIndex:index];
    [self saveData];

}
-(void) RemoveContactAtIndex:(NSInteger) index
{
    [self.recipientsNames removeObjectAtIndex:index];
    [self.recipientsNumbers removeObjectAtIndex:index];
    [self saveData];

}

-(void)AddMessage:(NSString *)message
{
    [self.messages addObject:message];
    [self saveData];

}

-(void)RemoveMessage:(NSString *)message
{
    [self.messages removeObject:message];
    [self saveData];

}

-(void)RemoveMessageAtIndex:(NSInteger)index
{
    [self.messages removeObjectAtIndex:index];
    [self saveData];

}

-(void)ChangeLocationButtonStatus:(BOOL)status
{
    self.showLocationBtn = status;
    if(status)
    {
        [locationManager startUpdatingLocation];
    }
    else
    {
        self.location = nil;
        [locationManager stopUpdatingLocation];
    }
    [self saveData];
}

-(void) StopLocationUpdate
{
    [locationManager stopUpdatingLocation];
}

- (void)loadData
{
    NSUserDefaults *defualt = [NSUserDefaults standardUserDefaults];
    self.messages = [[defualt valueForKey:@"messages"] mutableCopy];
    self.recipientsNumbers = [[defualt valueForKey:@"recipientsNumbers"] mutableCopy];
    self.recipientsNames = [[defualt valueForKey:@"recipientsNames"] mutableCopy];
    self.showLocationBtn = [defualt boolForKey:@"showLocationBtn"];
    self.messageCounter = [defualt integerForKey:@"counter"];
    NSData* imageData = [defualt objectForKey:@"image"];
    self.image = [UIImage imageWithData:imageData];
}

- (void)saveData
{
    NSUserDefaults *defualt = [NSUserDefaults standardUserDefaults];
    [defualt setObject:self.messages forKey:@"messages"];
    [defualt setObject: UIImagePNGRepresentation(self.image) forKey:@"image"];
    [defualt setObject:self.recipientsNames forKey:@"recipientsNames"];
    [defualt setObject:self.recipientsNumbers forKey:@"recipientsNumbers"];
    [defualt setBool:self.showLocationBtn forKey:@"showLocationBtn"];
    [defualt setInteger:self.messageCounter forKey:@"counter"];
    [defualt synchronize];
}

#pragma Location scope

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        double longitude = currentLocation.coordinate.longitude;
        double latitude = currentLocation.coordinate.latitude;
        self.location = [self navigateToLatitude:latitude longitude:longitude];
    }
}

- (NSString*) navigateToLatitude:(double)latitude longitude:(double)longitude{
    return [NSString stringWithFormat:@"waze://?ll=%f,%f&navigate=yes",latitude, longitude];
}

@end
