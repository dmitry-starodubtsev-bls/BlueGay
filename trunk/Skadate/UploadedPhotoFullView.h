//
//  UploadedPhotoFullView.h
//  Skadate
//
//  Created by SodiPhone_7 on 21/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"


@interface UploadedPhotoFullView : UIViewController<UIActionSheetDelegate,UIScrollViewDelegate>
{
    
    IBOutlet UIButton *btnBack;
    IBOutlet UIButton *btnSave;
    IBOutlet UIImageView *imgUploadFull;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UIBarButtonItem *reportBtnItem;
    IBOutlet UIScrollView *scrollView;
    
    NSString *strImageUpload;
    NSString *domain;
    NSString *strRep;
    NSString *urlReq;
    NSString *profileId;
    NSMutableData *respData;
    NSMutableArray *imgIDArr;
    NSURLConnection *urlConnRep;

    UILabel *indicatorLabel;
    UIView *indicatorView;
    UIActivityIndicatorView *objIndicatorView;
    float NewXval;
    
}
@property(nonatomic,retain) IBOutlet UIButton *btnSave;
@property(nonatomic,retain) IBOutlet UIBarButtonItem *reportBtnItem;
@property(nonatomic,retain) IBOutlet UIButton *btnBack;
@property(nonatomic,retain) IBOutlet UIImageView *imgUploadFull;
@property(retain,nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIButton *actbut;

@property (nonatomic,assign)float NewXval;

@property(nonatomic, retain) NSString *profileId;
@property(nonatomic, retain) NSString *strImageUpload;
@property(nonatomic, retain) NSString *strRep;
@property(nonatomic, retain) NSMutableData *respData;
@property(nonatomic, retain) NSMutableArray *imgIDArr;

@property(nonatomic,retain) UILabel *indicatorLabel;
@property(nonatomic,retain) UIView *indicatorView;
@property(nonatomic,retain) UIActivityIndicatorView *objIndicatorView;

-(IBAction)clickedReportButton:(id) sender;
-(IBAction)clickedBackButton:(id)sender;
-(IBAction)clickedSaveButton:(id) sender;
-(void)loading;

@end
