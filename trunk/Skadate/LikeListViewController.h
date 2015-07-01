//
//  LikeListViewController.h
//  Skadate
//
//  Created by Heinz Vallonthaiel on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "JSON.h"
#import "SkadateAppDelegate.h"
#import "ProfileView.h"
#import "DisplayDateTime.h"

@interface LikeListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{   
        
    IBOutlet UINavigationBar *navBar;
    IBOutlet UITableView *likesTV;
    IBOutlet UILabel *navlbl;
    IBOutlet UIButton *LikeButton;
    
    NSString *domain;
    NSString *entityId;
    NSMutableData *respData;
    NSURLConnection *likeslistConnection;
    NSURLConnection *likeConnection;
    NSURLConnection *UnlikeConnection;

    NSMutableArray *likesArray;
    NSMutableArray *profilePics;
    NSMutableArray *thumbPicURLs;
    
    UILabel *indicatorLabel;
    UIView *indicatorView;
    UIActivityIndicatorView *objIndicatorView;

    BOOL youLiked;
    BOOL iLiked;
    BOOL myFeed;
    dispatch_queue_t queue;
    float NewXval;

}
@property(nonatomic,retain) IBOutlet UITableView *likesTV;


@property(nonatomic,retain) NSString *entityId;
@property(nonatomic,retain) NSString *domain;
@property(nonatomic,retain) NSMutableData *respData;
@property(nonatomic,retain) NSURLConnection *likeslistConnection;
@property(nonatomic,retain) NSURLConnection *likeConnection;
@property(nonatomic,retain) NSURLConnection *UnlikeConnection;
@property(nonatomic,retain) NSMutableArray *profilePics;
@property(nonatomic,retain) NSMutableArray *thumbPicURLs;
@property(nonatomic,retain) NSMutableArray *likesArray;

@property (nonatomic,assign)float NewXval;

@property(nonatomic,assign) BOOL youLiked;
@property(nonatomic,assign) BOOL myFeed;

-(IBAction)clickedBackButton:(id)sender;
-(IBAction)clickedLikeButton:(id)sender;
-(void)updateLikeView;

@end
