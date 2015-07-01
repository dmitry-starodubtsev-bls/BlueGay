//
//  Structures.h
//  Chk
//
//  Created by kavitha on 05/09/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct{
	
	__unsafe_unretained NSString *loginStatus;
    __unsafe_unretained NSString *profilePicURL;
    __unsafe_unretained NSString *profileId;
    __unsafe_unretained NSString *gender;
    __unsafe_unretained NSString *skey;
    __unsafe_unretained NSNumber *notifications;
    __unsafe_unretained NSString *TimeZone;
	
} SignInResp;


typedef struct{
	
	__unsafe_unretained NSString *frgtPwStatusMsg;
	
} ForgotPasswordResp;


typedef struct {
	
	__unsafe_unretained NSString *loginNameAvailStat;
	__unsafe_unretained NSString *LoginURLValidity;
    
} SignUpInitialResp;


typedef struct{
    
    __unsafe_unretained NSString *profileID;
    __unsafe_unretained NSString *fullName;
    __unsafe_unretained NSString *realName;
    __unsafe_unretained NSString *sex;
    __unsafe_unretained NSString *match_sex;
    __unsafe_unretained NSString *headline;
    __unsafe_unretained NSString *dob;
    __unsafe_unretained NSString *matchAge;
    __unsafe_unretained NSString *essays;
    __unsafe_unretained NSString *membershipTypeId;
    __unsafe_unretained NSString *hasPhoto;
    __unsafe_unretained NSString *hasMedia;
    __unsafe_unretained NSString *status;
    __unsafe_unretained NSString *featured;
    __unsafe_unretained NSString *bgImageURL;
    __unsafe_unretained NSString *isPrivate;
    
} ProfileResp;


@interface Structures : NSObject {
    
}

@end
