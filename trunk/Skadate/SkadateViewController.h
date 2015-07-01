//
//  SkadateViewController.h
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Structures.h"
#import <QuartzCore/QuartzCore.h>
#import "UserModel.h"

@interface SkadateViewController : UIViewController <UITextFieldDelegate>
{
//    IBOutlet UISwitch *remember;
//    IBOutlet UITextField *textFldUsername;
//    IBOutlet UITextField *textFldPassword;
//    IBOutlet UITextField *textFldURL;
//    IBOutlet UIButton *btnSignIn;
//    IBOutlet UIButton *btnSignUp;
//    IBOutlet UIButton *btnFrgtPwd;
//    IBOutlet UIView *subView;
//    IBOutlet UINavigationBar *navBar;
//    IBOutlet UIImageView *imgView;
//    IBOutlet UILabel *lblNavTitle;
//    IBOutlet UILabel *lblEmail;
//    IBOutlet UILabel *lblPassword;
//    IBOutlet UILabel *lblSite;
//    IBOutlet UIScrollView *tempScrollView;
//    
//    NSString *strUsername;
//    NSString *strPassword;
//    NSString *strURL;
//    NSString *strEncryptedPass;
//    NSString *SALT;
//    NSMutableData *responseData;
//    
//    SignInResp respSignIn;
//      
//    BOOL signinFlag;
//    
//    UILabel *indicatorLabel;
//    UIView *indicatorView;
//    UIActivityIndicatorView *objIndicatorView;
}
@property (nonatomic, unsafe_unretained) UserModel *respSignIn;
@property (nonatomic, assign) BOOL signinFlag;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, retain) UISwitch *remember;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UIImageView *imgView;
@property (nonatomic, retain) IBOutlet UILabel *lblNavTitle;
@property (nonatomic, retain) IBOutlet UIScrollView *tempScrollView;
@property (nonatomic, retain) IBOutlet UILabel *lblEmail;
@property (nonatomic, retain) IBOutlet UILabel *lblPassword;
@property (nonatomic, retain) IBOutlet UILabel *lblSite;

@property(nonatomic,retain) UITextField *textFldUsername;
@property(nonatomic,retain) UITextField *textFldPassword;
@property(nonatomic,retain) UITextField *textFldURL;
@property(nonatomic,retain) UIButton *btnSignIn;
@property(nonatomic,retain) UIButton *btnSignUp;
@property(nonatomic,retain) UIButton *btnFrgtPwd;
@property(nonatomic,retain) UIView *subView;
@property(nonatomic,retain) UILabel *indicatorLabel;
@property(nonatomic,retain) UIView *indicatorView;
@property(nonatomic,retain) UIActivityIndicatorView *objIndicatorView;


@property(nonatomic, retain) NSString *strUsername;
@property(nonatomic, retain) NSString *strPassword;
@property(nonatomic, retain) NSString *strURL;
@property(nonatomic, retain) NSString *strEncryptedPass;
@property(nonatomic, retain) NSString *SALT;

- (NSString *)stringToSha1:(NSString *)str;
- (BOOL) validateUrl: (NSString *) testURL;
- (BOOL) siteUrlEmbedded;
- (NSString *) getSiteUrl;
- (IBAction)clickedSignInButton:(id)sender;
- (IBAction)clickedSignUpButton:(id)sender;
- (IBAction)clickedForgotPasswordButton:(id)sender;
- (IBAction)textFieldDidBeginEditing:(UITextField *)textField;
- (IBAction)textFieldDidEndEditing:(UITextField *)textField;

@end

