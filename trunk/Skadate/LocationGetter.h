//
//
//  ChkViewController.h
//  Chk
//
//  Created by SODTechnologies on 19/08/10.
//  Copyright 2010 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JSON.h"

@protocol LocationGetterDelegate <NSObject>

@required
@end

@interface LocationGetter : NSObject <CLLocationManagerDelegate>
{    
    CLLocationManager *locationManager;
    NSURLConnection *connectionLatLong;
    NSMutableData *responseData;
    NSURLConnection *fetchUserStat;
    NSString *domain;
    NSInteger count;
    id delegate;
    BOOL locUpdate;
    
}

@property(nonatomic,retain) NSMutableData *responseData;
@property(nonatomic,retain)NSURLConnection *connectionLatLong;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property(nonatomic,assign) NSInteger count;
@property(nonatomic , retain) id delegate;
@property(nonatomic , retain) NSString *domain;

- (void)startUpdates;
@end