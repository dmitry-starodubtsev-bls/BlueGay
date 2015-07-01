//
//  ChkViewController.m
//  Chk
//
//  Created by SODTechnologies on 19/08/10.
//  Copyright 2010 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

//   Modified on 26-12-2012 By sheeja


#import "GADBannerView.h"
#import "GADRequest.h"
#import "HomeView.h"
#import "SearchMembersView.h"
#import "MyPhotosView.h"
#import "MyProfileView.h"
#import "AboutUsView.h"
#import "SkadateViewController.h"
#import "NotificationsView.h"
#import "MailBoxView.h"
#import "OnlineMembers.h"
#import "SkadateAppDelegate.h"
#import "NewsFeedsController.h"
#import "JSON.h"
#import <QuartzCore/QuartzCore.h>
#import "MyNeighboursSearchResults.h"

#define kTutorialPointProductID
@implementation HomeView


@synthesize profilePic;
@synthesize profileID;
@synthesize notifications;
@synthesize btnAvatar;
@synthesize btnNotify;
@synthesize btnSearch;
@synthesize btnMyProfile;
@synthesize btnMyPhoto;
@synthesize btnInfo,btnMailBox,btnMembers;
@synthesize msgOrient;
@synthesize navBar;
@synthesize toolBar;
@synthesize lblSearch;
@synthesize lblMailBox;
@synthesize lblMembers;
@synthesize lblMyPhotos;
@synthesize lblMyProfile,domain;
@synthesize _popover;
@synthesize btnCamera;
@synthesize btNewsFeeds;
@synthesize imgNotification;
@synthesize logoImgage;
@synthesize logoImgView,timer,invocation,btnMapView,lblNearBy;
@synthesize timer1,invocation1;
@synthesize btnMailCount;
@synthesize NewXval;

#pragma mark Memory Management

- (void)dealloc
{    
    [indicatorView release];
    [objIndicatorView release];
    [indicatorLabel release];
    [logoImgage release];
    [timer invalidate];
    timer = nil;
    [fetchNot release];
    fetchNot=nil;
    [timer1 invalidate];
    timer1=nil;
    imageData=nil;
    
    
    [_bannerView release];
    [removeButton release];
    [_lbRemoveAds release];
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{    
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated{
    
    if([btnMailCount.titleLabel.text intValue]<1)
    {
        btnMailCount.hidden=YES;
    }
    else
    {
        if([btnMailCount.titleLabel.text length]<=1)
        {
            [btnMailCount setBackgroundImage:[UIImage imageNamed:@"Notification1.png"]  forState:normal];
        }
        else if([btnMailCount.titleLabel.text length]>1)
        {
            [btnMailCount setBackgroundImage:[UIImage imageNamed:@"Notification2.png"]  forState:normal];
        }
        
        btnMailCount.hidden=NO;
    }
    
    invocation= [NSInvocation invocationWithMethodSignature:
                 [self methodSignatureForSelector: @selector(FetchNotifications)]];
    [invocation setTarget:self];
    [invocation setSelector:@selector(FetchNotifications)];
    
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 invocation:invocation repeats:YES];
   
    invocation1= [NSInvocation invocationWithMethodSignature:
                  [self methodSignatureForSelector: @selector(UpdateCurrentLocation)]];
    [invocation1 setTarget:self];
    [invocation1 setSelector:@selector(UpdateCurrentLocation)];
    
    if (timer1)
    {
        [timer1 invalidate];
        timer1 = nil;
    }
    
    timer1 = [NSTimer scheduledTimerWithTimeInterval:5.0 invocation:invocation1 repeats:YES];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

/*-(void)ios6ipad{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        {
            btnNotify.titleLabel.font=[UIFont fontWithName:@"Ubuntu-Bold" size:15];
            btnMailCount.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
            if(([UIApplication sharedApplication].statusBarOrientation)==UIInterfaceOrientationLandscapeLeft||([UIApplication sharedApplication].statusBarOrientation)==UIInterfaceOrientationLandscapeRight)
            {
                indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
                btnNotify.frame=CGRectMake(529, 714, 25, 25);
                imgNotification.frame=CGRectMake(416, 714, 140, 25);
                lblSearch.frame=CGRectMake(82, 208, 150, 35);
                lblSearch.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
                lblMyProfile.frame=CGRectMake(405, 208, 150, 35);
                lblMyProfile.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
                lblMyPhotos.frame=CGRectMake(724, 208, 150, 35);
                lblMyPhotos.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
                lblMailBox.frame=CGRectMake(82, 425, 150, 35);
                lblMailBox.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
                lblMembers.frame=CGRectMake(403, 425, 150, 35);
                lblMembers.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
                btnMailCount.frame=CGRectMake(210, 266, 40, 40);
                lblMembers.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
                btnSearch.frame=CGRectMake(71, 47, 180, 183);
                btnMyProfile.frame=CGRectMake(389, 47, 180, 183);
                btnMyPhoto.frame=CGRectMake(707, 47, 180, 183);
                btnMailBox.frame=CGRectMake(71, 265, 180, 183);
                btnMembers.frame=CGRectMake(389, 265, 180, 183);
                btnMapView.frame=CGRectMake(71, 474, 180, 183);
                lblNearBy.frame=CGRectMake(87, 635, 150, 35);
                lblNearBy.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
                newsFeed.frame=CGRectMake(724, 425, 150, 35);
                newsFeed.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
                btNewsFeeds.frame=CGRectMake(707, 265, 180, 183);
            }
            else
            {
                indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
                btnNotify.frame=CGRectMake(432, 972, 25, 25);
                imgNotification.frame=CGRectMake(320, 972, 140, 25);
                lblSearch.frame=CGRectMake(63, 301, 150, 35);
                lblSearch.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
                lblMyProfile.frame=CGRectMake(303, 301, 150, 35);
                lblMyProfile.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
                lblMyPhotos.frame=CGRectMake(546, 301, 150, 35);
                lblMyPhotos.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
                lblMailBox.frame=CGRectMake(65, 545, 150, 35);
                lblMailBox.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
                lblMembers.frame=CGRectMake(304, 545, 150, 35);
                lblMembers.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
                btnMailCount.frame=CGRectMake(193, 385, 40, 40);
                btnSearch.frame=CGRectMake(53, 143, 180, 183);
                btnMyProfile.frame=CGRectMake(291, 143, 180, 183);
                btnMyPhoto.frame=CGRectMake(528, 143, 180, 183);
                btnMailBox.frame=CGRectMake(53, 384, 180, 183);
                btnMembers.frame=CGRectMake(291, 384, 180, 183);
                lblNearBy.frame=CGRectMake(65, 789, 150, 35);
                lblNearBy.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
                btnMapView.frame=CGRectMake(53, 625, 180, 183);
                btNewsFeeds.frame=CGRectMake(528, 384, 180, 183);
                newsFeed.frame=CGRectMake(546,545,150, 35);
                newsFeed.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            }
            
        }
        
    }

}*/

- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"Received ad successfully");
}

- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad with error: %@", [error localizedFailureReason]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    
    locationGetter = [[LocationGetter alloc] init];
    locationGetter.count=0;
    NSString *originalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
    NSString *imageName = @"profile.png";
    NSString *localFilePath = [originalPath stringByAppendingPathComponent:imageName];
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"profile" ofType:@"png"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:localFilePath];
   
    if (!fileExists)
    {
        [[NSFileManager defaultManager]createDirectoryAtPath: originalPath withIntermediateDirectories: YES attributes: nil error: NULL];
        [[NSFileManager defaultManager] copyItemAtPath:resourcePath toPath:localFilePath error:nil];
    }
    BOOL isDir=[CommonStaticMethods directoryExistsAtAbsolutePath:localFilePath];
    if(!isDir)
    {
        [[NSFileManager defaultManager]createDirectoryAtPath: originalPath withIntermediateDirectories: YES attributes: nil error: NULL];
    }
    
    // Lazy image loading
    
    locationGetter.delegate = self;
    [locationGetter startUpdates];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(invalidateTimer:)
     name:@"InvalidateHomePageTimers" object:nil];
    
    profileID=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID;
    profilePic=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfilePic;
    notifications=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications;
    
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    
    [toolBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    
    toolBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    toolBar.layer.borderWidth=1.0f;
   /*
    lblMailBox.font=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontHomeTitle;
    lblMembers.font=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontHomeTitle;
    lblMyPhotos.font=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontHomeTitle;
    lblMyProfile.font=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontHomeTitle;
    lblSearch.font=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontHomeTitle;
    newsFeed.font=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontHomeTitle;
    lblNearBy.font=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontHomeTitle;
    _lbRemoveAds.font=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontHomeTitle;*/
// _lbRemoveAds.textColor=[UIColor colorWithRed:98.0/255.0 green:96.0/255.0 blue:96.0/255.0 alpha:1.0];
    /*
    lblMailBox.textColor= [UIColor colorWithRed:98.0/255.0 green:96.0/255.0 blue:96.0/255.0 alpha:1.0];
    lblMembers.textColor= [UIColor colorWithRed:98.0/255.0 green:96.0/255.0 blue:96.0/255.0 alpha:1.0];
    lblMyPhotos.textColor= [UIColor colorWithRed:98.0/255.0 green:96.0/255.0 blue:96.0/255.0 alpha:1.0];
    lblMyProfile.textColor= [UIColor colorWithRed:98.0/255.0 green:96.0/255.0 blue:96.0/255.0 alpha:1.0];
    lblSearch.textColor= [UIColor colorWithRed:98.0/255.0 green:96.0/255.0 blue:96.0/255.0 alpha:1.0];
    newsFeed.textColor=[UIColor colorWithRed:98.0/255.0 green:96.0/255.0 blue:96.0/255.0 alpha:1.0];
    lblNearBy.textColor=[UIColor colorWithRed:98.0/255.0 green:96.0/255.0 blue:96.0/255.0 alpha:1.0];
    */
    btnAvatar.layer.cornerRadius = 5; // this value vary as per your desire
    btnAvatar.clipsToBounds = YES;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    
    NSString *logoUrl=[NSString stringWithFormat:@"%@%@",domain,@"/mobile/logo.png"];
    
    NSData *logoData = [[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:logoUrl]] autorelease];
    if (logoData)
    {
        logoImgage = [[UIImage alloc] initWithData:logoData] ;
        
        if (logoImgage)
        {
            logoImgView.image=logoImgage;
        }
        else
        {
            logoImgView.image=[UIImage imageNamed:@"BluGay.png"];
        }
    }
    else
    {
        logoImgView.image=[UIImage imageNamed:@"BluGay.png"];
    }
    
    msgOrient=[[[NSString alloc] init] retain];
    
    [btnNotify setTitleColor:[UIColor colorWithRed:251/255.0 green:102/255.0 blue:36/255.0 alpha:1.0] forState:normal];
    btnNotify.titleLabel.font=[UIFont fontWithName:@"Ubuntu-Bold" size:12];
    [btnMailCount setTitleColor:[UIColor whiteColor] forState:normal];
    [btnNotify setTitle:[NSString stringWithFormat:@"%@",@"0"] forState:normal];
    [btnMailCount setTitle:[NSString stringWithFormat:@"%@",@"0"] forState:normal];
    btnMailCount.titleLabel.textAlignment=NSTextAlignmentCenter;
    btnMailCount.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:10];
    [btnMailCount setBackgroundImage:[UIImage imageNamed:@"Notification1.png"]  forState:normal];
    
    if([btnMailCount.titleLabel.text intValue]<1)
    {
        btnMailCount.hidden=YES;
    }
    else
    {
        if([btnMailCount.titleLabel.text length]<=1)
        {
            [btnMailCount setBackgroundImage:[UIImage imageNamed:@"Notification1.png"]  forState:normal];
        }
        else if([btnMailCount.titleLabel.text length]>1)
        {
            [btnMailCount setBackgroundImage:[UIImage imageNamed:@"Notification2.png"]  forState:normal];
        }
        btnMailCount.hidden=NO;
    }
    
    [self GetAvatarChange];
    camFlag=NO;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
_bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0.0,screenHeight-GAD_SIZE_320x50.height, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height)];
    
   _bannerView.adUnitID = @"ca-app-pub-2576984835975357/2515357224";
    _bannerView.delegate = self;
    
     _bannerView.rootViewController = self;
    [self.view addSubview: _bannerView];
    [self.view bringSubviewToFront: _bannerView];
    
    _bannerView.backgroundColor= [UIColor redColor];
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ GAD_SIMULATOR_ID ];
  //  request.testing = NO;
    [ _bannerView loadRequest:request];
    
    [self fetchAvailableProducts];  
    
}





- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}

-(BOOL)shouldAutorotate
{
    return NO;
}


/*-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
        
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self ios6ipad];
    }
    
}*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        btnNotify.titleLabel.font=[UIFont fontWithName:@"Ubuntu-Bold" size:15];
        btnMailCount.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
        if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            btnNotify.frame=CGRectMake(529, 714, 25, 25);
            imgNotification.frame=CGRectMake(416, 714, 140, 25);
            lblSearch.frame=CGRectMake(82, 208, 150, 35);
            lblSearch.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            lblMyProfile.frame=CGRectMake(405, 208, 150, 35);
            lblMyProfile.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            lblMyPhotos.frame=CGRectMake(724, 208, 150, 35);
            lblMyPhotos.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            lblMailBox.frame=CGRectMake(82, 425, 150, 35);
            lblMailBox.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            lblMembers.frame=CGRectMake(403, 425, 150, 35);
            lblMembers.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            btnMailCount.frame=CGRectMake(210, 266, 40, 40);
            lblMembers.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            btnSearch.frame=CGRectMake(71, 47, 180, 183);
            btnMyProfile.frame=CGRectMake(389, 47, 180, 183);
            btnMyPhoto.frame=CGRectMake(707, 47, 180, 183);
            btnMailBox.frame=CGRectMake(71, 265, 180, 183);
            btnMembers.frame=CGRectMake(389, 265, 180, 183);
            btnMapView.frame=CGRectMake(71, 474, 180, 183);
            lblNearBy.frame=CGRectMake(87, 635, 150, 35);
            lblNearBy.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            newsFeed.frame=CGRectMake(724, 425, 150, 35);
            newsFeed.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            btNewsFeeds.frame=CGRectMake(707, 265, 180, 183);
        }
        else
        {
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            btnNotify.frame=CGRectMake(432, 972, 25, 25);
            imgNotification.frame=CGRectMake(320, 972, 140, 25);
            lblSearch.frame=CGRectMake(63, 301, 150, 35);
            lblSearch.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            lblMyProfile.frame=CGRectMake(303, 301, 150, 35);
            lblMyProfile.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            lblMyPhotos.frame=CGRectMake(546, 301, 150, 35);
            lblMyPhotos.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            lblMailBox.frame=CGRectMake(65, 545, 150, 35);
            lblMailBox.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            lblMembers.frame=CGRectMake(304, 545, 150, 35);
            lblMembers.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            btnMailCount.frame=CGRectMake(193, 385, 40, 40);
            btnSearch.frame=CGRectMake(53, 143, 180, 183);
            btnMyProfile.frame=CGRectMake(291, 143, 180, 183);
            btnMyPhoto.frame=CGRectMake(528, 143, 180, 183);
            btnMailBox.frame=CGRectMake(53, 384, 180, 183);
            btnMembers.frame=CGRectMake(291, 384, 180, 183);
            lblNearBy.frame=CGRectMake(65, 789, 150, 35);
            lblNearBy.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
            btnMapView.frame=CGRectMake(53, 625, 180, 183);
            btNewsFeeds.frame=CGRectMake(528, 384, 180, 183);
            newsFeed.frame=CGRectMake(546,545,150, 35);
            newsFeed.font=[UIFont fontWithName:@"Ubuntu-Bold" size:25];
        }
        return YES;
    }
    else
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }*/
}


#pragma mark Custom Methods

- (void)ShowIndicatorView : (NSString *)DiaplayText 
{        
    // fixing the activity indicator
    
    objIndicatorView =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    objIndicatorView.frame = CGRectMake(10, 10, objIndicatorView.bounds.size.width, objIndicatorView.bounds.size.height); 
    
    CGSize maximumLabelSize ;
    CGSize expectedLabelSize;
    UIFont *DisplayTextFont;
    
    //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    //{
        maximumLabelSize=CGSizeMake(100,objIndicatorView.bounds.size.height);
        DisplayTextFont = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    //}
    //else
    //{
    //    maximumLabelSize=CGSizeMake(150.0,objIndicatorView.bounds.size.height);
    //    DisplayTextFont = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    //}
    
    /*expectedLabelSize = [DiaplayText sizeWithFont:DisplayTextFont
                                constrainedToSize:maximumLabelSize 
                                    lineBreakMode:NSLineBreakByCharWrapping];*/
    
    CGRect expected = [DiaplayText boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DisplayTextFont} context:nil];
    expectedLabelSize = expected.size;
    
    indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake((objIndicatorView.bounds.size.width +15), 10, expectedLabelSize.width, objIndicatorView.bounds.size.height)];
    
    //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    //{
        [indicatorLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    //}
    //else
    //{
    //    [indicatorLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    //}
    
    indicatorLabel.backgroundColor = [UIColor clearColor];
    indicatorLabel.textColor = [UIColor whiteColor];
    indicatorLabel.adjustsFontSizeToFitWidth = YES;
    indicatorLabel.textAlignment = NSTextAlignmentCenter;
    indicatorLabel.text =DiaplayText; 
    
    NewXval=0;
    if (expectedLabelSize.width<maximumLabelSize.width)
    {
        NewXval=NewXval=(maximumLabelSize.width-expectedLabelSize.width)/2;
    }
    
    //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    //{
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            // iPhone Classic
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake((85 + NewXval), 200,  (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30),(objIndicatorView.frame.size.height+20))];
        }
        if(result.height == 568)
        {
            // iPhone 5
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake((85 + NewXval), 200+40,  (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30),(objIndicatorView.frame.size.height+20))];
        }
    //}
    /*else
    {        
        if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
        {
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30),(objIndicatorView.frame.size.height+20))];
            
        }
        else 
        {
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30),(objIndicatorView.frame.size.height+20))];
        }
          
    }*/
    
    indicatorView.backgroundColor = [UIColor blackColor];
    indicatorView.clipsToBounds = YES;
    indicatorView.layer.cornerRadius = 5.0;
    [indicatorView addSubview:objIndicatorView];
    [indicatorView addSubview:indicatorLabel];
    [self.view addSubview:indicatorView];
    [self.view bringSubviewToFront:indicatorView];
    [objIndicatorView startAnimating];
    
}

-(void)GetAvatarChange
{    
    profilePic=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfilePic;
    
    int gender = [((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).genderValue intValue];
    if ([profilePic isEqualToString:@""]||(profilePic == (id)[NSNull null])||([profilePic length] == 0)||(profilePic==NULL))
    {
        if (gender==1)
        {
            [btnAvatar setImage:[UIImage imageNamed:@"women.png"] forState:normal];             
        }
        else if (gender==2)
        {
            [btnAvatar setImage:[UIImage imageNamed:@"man.png"] forState:normal];
        }
        else if (gender==4)
        {
            [btnAvatar setImage:[UIImage imageNamed:@"man_women.png"] forState:normal];
        }
        else  if (gender==8)
        {
            [btnAvatar setImage:[UIImage imageNamed:@"man_women_a.png"] forState:normal];
        }
        else
        {
            [btnAvatar setImage:[UIImage imageNamed:@"man.png"] forState:normal];
        }
    }
    else
    {
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        
        // Lazy image loading         
        NSString *profilePicURL=[NSString stringWithFormat:@"%@%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfilePic];
        NSString *imageName=[NSString stringWithFormat:@"%@",((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfilePic];
        //imageName=[imageName stringByReplacingOccurrencesOfString:@"/$userfiles/" withString:@""];  // for old version
        imageName=[imageName stringByReplacingOccurrencesOfString:@"/userfiles/" withString:@""];  // for new version
        NSString *originalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
           
        NSString *localFilePath = [originalPath stringByAppendingPathComponent:imageName];
        
        BOOL isDir=[CommonStaticMethods directoryExistsAtAbsolutePath:[originalPath stringByAppendingPathComponent:@"profile.png"]];
        if(!isDir)
        {
            [[NSFileManager defaultManager]createDirectoryAtPath: originalPath withIntermediateDirectories: YES attributes: nil error: NULL];
        }
        dispatch_async(queue, ^{
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:localFilePath];
            if (!fileExists)
            {
                NSURL *imageURL = [[[NSURL alloc] initWithString:profilePicURL]autorelease];            
                NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
                [NSURLConnection connectionWithRequest:request delegate:self];
                NSData *thedata = [NSData dataWithContentsOfURL:imageURL];
                [thedata writeToFile:localFilePath atomically:YES];
            }
            UIImage* image = [UIImage imageWithContentsOfFile:localFilePath];
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                if (image) 
                {
                    [btnAvatar setImage:image forState:normal]; 
                }
                else
                {
                    if (gender==1) 
                    {
                        [btnAvatar setImage:[UIImage imageNamed:@"women.png"] forState:normal];             
                    }
                    else if (gender==2) 
                    {
                        [btnAvatar setImage:[UIImage imageNamed:@"man.png"] forState:normal];
                    }
                    else if (gender==4) 
                    {
                        [btnAvatar setImage:[UIImage imageNamed:@"man_women.png"] forState:normal];
                    }
                    else  if (gender==8)
                    {
                        [btnAvatar setImage:[UIImage imageNamed:@"man_women_a.png"] forState:normal];
                    } 
                    else
                    {
                        [btnAvatar setImage:[UIImage imageNamed:@"man.png"] forState:normal];
                    }
                }
            });
        }); 
        dispatch_release(queue);
        
    }
    
}


-(void)FetchNotifications
{
          
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *chat=[NSString stringWithFormat:@"%@",((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications];
    NSString *trimmed1 = [chat stringByTrimmingCharactersInSet:whitespace];
    
    if ([trimmed1 isEqualToString:@"(null)"]||[trimmed1 isEqualToString:@""]||(trimmed1 == (id)[NSNull null])||([trimmed1 length] == 0)||(trimmed1==NULL))
    {
         [btnNotify setTitle:[NSString stringWithFormat:@"%@",@"0"] forState:normal];
    }
    else
    {
        [btnNotify setTitle:[NSString stringWithFormat:@"%@",((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications] forState:normal];
    }
    
    NSString *mail=[NSString stringWithFormat:@"%@",((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedMailCount];
    NSString *trimmed = [mail stringByTrimmingCharactersInSet:whitespace];
    
    if ([trimmed isEqualToString:@"(null)"]||[trimmed isEqualToString:@""]||(trimmed == (id)[NSNull null])||([trimmed length] == 0)||(trimmed==NULL))
    {
        [btnMailCount setTitle:[NSString stringWithFormat:@"%@",@"0"] forState:normal];
                 
    }
    else
    {
        [btnMailCount setTitle:[NSString stringWithFormat:@"%@",((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedMailCount] forState:normal];
    }
    
    if([btnMailCount.titleLabel.text intValue]<1)
    {
        btnMailCount.hidden=YES;
    }
    else
    {
        if([btnMailCount.titleLabel.text length]<=1)
        {
            [btnMailCount setBackgroundImage:[UIImage imageNamed:@"Notification1.png"]  forState:normal];
        }
        else if([btnMailCount.titleLabel.text length]>1)
        {
            [btnMailCount setBackgroundImage:[UIImage imageNamed:@"Notification2.png"]  forState:normal];
        }
        btnMailCount.hidden=NO;
    }
    
    if(((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg)
    {
       [btnAvatar setImage:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg forState:normal];
    }
    
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserChatImg=btnAvatar.imageView.image;
    
 }


-(void)UpdateCurrentLocation
{    
    locationGetter.count+=1;
    locationGetter.delegate = self;
    [locationGetter startUpdates];
 }

-(void)invalidateTimer:(id)sender
{    
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
    if (timer1)
    {
        [timer1 invalidate];
        timer1 = nil;
    }
}

-(void) Upload: (NSData*) photoData
{    
    NSString *urlString =[NSString stringWithFormat:@"%@/mobile/UploadImage/index.php",domain];
    
    //Setting up the request object
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    //Generate a random boundary
    NSString *boundary = @"M!M#b0UnD@RY!@#$%^&*936924809";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    //Create the body of the post
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[@"Content-Disposition: form-data; name=\"id\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"%@",profileID] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[@"Content-Disposition: form-data; name=\"skey\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"%@",((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"orientation\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"%@",msgOrient] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data;name=\"image\"; filename=\"%@\"\r\n",@"Image.jpg"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:photoData]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // Make the connection to the web
    NSURLResponse *theResponse = [[NSURLResponse alloc]init];
    NSData *responseUpload = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:nil];
    NSString *returnString = [[NSString alloc] initWithData:responseUpload encoding:NSUTF8StringEncoding];
    NSError *error;
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:returnString error:&error];
    NSString *response=(NSString*)[parsedData objectForKey:@"Message"];
    CFRelease((CFTypeRef) parser);
    if([response isEqualToString:@"Site suspended"])
    {
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
        
        UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        sessionAlertView.tag=1;
        [sessionAlertView show];
        [sessionAlertView release];
        [returnString release];
    }
    else if ([response isEqualToString:@"Session Expired"])
    {
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
        
        UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        sessionAlertView.tag=1;
        [sessionAlertView show];
        [sessionAlertView release];
        [returnString release];
        
    }
    else if ([response isEqualToString:@"Image Uploaded"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Upload" message:@"Image uploaded successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
        [alertView release];
        [returnString release];
    }
    else
    {
        [returnString release];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Upload" message:@"Uploading failed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    
    indicatorView.hidden=YES;
    self.view.userInteractionEnabled=YES;
    
    //if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad && !camFlag)
    //{
    //    [_popover dismissPopoverAnimated:YES];
    //    [_popover release];
    //}
    //else
    //{
        [self dismissViewControllerAnimated:NO completion:nil];
    //}
    
    [self invokeCamera];
    
}

-(void)	invokeCamera
{    
	if (!camFlag)
	{
        UIImagePickerController *imagePicker = [[[UIImagePickerController alloc] init] autorelease];
		
        //if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        //{
        //    imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //}
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        camFlag=NO;
        imagePicker.delegate = self;
        
        /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
             _popover = [[[UIPopoverController alloc] initWithContentViewController:imagePicker] retain];
            [_popover setDelegate:self];
            [_popover setPopoverContentSize:CGSizeMake(320, 480) animated:NO];
            [_popover presentPopoverFromRect:[btnCamera frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
        }*/
        //else
        //{
            //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
            //{
                 CGSize result = [[UIScreen mainScreen] bounds].size;
                if(result.height == 480)
                {
                    // iPhone Classic
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }
                if(result.height == 568)
                {
                    // iPhone 5
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }
            //}
        //}
        
    }
    else
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        camFlag=YES;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
        [imagePicker release];
		imagePicker = nil;
    }
}


-(void)logout
{    
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
    if (timer1)
    {
        [timer1 invalidate];
        timer1 = nil;
    }
    [self performSelector:@selector(Userlogout) withObject:nil afterDelay:0.01];
}

-(void)Userlogout
{
    btnAvatar.enabled=NO;
    responseData = [[NSMutableData data] retain];
    [self ShowIndicatorView:@"Please Wait..."];
    self.view.userInteractionEnabled=NO;
    domain=@"http://blugay.net";
    NSString *urlReq = [NSString stringWithFormat:@"%@/mobile/SignOut/?id=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID];
    NSURL *url = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    logoutConnection=[[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"remember"];
     [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"Username"];
     [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"Password"];
    [[NSUserDefaults standardUserDefaults] synchronize];        
}

#pragma mark Managing API Calls

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{    
    [responseData appendData:data];
    indicatorView.hidden=YES;
    self.view.userInteractionEnabled=YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{    
    btnAvatar.enabled=YES;
    indicatorView.hidden=YES;
        self.view.userInteractionEnabled=YES;
    
    if(connection==logoutConnection)
    {
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfileID=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserStatus=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserUnRegistered=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfilePic=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserChatImg=nil;
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=nil;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release]; 
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{    
    indicatorView.hidden=YES;
    btnAvatar.enabled=YES;
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    CFRelease((CFTypeRef) parser);
    [responseString release];
    
    if(connection==logoutConnection)
    {
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfileID=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserStatus=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserUnRegistered=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfilePic=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserChatImg=nil;
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=nil;
        
        NSString *originalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
        BOOL isDir=[CommonStaticMethods directoryExistsAtAbsolutePath:[originalPath stringByAppendingPathComponent:@"profile.png"]];
        if(isDir)
        {
            if ([[NSFileManager defaultManager] removeItemAtPath: originalPath error: nil] == NO)
            {
                
            }
           
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    [responseData release];
}


#pragma mark - NotificationCounDelegate methods

- (void)loadNotificatonCounts:(NSDictionary *)notification
{
    
}

#pragma mark -ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        UIImagePickerController * picker1 = [[[UIImagePickerController alloc] init] autorelease];
        picker1.delegate = self;
        switch (actionSheet.tag) 
        {
            case 0:
                // Set source to the Photo library
                //if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                //{
                //    picker1.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                //}
                //else
                    picker1.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                camFlag=NO;
                //if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                //{
                //    _popover = [[[UIPopoverController alloc] initWithContentViewController:picker1] retain];
                //    [_popover setDelegate:self];
                //    [_popover setPopoverContentSize:CGSizeMake(320, 480) animated:NO];
                //    [_popover presentPopoverFromRect:[btnCamera frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
                //}
                //else
                //{
                    [self presentViewController:picker1 animated:YES completion:nil];
                //}
                break;
                
            case 1:
                [self logout];
                break; 
                
            default:
                break;
        }
        
    }
    
    if (buttonIndex == 1)
    {
        MyProfileView *objMyProfileView=[[MyProfileView alloc] initWithNibName:@"MyProfileView" bundle:nil];
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        switch (actionSheet.tag) 
        {
            case 0:
                // Set source to Camera 
                imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
                camFlag=YES;
                imagePicker.delegate = self;
                [self presentViewController:imagePicker animated:YES completion:nil];
                break;
                
            case 1:
                objMyProfileView.profileID=profileID;
                [self.navigationController pushViewController:objMyProfileView animated:YES];
                break;
                
            default:
                break;
        }
        
        [objMyProfileView release];
        [imagePicker release];
        
    }
    
}

#pragma mark -UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{          
    // fixing the activity indicator
    
    objIndicatorView =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    objIndicatorView.frame = CGRectMake(10, 10, objIndicatorView.bounds.size.width, objIndicatorView.bounds.size.height); 
    CGSize maximumLabelSize ;
    CGSize expectedLabelSize;
    UIFont *DisplayTextFont;
    NSString *DiaplayText=@"Uploading...";
    
    //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    //{
        maximumLabelSize=CGSizeMake(100,objIndicatorView.bounds.size.height);
        DisplayTextFont = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    //}
    //else
    //{
    //    maximumLabelSize=CGSizeMake(150.0,objIndicatorView.bounds.size.height);
    //    DisplayTextFont = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    //}
    
    /*expectedLabelSize = [DiaplayText sizeWithFont:DisplayTextFont
                                constrainedToSize:maximumLabelSize 
                                    lineBreakMode:NSLineBreakByCharWrapping];*/
    
    CGRect expected = [DiaplayText boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DisplayTextFont} context:nil];
    expectedLabelSize = expected.size;
    
    indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake((objIndicatorView.bounds.size.width +15), 10, expectedLabelSize.width, objIndicatorView.bounds.size.height)];
    
    //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    //{
        [indicatorLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    //}
    //else
    //{
    //    [indicatorLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    //}
    
    indicatorLabel.backgroundColor = [UIColor clearColor];
    indicatorLabel.textColor = [UIColor whiteColor];
    indicatorLabel.adjustsFontSizeToFitWidth = YES;
    indicatorLabel.textAlignment = NSTextAlignmentCenter;
    indicatorLabel.text =DiaplayText; 
    NewXval=0;
  
    if (expectedLabelSize.width<maximumLabelSize.width)
    {
        NewXval=NewXval=(maximumLabelSize.width-expectedLabelSize.width)/2;
    }
    
    //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    //{
        indicatorView = [[UIView alloc] initWithFrame:CGRectMake((85 + NewXval), 200,  (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30),(objIndicatorView.frame.size.height+20))];
    //}
    /*else
    {               
        if (camFlag==NO) 
        { 
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake(75, 225, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30),(objIndicatorView.frame.size.height+20))];
        }
        else
        {
            if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
            {
                indicatorView = [[UIView alloc] initWithFrame:CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30),(objIndicatorView.frame.size.height+20))];
            }
            else 
            {
                indicatorView = [[UIView alloc] initWithFrame:CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30),(objIndicatorView.frame.size.height+20))];
            }
        }
    }*/
    
    indicatorView.backgroundColor = [UIColor blackColor];
    indicatorView.clipsToBounds = YES;
    indicatorView.layer.cornerRadius = 5.0;
    [indicatorView addSubview:objIndicatorView];
    [indicatorView addSubview:indicatorLabel];
    [picker.view addSubview:indicatorView];
    [picker.view bringSubviewToFront:indicatorView];
    [objIndicatorView startAnimating];
    
    // Access the uncropped image from info dictionary
    UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
    //Compress photosss
    
    float actualHeight = img.size.height;
    float actualWidth = img.size.width;
    float maxHeight = 600.0;
    float maxWidth = 800.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth) {
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [img drawInRect:rect];
    img = UIGraphicsGetImageFromCurrentImageContext();
    imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    NSDictionary *dictData=[info objectForKey:@"UIImagePickerControllerMediaMetadata"]; 
    id orientation = [dictData objectForKey:@"Orientation"];
    msgOrient=[[NSString stringWithFormat:@"%d", (int)[orientation integerValue]] retain];
    imageData = UIImageJPEGRepresentation(img, 0.5);
    [self performSelector:@selector(Upload:) withObject:imageData afterDelay:0.01]; 
    
}

#pragma mark -IBActions

-(IBAction)openPhotoLibrary:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:@"Photo Library"
                                  otherButtonTitles:@"Take Photo",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    actionSheet.tag=0;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

-(IBAction)openProfileOptions:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:@"Log out"
                                  otherButtonTitles:@"Profile",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    actionSheet.tag=1;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

-(IBAction)clickedSearchButton:(id)sender
{
    
    SearchMembersView *objSearchMembersView=[[SearchMembersView alloc]initWithNibName:@"SearchMembersView" bundle:nil];
    objSearchMembersView.fromView=1;
    [self.navigationController pushViewController:objSearchMembersView animated:YES];
    [objSearchMembersView release];
}

-(IBAction)clickedMyPhoto:(id)sender
{
    MyPhotosView *objMyPhotosView=[[MyPhotosView alloc]initWithNibName:@"MyPhotosView" bundle:nil];
    objMyPhotosView.flagHome=YES;
    objMyPhotosView.profileID=profileID;
    [self.navigationController pushViewController:objMyPhotosView animated:YES];
    [objMyPhotosView release];
}

-(IBAction)clickedMyProfileButton:(id)sender
{   
    MyProfileView *objMyProfileView=[[MyProfileView alloc]initWithNibName:@"MyProfileView" bundle:nil];
    objMyProfileView.profileID=profileID;
    [self.navigationController pushViewController:objMyProfileView animated:YES];
    [objMyProfileView release];
}

-(IBAction)clickedInfoButton:(id)sender
{   
     AboutUsView *objAboutUsView=[[AboutUsView alloc]initWithNibName:@"AboutUsView" bundle:nil];
     objAboutUsView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:objAboutUsView animated:YES completion:nil];
    [objAboutUsView release];
}

-(IBAction)clickedNotificationButton:(id)sender
{ 
     NotificationsView *objNotificationsView=[[NotificationsView alloc]initWithNibName:@"NotificationsView" bundle:nil];
    [self.navigationController pushViewController:objNotificationsView animated:YES];
    [objNotificationsView release];
}


-(IBAction)clickedMailBoxButton:(id)sender
{
    MailBoxView *objMailBoxView=[[MailBoxView alloc]initWithNibName:@"MailBoxView" bundle:nil];
    objMailBoxView.fromView=1;
    [self.navigationController pushViewController:objMailBoxView animated:YES];
    [objMailBoxView release];
}


-(IBAction)clickedMailCountButton:(id)sender
{
    MailBoxView *objMailBoxView=[[MailBoxView alloc]initWithNibName:@"MailBoxView" bundle:nil];
    objMailBoxView.fromView=1;
    [self.navigationController pushViewController:objMailBoxView animated:YES];
    [objMailBoxView release];
}


-(IBAction)clickedMembersButton:(id)sender
{
     OnlineMembers *objOnlineMembers=[[OnlineMembers alloc]initWithNibName:@"OnlineMembers"  bundle:nil];
    [self.navigationController pushViewController:objOnlineMembers animated:YES];
    [objOnlineMembers release];
}


-(IBAction)clickedNewsFeedsButton:(id)sender
{   
     NewsFeedsController *objNewsFeedsView=[[NewsFeedsController alloc]initWithNibName:@"NewsFeedsController" bundle:nil];
    [self.navigationController pushViewController:objNewsFeedsView animated:YES];
    [objNewsFeedsView release];
}


-(IBAction)clickedMapButton:(id)sender
{
   
    MyNeighboursSearchResults *objMyNeighboursSearchResultsr=[[MyNeighboursSearchResults alloc]initWithNibName:@"MyNeighboursSearchResults" bundle:nil];
    [self.navigationController pushViewController:objMyNeighboursSearchResultsr animated:YES];
    [objMyNeighboursSearchResultsr release];
}


#pragma mark-UIAlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{        
    if (actionSheet.tag==1&&buttonIndex==0) 
    {
        if (timer) 
        {
            [timer invalidate];
            timer = nil;
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (actionSheet.tag==2&&buttonIndex==0) 
    {
        //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        //{
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
        //}
        /*else
        {       
            if (camFlag==NO) 
            {    
                indicatorView = [[UIView alloc] initWithFrame:CGRectMake(75, 125, 200, 200)];
            }
            else
            {
                if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
                {
                    indicatorView = [[UIView alloc] initWithFrame:CGRectMake(362, 234, 300, 300)];
                }
                else 
                {
                    indicatorView = [[UIView alloc] initWithFrame:CGRectMake(234, 310, 300, 300)];
                }
            }
        }*/
        
        indicatorView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        indicatorView.clipsToBounds = YES;
        indicatorView.layer.cornerRadius = 10.0;
        objIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
          
        //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        //{
            objIndicatorView.frame = CGRectMake(65, 40, objIndicatorView.bounds.size.width, objIndicatorView.bounds.size.height); 
        //}
        /*else
        {
            if (camFlag==NO)  
            {    
                objIndicatorView.frame = CGRectMake(80, 80, objIndicatorView.bounds.size.width, objIndicatorView.bounds.size.height); 
            }
            else
            {
                if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
                {
                    objIndicatorView.frame = CGRectMake(180, 100, objIndicatorView.bounds.size.width, objIndicatorView.bounds.size.height);
                }
                else 
                {
                    objIndicatorView.frame = CGRectMake(130, 100, objIndicatorView.bounds.size.width, objIndicatorView.bounds.size.height);
                }
            }
        }*/
        
        [indicatorView addSubview:objIndicatorView];
       
        //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        //{
            indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
        //}
        /*else
        {
            if (camFlag==NO)  
            {    
                indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 150, 30)]; 
            }
            else
            {
                if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
                {
                    indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 200, 150, 30)];
                }
                else 
                {
                    indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 200, 150, 30)];
                }
            }
        }*/
        
        indicatorLabel.backgroundColor = [UIColor clearColor];
        indicatorLabel.textColor = [UIColor whiteColor];
        indicatorLabel.adjustsFontSizeToFitWidth = YES;
        indicatorLabel.textAlignment = NSTextAlignmentCenter;
        indicatorLabel.text = @"Uploading...";
        [indicatorView addSubview:indicatorLabel];
        UIImagePickerController * picker = [[[UIImagePickerController alloc] init] autorelease];     
        [picker.view addSubview:indicatorView];
        [picker.view bringSubviewToFront:indicatorView];
        [objIndicatorView startAnimating];
    
       imageData = [[NSUserDefaults standardUserDefaults] valueForKey:@"imageToUpload"];
        [self performSelector:@selector(Upload:) withObject:imageData afterDelay:0.01];
        
    }
    
}

-(void)fetchAvailableProducts{
    NSSet *productIdentifiers = [NSSet
                                 setWithObjects:@"de.gerber.blugay.noad",nil];
    productsRequest = [[SKProductsRequest alloc]
                       initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
}

- (BOOL)canMakePurchases
{
    return [SKPaymentQueue canMakePayments];
}
- (void)purchaseMyProduct:(SKProduct*)product{
    if ([self canMakePurchases]) {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"Purchases are disabled in your device" message:nil delegate:
                                  self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
    }
}



- (IBAction)removeButtonClicked:(id)sender {
    //NSLog(@"hallo");

        [self purchaseMyProduct:[validProducts objectAtIndex:0]];
       //removeButton.enabled=NO;
}


#pragma mark StoreKit Delegate

-(void)paymentQueue:(SKPaymentQueue *)queue
updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"Purchasing");
                break;
            case SKPaymentTransactionStatePurchased:
                if ([transaction.payment.productIdentifier
                     isEqualToString:@"de.gerber.blugay.noad"]) {
                    NSLog(@"Purchased ");
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                              @"Purchase is completed succesfully" message:nil delegate:
                                              self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alertView show];
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Restored ");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"Purchase failed ");
                break;
            default:
                break;
        }
    }
}

-(void)productsRequest:(SKProductsRequest *)request
didReceiveResponse:(SKProductsResponse *)response
{
    
    SKProduct *validProduct = nil;
    int count = [response.products count];
    if (count>0) {
        validProducts = response.products;
        validProduct = [response.products objectAtIndex:0];
        if ([validProduct.productIdentifier
             isEqualToString:@"de.gerber.noad"]) {
           
        }
    } else {
        UIAlertView *tmp = [[UIAlertView alloc]
                            initWithTitle:@"Not Available"
                            message:@"No products to purchase"
                            delegate:self
                            cancelButtonTitle:nil
                            otherButtonTitles:@"Ok", nil];
        [tmp show];
    }    
   //   purchaseButton.hidden = NO;
}

@end

