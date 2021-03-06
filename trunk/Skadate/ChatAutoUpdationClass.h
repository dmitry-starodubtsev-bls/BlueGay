//
//  ChatAutoUpdationClass.h
//  Skadate
//
//  Created by SOD TECH on 12/04/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "SkadateAppDelegate.h"

@protocol ChatAutoUpdationDelegate;

@interface ChatAutoUpdationClass : NSObject
{    
    id <ChatAutoUpdationDelegate> chatDelegate;
    NSString *domain;
    NSMutableData *respData;
    NSURLConnection *chatConnection;
}
    
@property (nonatomic,retain) NSString *domain;
@property (nonatomic,retain) NSMutableData *respData;
@property (nonatomic,retain) NSURLConnection *chatConnection;
@property (nonatomic, assign) id <ChatAutoUpdationDelegate> chatDelegate;

-(void)updateChats:(NSString *) profileId;

@end


@protocol ChatAutoUpdationDelegate 
- (void)loadChats:(NSString *)response;

@end
