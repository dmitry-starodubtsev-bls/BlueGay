//
//  ForgotPassword.m
//  Chk
//
//  Created by kavitha on 31/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "ForgotPassword.h"
#import "SkadateViewController.h"
#import "SkadateAppDelegate.h"
#import "JSON.h"

@implementation ForgotPassword

@synthesize objSignInView;
@synthesize lblDefaultText;
@synthesize btnClose;
@synthesize mailID,indicatorView,indicatorLabel,objIndicatorView;
@synthesize lblNavTitle;
@synthesize navBar,lblforgotpass;
@synthesize imgView,siteUrlLbl,siteUrTF,strURL;
@synthesize NewXval;

#pragma mark Memory Management

- (void)dealloc
{
    [lblDefaultText release];
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
    
    /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        if (([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeRight||([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeLeft)
        {
            
            
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [imgView setFrame:(CGRectMake(230, 60, 600, 120))];
            [lblforgotpass setFrame:CGRectMake(255, 60, 80, 60)];
            [mailID setFrame:CGRectMake(355, 60, 400, 60)];
            [siteUrlLbl setFrame:CGRectMake(255, 117, 80, 60)];
            [siteUrTF setFrame:CGRectMake(355, 117, 400, 60)];
            [lblDefaultText setFrame:CGRectMake(230, 200, 600, 60)];
		}
        else
        {
            
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [imgView setFrame:(CGRectMake(100, 60, 600, 120))];
            [lblforgotpass setFrame:CGRectMake(125, 60, 80, 60)];
            [mailID setFrame:CGRectMake(225, 60, 400, 60)];
            [siteUrlLbl setFrame:CGRectMake(125, 117, 80, 60)];
            [siteUrTF setFrame:CGRectMake(225, 117, 400, 60)];
            [lblDefaultText setFrame:CGRectMake(100, 200, 600, 60)];
            
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

#pragma mark Validation Methods

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:email];
}

- (BOOL) validateUrl: (NSString *) testURL
{
    NSString *urlRegEx = @"(http|https)://+[A-Za-z0-9.-]+([\\.|/]+((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx]; 
    return [urlTest evaluateWithObject:testURL];
}

#pragma mark Text Field Delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
   
    if (![self validateEmailWithString:mailID.text]) 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Please enter a valid Email ID." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return YES;
    }
    
    if ( [self siteUrlEmbedded] )
    {
        strURL = [self getSiteUrl];
    }
    else
    {
        strURL = self.siteUrTF.text;
        if (![strURL hasPrefix:@"http://"])
        {
            strURL = [NSString stringWithFormat:@"http://%@", strURL];
        }
        
        if (![self validateUrl:strURL])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Please enter a valid Website." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return YES;
        }
    }
    
    respData = [[NSMutableData data] retain];
    NSString *req = [NSString stringWithFormat:@"%@/mobile/Forgot/index.php?email=%@",strURL,mailID.text];
    NSURL *url = [NSURL URLWithString:req];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    [self ShowIndicatorView:@"Sending..."];
    [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
   	return YES;
}

#pragma mark IBAction

- (IBAction)clickedCloseButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [objSignInView release];
}

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0 green:244/255.0 blue:243/255.0 alpha:1.0]];
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    lblNavTitle.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [lblNavTitle setText:@"Forgot Password?"];
    lblforgotpass.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;

    if ( [self siteUrlEmbedded] )
    {
        [siteUrTF setHidden:YES];
        [siteUrlLbl setHidden:YES];
        [imgView setImage:[UIImage imageNamed:@"bg_1.png"]];
        [imgView setFrame:(CGRectMake(10, 69, 299, 55))];
    }
}

- (void)viewDidUnload
{
    [self setLblDefaultText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if (interfaceOrientation==UIInterfaceOrientationPortrait || interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) 
        {
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [imgView setFrame:(CGRectMake(100, 60, 600, 120))];
            [lblforgotpass setFrame:CGRectMake(125, 60, 80, 60)];
            [mailID setFrame:CGRectMake(225, 60, 400, 60)];
            [siteUrlLbl setFrame:CGRectMake(125, 117, 80, 60)];
            [siteUrTF setFrame:CGRectMake(225, 117, 400, 60)];
            [lblDefaultText setFrame:CGRectMake(100, 200, 600, 60)];
        }
        else if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [imgView setFrame:(CGRectMake(230, 60, 600, 120))];
            [lblforgotpass setFrame:CGRectMake(255, 60, 80, 60)];
            [mailID setFrame:CGRectMake(355, 60, 400, 60)];
            [siteUrlLbl setFrame:CGRectMake(255, 117, 80, 60)];
            [siteUrTF setFrame:CGRectMake(355, 117, 400, 60)];
            [lblDefaultText setFrame:CGRectMake(230, 200, 600, 60)];
        } 
        return YES;  
    }
    else 
    {
        return NO;  
    }*/
}

- (BOOL)siteUrlEmbedded
{
    NSString *urlKey;
    urlKey =[[NSBundle mainBundle] objectForInfoDictionaryKey:@"SKAPIURL"];
    
    return [urlKey length] != 0;
    //return 1;
}

- (NSString *)getSiteUrl
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"SKAPIURL"];
  //  return @"blugay.net";
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
   	NSString *responseString = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
	NSError *error;
	SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    respForgotPw.frgtPwStatusMsg = (NSString*)[parsedData objectForKey:@"Message"];
    [parser release];
    if(!responseString)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to retrieve data from the site. Kindly re-enter the Email ID!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }
    else  if([respForgotPw.frgtPwStatusMsg isEqualToString:@"Site suspended"])
    {
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
        UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        sessionAlertView.tag=1;
        [sessionAlertView show];
        [sessionAlertView release];
    }
    else if ([respForgotPw.frgtPwStatusMsg isEqualToString:@"Email sent to given email address"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Password has been sent to the given Email address! Kindly re-enter the login credentials." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        SkadateViewController *objSkadateViewController=[[SkadateViewController alloc]initWithNibName:@"SkadateViewController" bundle:nil];
        [self.navigationController pushViewController:objSkadateViewController animated:YES];
        [objSkadateViewController release];
    }
    else if([respForgotPw.frgtPwStatusMsg isEqualToString:@"Error: Requires Valid Email"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"The e-mail address you entered is not valid." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        mailID.text = nil;
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Email ID provided does not match any ID in records! Kindly re-enter the Email ID." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        mailID.text = nil;
    }
    [responseString release];
}

#pragma mark-AlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1&&buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
