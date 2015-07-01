//
//  SearchSavedView.h
//  Skadate
//
//  Created by SREEJITH P.R. on 20/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchSavedView : UIViewController<UIAlertViewDelegate>
{    
    IBOutlet UINavigationBar *navBar;
    IBOutlet UILabel *searchsavedlab;
    IBOutlet UIButton *btnBack; 
    IBOutlet UITableView *table;
    IBOutlet UISegmentedControl *control1;
    
    NSString *domain;
    NSString *urlReq;
    NSMutableData *respData;
    NSMutableArray *listOfNames;
    NSMutableArray *searchId;
        
    UILabel *indicatorLabel;
    UIView *indicatorView;
    UIActivityIndicatorView *objIndicatorView;
    	   
    int fromView;
    float NewXval;
} 

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UISegmentedControl *control1;
@property (nonatomic, retain) IBOutlet UIButton *btnBack;
@property (nonatomic, retain) IBOutlet UILabel *indicatorLabel;
@property (nonatomic, retain) IBOutlet UIView *indicatorView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *objIndicatorView;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UILabel *searchsavedlab;

@property(nonatomic, retain) NSString *domain;
@property (nonatomic,retain) NSString *urlReq;
@property (nonatomic,retain) NSMutableArray *listOfNames;
@property (nonatomic,retain) NSMutableArray *searchId;
@property (nonatomic,retain) NSMutableData *respData;

@property (nonatomic) int fromView;
@property (nonatomic,assign)float NewXval;

-(IBAction)clickedBackButton:(id) sender;
-(IBAction)clickedSegmentControllerSearchedSaved;

@end
