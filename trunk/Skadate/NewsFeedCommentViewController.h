//
//  NewsFeedCommentViewController.h
//  Skadate
//
//  Created by Heinz Vallonthaiel on 1/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkadateAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface NewsFeedCommentViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate>
{    
    IBOutlet UINavigationBar *navBar;
    IBOutlet UITextView *commentTextView;
    
    NSString *entityId;
    NSString *domain;
    NSURLConnection *commentNewsFeedConnection;
    NSMutableData *responseData;

    UILabel *indicatorLabel;
    UIView *indicatorView;
    UIActivityIndicatorView *objIndicatorView;
    
    float NewXval;

}
@property(nonatomic,retain) IBOutlet UITextView *commentTextView;

@property (nonatomic,assign)float NewXval;

@property(nonatomic,retain) NSString *entityId;
@property(nonatomic,retain) NSString *domain;
@property(nonatomic,retain) NSURLConnection *commentNewsFeedConnection;
@property(nonatomic,retain) UILabel *indicatorLabel;
@property(nonatomic,retain) UIView *indicatorView;
@property(nonatomic,retain) UIActivityIndicatorView *objIndicatorView;

-(IBAction)clickedCancelButton:(id)sender;
-(IBAction)clickedPostButton:(id)sender;

@end
