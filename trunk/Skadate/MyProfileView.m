//
//  MyProfileView.m
//  Chk
//
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "MyProfileView.h"
#import "SkadateViewController.h"
#import "MyPhotosView.h"
#import "JSON.h"
#import "SkadateAppDelegate.h"
#import "NotificationsView.h"
#import "CommonStaticMethods.h"

@implementation MyProfileView

@synthesize btnHome;
@synthesize btnLogOut;
@synthesize btnNotify;
@synthesize lblProfileName;
@synthesize imgProfile;
@synthesize txtInfo;
@synthesize txtViewEssays;
@synthesize tempScrollView;
@synthesize profileID;
@synthesize txtInfoName;
@synthesize txtInfoAge,indicatorView,indicatorLabel,objIndicatorView;
@synthesize toolBar;
@synthesize imgNotification,dividerLineImage;
@synthesize navBar;
@synthesize lblNavTitle,domain;
@synthesize NewXval;

#pragma mark Memory Management

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark initWithNibName

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!loadFlag) 
    {
        return;
    }
    notifFlag = 1;
    /*if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft)
        {
            btnNotify.frame=CGRectMake(530, 714, 25, 25);
            imgNotification.frame=CGRectMake(416, 714, 140, 25);
        }
        else 
        {
            btnNotify.frame=CGRectMake(430, 972, 25, 25);
            imgNotification.frame=CGRectMake(320, 972, 140, 25);
        }
    }*/
    domain = @"http://blugay.net";
    NSString *urlReq = [NSString stringWithFormat:@"%@/mobile/NotificationCount/?pid=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID];
    respData = [[NSMutableData data] retain];
    NSURL *url = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    toolBar.hidden=YES;
    imgNotification.hidden=YES;
    btnNotify.hidden=YES;
    dividerLineImage.hidden=YES;
    txtViewEssays.text=@"";
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    txtViewEssays.layer.cornerRadius = 10;
    txtViewEssays.layer.borderWidth = 1.0f;
    txtViewEssays.layer.borderColor = [UIColor grayColor].CGColor;
    txtViewEssays.clipsToBounds = YES; 
    txtViewEssays.scrollEnabled=NO;
    txtViewEssays.editable=NO;
    respData = [[NSMutableData data] retain];
    loadFlag=NO;
    tempScrollView.backgroundColor=[UIColor clearColor];
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    [toolBar  setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    toolBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    toolBar.layer.borderWidth=1.0f;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    imgProfile.layer.cornerRadius=12.0;
    imgProfile.layer.masksToBounds=YES;
    lblNavTitle.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [lblNavTitle setText:@"My Profile"];
    [btnNotify setTitleColor:[UIColor colorWithRed:251/255.0 green:102/255.0 blue:36/255.0 alpha:1.0] forState:normal];
    btnNotify.titleLabel.font=[UIFont fontWithName:@"Ubuntu-Bold" size:12];
    [btnNotify setTitle:[NSString stringWithFormat:@"%@",((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications] forState:normal];
    
    NSString *req = [NSString stringWithFormat:@"%@/mobile/Profile_Detail/index.php?id=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
    NSURL *url = [NSURL URLWithString:req];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    [self ShowIndicatorView:@"Loading..."];
    self.view.userInteractionEnabled=NO;
    btnLogOut.enabled=NO;
    btnHome.enabled=NO;
    [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
    
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        infodettexview.font=[UIFont fontWithName:@"Helvetica-Bold" size:23];
        txtInfo.font=[UIFont fontWithName:@"Helvetica" size:23];
        txtInfoName.font=[UIFont fontWithName:@"Helvetica" size:23];
        txtInfoAge.font=[UIFont fontWithName:@"Helvetica" size:21];
        lblProfileName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:30];
        txtViewEssays.font=[UIFont fontWithName:@"Helvetica" size:20];
    }*/
    
    
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
 //   request.testing = YES;
    [ _bannerView loadRequest:request];

        
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    // Return YES for supported orientations
    
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        infodettexview.font=[UIFont fontWithName:@"Helvetica-Bold" size:23];
        // txtInfo.font=[UIFont fontWithName:@"Helvetica" size:23];
        if([txtInfo.text length]>26) 
        {
            txtInfo.font=[UIFont fontWithName:@"Helvetica" size:19];
        }
        else
        {
            txtInfo.font=[UIFont fontWithName:@"Helvetica" size:23];
        }
        txtInfoName.font=[UIFont fontWithName:@"Helvetica" size:23];
        txtInfoAge.font=[UIFont fontWithName:@"Helvetica" size:21];
        lblProfileName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:30];
        txtViewEssays.font=[UIFont fontWithName:@"Helvetica" size:20];
        if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            tempScrollView.scrollEnabled=YES;
            tempScrollView.userInteractionEnabled=YES;
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            btnNotify.frame=CGRectMake(530, 714, 25, 25);
            imgNotification.frame=CGRectMake(416, 714, 140, 25);          
            tempScrollView.frame=CGRectMake(0, 44, 1024, 724);
            tempScrollView.contentSize=CGSizeMake(1024,938);
            imgProfile.frame=CGRectMake(289, 32, 180, 150);
            lblProfileName.frame=CGRectMake(500, 80, 100, 40);
            infoimgview.frame=CGRectMake(289, 241, 483, 250);
            infodettexview.frame=CGRectMake(297, 293, 225, 190);
            txtInfo.frame=CGRectMake(522, 296, 250, 62);
            txtInfoName.frame=CGRectMake(522, 352, 200, 60);
            txtInfoAge.frame=CGRectMake(522, 408, 200, 60);
            essayimgview.frame=CGRectMake(289, 535, 483, 50);
            txtViewEssays.frame=CGRectMake(289, 577, 483, 130);
        }
        else
        {
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            btnNotify.frame=CGRectMake(430, 972, 25, 25);
            imgNotification.frame=CGRectMake(320, 972, 140, 25);
            lblProfileName.frame=CGRectMake(360, 80, 100, 40);
            tempScrollView.frame=CGRectMake(0, 44, 768, 936);
            tempScrollView.contentSize=CGSizeMake(768,938);
            imgProfile.frame=CGRectMake(150, 32, 180, 150);
            infoimgview.frame=CGRectMake(150, 241, 483, 250);
            infodettexview.frame=CGRectMake(160, 293, 225, 190);
            txtInfo.frame=CGRectMake(385, 296, 250, 62);
            txtInfoName.frame=CGRectMake(385, 352, 200, 60);
            txtInfoAge.frame=CGRectMake(385, 408, 200, 60);
            essayimgview.frame=CGRectMake(150, 535, 483, 50);
            txtViewEssays.frame=CGRectMake(150, 577, 483, 130);
        }
        [self textViewFunction];
        [self SetEssaysFrame];
        return YES;
    }
    else
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }*/
}

#pragma mark Custom Methods

-(void)ios6ipad{
    
    /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        {
            infodettexview.font=[UIFont fontWithName:@"Helvetica-Bold" size:23];
            // txtInfo.font=[UIFont fontWithName:@"Helvetica" size:23];
            if([txtInfo.text length]>26)
            {
                txtInfo.font=[UIFont fontWithName:@"Helvetica" size:19];
            }
            else
            {
                txtInfo.font=[UIFont fontWithName:@"Helvetica" size:23];
            }
            txtInfoName.font=[UIFont fontWithName:@"Helvetica" size:23];
            txtInfoAge.font=[UIFont fontWithName:@"Helvetica" size:21];
            lblProfileName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:30];
            txtViewEssays.font=[UIFont fontWithName:@"Helvetica" size:20];
            if(([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeLeft||([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeRight)
            {
                tempScrollView.scrollEnabled=YES;
                tempScrollView.userInteractionEnabled=YES;
                indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
                btnNotify.frame=CGRectMake(530, 714, 25, 25);
                imgNotification.frame=CGRectMake(416, 714, 140, 25);
                tempScrollView.frame=CGRectMake(0, 44, 1024, 724);
                tempScrollView.contentSize=CGSizeMake(1024,938);
                imgProfile.frame=CGRectMake(289, 32, 180, 150);
                lblProfileName.frame=CGRectMake(500, 80, 100, 40);
                infoimgview.frame=CGRectMake(289, 241, 483, 250);
                infodettexview.frame=CGRectMake(297, 293, 225, 190);
                txtInfo.frame=CGRectMake(522, 296, 250, 62);
                txtInfoName.frame=CGRectMake(522, 352, 200, 60);
                txtInfoAge.frame=CGRectMake(522, 408, 200, 60);
                essayimgview.frame=CGRectMake(289, 535, 483, 50);
                txtViewEssays.frame=CGRectMake(289, 577, 483, 130);
            }
            else
            {
                indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
                btnNotify.frame=CGRectMake(430, 972, 25, 25);
                imgNotification.frame=CGRectMake(320, 972, 140, 25);
                lblProfileName.frame=CGRectMake(360, 80, 100, 40);
                tempScrollView.frame=CGRectMake(0, 44, 768, 936);
                tempScrollView.contentSize=CGSizeMake(768,938);
                imgProfile.frame=CGRectMake(150, 32, 180, 150);
                infoimgview.frame=CGRectMake(150, 241, 483, 250);
                infodettexview.frame=CGRectMake(160, 293, 225, 190);
                txtInfo.frame=CGRectMake(385, 296, 250, 62);
                txtInfoName.frame=CGRectMake(385, 352, 200, 60);
                txtInfoAge.frame=CGRectMake(385, 408, 200, 60);
                essayimgview.frame=CGRectMake(150, 535, 483, 50);
                txtViewEssays.frame=CGRectMake(150, 577, 483, 130);
            }
            [self textViewFunction];
            [self SetEssaysFrame];
            
        }
    }*/
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

-(void)SetEssaysFrame
{
    if ([txtViewEssays.text isEqualToString:@""])
    {
    }
    else
    {
        textViewValue = txtViewEssays.text.length;
        if(textViewValue>1)
        {
            CGRect frame = txtViewEssays.frame;
            frame.size = txtViewEssays.contentSize;
            if(frame.size.height>txtViewEssays.frame.size.height)
            {
                txtViewEssays.frame = frame;
            }
        }
        NSUInteger TotlScroll = (txtViewEssays.frame.size.height) + (txtViewEssays.frame.origin.y) + 250;
        /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if(self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft||
               self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
            {
                if(textViewValue > 1)
                {
                    tempScrollView.contentSize=CGSizeMake(1024,TotlScroll);
                }
                else
                {
                    tempScrollView.contentSize=CGSizeMake(1024,938);
                }
            }
            else
            {
                if(textViewValue > 1)
                {
                    tempScrollView.contentSize=CGSizeMake(768,TotlScroll);
                }
                else
                {
                    tempScrollView.contentSize=CGSizeMake(768,938);
                }
            }
        }*/
        //else
        //{
            if(textViewValue > 1)
            {
                tempScrollView.contentSize=CGSizeMake(320,TotlScroll);
            }
            else
            {
                tempScrollView.contentSize=CGSizeMake(320,620);
            }
        //}
    }
}

-(NSString *)returnGender:(int)value
{
    NSString *gender=@""; 
    switch (value)
    {
        case 1:
            gender=@"Female";
            break;
        case 2:
            gender=@"Male";
            break; 
        case 3:
            gender=@"Female,Male";
            break; 
        case 4:
            gender=@"Couple";
            break; 
        case 5:
            gender=@"Female,Couple";
            break;
        case 6:
            gender=@"Male,Couple";
            break; 
        case 7:
            gender=@"Female,Male,Couple";
            break; 
        case 8:
            gender=@"Group";
            break;
        case 9:
            gender=@"Female,Group";
            break;
        case 10:
            gender=@"Male,Group";
            break; 
        case 11:
            gender=@"Female,Male,,Group";
            break; 
        case 12:
            gender=@"Couple,Group";
            break;
        case 13:
            gender=@"Female,Couple,Group";
            break;
        case 14:
            gender=@"Male,Couple,Group";
            break; 
        case 15:
            gender=@"Female,Male,Couple,Group";
            break; 
            
        default:
            gender=@"";
            break;
    }
    return gender;
}

-(void)textViewFunction
{
    CGRect frame = txtViewEssays.frame;
    frame.size = txtViewEssays.contentSize;
    txtViewEssays.frame = frame;
    //NSUInteger TotlScroll = (txtViewEssays.frame.size.height) + (txtViewEssays.frame.origin.y) + 250;
    
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if(self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft||
           self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            if(textViewValue > 1)
            {
                tempScrollView.contentSize=CGSizeMake(1024,TotlScroll);
            }
            else
            {
                tempScrollView.contentSize=CGSizeMake(1024,938);
                txtViewEssays.frame=CGRectMake(289, 577, 483, 130);
            }
        }
        else
        {
            if(textViewValue > 1)
            {
                tempScrollView.contentSize=CGSizeMake(768,TotlScroll);
            }
            else
            {
                tempScrollView.contentSize=CGSizeMake(768,938);
                txtViewEssays.frame=CGRectMake(150, 577, 483, 130);
            }
        }
    }*/
}

#pragma mark IBAction

-(IBAction)clickedHomeButton:(id) sender
{
    btnLogOut.enabled=YES;
    btnHome.enabled=YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)closeToolBar:(id)sender
{
    toolBar.hidden=YES;
    imgNotification.hidden=YES;
    btnNotify.hidden=YES;
    dividerLineImage.hidden=YES;
}

-(IBAction)clickedLogoutButton:(id) sender
{
    [self ShowIndicatorView:@"Please Wait..."];
    self.view.userInteractionEnabled=NO;
    btnLogOut.enabled=NO;
    btnHome.enabled=NO;
    domain = @"http://blugay.net";
    NSString *urlReq = [NSString stringWithFormat:@"%@/mobile/SignOut/?id=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID];
    respData = [[NSMutableData data] retain];
    NSURL *url = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    logoutConnection=[[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];  
}

-(IBAction)clickedNotificationButton:(id)sender
{
    NotificationsView *objNotificationsView=[[NotificationsView alloc]initWithNibName:@"NotificationsView" bundle:nil];
    [self.navigationController pushViewController:objNotificationsView animated:YES];
    [objNotificationsView release];
}

-(IBAction)UpgradeButtonClicked:(id)sender 
{
}

#pragma mark Managing API Calls

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [respData setLength:0 ];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [respData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    indicatorView.hidden=YES;
    btnLogOut.enabled=YES;
    btnHome.enabled=YES;
    self.view.userInteractionEnabled=YES;
    if (connection==logoutConnection) 
    {
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfileID=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserStatus=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserUnRegistered=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfilePic=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserStatus=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserUnRegistered=@"";
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=nil;
        [self.navigationController popToRootViewControllerAnimated:YES];
     }
    else
    {
    	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        tempScrollView.contentSize=CGSizeMake(320,620);
    }
    return;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    indicatorView.hidden=YES;
    self.view.userInteractionEnabled=YES;
    btnLogOut.enabled=YES;
    btnHome.enabled=YES;
	NSString *responseString = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
	NSError *error;
	SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
   
    if(!responseString)
    {  
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Failed to retrieve data from the site. Kindly try again after some time!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alertView.tag=2;
        [alertView show];
        [alertView release];  
        [responseString release];
        return;
    }
    
    [responseString release];
    CFRelease((CFTypeRef) parser);
   
    if (connection==logoutConnection)
    {
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfileID=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserStatus=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserUnRegistered=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfilePic=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserStatus=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserUnRegistered=@"";
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=nil;
        NSString *originalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
        BOOL isDir=[CommonStaticMethods directoryExistsAtAbsolutePath:[originalPath stringByAppendingPathComponent:@"profile.png"]];
        if(isDir)
        {
            if ([[NSFileManager defaultManager] removeItemAtPath: originalPath error: nil] == NO)
            {
                // Operation Failed
            }
            
        }
        NSString *res=(NSString*)[parsedData objectForKey:@"Message"];
        
        if ([res isEqualToString:@"Sign out successfully"])
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        return;
    }
  
    if (notifFlag == 1 && loadFlag) 
    {
        NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"]; 
        //For checking session validation
        if([messegeStr isEqualToString:@"Site suspended"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=1;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([messegeStr isEqualToString:@"Session Expired"]) 
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=1;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }                      
        notifications = (NSNumber*)[parsedData objectForKey:@"chatcount"];
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications=notifications;
        [btnNotify setTitle:[NSString stringWithFormat:@"%@",notifications] forState:normal];
    }
    else
    {
        respProflieDetails.profileID=(NSString*)[parsedData objectForKey:@"profile_id"];
        if ([respProflieDetails.profileID isEqualToString:@""])
        {
            indicatorView.hidden=YES;
            self.view.userInteractionEnabled=YES;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            tempScrollView.contentSize=CGSizeMake(320,620);
            return;
        }
        else
        {
            indicatorView.hidden=YES;
            self.view.userInteractionEnabled=YES;
            NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"];
            if([messegeStr isEqualToString:@"Site suspended"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
                return;
            }
            else if ([messegeStr isEqualToString:@"Session Expired"]) 
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
                return;
            }
            else if ([messegeStr isEqualToString:@"Membership Denied"])
            {
                UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to view  the profile." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [MembershipAlertView show];
                [MembershipAlertView release];
                return;
            }
            else if ([messegeStr isEqualToString:@"Incorrect ID"]) 
            {
                UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [MembershipAlertView show];
                [MembershipAlertView release];
                tempScrollView.contentSize=CGSizeMake(320,620);
                return;
            }   
            
            respProflieDetails.bgImageURL=(NSString*)[parsedData objectForKey:@"Profile_Image"];
            respProflieDetails.fullName=(NSString*)[parsedData objectForKey:@"username"];
            NSString *Val=(NSString*)[parsedData objectForKey:@"sex"];
            int intVal=[Val intValue];
            respProflieDetails.sex=[self returnGender:intVal];
            NSString *ValLooking=(NSString*)[parsedData objectForKey:@"match_sex"];
            int intValLooking;
            @try 
            {
                intValLooking=[ValLooking intValue];
            } 
            @catch (NSException *e) 
            {
            }
            respProflieDetails.match_sex=@"";//[self returnGender:intValLooking];
            respProflieDetails.dob=(NSString*)[parsedData objectForKey:@"birthdate"];
            NSLog(@"Geburtstag %@",(NSString*)[parsedData objectForKey:@"birthdate"]);
            respProflieDetails.matchAge=(NSString*)[parsedData objectForKey:@"match_agerange"];
            respProflieDetails.headline=(NSString*)[parsedData objectForKey:@"headline"];
            respProflieDetails.realName=(NSString*)[parsedData objectForKey:@"real_name"];
            respProflieDetails.essays=(NSString*)[parsedData objectForKey:@"general_description"];
            ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfilePic=respProflieDetails.bgImageURL;
             imgProfile.image=[UIImage imageNamed:@"Loading large.PNG"];
         
            // Lazy image loading         
            NSString *profilePicURL1=[NSString stringWithFormat:@"%@%@",domain,respProflieDetails.bgImageURL];
            NSString *imageName=[NSString stringWithFormat:@"%@",respProflieDetails.bgImageURL];
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
                   NSURL *imageURL = [[[NSURL alloc] initWithString:profilePicURL1]autorelease];            
                    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
                    [NSURLConnection connectionWithRequest:request delegate:self];
                    NSData *thedata = [NSData dataWithContentsOfURL:imageURL];
                    [thedata writeToFile:localFilePath atomically:YES];
                }
                UIImage* image = [UIImage imageWithContentsOfFile:localFilePath];
                dispatch_sync(dispatch_get_main_queue(), ^{
                if(image)
                {
                    [imgProfile setImage:image];
                }
                else
                {
                    if ( (Val == (id)[NSNull null]) || (Val == NULL) || ([Val isEqual:@""]) || ([Val length] == 0) )
                    {                                                      
                        imgProfile.image=[UIImage imageNamed:@"man.png"];
                    }
                    else
                    {
                        if (intVal==1) 
                        {
                            imgProfile.image=[UIImage imageNamed:@"women.png"];
                        }
                        else if (intVal==2) 
                        {
                            imgProfile.image=[UIImage imageNamed:@"man.png"];
                        }
                        else if (intVal==4) 
                        {
                            imgProfile.image=[UIImage imageNamed:@"man_women.png"];
                        }
                        else if (intVal==8) 
                        {
                            imgProfile.image=[UIImage imageNamed:@"man_women_a.png"];
                        }
                        else 
                        {
                            imgProfile.image=[UIImage imageNamed:@"man.png"];
                        } 
                    }
                    
                }
                    
            });
                
        });  
            
        dispatch_release(queue);
            
        if (respProflieDetails.headline == (id)[NSNull null])
        {
            respProflieDetails.headline=@" ";
        }
            
        if (respProflieDetails.realName == (id)[NSNull null])
        {
            respProflieDetails.realName=@" ";
        }
            
        if (respProflieDetails.essays == (id)[NSNull null]) 
        {
            respProflieDetails.essays=@" ";
        }
            
        if (respProflieDetails.dob == (id)[NSNull null])
        {
            respProflieDetails.dob=@"";
        }
            
        if (respProflieDetails.matchAge == (id)[NSNull null]) 
        {
            respProflieDetails.matchAge=@"";
        }
            
        NSString *infoText=[NSString stringWithFormat:@"%@\r%@",respProflieDetails.sex,respProflieDetails.match_sex];
        NSString *infoTextMiddle=[NSString stringWithFormat:@"%@\r%@",respProflieDetails.realName,respProflieDetails.headline];
      //  NSString *strDob;
      //  NSArray* strDOB = [respProflieDetails.dob componentsSeparatedByString: @"-"];
       
            // entfernt von BG, da Datumsanzeige falsch
    /*    if ([strDOB count]>0)
        {
            NSString * day = [strDOB objectAtIndex: 1];
            NSString *year = [strDOB objectAtIndex: 2];
            NSString *seperator=@"-";
            NSString * monthName= [CommonStaticMethods GetMonthName:[strDOB objectAtIndex: 0]];      
            NSString *strdob1=[monthName stringByAppendingString:seperator];
            NSString *strdob2=[strdob1 stringByAppendingString:day];
            NSString *strdob3=[strdob2 stringByAppendingString:seperator];
            strDob=[strdob3 stringByAppendingString:year];
        }
     */
        NSString *infoTextLast=[NSString stringWithFormat:@"%@\r%@",respProflieDetails.dob,respProflieDetails.matchAge];
        lblProfileName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:22];
        lblProfileName.text=respProflieDetails.fullName;
        txtInfo.text=infoText;
        
        /*if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            if([txtInfo.text length]>26) 
            {
                txtInfo.font=[UIFont fontWithName:@"Helvetica" size:19];
            }
            else
            {
                txtInfo.font=[UIFont fontWithName:@"Helvetica" size:23];
            }
        }*/
            
        txtInfoName.text=infoTextMiddle;
        txtInfoAge.text=infoTextLast;
     
        if (![respProflieDetails.essays isEqualToString:@""]) 
        {
            txtViewEssays.text=respProflieDetails.essays;
            textViewValue = respProflieDetails.essays.length;
            if(textViewValue>1)
            {
                CGRect frame = txtViewEssays.frame;
                frame.size = txtViewEssays.contentSize;
                if(frame.size.height>txtViewEssays.frame.size.height)
                {
                    txtViewEssays.frame = frame;
                }
            }
                       
            NSUInteger TotlScroll = (txtViewEssays.frame.size.height) + (txtViewEssays.frame.origin.y) + 125;
                                    
            if(textViewValue > 1)
            {
                tempScrollView.contentSize=CGSizeMake(320,TotlScroll);
            }
            else
            {
                //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                //{
                //    tempScrollView.contentSize=CGSizeMake(320,938);
                //}
                //else
                //{
                    tempScrollView.contentSize=CGSizeMake(320,320);
                //}
                
            }
        }
        else
        {
             NSUInteger TotlScroll = (txtViewEssays.frame.size.height) + (txtViewEssays.frame.origin.y) + 100;
            
            tempScrollView.contentSize=CGSizeMake(320,TotlScroll);
        }
        loadFlag=YES;
    }
                   
  }
    tempScrollView.scrollEnabled=YES;
    tempScrollView.userInteractionEnabled=YES;
}

#pragma mark-UIAlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1&&buttonIndex==0) 
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (actionSheet.tag==2&&buttonIndex==0)
    {
        btnLogOut.enabled=YES;
        btnHome.enabled=YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)photoClicked:(id)sender {
    MyPhotosView *objMyPhotosView=[[MyPhotosView alloc]initWithNibName:@"MyPhotosView" bundle:nil];
    objMyPhotosView.flagHome=YES;
    objMyPhotosView.profileID=profileID;
    [self.navigationController pushViewController:objMyPhotosView animated:YES];
    [objMyPhotosView release];
}
@end
