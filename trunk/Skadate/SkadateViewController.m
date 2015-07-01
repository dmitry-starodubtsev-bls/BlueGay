//
//  SkadateViewController.m
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "SkadateAppDelegate.h"
#import "SkadateViewController.h"
#import "SignUPFirstView.h"
#import "HomeView.h"
#import "ForgotPassword.h"
#import "JSON.h"

@implementation SkadateViewController
/*@synthesize textFldUsername;
@synthesize textFldPassword;
@synthesize textFldURL;
@synthesize btnSignIn;
@synthesize btnSignUp;
@synthesize btnFrgtPwd;
@synthesize subView,indicatorView,indicatorLabel,objIndicatorView;
@synthesize navBar;
@synthesize lblNavTitle;
@synthesize imgView;
@synthesize lblEmail;
@synthesize lblPassword;
@synthesize lblSite;
@synthesize tempScrollView;
@synthesize strUsername;
@synthesize strURL;
@synthesize strPassword;
@synthesize strEncryptedPass;
@synthesize SALT;*/

#pragma mark Memory Management

- (void)dealloc
{
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

- (void)ShowIndicatorView:(NSString *)DiaplayText 
{
    // fixing the activity indicator
    self.objIndicatorView =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.objIndicatorView.frame = CGRectMake(10, 10, self.objIndicatorView.bounds.size.width, self.objIndicatorView.bounds.size.height);
  
    self.indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.objIndicatorView.bounds.size.width +15), 10, 150, self.objIndicatorView.bounds.size.height)];
    
    self.indicatorLabel.backgroundColor = [UIColor clearColor];
    self.indicatorLabel.textColor = [UIColor darkGrayColor];
    self.indicatorLabel.adjustsFontSizeToFitWidth = YES;
    self.indicatorLabel.textAlignment = NSTextAlignmentCenter;
    self.indicatorLabel.text =DiaplayText ;

    self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(65, 400,  (self.objIndicatorView.frame.size.width+self.indicatorLabel.frame.size.width+30),(self.objIndicatorView.frame.size.height+20))];
    
    self.indicatorView.backgroundColor = [UIColor clearColor];
    self.indicatorView.clipsToBounds = YES;
    self.indicatorView.layer.cornerRadius = 5.0;
    
    [self.indicatorView addSubview:self.objIndicatorView];
    [self.indicatorView addSubview:self.indicatorLabel];
    [self.view addSubview:self.indicatorView];
    [self.view bringSubviewToFront:self.indicatorView];
    [self.objIndicatorView startAnimating];
    [self.indicatorView addSubview:self.objIndicatorView];
    [self.indicatorView addSubview:self.indicatorLabel];
    [self.view addSubview:self.indicatorView];
    [self.view bringSubviewToFront:self.indicatorView];
    [self.objIndicatorView startAnimating];
    
}

- (NSString *)stringToSha1:(NSString *)str
{    
    const char *s = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    // This is the destination
    uint8_t digest[CC_SHA1_DIGEST_LENGTH] = {0};
    /// This one function does an unkeyed SHA1 hash of your hash data
    CC_SHA1(keyData.bytes, (int)keyData.length, digest);
    
    // Now convert to NSData structure to make it usable again
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    // description converts to hex but puts <> around it and spaces every 4 bytes
    NSString *hash = [out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    return hash;
}

- (BOOL) validateUrl: (NSString *) testURL 
{    
    NSString *urlRegEx = @"(http|https)://+[A-Za-z0-9.-]+([\\.|/]+((\\w)*|([0-9]*)|([-|_])*))+";
    
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx]; 
    return [urlTest evaluateWithObject:testURL];
}

/*-(void)iPadOrientation
{    return;
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) 
    {
        if (self.interfaceOrientation==UIInterfaceOrientationPortrait || self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) 
        {
            
            indicatorView.frame = CGRectMake(250, 310, 300, 300);
            [tempScrollView setFrame:(CGRectMake(0, 44, 768, 980))];
            tempScrollView.contentSize=CGSizeMake(768, 980);
            
            [imgView setFrame:(CGRectMake(84, 60, 600, 110))];
            [textFldUsername setFrame:CGRectMake(220, 70, 535, 60)];
            [textFldPassword setFrame:CGRectMake(220, 105, 535, 60)];
            [textFldURL setFrame:CGRectMake(114, 152, 535, 60)];
            
            [btnFrgtPwd setFrame:(CGRectMake(520, 230, 150, 37))];
            [btnSignIn setFrame:(CGRectMake(231, 280, 306, 46))];
        }
        else if (self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            
            indicatorView .frame=CGRectMake(364, 234, 300, 300);
            [tempScrollView setFrame:(CGRectMake(0, 44, 1024, 724))];
            tempScrollView.contentSize=CGSizeMake(1024, 724);
            
            [imgView setFrame:(CGRectMake(212, 60, 600, 150))];
            
            [textFldUsername setFrame:CGRectMake(237, 60, 535, 60)];
            [textFldPassword setFrame:CGRectMake(237, 105, 535, 60)];
            [textFldURL setFrame:CGRectMake(237, 152, 535, 60)];
            
            [btnFrgtPwd setFrame:(CGRectMake(642, 230, 150, 37))];
            [btnSignIn setFrame:(CGRectMake(359, 280, 306, 46))];
            
        } 
    }
}*/



#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad
{
    
    self.navigationController.navigationBarHidden=YES;
    self.strUsername =[[NSString alloc]init] ;
    self.strPassword =[[NSString alloc]init];
    self.strURL = [[NSString alloc]init];
    
            
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [self.subView setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [self.imgView setBackgroundColor:[UIColor clearColor]];
    
    [self.navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    self.navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    self.navBar.layer.borderWidth=1.0f;
    self.lblNavTitle.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    self.lblEmail.font=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontHomeTitle;
    self.lblPassword.font=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontHomeTitle;
    self.lblSite.font=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontHomeTitle;
    
    [self.lblNavTitle setText:@"Sign In"];
    
    self.textFldUsername.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    self.textFldPassword.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    self.textFldURL.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    
    if ( [self siteUrlEmbedded] )
    {
        [self.textFldURL setHidden:YES];
        [self.imgView setImage:[UIImage imageNamed:@"bg_2.png"]];
        [self.imgView setFrame:(CGRectMake(10, 69, 299, 110))];
    }
    else
    {
        [self.textFldURL setDelegate:self];
        [self.textFldURL setTag:3];
    }
    
    [self.tempScrollView setContentMode:UIViewContentModeScaleAspectFit];
    [self.tempScrollView sizeToFit];

    self.tempScrollView.contentSize=CGSizeMake(300,418);
    
      NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    /*   [prefs setValue:textFldUsername.text forKey:@"Username"];
     [prefs setValue:textFldPassword.text forKey:@"Password"];*/
    
    
    NSString *username = [prefs objectForKey:@"Username"];
    NSString *password = [prefs objectForKey:@"Password"];
    
    self.remember.on =[[NSUserDefaults standardUserDefaults] boolForKey:@"remember"];
      self.textFldUsername.text=username;
     self.textFldPassword.text=password;
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"remember"]) {
        [self clickedSignInButton:nil];

    }
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] 
     postNotificationName:@"InvalidateHomePageTimers" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[self iPadOrientation];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
       
    //if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    //{
        //[self iPadOrientation];
        
    //}
    
}*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    // Return YES for supported orientations
    
    /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {        
        //[self iPadOrientation];
        return YES;  
    }
    else 
    {
        return NO;  
    }*/
    
}


#pragma mark Text Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{      
    if (textField==self.textFldUsername)
    {        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        
        if (newLength > 50) 
        {            
            return NO;
        }
        else
        {            
            NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789._-@"] invertedSet];
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
            return [string isEqualToString:filtered];
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
    
    if (textField.tag!=3) 
    {
        return;
    }
    //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    //{
    //    return;
    //}
    [self.tempScrollView setContentOffset:CGPointMake(0,40) animated:YES];

}

- (IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag!=3) 
    {
        return;
    }
   
    //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    //{
    //    return;
    //}
    [self.tempScrollView setContentOffset:CGPointMake(0,0) animated:YES];

}

#pragma mark -IBAction

- (IBAction)clickedSignInButton:(id)sender
{
    NSLog(@"login");
    [self.textFldUsername resignFirstResponder];
    [self.textFldPassword resignFirstResponder];
    [self.textFldURL resignFirstResponder];
    
    self.btnSignIn.enabled = NO;
    self.btnFrgtPwd.enabled = NO;
    self.strUsername = self.textFldUsername.text;
    self.strPassword = self.textFldPassword.text;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
   [prefs setBool:self.remember.on forKey:@"remember"];
    
    
    
    if ( [self siteUrlEmbedded] )
    {
        self.strURL = @"blugay.net";
    }
    else
    {
        self.strURL = @"blugay.net";
    }
    
    if ( [self.textFldUsername.text isEqualToString:@""] || [self.textFldPassword.text isEqualToString:@""] || (![self siteUrlEmbedded] && [self.textFldURL.text isEqualToString:@""]) )
    {
        self.btnSignIn.enabled=YES;
        //btnSignUp.enabled=YES;
        self.btnFrgtPwd.enabled=YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Please fill all fields." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if ( ![self.strURL hasPrefix:@"http://"] )
    {
        self.strURL = [NSString stringWithFormat:@"http://%@", self.strURL];
    }
    
    if ( ![self validateUrl:self.strURL] )
    {        
        self.btnSignIn.enabled = YES;
        self.btnFrgtPwd.enabled = YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Please enter a valid Website." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    self.responseData = [NSMutableData data];
    self.signinFlag = NO;
    
    [prefs setValue:self.strURL forKey:@"URL"];
    NSString *domain = [prefs stringForKey:@"URL"];
    NSString *req = [NSString stringWithFormat:@"%@/%@",domain,@"mobile/Init/"];
    NSURL *url = [NSURL URLWithString:[req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    
    [self ShowIndicatorView:@"Contacting server..."];  
    
    [[NSURLConnection alloc] initWithRequest:urlrequest delegate:self];
}


- (IBAction)clickedSignUpButton:(id)sender
{
    [self.textFldUsername resignFirstResponder];
    [self.textFldPassword resignFirstResponder];
    [self.textFldURL resignFirstResponder];
    SignUPFirstView *objSignUpFirstView=[[SignUPFirstView alloc]initWithNibName:@"SignUPFirstView" bundle:nil];
    [self.navigationController pushViewController:objSignUpFirstView animated:YES];
}


- (IBAction)clickedForgotPasswordButton:(id)sender
{
    ForgotPassword *objForgtPsw=[[ForgotPassword alloc]initWithNibName:@"ForgotPassword" bundle:nil];
    [self.navigationController pushViewController:objForgtPsw animated:YES];
}


#pragma mark Managing API Calls

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{    
    [self.responseData setLength:0];
}

- (BOOL)siteUrlEmbedded
{
    NSString *urlKey;
    urlKey =[[NSBundle mainBundle] objectForInfoDictionaryKey:@"SKAPIURL"];
    
  return [urlKey length] != 0;
   
}

- (NSString *)getSiteUrl
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"SKAPIURL"];
  //  return @"blugay.net";
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    [self.responseData appendData:data];
    self.indicatorView.hidden=YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{   
    self.btnSignIn.enabled=YES;
    //btnSignUp.enabled=YES;
    self.btnFrgtPwd.enabled=YES;
    if ([error code]==-1003)
    {
        NSRange textRange = [[self.strURL lowercaseString] rangeOfString:@"www."];
        
        if(textRange.location == NSNotFound)
        {
            self.indicatorView.hidden=YES;
            //Does contain the substring
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Invalid site." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        
        self.strURL=[self.strURL stringByReplacingOccurrencesOfString:@"www." withString:@""];
        self.responseData = [NSMutableData data];
        self.signinFlag = NO;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setValue:self.strURL forKey:@"URL"];
        
        
        NSString *domain = [prefs stringForKey:@"URL"];
        NSString *req = [NSString stringWithFormat:@"%@/%@",domain,@"mobile/Init/"];
        NSURL *url = [NSURL URLWithString:req];
       
        
        NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
        [[NSURLConnection alloc] initWithRequest:urlrequest delegate:self];
        return;
    }
    
    self.indicatorView.hidden=YES;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    return;
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    
    NSString *responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
           
    NSError *error;
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];

    if(!responseString||!parsedData)
    {
        self.btnSignIn.enabled=YES;

        self.btnFrgtPwd.enabled=YES;
        self.indicatorView.hidden=YES;
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to retrieve data from the site. Kindly re-enter login credentials." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        if (!self.signinFlag)
        {
            self.SALT=(NSString*)[parsedData objectForKey:@"Salt"];
            
            if([(NSString*)[parsedData objectForKey:@"Message"] isEqualToString:@"Site suspended"])
            {                
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                [sessionAlertView show];
                self.btnSignIn.enabled=YES;
                //btnSignUp.enabled=YES;
               self.btnFrgtPwd.enabled=YES;
                self.indicatorView.hidden=YES;
                return;
                
            }
            
            if (!self.SALT)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Entered site is not vallid" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];

                self.btnSignIn.enabled=YES;

                self.btnFrgtPwd.enabled=YES;
                self.indicatorView.hidden=YES;
                
                return;
            }
            self.strURL = @"http://blugay.net";
            self.strUsername = self.textFldUsername.text;
            self.strPassword = self.textFldPassword.text;
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:self.strURL forKey:@"URL"];

            
            NSString *domain = self.strURL;
            
            //strPassword=[NSString stringWithFormat:@"%@%@",SALT, strPassword];
            //strEncryptedPass = [self stringToSha1:strPassword];
            
            self.responseData = [NSMutableData data];
            
            NSLog(@"%@",domain);
            NSString *req = [NSString stringWithFormat:@"%@/mobile/SignIn/index.php?param=login&u=%@&p=%@&t=1", domain,self.strUsername, self.strPassword];
            
            self.signinFlag=YES;

            NSURL *url = [NSURL URLWithString:[req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
          
            NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
                      
            [self ShowIndicatorView:@"Contacting server..."];   
                       
            [[NSURLConnection alloc] initWithRequest:urlrequest delegate:self];

        }
        else 
        {
            self.respSignIn.profileId = (NSString*)[parsedData objectForKey:@"profile_id"];
            if ([self.respSignIn.profileId isEqualToString:@"NULL"]||[self.respSignIn.profileId isEqualToString:@"0."])
            {
                self.btnSignIn.enabled=YES;
                //btnSignUp.enabled=YES;
                self.btnFrgtPwd.enabled=YES;
                self.indicatorView.hidden=YES;
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR" message:[parsedData objectForKey:@"Message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                
                self.textFldUsername.text = nil;
                self.textFldPassword.text = nil;
                
            }
            
            /*if([(NSString*)[parsedData objectForKey:@"Message"] isEqualToString:@"Site suspended"])
            {                
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                [sessionAlertView show];
                [sessionAlertView release];
                btnSignIn.enabled=YES;
                //btnSignUp.enabled=YES;
                btnFrgtPwd.enabled=YES;
                indicatorView.hidden=YES;
                return;
                
            }*/

            
            else
            {
                
                
                
               // NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                
                /*   [prefs setValue:textFldUsername.text forKey:@"Username"];
                 [prefs setValue:textFldPassword.text forKey:@"Password"];*/
                
                
              
             //   NSString *password = [prefs objectForKey:@"Password"];

                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                
                  NSString *token = [prefs objectForKey:@"apnsToken"];
                [prefs setValue:self.textFldUsername.text forKey:@"Username"];
                [prefs setValue:self.textFldPassword.text forKey:@"Password"];
                [prefs setValue:self.strURL forKey:@"URL"];
                
              
                
                // hier Push Registrierung
                  NSString *domain = @"http://blugay.net";
                
                NSString *req2 = [NSString stringWithFormat:@"%@/mobile/Push_Reg/index.php?u=%@&p=%@&device_type=ios&device_token=%@",domain,self.textFldUsername.text,self.textFldPassword.text,token];
//                NSLog(req2);
                
                
                NSURL *url2 = [NSURL URLWithString:[req2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                NSURLResponse *response;
                NSError *error;
                NSURLRequest *urlrequest2 = [NSURLRequest requestWithURL:url2];
                [NSURLConnection sendSynchronousRequest:urlrequest2 returningResponse:&response error:&error];
                
                
                NSString *originalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
                [[NSFileManager defaultManager] removeItemAtPath:originalPath error:NULL];
                             
                self.respSignIn.profilePicURL = (NSString*)[parsedData objectForKey:@"Profile_Pic"];
                self.respSignIn.notifications = (NSNumber*)[parsedData objectForKey:@"Notifications"];
                self.respSignIn.gender = (NSString*)[parsedData objectForKey:@"sex"];
                self.respSignIn.skey = (NSString*)[parsedData objectForKey:@"skey"];
                self.respSignIn.TimeZone = (NSString*)[parsedData objectForKey:@"Time"];
               
                ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID=self.respSignIn.profileId;
                ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID=self.respSignIn.skey;
                ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfilePic=self.respSignIn.profilePicURL;
                
                ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications=0;
                ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).genderValue=self.respSignIn.gender;
                ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedTimeZone=self.respSignIn.TimeZone;
                              
                self.btnSignIn.enabled=YES;
            //     btnSignUp.enabled=YES;
                self.btnFrgtPwd.enabled=YES;
                self.indicatorView.hidden=YES;
                self.textFldUsername.text=@"";
                self.textFldPassword.text=@"";
                //test
         
                HomeView *objHomeView=[[HomeView alloc]initWithNibName:@"HomeView" bundle:nil];
                
                objHomeView.profileID=self.respSignIn.profileId;
                objHomeView.profilePic=self.respSignIn.profilePicURL;
                objHomeView.notifications=self.respSignIn.notifications;
                [self.navigationController pushViewController:objHomeView animated:YES];
            }
            
        }
        
    }
    
}


@end
