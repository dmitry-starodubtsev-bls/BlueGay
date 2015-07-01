//
//  TermsOfUse.h
//  Chk
//
//  Created by kavitha on 01/09/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUPSecondView.h" 

@class SkadateViewController;

@interface TermsOfUse : UIViewController<UIAlertViewDelegate> 
{    
    IBOutlet UINavigationBar *navBar;
    IBOutlet UILabel *lblNavTitle;
    IBOutlet UITextView *textView;

    NSMutableData *respData;
    NSString *urlReq;
    NSString *textViewDetails;
    NSString *domain;
    
    SignUPSecondView *objSignUPSecondView;
    SkadateViewController *objSignInView;
           
    UILabel *indicatorLabel;
    UIView *indicatorView;
    UIActivityIndicatorView *objIndicatorView;
    
    float NewXval;
    
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UILabel *lblNavTitle;
@property (nonatomic, retain) IBOutlet IBOutlet UITextView *textView;

@property (nonatomic, retain)  NSMutableData *respData;
@property (nonatomic, retain)  NSString *urlReq;
@property (nonatomic, retain)  NSString *textViewDetails;
@property (nonatomic, retain)  NSString *domain;

@property (nonatomic,assign)float NewXval;
@property (nonatomic, retain) SignUPSecondView *objSignUPSecondView;
@property (nonatomic, retain) SkadateViewController *objSignInView;

@property (nonatomic, retain) UILabel *indicatorLabel;
@property (nonatomic, retain) UIView *indicatorView;
@property (nonatomic, retain) UIActivityIndicatorView *objIndicatorView;


- (IBAction)clickedAccept:(UIButton *)button;
- (IBAction)clickedDecline:(UIButton *)button;
- (IBAction)clickedClose:(UIButton *)button;
- (void)ShowIndicatorView : (NSString *)DiaplayText;

@end
