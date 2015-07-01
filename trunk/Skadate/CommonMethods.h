//
//  CommonMethods.h
//  Skadate
//
//  Created by SodiPhone_7 on 24/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "SkadateAppDelegate.h"

@protocol NotificationCountDelegate;

@interface CommonMethods : NSObject
{    
    id <NotificationCountDelegate> delegate;
    NSString *domain;
    NSMutableData *respData;
    NSURLConnection *NotificationCountConnection;
    NSURLConnection *LocationUpdateConnection;
    NSURLConnection *ProfilePhotConnection;
}

@property (nonatomic,retain) NSString *domain;
@property (nonatomic,retain) NSMutableData *respData;
@property (nonatomic,retain) NSURLConnection *NotificationCountConnection;
@property (nonatomic,retain) NSURLConnection *ProfilePhotConnection;
@property (nonatomic, assign) id <NotificationCountDelegate> delegate;

-(void)fetchNotification;
-(void)fetchProfilePhoto:(NSString *) profileId;

@end

@protocol NotificationCountDelegate 

- (void)loadNotificatonCounts:(NSDictionary *)notification;

@end

