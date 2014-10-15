//
//  Messages.m
//  DontWorry
//
//  Created by Liroy Machluf on 6/21/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import "Messages.h"

@interface Messages()

@property (nonatomic) NSInteger messageCounter;
@property (nonatomic,strong) NSUserDefaults *defualt;

@end


@implementation Messages{

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
    
    [self.defualt setInteger:self.messageCounter forKey:@"counter"];
    [self.defualt synchronize];
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
        self.defualt = [NSUserDefaults standardUserDefaults];
        [self loadData];
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager requestAlwaysAuthorization];
        }
        [self.locationManager startUpdatingLocation];
    }
    
    return self;
}

-(UIImage*)ResizeImageToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self.image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(UIImage*)SetEmptyImage
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:105.0f/255 green:202.0f/255 blue:249.0f/255 alpha:1] CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


-(NSString *)addLocationMessage
{
    return self.locationMessageString;
}

-(void) setImagebackground:(UIImage *)image
{
    self.image = image;
    [self.defualt setObject: UIImagePNGRepresentation(self.image) forKey:@"image"];
    [self.defualt synchronize];
}

-(void)AddContactWithName:(NSString *)name AndNumber:(NSString*)number;
{
    if(![self.recipientsNumbers containsObject:number])
    {
        [self.recipientsNames addObject:name];
        [self.recipientsNumbers addObject:number];
        [self saveContacts];
    }

}

-(void)RemoveContactWithName:(NSString *)name
{
    NSInteger index = [self.recipientsNames indexOfObject:name];
    [self.recipientsNames removeObject:name];
    [self.recipientsNumbers removeObjectAtIndex:index];
    [self saveContacts];

}
-(void) RemoveContactAtIndex:(NSInteger) index
{
    [self.recipientsNames removeObjectAtIndex:index];
    [self.recipientsNumbers removeObjectAtIndex:index];
    [self saveContacts];

}

-(void)AddMessage:(NSString *)message
{
    [self.messages addObject:message];
    [self.defualt setObject:self.messages forKey:@"messages"];
    [self.defualt synchronize];
}


-(void)RemoveMessage:(NSString *)message
{
    [self.messages removeObject:message];
    [self.defualt setObject:self.messages forKey:@"messages"];
    [self.defualt synchronize];
}

-(void)RemoveMessageAtIndex:(NSInteger)index
{
    [self.messages removeObjectAtIndex:index];
    [self.defualt setObject:self.messages forKey:@"messages"];
    [self.defualt synchronize];

}

-(void)ChangeLocationButtonStatus:(BOOL)status
{
    self.showLocationBtn = status;
    
    [self.defualt setBool:self.showLocationBtn forKey:@"showLocationBtn"];
    [self.defualt synchronize];

    if(status)
    {
        [self.locationManager startUpdatingLocation];
    }
    else
    {
        self.location = nil;
        [self.locationManager stopUpdatingLocation];
    }
}

-(void) StopLocationUpdate
{
    [self.locationManager stopUpdatingLocation];
}

- (void)loadData
{
    self.messages = [[self.defualt valueForKey:@"messages"] mutableCopy];
    if([self.messages count]==0)
    {
        self.messages = [NSMutableArray arrayWithObjects:@"הגעתי לבית הספר", @"הגעתי הביתה",@"יצאתי מהעבודה", nil];
        [self.defualt setObject:self.messages forKey:@"messages"];
        [self.defualt synchronize];
    }
    self.recipientsNumbers = [[self.defualt valueForKey:@"recipientsNumbers"] mutableCopy];
    self.recipientsNames = [[self.defualt valueForKey:@"recipientsNames"] mutableCopy];
    self.showLocationBtn = [self.defualt boolForKey:@"showLocationBtn"];
    self.messageCounter = [self.defualt integerForKey:@"counter"];
    NSData* imageData = [self.defualt objectForKey:@"image"];
    self.image = [UIImage imageWithData:imageData];
}

- (void)saveContacts
{
    [self.defualt setObject:self.recipientsNames forKey:@"recipientsNames"];
    [self.defualt setObject:self.recipientsNumbers forKey:@"recipientsNumbers"];
    [self.defualt synchronize];
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
