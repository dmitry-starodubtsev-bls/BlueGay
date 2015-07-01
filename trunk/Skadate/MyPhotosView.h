//
//  MyPhotosView.h
//  Chk
//
//  Created by SODTechnologies on 14/09/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerViewDelegate.h"
#import "GADBannerView.h"

@interface MyPhotosView : UIViewController <UINavigationControllerDelegate ,UIActionSheetDelegate, UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UIPickerViewDelegate>
{
    IBOutlet UIButton* btnCamera;
    IBOutlet UIButton *btnHome;
    IBOutlet UIButton *btnNotify;
    IBOutlet UIImageView *imgNotification;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UIScrollView *tempScrollView;
    IBOutlet UILabel *myphotolab;
    IBOutlet UIImageView *dividerLineImage;
    IBOutlet UIButton* btnDelete;
    IBOutlet UIButton* btnEdit;

    BOOL notifFlag;
    BOOL flagHome;
    BOOL camFlag;
    BOOL loadFlag;
    
    NSString *profileID;
    NSString *msgOrient;
    NSString *domain;
    NSNumber *notifications;
    NSMutableData *respData;
    NSMutableArray *thumbPicURLs;
    NSMutableArray *imgurl;
    NSMutableArray *selectedThumbPicURLs;
    NSMutableArray *imgIDArr;
    NSMutableArray *selectedUrlArray;
    NSURLConnection *loadPhotoCon;
    NSURLConnection *deletePhotoCon;
    NSOperationQueue *deleteQueue;
    NSOperationQueue *queue;
    NSData * imageData;
    
    UIButton *imgBtn;
    UIImageView *imageView;
    UILabel *indicatorLabel;
    UIView *indicatorView;
    UIActivityIndicatorView *objIndicatorView;
    UIPopoverController *_popover;
    
    float NewXval;
}
@property (nonatomic,assign)float NewXval;
@property (nonatomic, retain)  IBOutlet GADBannerView *bannerView;
@property(nonatomic,retain)IBOutlet UIButton* btnCamera;
@property(nonatomic,retain)IBOutlet UIButton *btnHome;
@property(nonatomic,retain)IBOutlet UIButton *btnNotify;
@property(nonatomic,retain)IBOutlet UIImageView *dividerLineImage;
@property(nonatomic,retain)IBOutlet UIScrollView *tempScrollView;
@property(nonatomic,retain)IBOutlet UIToolbar *toolBar;
@property(nonatomic,retain)IBOutlet UIImageView *imgNotification;
@property(nonatomic,retain)IBOutlet UINavigationBar *navBar;
@property(nonatomic,retain)IBOutlet UIButton* btnDelete;
@property(nonatomic,retain)IBOutlet UIButton* btnEdit;

@property(nonatomic,readwrite)BOOL flagHome;

@property(nonatomic,retain) NSString *profileID;
@property(nonatomic,retain) NSString *msgOrient;
@property(nonatomic,retain) NSString *domain;
@property(nonatomic,retain) NSMutableData *respData;

@property(nonatomic,retain) NSMutableArray *thumbPicURLs;
@property(nonatomic,retain) NSMutableArray *selectedThumbPicURLs;
@property(nonatomic,retain) NSMutableArray *imgIDArr;
@property(nonatomic,retain) NSMutableArray *selectedUrlArray;
@property(nonatomic,retain) NSOperationQueue *queue;

@property(nonatomic,retain) UIButton *imgBtn;
@property(nonatomic,retain) UILabel *indicatorLabel;
@property(nonatomic,retain) UIView *indicatorView;
@property(nonatomic,retain) UIImageView *imageView;
@property(nonatomic,retain) UIActivityIndicatorView *objIndicatorView;
@property(nonatomic,retain) UIPopoverController *_popover;

-(IBAction)openPhotoLibrary:(id)sender;
-(IBAction)clickedHomeButton:(id)sender;
-(IBAction)closeToolBar:(id)sender;
-(IBAction)clickedNotificationButton:(id)sender;
-(void)	invokeCamera;
-(void)loadImage;
-(void)displayImage:(UIImage *)image;
-(void)loadDefaultImage;
-(void)deletePhotos;
-(void)ChangeImageOrientation;

@end
