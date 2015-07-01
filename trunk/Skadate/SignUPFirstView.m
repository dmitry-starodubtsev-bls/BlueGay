//
//  SignUPFirstView.m
//  Chk
//
//  Created by SODTechnologies on 29/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "SignUPFirstView.h"
#import "SkadateViewController.h"
#import "SignUPSecondView.h"
#import "JSON.h"
#import "SkadateAppDelegate.h"

static const int minUserLen=1;
static const int minPswLen=4;
static const int maxUserLen=40;
static const int maxPswLen=30;

@implementation SignUPFirstView

@synthesize btnSignIn;
@synthesize btnNext;
@synthesize objSkadateViewController;
@synthesize objSignUPSecondView;
@synthesize txtUsername;
@synthesize txtPassword;
@synthesize txtConfirmPassword;
@synthesize txtSiteURL;
@synthesize subView,indicatorView,indicatorLabel,objIndicatorView;
@synthesize strUsername;
@synthesize strURL;
@synthesize strPassword;
@synthesize strEncryptedPass,scrollview;
@synthesize SALT,usernamelab,passwordlab1,passwordlab2,siteurllab;
@synthesize imgView;
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

- (BOOL) validateUrl: (NSString *) testURL
{    
    NSString *urlRegEx = @"(http|https)://+[A-Za-z0-9.-]+([\\.|/]+((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx]; 
    return [urlTest evaluateWithObject:testURL];
}

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [subView setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
 
    //if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    //{
         scrollview.contentSize=CGSizeMake(0, 800);
    //}
    
    if ( [self siteUrlEmbedded] )
    {
        [txtSiteURL setHidden:YES];
        [siteurllab setHidden:YES];
        [imgView setImage:[UIImage imageNamed:@"bg_3.png"]];
        [imgView setFrame:(CGRectMake(10, 59, 320, 175))];
    }
    
    scrollview.contentSize=CGSizeMake(0, 500);
    scrollview.canCancelContentTouches = NO;
    signuplab.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    signuplab.text=@"Sign Up";
    usernamelab.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    passwordlab1.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    passwordlab2.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    siteurllab.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    txtConfirmPassword.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    txtPassword.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    txtSiteURL.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    txtUsername.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
}


-(void)viewWillAppear:(BOOL)animated
{        
    /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {        
        if (self.interfaceOrientation==UIInterfaceOrientationPortrait || self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) 
        {            
            scrollview.frame=CGRectMake(0, 44, 768, 936);
            scrollview.contentSize=CGSizeMake(768,938);
            [imgView setFrame:(CGRectMake(100, 60, 580, 240))];
            [usernamelab setFrame:CGRectMake(140, 70, 130, 50)];
            [passwordlab1 setFrame:CGRectMake(140, 130, 130, 50)];
            [passwordlab2 setFrame:CGRectMake(140, 190, 130, 50)];
            [siteurllab setFrame:CGRectMake(140, 250, 80, 50)];
            [txtUsername setFrame:CGRectMake(280, 75, 300, 40)];
            [txtPassword setFrame:CGRectMake(280, 135, 300, 40)];
            [txtConfirmPassword setFrame:CGRectMake(280, 195, 300, 40)];
            [txtSiteURL setFrame:CGRectMake(280, 250, 300, 40)];
            
        }
        else if (self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {            
            scrollview.frame=CGRectMake(0, 44, 1024, 724);
            scrollview.contentSize=CGSizeMake(1024,1200);
            [imgView setFrame:(CGRectMake(230, 60, 580, 240))];
            [usernamelab setFrame:CGRectMake(270, 70, 130, 50)];
            [passwordlab1 setFrame:CGRectMake(270, 130, 130, 50)];
            [passwordlab2 setFrame:CGRectMake(270, 190, 130, 50)];
            [siteurllab setFrame:CGRectMake(270, 250, 80, 50)];
            [txtUsername setFrame:CGRectMake(410, 75, 300, 40)];
            [txtPassword setFrame:CGRectMake(410, 135, 300, 40)];
            [txtConfirmPassword setFrame:CGRectMake(410, 195, 300, 40)];
            [txtSiteURL setFrame:CGRectMake(410, 250, 300, 40)];
        } 
        
    }*/
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if (interfaceOrientation==UIInterfaceOrientationPortrait || interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
        {
            scrollview.frame=CGRectMake(0, 44, 768, 936);
            scrollview.contentSize=CGSizeMake(768,938);
            [imgView setFrame:(CGRectMake(100, 60, 580, 240))];
            [usernamelab setFrame:CGRectMake(140, 70, 130, 50)];
            [passwordlab1 setFrame:CGRectMake(140, 130, 130, 50)];
            [passwordlab2 setFrame:CGRectMake(140, 190, 130, 50)];
            [siteurllab setFrame:CGRectMake(140, 250, 80, 50)];
            [txtUsername setFrame:CGRectMake(280, 75, 300, 40)];
            [txtPassword setFrame:CGRectMake(280, 135, 300, 40)];
            [txtConfirmPassword setFrame:CGRectMake(280, 195, 300, 40)];
            [txtSiteURL setFrame:CGRectMake(280, 250, 300, 40)];
            
        }
        else if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight) 
        {
            scrollview.frame=CGRectMake(0, 44, 1024, 724);
            scrollview.contentSize=CGSizeMake(1024,1200);
            [imgView setFrame:(CGRectMake(230, 60, 580, 240))];
            [usernamelab setFrame:CGRectMake(270, 70, 130, 50)];
            [passwordlab1 setFrame:CGRectMake(270, 130, 130, 50)];
            [passwordlab2 setFrame:CGRectMake(270, 190, 130, 50)];
            [siteurllab setFrame:CGRectMake(270, 250, 80, 50)];
            [txtUsername setFrame:CGRectMake(410, 75, 300, 40)];
            [txtPassword setFrame:CGRectMake(410, 135, 300, 40)];
            [txtConfirmPassword setFrame:CGRectMake(410, 195, 300, 40)];
            [txtSiteURL setFrame:CGRectMake(410, 250, 300, 40)];
        } 
        return YES;  
    }
    else
    {
        return NO;  
    }*/
 }


#pragma mark Text Field Delegates

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    //{
    //    return;
    //}
    int movementDistance = 50; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    if (textField.tag==4) 
    {
        movementDistance=movementDistance + 25;
    }
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    
    subView.frame= CGRectOffset(subView.frame, 0, movement);
    [UIView commitAnimations];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField==txtUsername) 
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if (newLength > 50) 
        {
            return NO;
        }
        else
        {
            NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789._"] invertedSet];
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
            return [string isEqualToString:filtered];
        }
    }
    else if (textField==txtPassword ) 
    {
        if ([txtPassword.text length]==0)
        {
            if([string isEqualToString:@" "])
            {
                return NO;
            }
            else
            {
                return YES;
            }
        }
        else
        {
            return YES;
        }
    }
    else if (textField==txtConfirmPassword) 
    {
        if ([txtConfirmPassword.text length]==0)
        {
            if([string isEqualToString:@" "])
            {
                return NO;
            }
            else
            {
                return YES;
            }
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return YES;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) 
    {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } 
    else 
    {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}


- (IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag==1)
    {
        return;
    }
    if (textField.tag==2) 
    {
        return;
    }
    [self animateTextField: textField up: YES];
}


- (IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    //{
    //    return;
    //}
    if (textField.tag==1) 
    {
        return;
    }
    if (textField.tag==2) 
    {
        return;
    }
    
    [self animateTextField: textField up: NO];
}


#pragma mark IBAction

- (IBAction)clickedSignInButton:(id)sender
{    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickedNextButton:(id)sender
{
    
    [self.txtUsername resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    [self.txtConfirmPassword resignFirstResponder];
    [self.txtSiteURL resignFirstResponder];
    
    if ([txtUsername.text length]==0 || [txtPassword.text length]==0 || [txtConfirmPassword.text length]==0 ||[txtSiteURL.text length]==0) 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Please fill all fields." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }  
    
    if ([txtUsername.text length]< minUserLen||[[txtUsername.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]<minPswLen) 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[[NSString stringWithFormat:@"Username must be atleast %i characters.",minUserLen]description]   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    if ([txtUsername.text length]> maxUserLen)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[[NSString stringWithFormat:@"Username should not exceed  %i characters.",maxUserLen]description]   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    if ([txtPassword.text length]<minPswLen||[[txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]<minPswLen) 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[[NSString stringWithFormat:@"Password must be atleast %i characters.",minPswLen] description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    if ([txtPassword.text length]>maxPswLen) 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[[NSString stringWithFormat:@"Password should not exceed %i characters.",maxPswLen] description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    else
    {
        NSString *rawString = [txtPassword text];
        NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
        if ([trimmed length] == 0)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Password should not be empty." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return;
        }
        else
        {
            // For checking white space
            NSString *trimmedString = [txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if ([trimmedString length]==0) 
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Please enter a valid password." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                return;
            }
        }
    }
    
    if (![txtPassword.text isEqualToString:txtConfirmPassword.text])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Password mismatch" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    // check if url embedded
    if ( [self siteUrlEmbedded] )
    {
        strURL = [self getSiteUrl];
    }
    else
    {
        NSString *siteURL = self.txtSiteURL.text;
        
        if ( ![siteURL hasPrefix:@"http://"] )
        {
            siteURL = [NSString stringWithFormat:@"http://%@", siteURL];
        }
        
        if ( ![self validateUrl:siteURL] )
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Please enter a valid website." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return;
        }
        
        strURL = siteURL;
    }
    

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setValue:strURL forKey:@"URL"];
    respData = [[NSMutableData data] retain];
    [self ShowIndicatorView:@"Contacting server..."]; 
    NSString *domain = @"http://blugay.net";
    NSString *req = [NSString stringWithFormat:@"%@/%@%@",domain,@"/mobile/Username/index.php?username=",txtUsername.text];
    NSURL *url = [NSURL URLWithString:req];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
    btnNext.enabled = NO;
    self.view.userInteractionEnabled=NO;
}

- (BOOL)siteUrlEmbedded
{
    NSString *urlKey;
    urlKey =[[NSBundle mainBundle] objectForInfoDictionaryKey:@"SKAPIURL"];
    
    return [urlKey length] != 0;
  //  return 1;
}

- (NSString *)getSiteUrl
{
     return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"SKAPIURL"];
   // return @"blugay.net";
}


#pragma mark Managing API Calls

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{    
	[respData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
       
    if ([error code]==-1003)
    {
        NSRange textRange = [[strURL lowercaseString] rangeOfString:@"www."];
        
        if(textRange.location == NSNotFound)
        {
            btnNext.enabled=YES;
            indicatorView.hidden=YES;
            self.view.userInteractionEnabled=YES;
        
            //Does contain the substring
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Invalid site." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return;
        }
        
        strURL=[strURL stringByReplacingOccurrencesOfString:@"www." withString:@""]; 
        respData = [[NSMutableData data] retain];
        [strURL retain];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setValue:strURL forKey:@"URL"];
        NSString *domain = @"http://blugay.net";
        NSString *req = [NSString stringWithFormat:@"%@/%@",domain,@"mobile/Init/"];
        NSURL *url = [NSURL URLWithString:req];
        NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
        [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
        self.view.userInteractionEnabled=NO;
        return;
        
    }
    
    btnNext.enabled = YES;
    indicatorView.hidden=YES;
    self.view.userInteractionEnabled=YES;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    return;
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    
    indicatorView.hidden=YES;
    btnNext.enabled=YES;
    self.view.userInteractionEnabled=YES;
    NSString *responseString = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
	NSError *error;
	SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    CFRelease((CFTypeRef) parser); 
    
    if (!responseString)
    {
        btnNext.enabled = YES;
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to retrieve data from the site. Kindly try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release]; 
        [responseString release];
    }
    else    
    {
        [responseString release];
        signUpResp.loginNameAvailStat=(NSString*) [parsedData objectForKey:@"Message"];
        SALT=(NSString*)[parsedData objectForKey:@"Salt"];
       
        if([signUpResp.loginNameAvailStat isEqualToString:@"Site suspended"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            btnNext.enabled=YES;
            sessionAlertView.tag=1;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        
        if (!SALT) 
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Entered site is not vallid" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            btnNext.enabled=YES;
            return;
        }
        
        if ((signUpResp.loginNameAvailStat==(NSString*)[NSNull null]) || [signUpResp.loginNameAvailStat isEqualToString:@"Username Already Taken"])
        {
            btnNext.enabled = YES;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username already existing.." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release]; 
            return;
        }
        else 
        {
            btnNext.enabled=YES;
            objSignUPSecondView=[[SignUPSecondView alloc]initWithNibName:@"SignUPSecondView" bundle:nil];
            objSignUPSecondView.username = txtUsername.text;
            objSignUPSecondView.password = txtPassword.text;
            //objSignUPSecondView.siteSALT=SALT;
            [self.navigationController pushViewController:objSignUPSecondView animated:YES];
        }
        
    }
    
}


#pragma mark Alert View Delegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{    
    if (actionSheet.tag==1&&buttonIndex==0) 
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}



@end
