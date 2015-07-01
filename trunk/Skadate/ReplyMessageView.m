//
//  ReplyMessageView.m
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ReplyMessageView.h"
#import "JSON.h"
#import "SkadateAppDelegate.h"


@implementation ReplyMessageView
@synthesize NewXval;
@synthesize btnCancel,replyTxtLabel,indicatorView,indicatorLabel,objIndicatorView;
@synthesize btnSend,messageTxt,replyMessageTxt,messageTextView,rplyMessageTxt,scroller,mesageId,domain;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    scroller.contentSize=CGSizeMake(320,1100);
    scroller.canCancelContentTouches = NO;
    [scroller flashScrollIndicators];
    replyMessageTxt.layer.cornerRadius = 10;
    replyMessageTxt.layer.borderWidth = 2.0f;
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    replyMessageTxt.layer.borderColor =[[UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:5.0]CGColor];
    replyMessageTxt.backgroundColor=[UIColor colorWithRed:245/255.0 green:242/255.0 blue:242/255.0 alpha:5.0];
    messageTxt.text=messageTextView;
    messageTxt.textColor=[UIColor colorWithRed:111/255.0 green:109/255.0 blue:109/255.0 alpha:2.0];
    replyTxtLabel.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [replyTxtLabel setTextAlignment:NSTextAlignmentCenter];
    replyTxtLabel.text=[NSString stringWithFormat:@"Re: %@",rplyMessageTxt];
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
        if (interfaceOrientation==UIDeviceOrientationLandscapeRight || interfaceOrientation==UIDeviceOrientationLandscapeLeft)
        {
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
        }
        else 
        {
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
        }
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
        
        if (([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeRight||([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeLeft)
        {
            
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            
            
		}
        else
        {
            
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            
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


#pragma mark IBAction

-(IBAction)clickedCancelButton:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clickedSendButton:(id) sender
{
    [replyMessageTxt resignFirstResponder];
    [messageTxt resignFirstResponder];
    respData = [[NSMutableData data] retain];
    replyMessageTxt.layer.borderWidth=1.0f;
    replyMessageTxt.layer.cornerRadius = 5;
    replyMessageTxt.layer.borderColor = [UIColor colorWithRed:171.0/255.0 green:171.0/255.0 blue:171.0/255.0 alpha:1.0].CGColor;
    replyMessageTxt.clipsToBounds = YES;
    NSString *newText = [replyMessageTxt.text stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
     NSString *newText1 = [newText stringByReplacingOccurrencesOfString:@"#" withString:@"%23"];
    NSString *req = [NSString stringWithFormat:@"%@/mobile/ReplyMessage/?id=%@&skey=%@&mid=%@&msg=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,mesageId,newText1];
         
    NSURL *url = [NSURL URLWithString:[req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
    [self ShowIndicatorView:@"Sending..."];    
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
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	return;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    indicatorView.hidden=YES;
    NSString *responseString = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
 	NSError *error;
	SBJsonParser *parser = [[SBJsonParser alloc] init];
 	NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    [responseString release];
    CFRelease((CFTypeRef) parser);
    NSString *sendMsg=(NSString*)[parsedData objectForKey:@"Message"];
   
    if([sendMsg isEqualToString:@"Site suspended"])
    {
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
        UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        sessionAlertView.tag=2;
        [sessionAlertView show];
        [sessionAlertView release];
        return;
    } 
    else if ([sendMsg isEqualToString:@"Session Expired"])
    {
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
        UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        sessionAlertView.tag=2;
        [sessionAlertView show];
        [sessionAlertView release];
        return;
    }
    else if ([sendMsg isEqualToString:@"Membership denied"]||[sendMsg isEqualToString:@"Membership Denied"])
    {
        UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to send  the message." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        MembershipAlertView.tag=3;
        [MembershipAlertView show];
        [MembershipAlertView release];
        return;
    }
    else if ([sendMsg isEqualToString:@"Your profile has been blocked"])
    {
        UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"You are blocked by this user. You cannot message to this user." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [MembershipAlertView show];
        MembershipAlertView.tag=3;
        [MembershipAlertView release];
        return;
    }
    else if ([sendMsg isEqualToString:@"Success"]) 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:[@"Successfully sent the message." description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alertView.tag=1;
        [alertView show];
        [alertView release];
    }
    else if ([sendMsg isEqualToString:@"Message Exceed"])
    {
        UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Sorry, you can send limited number of messages per day. Please upgrade." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [MembershipAlertView show];
        MembershipAlertView.tag=3;
        [MembershipAlertView release];
        return;
    }
    else if ([sendMsg isEqualToString:@"Error"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Failed to send, please try again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }    
}

#pragma mark AlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1&&buttonIndex==0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(actionSheet.tag==2&&buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if(actionSheet.tag==3&&buttonIndex==0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark Text Field Delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

@end
