//
//  ChatMembersView.m
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChatMembersView.h"
#import "HomeView.h"
#import "SkadateAppDelegate.h"
#import "JSON.h"

@implementation ChatMembersView
@synthesize sampleTxtView;

@synthesize messageList;
@synthesize btnImage,domain;
@synthesize btnHome;
@synthesize btnSend;
@synthesize lblName,lblDateTime;
@synthesize txtFldChat;
@synthesize toolBarBottom;
@synthesize respData,urlReq,receipientProfileId,receipientName,receipientProfilePic,resultCount;
@synthesize indicatorView,indicatorLabel,objIndicatorView;
@synthesize status,text,timestamp,recipientgender,chatMsgId,navBar;
@synthesize arrayCount;
@synthesize NewXval;
@synthesize invocation;

#pragma mark Memory Management

- (void)dealloc
{
    [super dealloc];
    if(timer)
    {
        [timer invalidate];
        timer = nil;
        [timer release];
    }    
    [connection release];
    [chatMsgId release];
    [status release];
    [text release];
    [timestamp release];
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

/*-(void)ios6ipad{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        if (([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeRight||([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeLeft)
        {
            
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [toolBarBottom setFrame:CGRectMake(0, 700, 1024, 50)];
            
            
		}
        else
        {
            
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [toolBarBottom setFrame:CGRectMake(0, 955, 768, 50)];
            
        }
        
    }
}*/

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

- (void)getNewChats
{
    if (sendChat == YES)
    {
     
    }
    else
    {            
        sendChat = NO;
        respData = [[NSMutableData data] retain];
        
        urlReq = [NSString stringWithFormat:@"%@/mobile/PrivateChatMsgReceiving/?sid=%@&rid=%@&skey=%@",domain,receipientProfileId,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
        NSURL *url = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
        connection = [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] retain];
    }
}

-(NSString *)FormatTime:(NSString *)ServerTimeStr
{
    NSString *serverTime =ServerTimeStr;
    NSString * serverTimeZone=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedTimeZone;
    NSString *TimeZoneName=[[NSTimeZone systemTimeZone] name];
    
    DisplayDateTime *objDisplayDateTime =[[DisplayDateTime alloc]init];
    NSString *result= [objDisplayDateTime CalculateTime:serverTime andServerTimeZone:serverTimeZone andDeviceTimeZone:TimeZoneName];
    [objDisplayDateTime release];
    return result;
}

-(void)updateChats
{    
    objChatAutoUpdationClass=[[ChatAutoUpdationClass alloc]init];
    objChatAutoUpdationClass.chatDelegate=self;
    [objChatAutoUpdationClass updateChats:receipientProfileId];
}


- (void)loadChats:(NSString  *)responseString
{
    
    NSError *error;
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    NSDictionary *json = [responseString JSONValue];
    [parser release];
    
    if(!responseString)
    {
        if (firstTime == YES) 
        {
            firstTime=NO;
        }
    }
    else if(sendChat == NO)
    {        
        NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"];
        //For checking session validation
        if([messegeStr isEqualToString:@"Site suspended"])
        {   
            return;
        }
        else if ([messegeStr isEqualToString:@"Session Expired"])
        {
            return;
        }
        else if ([messegeStr isEqualToString:@"Membership denied"]||[messegeStr isEqualToString:@"Membership Denied"])
        {
            return;
        }
        else if ([messegeStr isEqualToString:@"Limit Exceeds"]||[messegeStr isEqualToString:@"Limit exceeds"])
        {
            return;
        }                                                               
        resultCount = (NSString*)[parsedData objectForKey:@"count"];
        [resultCount retain];
        if ([resultCount intValue] == 0 )
        {
            if (firstTime == YES)
            {
                firstTime = NO;
            }
        }
        else
        {
            NSArray *chatMsgIds = [json valueForKeyPath:@"result.im_message_id"];
            chatMsgId=[[NSMutableArray alloc] initWithArray:chatMsgIds copyItems:YES];
            NSArray *textMsg = [json valueForKeyPath:@"result.text"];
            text=[[NSMutableArray alloc] initWithArray:textMsg copyItems:YES];
            NSArray *msgTimeStamp = [json valueForKeyPath:@"result.Time"];
            timestamp=[[NSMutableArray alloc] initWithArray:msgTimeStamp copyItems:YES];
            NSArray *statuses = [json valueForKeyPath:@"result.chat"];
            status=[[NSMutableArray alloc] initWithArray:statuses copyItems:YES];
            [messageList reloadData];
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([chatMsgId count] -1) inSection:0];
            [messageList scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            lblDateTime.text = [timestamp objectAtIndex:0];
        }  
    }
           
}


#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated
{      
    invocation= [NSInvocation invocationWithMethodSignature:
                 [self methodSignatureForSelector: @selector(updateChats)]];
    [invocation setTarget:self];
    [invocation setSelector:@selector(updateChats)];
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:10.0 invocation:invocation repeats:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    btnSend.enabled=NO;
    boolHeight=YES;
    messageList.dataSource = self;
    messageList.delegate = self;
    messageList.scrollEnabled=YES;
    messageList.allowsSelection=NO;
    lblName.text = receipientName; 
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    [toolBarBottom setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    toolBarBottom.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    toolBarBottom.layer.borderWidth=1.0f;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    txtFldChat.layer.cornerRadius = 5.0f;
    lblName.font = [UIFont fontWithName:@"Ubuntu-Bold" size:20];
    lblDateTime.font = [UIFont fontWithName:@"Ubuntu-Bold" size:20];
    if ((receipientProfilePic == (id)[NSNull null])||([receipientProfilePic length] == 0)||(receipientProfilePic==NULL)) 
    { 
        if ([recipientgender intValue]==1) 
        {
            UIImage *myimage =[UIImage imageNamed:@"women.png"];
            [btnImage setImage:myimage forState:normal]; 
        }
        else if ([recipientgender intValue]==2)
        {
            UIImage *myimage =[UIImage imageNamed:@"man.png"];
            [btnImage setImage:myimage forState:normal]; 
        }
        else if ([recipientgender intValue]==4)
        {
            UIImage *myimage =[UIImage imageNamed:@"man_women.png"];
            [btnImage setImage:myimage forState:normal]; 
        }
        else if ([recipientgender intValue]==8)
        {
            UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
            [btnImage setImage:myimage forState:normal]; 
        }
        else
        {
            UIImage *myimage =[UIImage imageNamed:@"man.png"];
            [btnImage setImage:myimage forState:normal]; 
        }
    }
    else
    {
        receipientProfilePic=[NSString stringWithFormat:@"%@%@",domain,receipientProfilePic];
        NSData *mydata = [[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:receipientProfilePic]] autorelease];
        if (mydata) 
        {
            UIImage *myimage = [[[UIImage alloc] initWithData:mydata] autorelease];
            if (myimage) 
            {
                [btnImage setImage:myimage forState:normal]; 
            }
            else
            {
                if ([recipientgender intValue]==1)
                {
                    UIImage *myimage =[UIImage imageNamed:@"women.png"];
                    [btnImage setImage:myimage forState:normal]; 
                }
                else if ([recipientgender intValue]==2)
                {
                    UIImage *myimage =[UIImage imageNamed:@"man.png"];
                    [btnImage setImage:myimage forState:normal]; 
                }
                else if ([recipientgender intValue]==4)
                {
                    UIImage *myimage =[UIImage imageNamed:@"man_women.png"];
                    [btnImage setImage:myimage forState:normal]; 
                }
                else if ([recipientgender intValue]==8)
                {
                    UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                    [btnImage setImage:myimage forState:normal]; 
                }
                else
                {
                    UIImage *myimage =[UIImage imageNamed:@"man.png"];
                    [btnImage setImage:myimage forState:normal]; 
                }
            }
        }
        else
        {
            if ([recipientgender intValue]==1)
            {
                UIImage *myimage =[UIImage imageNamed:@"women.png"];
                [btnImage setImage:myimage forState:normal]; 
            }
            else if ([recipientgender intValue]==2)
            {
                UIImage *myimage =[UIImage imageNamed:@"man.png"];
                [btnImage setImage:myimage forState:normal]; 
            }
            else if ([recipientgender intValue]==4)
            {
                UIImage *myimage =[UIImage imageNamed:@"man_women.png"];
                [btnImage setImage:myimage forState:normal]; 
            }
            else if ([recipientgender intValue]==8)
            {
                UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                [btnImage setImage:myimage forState:normal]; 
            }
            else
            {
                UIImage *myimage =[UIImage imageNamed:@"man.png"];
                [btnImage setImage:myimage forState:normal]; 
            }
        }
    }
    
    btnImage.layer.cornerRadius = 5; // this value vary as per your desire
    btnImage.clipsToBounds = YES;
    sendChat = NO;
    firstTime =  YES;
    [self getNewChats];
    [self ShowIndicatorView:@"Loading..."];
    self.view.userInteractionEnabled=NO;
    
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (self.interfaceOrientation==UIInterfaceOrientationLandscapeRight||self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft)
        {
            [toolBarBottom setFrame:CGRectMake(0, 700, 1024, 50)];
        }
        else
        {
            [toolBarBottom setFrame:CGRectMake(0, 955, 768, 50)];
        }
    }*/
    //else
    //{
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            // iPhone Classic
            [toolBarBottom setFrame:CGRectMake(0, 436, 320,44)];
        }
        if(result.height == 568)
        {
            // iPhone 5
            [toolBarBottom setFrame:CGRectMake(0,526,320,44)];
        }
    //}
}

- (void)viewDidUnload
{
    [self setSampleTxtView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    // Return YES for supported orientations
    /*[txtFldChat resignFirstResponder];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (interfaceOrientation==UIInterfaceOrientationLandscapeRight||interfaceOrientation==UIInterfaceOrientationLandscapeLeft)
        {
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [toolBarBottom setFrame:CGRectMake(0, 700, 1024, 50)];
        }
        else
        {
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [toolBarBottom setFrame:CGRectMake(0, 955, 768, 50)];
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
    [respData setLength:0 ];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [respData appendData:data];
    indicatorView.hidden=YES;
    self.view.userInteractionEnabled=YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    indicatorView.hidden=YES;
    self.view.userInteractionEnabled=YES;
    btnSend.enabled=YES;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    return;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSString *responseString = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
    NSError *error;
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    NSDictionary *json = [responseString JSONValue];
    [parser release];
    [responseString release];
   
    if(!responseString)
    {
        if (firstTime == YES) 
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to retrieve data from the site. Kindly try again after some time!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
    }
    else if(sendChat == NO)
    {
        indicatorView.hidden=YES;
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
        else if ([messegeStr isEqualToString:@"Membership denied"]||[messegeStr isEqualToString:@"Membership Denied"])
        {
            UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to receive/send the chats." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
        }
        else if ([messegeStr isEqualToString:@"Limit Exceeds"]||[messegeStr isEqualToString:@"Limit exceeds"])
        {
            NSString *val=[NSString stringWithFormat:@"You have exceeded the chat sessions limit for the day (%@ per day).",[parsedData objectForKey:@"Limit"]];
            UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:val delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
        }                                                               
        resultCount = (NSString*)[parsedData objectForKey:@"count"];
        [resultCount retain];
        if ([resultCount intValue] == 0 )
        {
            if (firstTime == YES)
            {
                firstTime = NO;
                 
            }
            
        }
        else
        {
            NSArray *chatMsgIds = [json valueForKeyPath:@"result.im_message_id"];
            chatMsgId=[[NSMutableArray alloc] initWithArray:chatMsgIds copyItems:YES];
            NSArray *textMsg = [json valueForKeyPath:@"result.text"];
            text=[[NSMutableArray alloc] initWithArray:textMsg copyItems:YES];
            NSArray *msgTimeStamp = [json valueForKeyPath:@"result.Time"];
            timestamp=[[NSMutableArray alloc] initWithArray:msgTimeStamp copyItems:YES];
            NSArray *statuses = [json valueForKeyPath:@"result.chat"];
            status=[[NSMutableArray alloc] initWithArray:statuses copyItems:YES];
            [messageList reloadData];
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([chatMsgId count] -1) inSection:0];
            [messageList scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            lblDateTime.text = [timestamp objectAtIndex:0];
        }  
    }
    else
    {
        sendChat=NO;  
        btnSend.enabled=YES;    
        NSString *message = (NSString*)[parsedData objectForKey:@"Message"];        
        if(!parsedData)
        {
            if (firstTime == YES) 
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to retrieve data from the site. Kindly try again after some time!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
            }
        }
        else if([message isEqualToString:@"Site suspended"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=1;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
            
        }
        else if([message isEqualToString:@"Session Expired"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=1;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([message isEqualToString:@"Membership denied"]||[message isEqualToString:@"Membership Denied"])
        {
            NSString *Membership=(NSString*)[parsedData objectForKey:@"Type"];
            NSString *strAlert=@"";
            if ([Membership isEqualToString:@"Recipient"])
            {
                strAlert=@"You are not able to send chat to free members.";
            }
            else
            {
                strAlert=@"Please upgrade your membership to send chats.";
            }
            UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[strAlert description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
        }
        else if ([message isEqualToString:@"Limit Exceeds"]||[message isEqualToString:@"Limit exceeds"])
        {
            NSString *val=[NSString stringWithFormat:@"You have exceeded the chat sessions limit for the day (%@ per day).",[parsedData objectForKey:@"Limit"]];
            UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:val delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
        }
        else if(![message isEqualToString:@"Success"] )
        {
            if ( (message == (id)[NSNull null]) || (message == NULL) || ([message isEqual:@""]) || ([message length] == 0) )
            {
                txtFldChat.text=@"";
                [self getNewChats];
                return ;
            }  
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Not able to send chat. Kindly re-try after some time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
            }
            
        }
        else
        {
            txtFldChat.text=@"";
            [self getNewChats];
        }
    }
}

#pragma mark Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:
(NSInteger)section
{
    return ( text == nil ) ? 0 : [text count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    if (!boolHeight)
    {
        if ([[text objectAtIndex:indexPath.row] length]<23)
        {
            return 90; 
        }
        else if ([[text objectAtIndex:indexPath.row] length]<46)
        {
            return 105; 
        }
        else if ([[text objectAtIndex:indexPath.row] length]<69)
        {
            return 118; 
        }
        else if ([[text objectAtIndex:indexPath.row] length]<92)
        {
            return 136; 
        }
        else if ([[text objectAtIndex:indexPath.row] length]<115) 
        {
            return 146; 
        }
        else if ([[text objectAtIndex:indexPath.row] length]<138) 
        {
            return 165; 
        }
        else
            return 90;
    }
    else
    {
        boolHeight=NO;
        return 90;
    }
}

- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = (UITableViewCell *)[self.messageList 
                                                dequeueReusableCellWithIdentifier:@"ChatListItemLeft"];
    if ([[status objectAtIndex:indexPath.row] isEqualToString:@"receiving"]) 
    {
        if (cell == nil) 
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatListItemLeft" 
                                                         owner:self options:nil];
            cell = (UITableViewCell *)[nib objectAtIndex:0];
            UILabel *textLabel = (UILabel *)[cell viewWithTag:1];
            textLabel.font=[UIFont fontWithName:@"Ubuntu-Bold" size:14];
            textLabel.textColor =[UIColor darkGrayColor]; 
            textLabel.textAlignment=NSTextAlignmentLeft;
            textLabel.text = [text objectAtIndex:indexPath.row];
            UIButton *profileImg = (UIButton *)[cell viewWithTag:4];
            [profileImg setImage:btnImage.imageView.image forState:normal];
            profileImg.layer.cornerRadius = 5; // this value vary as per your desire
            profileImg.clipsToBounds = YES;
            UILabel *timeLabel = (UILabel *)[cell viewWithTag:3];
            timeLabel.textAlignment=NSTextAlignmentLeft;
            timeLabel.textColor=[UIColor grayColor];
            NSString *time=[NSString stringWithFormat:@"%@",[timestamp objectAtIndex:indexPath.row]];
            timeLabel.text=[self FormatTime:time];
            
            // Adjust size
            CGSize maximumLabelSize ;
            CGSize expectedLabelSize;
            UIImageView *imgview=(UIImageView *)[cell viewWithTag:2];
            maximumLabelSize = CGSizeMake(190,125);
            
            CGRect expected2 = [textLabel.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Ubuntu-Bold" size:14] } context:nil];
            expectedLabelSize = expected2.size;
            
            CGRect frameRect = textLabel.frame;
            frameRect.size.width = expectedLabelSize.width+20;
            frameRect.size.height = expectedLabelSize.height+7;
            frameRect.origin.x=textLabel.frame.origin.x+5;
            frameRect.origin.y=imgview.frame.origin.y;            
            textLabel.frame = frameRect;
            CGRect frameRect1 = imgview.frame;
            frameRect1.size.width = expectedLabelSize.width+35;
            frameRect1.size.height = expectedLabelSize.height+17;
            frameRect1.origin.x=imgview.frame.origin.x;
            frameRect1.origin.y=imgview.frame.origin.y;  
            imgview.frame=frameRect1;
            CGRect frameRect3 = profileImg.frame;
            frameRect3.origin.y=(imgview.frame.origin.y+imgview.frame.size.height+5);  
            profileImg.frame=frameRect3;
            CGRect frameRect2 = timeLabel.frame;
            frameRect2.origin.y=(imgview.frame.origin.y+imgview.frame.size.height+5);  
            timeLabel.frame=frameRect2;
        }
    }
    else
    {
        if (cell == nil)
        {
            NSArray *nib1 = [[NSBundle mainBundle] loadNibNamed:@"ChatListItemRight" 
                                                          owner:self options:nil];
            cell = (UITableViewCell *)[nib1 objectAtIndex:0];
            UILabel *textLabel = (UILabel *)[cell viewWithTag:1];
            textLabel.font=[UIFont fontWithName:@"Ubuntu-Bold" size:14];
            textLabel.textColor =[UIColor blackColor]; 
            textLabel.textAlignment=NSTextAlignmentRight;
            textLabel.text = [text objectAtIndex:indexPath.row];
            UILabel *timeLabel = (UILabel *)[cell viewWithTag:3];
            timeLabel.textAlignment=NSTextAlignmentRight;
            timeLabel.textColor=[UIColor grayColor];
            NSString *time=[NSString stringWithFormat:@"%@",[timestamp objectAtIndex:indexPath.row]];
            timeLabel.text=[self FormatTime:time];
            UILabel *nameLabel = (UILabel *)[cell viewWithTag:4];
            nameLabel.textAlignment=NSTextAlignmentLeft;
            nameLabel.text=@"Me";
            
            // Adjust size
            
            CGSize maximumLabelSize ;
            CGSize expectedLabelSize;
            UIImageView *imgview=(UIImageView *)[cell viewWithTag:2];
            maximumLabelSize = CGSizeMake(190,125);

            CGRect expected2 = [textLabel.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Ubuntu-Bold" size:14] } context:nil];
            expectedLabelSize = expected2.size;
            
            CGRect frameRect = textLabel.frame;
            frameRect.size.width = expectedLabelSize.width+20;
            frameRect.size.height = expectedLabelSize.height+7;
            frameRect.origin.x = (textLabel.frame.origin.x+(textLabel.frame.size.width-frameRect.size.width));
            frameRect.origin.y=imgview.frame.origin.y;            
            textLabel.frame = frameRect;
            CGRect frameRect1 = imgview.frame;
            frameRect1.size.width = expectedLabelSize.width+25;
            frameRect1.size.height = expectedLabelSize.height+17;
            frameRect1.origin.x = (imgview.frame.origin.x+(imgview.frame.size.width-frameRect1.size.width));
            frameRect1.origin.y=imgview.frame.origin.y;  
            imgview.frame=frameRect1;
            CGRect frameRect2 = timeLabel.frame;
            frameRect2.origin.y=(imgview.frame.origin.y+imgview.frame.size.height+5);  
            timeLabel.frame=frameRect2;
            CGRect frameRect3 = nameLabel.frame;
            frameRect3.origin.y=(imgview.frame.origin.y+imgview.frame.size.height+5);  
            nameLabel.frame=frameRect3;
        }    
    }
    return cell;
}

#pragma mark-UIAlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1&&buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark -IBAction

-(IBAction)clickedImageButton:(id)sender
{
    if(timer)
    {
        [timer invalidate];
        timer = nil;
        [timer release];
    }
    connection=nil;
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clickedHomeButton:(id)sender
{
    if(timer)
    {
        [timer invalidate];
        timer = nil;
        [timer release];
    }
    HomeView *objHomeView=[[HomeView alloc]initWithNibName:@"HomeView" bundle:nil];
    [self.navigationController pushViewController:objHomeView animated:NO];
    [objHomeView release];
}

-(IBAction)clickedSendButton:(id)sender
{
    // For checking white space
    NSString *trimmedString = [txtFldChat.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
   
    if ([trimmedString length]==0)
    {
        txtFldChat.text=@"";
        return;
    }
    
    btnSend.enabled=NO;
    firstTime = NO;
    sendChat=YES;  
    [txtFldChat resignFirstResponder];
        
    urlReq = [NSString stringWithFormat:@"%@/mobile/PrivateChatMsgSending/?sid=%@&skey=%@&rid=%@&msg=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,receipientProfileId,txtFldChat.text];
    NSURL *url = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    connection = [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease]; 
    [self ShowIndicatorView:@"Sending..."];
    
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations : @"Display notif" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:FALSE];
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (self.interfaceOrientation==UIInterfaceOrientationLandscapeRight||self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft)
        {
            [toolBarBottom setFrame:CGRectMake(0, 346, 1024, 50)];
        }
        else
        {
            [toolBarBottom setFrame:CGRectMake(0, 695, 768, 50)];
        }
    }*/
    //else
    //{
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            // iPhone Classic
            toolBarBottom.frame = CGRectMake(0, 214, 320, 50);
        }
        if(result.height == 568)
        {
            // iPhone 5
            [toolBarBottom setFrame:CGRectMake(0,308,320,44)];
        }
    //}
    [UIView commitAnimations];
}

- (IBAction)textFieldDidEndEditing:(UITextField *)textField
{    
    [UIView beginAnimations : @"Display notif" context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:FALSE];
        
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (self.interfaceOrientation==UIInterfaceOrientationLandscapeRight||self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft)
        {
            [toolBarBottom setFrame:CGRectMake(0, 700, 1024, 50)];
        }
        else
        {
            [toolBarBottom setFrame:CGRectMake(0, 955, 768, 50)];
        }
    }*/
    //else
    //{
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            // iPhone Classic
            [toolBarBottom setFrame:CGRectMake(0, 436, 320,44)];
        }
        if(result.height == 568)
        {
            // iPhone 5
            [toolBarBottom setFrame:CGRectMake(0,526,320,44)];
        }
    //}
    [UIView commitAnimations];
}

- (IBAction)textFieldChatEdited:(id)sender
{
    if ([txtFldChat.text length]>0)
    {
        btnSend.enabled=YES;
    }
    else
    {
        btnSend.enabled=NO;
    }
}

#pragma mark Text Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if (newLength > 125)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Chat can not exceed 125 characters! Kindly press return key." delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return NO;
    }
    else
        return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==txtFldChat)
    {       
        [txtFldChat resignFirstResponder];
    }
    return YES;
}

@end

