//
//  UserModel.h
//  Skadate
//
//  Created by admin on 01.07.15.
//
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property(nonatomic, strong) NSString *loginStatus;
@property(nonatomic, strong) NSString *profilePicURL;
@property(nonatomic, strong) NSString *profileId;
@property(nonatomic, strong) NSString *gender;
@property(nonatomic, strong) NSString *skey;
@property(nonatomic, strong) NSNumber *notifications;
@property(nonatomic, strong) NSString *TimeZone;

@end
