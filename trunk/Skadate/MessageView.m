//
//  MessageView.m
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MessageView.h"
#import "MailBoxView.h"
#import "MailConversationView.h"
#import "ReplyMessageView.h"
#import "JSON.h"
#import "SkadateAppDelegate.h"
#import "CommonStaticMethods.h"

@implementation MessageView

@synthesize  btnMailBox;
@synthesize  btnBookMark,profileID;
@synthesize  btnReply,labelSubject1,labelSubject,labelName,labelDate,indicatorView,indicatorLabel,objIndicatorView;
@synthesize  btnDelete,viewMessage,profileImg,fullName,dateTime,subject1,subject,message,profilePic,messageId,messageID1;
@synthesize rootConIDArray,genders;
@synthesize rootConNumArray;
@synthesize rootMsgIDArray;
@synthesize index;
@synthesize segmentCtrl;
@synthesize fromInbox;
@synthesize domain;
@synthesize senderIDs;
@synthesize recipientIDs;
@synthesize conversationIDs;
@synthesize isKiss;
@synthesize isWink;
@synthesize is_readableArray;
@synthesize NewXval;
@synthesize conversationNumber;

#pragma mark Memory Management

- (void)dealloc
{
    [fullName release];
    [dateTime release];
    [subject release];
    [subject1 release];
    [message release];
    [profilePic release];
    [messageId release];
    [kissesImagesArray release];
    [winkImagesArray release];
    [smileyImgView release];
    [kissImageView release];
    [is_readableArray release];
    dispatch_release(queue);
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

#pragma mark Custom Methods

-(void)ios6ipad{
    
    labelName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:30];
    labelSubject1.font=[UIFont fontWithName:@"Ubuntu-Bold" size:20];
    viewMessage.font=[UIFont fontWithName:@"Helvetica" size:20];
    
    /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        if (([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeRight||([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeLeft)
        {
            
            smileyImgView.frame=CGRectMake(50, 300, 25, 25);
            kissImageView.frame=CGRectMake(50, 300, 35, 20);
            indicatorView.frame =CGRectMake(412, 344, 200, 40);
            [profileImg setFrame:CGRectMake(27,65,170,140)];
            [labelName setFrame:CGRectMake(230,85,170,40)];
            [labelDate setFrame:CGRectMake(230,125,170,40)];
            
		}
        else
        {
            
            smileyImgView.frame=CGRectMake(50, 300, 25, 25);
            kissImageView.frame=CGRectMake(50, 300, 35, 20);
            indicatorView.frame =CGRectMake(284, 471, 200, 40);
            [profileImg setFrame:CGRectMake(30,70,200,180)];
            [labelName setFrame:CGRectMake(260,100,250,40)];
            [labelDate setFrame:CGRectMake(260,140,300,40)];
            
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

-(NSString *)FormatTime:(NSString *)ServerTimeStr
{
    NSString *serverTime =ServerTimeStr;
    NSString * serverTimeZone=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedTimeZone;
    NSString *TimeZoneName=[[NSTimeZone systemTimeZone] name];
    DisplayDateTime *objDisplayDateTime =[[DisplayDateTime alloc]init];
    NSString *result= [objDisplayDateTime ConvertDateTime:serverTime andServerTimeZone:serverTimeZone andDeviceTimeZone:TimeZoneName];
    [objDisplayDateTime release];
    return result;
}


#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    btnMailBox.enabled=NO;
    btnBookMark.enabled=NO;
    btnReply.enabled=NO;
    btnDelete.enabled=NO;
    segmentCtrl.enabled=NO;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    fromInbox=[prefs boolForKey:@"Inbox"];
    segmentCtrl.momentary=YES;
    //segmentCtrl.segmentedControlStyle = UISegmentedControlStyleBar;
    CGRect frame = CGRectMake (233, 8, 71, 29);
    segmentCtrl.frame = frame;
    segmentCtrl.clipsToBounds = YES;
    segmentCtrl.layer.cornerRadius = 7.0;
    
    deleteFlag=NO;
    bookmarkFlag=NO;
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    [toolBar  setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    
    toolBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    toolBar.layer.borderWidth=1.0f;
    kissesImagesArray=[[NSMutableArray alloc]init ];
  
    for (int j=1; j<=24; j++) 
    {
        UIImage *kiss=[UIImage imageNamed:[NSString stringWithFormat:@"kiss%d.png",j]];
        [kissesImagesArray addObject:kiss];
    }
    
    winkImagesArray=[[NSMutableArray alloc]init ];
   
    for (int l=1; l<=6; l++) 
    {
        UIImage *wink=[UIImage imageNamed:[NSString stringWithFormat:@"wink%d.png",l]];
        [winkImagesArray addObject:wink];
    }
    
    kissImageView=[[UIImageView alloc]initWithFrame:CGRectMake(135, 65, 35, 20)];
    [self.view addSubview:kissImageView];
    smileyImgView=[[UIImageView alloc]initWithFrame:CGRectMake(135, 65, 25, 25)];
    [self.view addSubview:smileyImgView];
    smileyImgView.hidden=YES;
    viewMessage.hidden=YES;
    kissImageView.hidden=YES;
    respData = [[NSMutableData data] retain];
    NSString *req;
    is_readableArray=[[NSMutableArray alloc]init];
 
    if (fromInbox) 
    {
        btnReply.hidden=NO;
        btnBookMark.hidden=NO;
        req = [NSString stringWithFormat:@"%@/mobile/Message_Details_Inverse/?id=%@&pid=%@&skey=%@",domain,messageID1,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
    }
    else 
    {
        btnReply.hidden=YES;
        btnBookMark.hidden=YES;
        req = [NSString stringWithFormat:@"%@/mobile/Message_Details/?id=%@&pid=%@&skey=%@",domain,messageID1,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
    }
    
    NSURL *url = [NSURL URLWithString:req];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
    [self ShowIndicatorView:@"Loading..."]; 
    profileImg.layer.cornerRadius=12.0;
    profileImg.layer.masksToBounds=YES;
    labelName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:20];
   
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        labelName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:30];
        labelSubject1.font=[UIFont fontWithName:@"Ubuntu-Bold" size:20];
        viewMessage.font=[UIFont fontWithName:@"Helvetica" size:20];
    }*/
    
    if (conversationNumber==2) 
    {
        toolBar.hidden=YES;
        btnReply.hidden=YES;
        btnBookMark.hidden=YES;
        btnDelete.hidden=YES;
        segmentCtrl.hidden=YES;
    }
    
    UIImage* seg0 = [UIImage imageNamed:@"nextbutton.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        seg0 = [seg0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [segmentCtrl setImage:seg0 forSegmentAtIndex:0];
    
    UIImage* seg1 = [UIImage imageNamed:@"previous_button.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        seg1 = [seg1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [segmentCtrl setImage:seg1 forSegmentAtIndex:1];
    
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
    
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {        
        labelName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:30];
        labelSubject1.font=[UIFont fontWithName:@"Ubuntu-Bold" size:20];
        viewMessage.font=[UIFont fontWithName:@"Helvetica" size:20];
       
        if (interfaceOrientation==UIInterfaceOrientationLandscapeRight||interfaceOrientation==UIInterfaceOrientationLandscapeLeft) 
        {
            smileyImgView.frame=CGRectMake(50, 300, 25, 25);
            kissImageView.frame=CGRectMake(50, 300, 35, 20);
            indicatorView.frame =CGRectMake(412, 344, 200, 40);
            [profileImg setFrame:CGRectMake(27,65,170,140)];
            [labelName setFrame:CGRectMake(230,85,170,40)];
            [labelDate setFrame:CGRectMake(230,125,170,40)];
        }
        else
        {
            smileyImgView.frame=CGRectMake(50, 300, 25, 25);
            kissImageView.frame=CGRectMake(50, 300, 35, 20);
            indicatorView.frame =CGRectMake(284, 471, 200, 40);
            [profileImg setFrame:CGRectMake(30,70,200,180)];
            [labelName setFrame:CGRectMake(260,100,250,40)];
            [labelDate setFrame:CGRectMake(260,140,300,40)];
        }
        return YES;
    }
    else
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }*/
}

#pragma mark Managing API Calls

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [respData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [respData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    indicatorView.hidden=YES;
    btnMailBox.enabled=YES;
    btnBookMark.enabled=YES;
    btnReply.enabled=YES;
    btnDelete.enabled=YES;
    segmentCtrl.enabled=YES;
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	return;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    indicatorView.hidden=YES;
    btnMailBox.enabled=YES;
    btnBookMark.enabled=YES;
    btnReply.enabled=YES;
    btnDelete.enabled=YES;
    segmentCtrl.enabled=YES;
   
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        profileImg.layer.cornerRadius=25.0;
    }*/
    
    NSString *responseString = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
	NSError *error;
	SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    CFRelease((CFTypeRef) parser);
    NSDictionary *json = [responseString JSONValue];  
   
    if(!responseString)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to retrieve data from the site. Please try after sometime." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        if (bookmarkFlag) 
        {
            bookmarkFlag=NO;
        }
        if (deleteFlag) 
        {
            deleteFlag=NO;
        }
        [alertView show];
		[alertView release];
        [responseString release];
        return;
    }
    
    [responseString release];
    
    if (bookmarkFlag)
    {
        NSString *bookMark=(NSString*)[parsedData objectForKey:@"Message"];
        if([bookMark isEqualToString:@"Site suspended"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=2;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([bookMark isEqualToString:@"Session Expired"]) 
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=2;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([bookMark isEqualToString:@"Membership Denied"]) 
        {
            UIAlertView * MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to bookmark the profile." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
        }
        else if ([bookMark isEqualToString:@"Bookmarked"]) 
        {
            bookmarkFlag=NO;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Successfully bookmarked." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        } 
        else if ([bookMark isEqualToString:@"Already Bookmarked"])
        {
            bookmarkFlag=NO;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"You had already bookmarked this profile." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
        else if ([bookMark isEqualToString:@"Bookmarked Failed"])
        {
            UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Failed to bookmark the profile." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
        }
        else if ([bookMark isEqualToString:@"Error"])
        {
            bookmarkFlag=NO;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Failed to save bookmark, try again" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
    }
    else if (deleteFlag) 
    {
        NSString *delete=(NSString*)[parsedData objectForKey:@"Message"];
        if([delete isEqualToString:@"Site suspended"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=2;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([delete isEqualToString:@"Session Expired"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=2;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([delete isEqualToString:@"Membership Denied"]) 
        {
            UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to delete  the message." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
        }
        else if ([delete isEqualToString:@"Success"]) 
        {
            deleteFlag=NO;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Successfully deleted the message." description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alertView.tag=1;
            [alertView show];
            [alertView release];
        }
        else if ([delete isEqualToString:@"Error"])
        {
            deleteFlag=NO;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Failed to delete the message, try again" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }  
    }
    else
    {
        fullName=[[NSMutableArray alloc]init];
        dateTime=[[NSMutableArray alloc]init];
        subject=[[NSMutableArray alloc]init];
        subject1=[[NSMutableArray alloc]init];
        message=[[NSMutableArray alloc]init];
        profilePic=[[NSMutableArray alloc]init];
        messageId=[[NSMutableArray alloc]init];
        NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"];
        //For checking session validation
        NSString *resultCount = (NSString*)[parsedData objectForKey:@"count"];
       
        if([messegeStr isEqualToString:@"Site suspended"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=2;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([messegeStr isEqualToString:@"Session Expired"]) 
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=2;
            [sessionAlertView show];
            [sessionAlertView release];
            return; 
        }
        else if ([messegeStr isEqualToString:@"Membership Denied"]) 
        {
            UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to view the message." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
        }
        else if([resultCount intValue]==0)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Message was not found"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
        else
        {
            smileyImgView.hidden=YES;
            viewMessage.hidden=YES;
            kissImageView.hidden=YES;
            NSArray *username = [json valueForKeyPath:@"result.username"];
            fullName=[[NSMutableArray alloc] initWithArray:username copyItems:YES];
            NSArray *dateAndTime = [json valueForKeyPath:@"result.DateTime"];
            dateTime=[[NSMutableArray alloc] initWithArray:dateAndTime copyItems:YES];
            NSArray *subjet = [json valueForKeyPath:@"result.subject"];
            subject=[[NSMutableArray alloc] initWithArray:subjet copyItems:YES];
            NSArray *subjet1 = [json valueForKeyPath:@"result.subject"];
            subject1=[[NSMutableArray alloc] initWithArray:subjet1 copyItems:YES];
            NSArray *mesage = [json valueForKeyPath:@"result.text"];
            message=[[NSMutableArray alloc] initWithArray:mesage copyItems:YES];
            NSArray *mesageId = [json valueForKeyPath:@"result.message_id"];
            messageId=[[NSMutableArray alloc] initWithArray:mesageId copyItems:YES];
            NSArray *gendersId = [json valueForKeyPath:@"result.sex"];
            genders=[[NSMutableArray alloc] initWithArray:gendersId copyItems:YES];
            NSArray *senders = [json valueForKeyPath:@"result.sender_id"];
            senderIDs=[[NSMutableArray alloc] initWithArray:senders copyItems:YES];
            NSArray *recipients = [json valueForKeyPath:@"result.recipient_id"];
            recipientIDs=[[NSMutableArray alloc] initWithArray:recipients copyItems:YES];
            strBid=[recipientIDs objectAtIndex:0];
            NSArray *conversations = [json valueForKeyPath:@"result.conversation_id"];
            conversationIDs=[[NSMutableArray alloc] initWithArray:conversations copyItems:YES];
            NSArray *profileUrl = [json valueForKeyPath:@"result.Profile_Image"];
            profilePic=[[NSMutableArray alloc] initWithArray:profileUrl copyItems:YES];
            respProflieDetails.bgImageURL=[profilePic objectAtIndex:0];
            NSArray *readableArray = [json valueForKeyPath:@"result.is_readable"];
            is_readableArray=[[NSMutableArray alloc] initWithArray:readableArray copyItems:YES];
            profileImg.image=[UIImage imageNamed:@"ImageLoading.png"];
            
            NSString *giftURL = [[json valueForKeyPath:@"result.gift_url"] objectAtIndex:0];
            
            // Lazy image loading         
            NSString *profilePicURL=[NSString stringWithFormat:@"%@%@",domain,respProflieDetails.bgImageURL];
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
                NSURL *imageURL = [[[NSURL alloc] initWithString:profilePicURL]autorelease];            
                NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
                [NSURLConnection connectionWithRequest:request delegate:self];
                NSData *thedata = [NSData dataWithContentsOfURL:imageURL];
                [thedata writeToFile:localFilePath atomically:YES];
            }
            UIImage* image = [UIImage imageWithContentsOfFile:localFilePath];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(image)
                {
                    [profileImg setImage:image];
                }
                else
                {
                    if ( ([genders objectAtIndex:0] == (id)[NSNull null])
                        || ([genders objectAtIndex:0] == NULL)
                        || ([[genders objectAtIndex:0] isEqual:@""])
                        || ([[genders objectAtIndex:0] length] == 0) )
                    {                                                      
                        profileImg.image=[UIImage imageNamed:@"man.png"];
                    }
                    else
                    {
                        if ([[genders objectAtIndex:0] intValue]==1) 
                        {
                            profileImg.image=[UIImage imageNamed:@"women.png"];
                        }
                        else if ([[genders objectAtIndex:0] intValue]==2) 
                        {
                            profileImg.image=[UIImage imageNamed:@"man.png"];
                        }
                        else if ([[genders objectAtIndex:0] intValue]==4) 
                        {
                            profileImg.image=[UIImage imageNamed:@"man_women.png"];
                        }
                        else if ([[genders objectAtIndex:0] intValue]==8) 
                        {
                            profileImg.image=[UIImage imageNamed:@"man_women_a.png"];
                        }
                        else 
                        {
                            profileImg.image=[UIImage imageNamed:@"man.png"];
                        } 
                    }
                  }
                });
            });  
            
            //labelSubject.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
            [labelSubject setTextAlignment:NSTextAlignmentCenter];
            labelSubject1.font=[UIFont fontWithName:@"Ubuntu-Bold" size:17];
           
            if (([fullName objectAtIndex:0]== (id)[NSNull null])||([fullName objectAtIndex:0]== NULL))
            {
                labelName.text= @"";
            }
            else
            {
                labelName.text= [fullName objectAtIndex:0];
            }
            
            if (([dateTime objectAtIndex:0]== (id)[NSNull null])||([dateTime objectAtIndex:0]== NULL)) 
            {
                labelDate.text=@"";
            }
            else
            {
                NSMutableString *trimstring=[[NSMutableString alloc]initWithString:[dateTime objectAtIndex:0]];
                labelDate.text=[self FormatTime:trimstring];
                [trimstring release];
            }
            
            //NSString *winkstring=[NSString stringWithFormat:@"[wink]4[/wink]"];
            //NSString *winkstring2=[NSString stringWithFormat:@"[wink]4[/wink] <br />  <br />"];
            NSString *kisscestring=[NSString stringWithFormat:@"[smiles]58[/smiles]"];
            NSString *kisscestring2=[NSString stringWithFormat:@"[smiles]58[/smiles] <br />  <br />"];
           
            if (([message objectAtIndex:0]== (id)[NSNull null])||([message objectAtIndex:0]== NULL)) 
            {
                viewMessage.text=@"";
                smileyImgView.hidden=YES;
                kissImageView.hidden=YES;
                viewMessage.hidden=NO;
            }
            else if(([[message objectAtIndex:0] isEqualToString:kisscestring]||[[message objectAtIndex:0] isEqualToString:kisscestring2])&&[[is_readableArray objectAtIndex:0] isEqualToString:@"no"])
            {
                isKiss=YES;
                isWink=NO;
                smileyImgView.hidden=YES;
                kissImageView.hidden=NO;
                viewMessage.hidden=YES;
                
                /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    if(self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft||self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
                    {
                        kissImageView.frame=CGRectMake(50, 300, 35, 20);
                    }
                    else
                    {
                        kissImageView.frame=CGRectMake(50, 380, 35, 20);
                    }
                }*/
                //else
                //{
                    kissImageView.frame=CGRectMake(50, 210, 35, 20);
                //}
                
                kissImageView.animationImages=kissesImagesArray;
                kissImageView.animationDuration=3.5;
                kissImageView.animationRepeatCount=0;
                [kissImageView startAnimating];
                
                if (fromInbox)
                {
                    labelSubject.text=[NSString stringWithFormat:@"%@ kissed to you",[subject objectAtIndex:0]];
                    labelSubject1.text=[NSString stringWithFormat:@"%@ kissed to you",[subject1 objectAtIndex:0]];
                }
                else
                {
                    labelSubject.text=[NSString stringWithFormat:@"You kissed to %@",[fullName objectAtIndex:0]];
                    labelSubject1.text=[NSString stringWithFormat:@"You kissed to %@",[fullName objectAtIndex:0]];
                }
                
            }
            else if ( ![giftURL isEqualToString:@""] )
            {
                isKiss=YES;
                isWink=NO;
                smileyImgView.hidden=YES;
                kissImageView.hidden=NO;
                viewMessage.hidden=NO;
                
                viewMessage.text=@"";
               
                /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    if(self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft||self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
                    {
                        kissImageView.frame=CGRectMake(50, 300, 35, 20);
                    }
                    else
                    {
                        kissImageView.frame=CGRectMake(50, 380, 35, 20);
                    }
                }
                else
                {*/
                    kissImageView.frame=CGRectMake(10, 210, 100, 100);
                //}
                
                NSURL *url = [NSURL URLWithString:giftURL];
                NSData *giftImgData = [NSData dataWithContentsOfURL:url];
                UIImage *giftImg = [[UIImage alloc] initWithData:giftImgData];
                
                kissImageView.image = giftImg;
                labelSubject.text=[subject objectAtIndex:0];
                labelSubject1.text=[subject1 objectAtIndex:0];
                btnReply.hidden = YES;
                
                //kissImageView.animationDuration=3.5;
                //kissImageView.animationRepeatCount=0;
                //[kissImageView startAnimating];
                
                /*if (fromInbox)
                {
                    labelSubject.text=[NSString stringWithFormat:@"%@ kissed to you",[subject objectAtIndex:0]];
                    labelSubject1.text=[NSString stringWithFormat:@"%@ kissed to you",[subject1 objectAtIndex:0]];
                }
                else
                {
                    labelSubject.text=[NSString stringWithFormat:@"You kissed to %@",[fullName objectAtIndex:0]];
                    labelSubject1.text=[NSString stringWithFormat:@"You kissed to %@",[fullName objectAtIndex:0]];
                }*/
             
            }
            else
            {
                smileyImgView.hidden=YES;
                viewMessage.hidden=NO;
                viewMessage.text=[message objectAtIndex:0];
                labelSubject.text=[subject objectAtIndex:0];
                labelSubject1.text=[subject1 objectAtIndex:0];
            }
        }
    }
}

#pragma mark AlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1)
    {
        if (buttonIndex == 0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if (actionSheet.tag==2&&buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (actionSheet.tag==3&&buttonIndex==0) 
    {
        deleteFlag=YES;
        NSString *req=@"";
        if (!fromInbox)
        {
            req = [NSString stringWithFormat:@"%@/mobile/DeleteMessageBySender/?sid=%@&rid=%@&cid=%@&skey=%@",domain,[senderIDs objectAtIndex:0],[recipientIDs objectAtIndex:0],[conversationIDs objectAtIndex:0],((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
        }
        else
        {
            req = [NSString stringWithFormat:@"%@/mobile/DeleteMessageByRecipient/?sid=%@&rid=%@&cid=%@&skey=%@",domain,[senderIDs objectAtIndex:0],[recipientIDs objectAtIndex:0],[conversationIDs objectAtIndex:0],((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
        }
        NSURL *url = [NSURL URLWithString:[req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
        [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
       [self ShowIndicatorView:@"Deleting..."];         
    }
}

#pragma mark IBAction

-(IBAction) clickedSegmentContol
{
	int selectedsegment = (int)segmentCtrl.selectedSegmentIndex;
   
    if (selectedsegment==0) 
    {
        index--;
        if (index<0) 
        {
            index=0;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"You have reached the first message." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return;
        }
    }
    
    if (selectedsegment==1)
    {
        index++;
        if (index>=[rootMsgIDArray count])
        {
            index=[rootMsgIDArray count]-1;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"You have reached the last message." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return;
        }
    }
    
    if ([[rootConNumArray objectAtIndex:index] isEqualToString:@"0"] || [[rootConNumArray objectAtIndex:index] isEqualToString:@"1"]) 
    {
        NSString *mesgId=[rootMsgIDArray objectAtIndex:index];
        [self ShowIndicatorView:@"Loading..."];  
        respData = [[NSMutableData data] retain];
        messageID1=mesgId;
        NSString *req; 
        if (fromInbox) 
        {
            req = [NSString stringWithFormat:@"%@/mobile/Message_Details_Inverse/?id=%@&pid=%@&skey=%@",domain,mesgId,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
        }
        else
        {
            req = [NSString stringWithFormat:@"%@/mobile/Message_Details/?id=%@&pid=%@&skey=%@",domain,mesgId,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
        }
        NSURL *url = [NSURL URLWithString:req];
        NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
        [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
    }
    else
    {
        if ([[rootConIDArray objectAtIndex:index] isEqualToString:messageID1]) 
        {
            return;
        }
        NSString *mesgId1=[rootConIDArray objectAtIndex:index];
        MailConversationView *objMailConversationView=[[MailConversationView alloc]initWithNibName:@"MailConversationView" bundle:nil];
        objMailConversationView.messageID=mesgId1;
        objMailConversationView.rootMsgIDArray=rootMsgIDArray;
        objMailConversationView.rootConIDArray=rootConIDArray;
        objMailConversationView.rootConNumArray=rootConNumArray;
        objMailConversationView.index=index;
        objMailConversationView.conversNum=[rootConNumArray objectAtIndex:index];
        [self.navigationController pushViewController:objMailConversationView animated:NO];
        [objMailConversationView release];        
    }
    
}

-(IBAction)clickedMailboxFromMessageButton:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clickedBookMarkFromMessageButton:(id) sender
{
    NSString *pid=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID;
    if ([pid isEqualToString:profileID]) 
    {
        UIAlertView *bookmarkselfAlert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"you are not able to bookmark yourself."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [ bookmarkselfAlert show];
        [bookmarkselfAlert release];
    } 
    else
    {
        bookmarkFlag=YES;
        NSString *req = [ NSString stringWithFormat: @"%@/mobile/Bookmark_Profile/?pid=%@&skey=%@&bid=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,profileID];
        NSURL *url = [NSURL URLWithString:[req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
        [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
        [self ShowIndicatorView:@"Bookmarking..."]; 
    } 
}

-(IBAction)clickedReplyFromMessageButton:(id) sender
{
    if ([[is_readableArray objectAtIndex:0] isEqualToString:@"no"]) 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"You can not reply to this message." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    else
    {
        ReplyMessageView *objReplyFromMessage=[[ReplyMessageView alloc]initWithNibName:@"ReplyMessageView" bundle:nil];
        objReplyFromMessage.messageTextView=[message objectAtIndex:0];
        objReplyFromMessage.rplyMessageTxt=[subject objectAtIndex:0];
        objReplyFromMessage.mesageId=messageID1;
        [self.navigationController pushViewController:objReplyFromMessage animated:NO];
        [objReplyFromMessage release];
    }
}

-(IBAction)clickedDeleteFromMessageButton:(id) sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[@"Are you sure to delete this message." description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel",nil]; 
    alert.tag=3;
    [alert show];
    [alert release];     
}

@end
