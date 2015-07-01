//
//  ComposeMessageView.m
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ComposeMessageView.h"
#import "MailBoxView.h"
#import "JSON.h"
#import "SkadateAppDelegate.h"
#import "CommonStaticMethods.h"

@implementation ComposeMessageView

@synthesize lblCharCount;
@synthesize btnCancel,tolab;
@synthesize domain;
@synthesize btnSend,respData,selectedprofileid,profilenamestring,userImage;
@synthesize txtFldSubject,txtFldTo,txtViewReply,indicatorView,indicatorLabel,resultArray,objIndicatorView,samplearray,profileIdArray,sortedArray,sortedprofileIdArray,thumbPicURLs,imagearray,profilePicUrl,sortedProfileImageArray,searchedSortedProfileImageArray,decision,genderArray,searchedprofileIdArray,userImageUrl,userGender,sortedProfilePicImageArray,profilePicImageArray,searchedSortedProfilePicImageArray,sortedgenderArray,searchedsortedgenderArray;
@synthesize NewXval;

#pragma mark Memory Management

- (void)dealloc
{
    [resultArray release];
    [sortedprofileIdArray release];
    [searchedprofileIdArray release];
    [sortedProfileImageArray release];
    [searchedSortedProfileImageArray release];
    [samplearray release];
    [profileIdArray release];
    toimageview.image=nil;
    [lblCharCount release];
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
            [table setFrame:CGRectMake(0,93,1028,675)];
            
            
		}
        else
        {
            
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [table setFrame:CGRectMake(0,93,768,935)];
            
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


-(void)LoadProfilePic
{
    if((userImageUrl== (id)[NSNull null])||(userImageUrl==NULL)||([userImageUrl isEqualToString:@""])||([userImageUrl length]==0))
    {
        if((userGender== (id)[NSNull null])||(userGender==NULL)||([userGender isEqualToString:@""])||([userGender length]==0))
        {
            toimageview.image=[UIImage imageNamed:@"man.png"];
        }
        else
        {
            if ([userGender intValue]==1)
            {
                toimageview.image=[UIImage imageNamed:@"women.png"];
            }
            else if ([userGender intValue]==2)
            {
                toimageview.image=[UIImage imageNamed:@"man.png"];
            }
            else if ([userGender intValue]==4)
            {
                toimageview.image=[UIImage imageNamed:@"man_women.png"];
            }
            else if ([userGender intValue]==8)
            {
                toimageview.image=[UIImage imageNamed:@"man_women_a.png"];
            }
            else
            {
                toimageview.image=[UIImage imageNamed:@"man.png"];
            }
        }
    }
    else
    {
        NSString *profilePicURL=[NSString stringWithFormat:@"%@%@",domain,userImageUrl];
        NSString *imageName=[NSString stringWithFormat:@"%@",userImageUrl];
        //imageName=[imageName stringByReplacingOccurrencesOfString:@"/$userfiles/" withString:@""];  // old version
        
        imageName=[imageName stringByReplacingOccurrencesOfString:@"/userfiles/" withString:@""];  // for new version
        
        NSString *originalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
        NSString *localFilePath = [originalPath stringByAppendingPathComponent:imageName];
        BOOL isDir=[CommonStaticMethods directoryExistsAtAbsolutePath:[originalPath stringByAppendingPathComponent:@"profile.png"]];
        if(!isDir)
        {
            [[NSFileManager defaultManager]createDirectoryAtPath: originalPath withIntermediateDirectories: YES attributes: nil error: NULL];
        }
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:localFilePath];
            if (!fileExists)
            {
                NSURL *imageURL1 = [[[NSURL alloc] initWithString:profilePicURL]autorelease];
                NSURLRequest *request = [NSURLRequest requestWithURL:imageURL1];
                [NSURLConnection connectionWithRequest:request delegate:self];
                NSData *thedata = [NSData dataWithContentsOfURL:imageURL1];
                [thedata writeToFile:localFilePath atomically:YES];
            }
            UIImage* image = [UIImage imageWithContentsOfFile:localFilePath];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(image)
                {
                    toimageview.image=image;
                }
                else
                {
                    if((userGender== (id)[NSNull null])||(userGender==NULL)||([userGender isEqualToString:@""])||([userGender length]==0))
                    {
                        toimageview.image=[UIImage imageNamed:@"man.png"];
                    }
                    else
                    {
                        if ([userGender intValue]==1)
                        {
                            toimageview.image=[UIImage imageNamed:@"women.png"];
                        }
                        else if ([userGender intValue]==2)
                        {
                            toimageview.image=[UIImage imageNamed:@"man.png"];
                        }
                        else if ([userGender intValue]==4)
                        {
                            toimageview.image=[UIImage imageNamed:@"man_women.png"];
                        }
                        else if ([userGender intValue]==8)
                        {
                            toimageview.image=[UIImage imageNamed:@"man_women_a.png"];
                        }
                        else 
                        {
                            toimageview.image=[UIImage imageNamed:@"man.png"];
                        } 
                    }
                }
            });
        });  
        dispatch_release(queue);
    }
}

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

#pragma mark View lifecycle

- (void)viewDidLoad
{
    sendFlag=NO;
    lblCharCount.text=@"256";
    [txtFldTo setDelegate:self];
    indicatorView.hidden=YES;
    selec=NO;
    clear=YES;
    txtViewReply.layer.cornerRadius = 5;
    txtViewReply.layer.borderColor = [UIColor colorWithRed:171.0/255.0 green:171.0/255.0 blue:171.0/255.0 alpha:1.0].CGColor;
    txtViewReply.clipsToBounds = YES;
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    newmessagelab.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [newmessagelab setTextAlignment:NSTextAlignmentCenter];
    toimageview=[[UIImageView alloc]initWithFrame:CGRectMake(38, 50, 40, 36)];
    toimageview.layer.cornerRadius=5.0;
    toimageview.layer.masksToBounds=YES;
  
    if(decision)
    {
        tolab.hidden=YES;
        newmessagelab.text=@"Mail To";
        toimageview.frame=CGRectMake(10, 70, 40, 36);
       txtFldTo.frame=CGRectMake(55, 72, 208, 31);
        [self.view addSubview:toimageview];
        if(userImage)
        {
            toimageview.image=userImage;
        }
        else
        {
            [self LoadProfilePic];
        }
        txtFldTo.font=[UIFont fontWithName:@"Ubuntu-Bold" size:17];
        [self.view addSubview:txtFldTo];
        txtFldTo.text=profilenamestring;
        [txtFldTo setUserInteractionEnabled:NO];
    }
    else
    {
        loading=YES;
        newmessagelab.text=@"New Message";
        [txtFldTo setDelegate:self];
        txtFldTo.frame=CGRectMake(38, 72, 208, 31);
        txtFldTo.font=[UIFont fontWithName:@"Ubuntu-Bold" size:17];
        [txtFldTo setUserInteractionEnabled:YES];
        [self.view addSubview:txtFldTo];
        resultArray=[[NSMutableArray alloc]init];
        sortedprofileIdArray=[[NSMutableArray alloc]init];
        searchedprofileIdArray=[[NSMutableArray alloc]init];
        sortedProfileImageArray=[[NSMutableArray alloc]init];
        searchedSortedProfileImageArray=[[NSMutableArray alloc]init];
        sortedProfilePicImageArray=[[NSMutableArray alloc]init];
        searchedSortedProfilePicImageArray=[[NSMutableArray alloc]init];
        sortedgenderArray=[[NSMutableArray alloc]init];
        searchedsortedgenderArray=[[NSMutableArray alloc]init];
        imagearray=[[NSMutableArray alloc]init ];
        thumbPicURLs=[[NSMutableArray alloc]init ];
        profilePicImageArray=[[NSMutableArray alloc]init ];
    }
    
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [self setLblCharCount:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (interfaceOrientation==UIInterfaceOrientationLandscapeRight||interfaceOrientation==UIInterfaceOrientationLandscapeLeft)
        {
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [table setFrame:CGRectMake(0,93,1028,675)];
        }
        else
        {
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [table setFrame:CGRectMake(0,93,768,935)];
        }
        return YES;
    }
    else
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }*/
}

#pragma mark IBActions

-(IBAction)sortingTextClick
{
    if (clear)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"firstcharacter"];
    }
    
    //if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad )
    //{
        [table setFrame:CGRectMake(0,120,320,380)];
    //}
    
    if(!selec)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *rawString = [prefs stringForKey:@"val"];
        NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
        int vallen = (int)[trimmed length];
        NSString *chr = [prefs stringForKey:@"firstcharacter"];
        if (vallen<3)
        {
            indicatorView.hidden=YES;
            table.hidden=YES;
            [samplearray removeAllObjects];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"firstcharacter"];
        }
        else if (vallen==3)
        {
            if ([trimmed length] == 0)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Please enter a valid name." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                return;
                indicatorView.hidden=YES;
            }
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            if (![chr isEqualToString:trimmed])
            {
                domain = [prefs stringForKey:@"URL"];
                respData = [[NSMutableData data] retain];
                firstchar= [trimmed substringToIndex:3];
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                [prefs setObject:firstchar forKey:@"firstcharacter"];       
                urlReq=[NSString stringWithFormat:@"%@/mobile/AllContacts_ByName/?id=%@&skey=%@&name=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,trimmed];
                NSURL *url = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
                [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
                [sortedProfilePicImageArray removeAllObjects];
                [self ShowIndicatorView:@"Loading..."]; 
                [txtFldTo resignFirstResponder];
                [self.view setUserInteractionEnabled:NO];
            }
        }
        else if(vallen>3)
        {
            NSString *rawString = trimmed;
            NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
            if ([trimmed length] == 0)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Please enter a valid name." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                return;
                indicatorView.hidden=YES;
            }
        }
        
        [searchedSortedProfileImageArray removeAllObjects];
        [resultArray removeAllObjects];
        [searchedprofileIdArray removeAllObjects];
        [searchedSortedProfilePicImageArray removeAllObjects];
        [searchedsortedgenderArray removeAllObjects];
       
        if ([chr isEqualToString:txtFldTo.text])
        {
            [resultArray addObjectsFromArray:samplearray];
            [searchedprofileIdArray addObjectsFromArray:sortedprofileIdArray];
            [searchedSortedProfilePicImageArray addObjectsFromArray:sortedProfilePicImageArray];
            [searchedSortedProfileImageArray addObjectsFromArray:sortedProfileImageArray ];
            [searchedsortedgenderArray addObjectsFromArray:sortedgenderArray];
            NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
            [def setObject:[NSKeyedArchiver archivedDataWithRootObject:searchedprofileIdArray] forKey:@"value"];
            [def setObject:[NSKeyedArchiver archivedDataWithRootObject:searchedSortedProfilePicImageArray] forKey:@"profileImage"];
            [def setObject:[NSKeyedArchiver archivedDataWithRootObject:searchedSortedProfileImageArray] forKey:@"image"];
            [def synchronize];
        }
        else
        {
            for(int i=0; i<[samplearray count]; i++)
            {
                NSRange prefixRange = [[samplearray objectAtIndex:i] rangeOfString:trimmed options:(NSAnchoredSearch | NSCaseInsensitiveSearch)];
                if ((prefixRange.location==0)&&(prefixRange.length>0))
                {
                    [resultArray addObject:[samplearray objectAtIndex:i]];
                    [searchedprofileIdArray addObject:[sortedprofileIdArray objectAtIndex:i]];
                    [searchedSortedProfilePicImageArray addObject:[sortedProfilePicImageArray objectAtIndex:i]];
                    [searchedSortedProfileImageArray addObject:[sortedProfileImageArray objectAtIndex:i]];
                    [searchedsortedgenderArray addObject:[sortedgenderArray objectAtIndex:i]];
                    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
                    [def setObject:[NSKeyedArchiver archivedDataWithRootObject:searchedprofileIdArray] forKey:@"value"];
                    [def setObject:[NSKeyedArchiver archivedDataWithRootObject:searchedSortedProfilePicImageArray] forKey:@"profileImage"];
                    [def setObject:[NSKeyedArchiver archivedDataWithRootObject:searchedSortedProfileImageArray] forKey:@"image"];
                    [def synchronize];
                }
            }
        }
        
        if ([resultArray count]>0)
        {
            table.hidden=NO;
        }
        else
        {
            table.hidden=YES;
        }
        
        [table reloadData];
        
    }
}

-(IBAction)clickedCancelButton:(id) sender
{
    [txtFldTo resignFirstResponder];
    [txtFldSubject resignFirstResponder];
    [txtViewReply resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clickedSendButton:(id) sender
{
    sendFlag=YES;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    respData = [[NSMutableData data] retain];
    [txtFldTo resignFirstResponder];
    [txtFldSubject resignFirstResponder];
    [txtViewReply resignFirstResponder];
   
    if ([((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID isEqualToString:[NSString stringWithFormat:@"%d",selectedprofileid]])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"You can not send message to yourself." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    NSString *rawString_msg = [txtViewReply text];
    NSCharacterSet *whitespace_msg = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed_msg = [rawString_msg stringByTrimmingCharactersInSet:whitespace_msg];
    NSString *rawString_sub = [txtFldSubject text];
    NSCharacterSet *whitespace_sub = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed_sub = [rawString_sub stringByTrimmingCharactersInSet:whitespace_sub];
   
    if ([txtFldTo.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Please fill To address." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else if(trimmed_sub.length==0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Subject should not be empty." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else if(trimmed_msg.length==0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Message should not be empty." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else if(trimmed_msg.length>256)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Message should not exceed 256 characters." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        if (![resultArray count]>0) 
        {
            if ([newmessagelab.text isEqualToString:@"New Message"])
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Username does not exists." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                return;
            }
        }
        if (table.hidden==YES)
        {
            btnSend.enabled=NO;
            btnCancel.enabled=NO;
            NSString *req = [NSString stringWithFormat:@"%@/mobile/ComposeNewMessage/?sender=%@&skey=%@&recipient=%d&sub=%@&msg=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,selectedprofileid,txtFldSubject.text,txtViewReply.text];
            NSURL *url = [NSURL URLWithString:[req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
            [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
            [self ShowIndicatorView:@"Sending..."];
        }
        else if (table.hidden==NO)
        {
            for (int i=0;i<[resultArray count]; i++)
            {
                if ([txtFldTo.text isEqualToString:[resultArray objectAtIndex:i]])
                {
                    selectedprofileid = [[searchedprofileIdArray objectAtIndex:i] intValue];
                }
            }
            btnSend.enabled=NO;
            btnCancel.enabled=NO;
            NSString *req = [NSString stringWithFormat:@"%@/mobile/ComposeNewMessage/?sender=%@&skey=%@&recipient=%d&sub=%@&msg=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,selectedprofileid,txtFldSubject.text,txtViewReply.text];
            NSURL *url = [NSURL URLWithString:[req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
            [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
            [self ShowIndicatorView:@"Sending..."];
        }
        
    }
    
}


#pragma mark Table View Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // returning the no of rows in section
    if ([resultArray count])
    {
        return [resultArray count];
    }
    else
    {
        return [samplearray count];
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     //for creating cell height
     return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    cell=nil;
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIImageView *imgview=[[[UIImageView alloc]initWithFrame:CGRectMake(7, 7, 40, 36)] autorelease];
    [cell addSubview:imgview];
    imgview.layer.cornerRadius=5.0;
    imgview.layer.masksToBounds=YES;
    imgview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imgview.layer.borderWidth = 1.0;
    CGRect frameName =CGRectMake(60,10, 250,30);
    lblOfName=[[UILabel alloc]initWithFrame:frameName];
   
    if ([resultArray count])
    {        
        lblOfName.text=[resultArray objectAtIndex:indexPath.row];
        NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
        NSString *imgName=(NSString *) [[NSKeyedUnarchiver unarchiveObjectWithData:[def objectForKey:@"image"]] objectAtIndex:indexPath.row];
        UIImage *myimage =[UIImage imageNamed:imgName];
        imgview.image=myimage;
    }
    else
    {
        lblOfName.text=[samplearray objectAtIndex:indexPath.row];
        UIImage *myimage =[UIImage imageNamed:[sortedProfileImageArray objectAtIndex:indexPath.row]];
        imgview.image=myimage;
    }
    
    lblOfName.font=[UIFont boldSystemFontOfSize:20];
    lblOfName.textColor =[UIColor blackColor]; 
    lblOfName.textAlignment=NSTextAlignmentLeft;
    //lblOfName.backgroundColor=[UIColor colorWithRed:235.0/255.0
    //                                          green:235.0/255.0
    //                                           blue:235.0/255.0
    //                                          alpha:1.0];
    [ cell addSubview: lblOfName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *profilePicUrl1;
    [self.view addSubview:toimageview];
    txtFldTo.frame=CGRectMake(90, 72, 208, 31);
    toimageview.frame=CGRectMake(40, 75, 30, 30);
    
    if ([resultArray count]) 
    {              
        txtFldTo.text=[resultArray objectAtIndex:indexPath.row];
        NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
        [def stringArrayForKey:@"value"];
        selectedprofileid = [[[def stringArrayForKey:@"value"] objectAtIndex:indexPath.row] intValue];
       
        if (([searchedsortedgenderArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([searchedsortedgenderArray objectAtIndex:indexPath.row]== NULL)||([[searchedsortedgenderArray objectAtIndex:indexPath.row] length]==0)||([searchedsortedgenderArray objectAtIndex:indexPath.row]== NULL))
        {
            if ( ([searchedsortedgenderArray objectAtIndex:indexPath.row] == (id)[NSNull null])
                || ([searchedsortedgenderArray objectAtIndex:indexPath.row] == NULL)
                || ([[searchedsortedgenderArray objectAtIndex:indexPath.row] isEqual:@""])
                || ([[searchedsortedgenderArray objectAtIndex:indexPath.row] length] == 0) )
            {
                UIImage *myimage =[UIImage imageNamed:@"man.png"];
                toimageview.image=myimage;
            }
            else
            {
                if ([[searchedsortedgenderArray objectAtIndex:indexPath.row] intValue]==1)
                {
                    UIImage *myimage =[UIImage imageNamed:@"women.png"];
                    toimageview.image=myimage;
                }
                else if ([[searchedsortedgenderArray objectAtIndex:indexPath.row] intValue]==2)
                {
                    UIImage *myimage =[UIImage imageNamed:@"man.png"];
                    toimageview.image=myimage;
                }
                else if ([[searchedsortedgenderArray objectAtIndex:indexPath.row] intValue]==4)
                {
                    UIImage *myimage =[UIImage imageNamed:@"man_women.png"];
                    toimageview.image=myimage;
                }
                else if ([[searchedsortedgenderArray objectAtIndex:indexPath.row] intValue]==8)
                {
                    UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                    toimageview.image=myimage;
                }
                else
                {
                    UIImage *myimage =[UIImage imageNamed:@"man.png"];
                    toimageview.image=myimage;
                }
            }
        }
        else
        {
            profilePicUrl1=[NSString stringWithFormat:@"%@/%@",domain,[searchedSortedProfilePicImageArray objectAtIndex:indexPath.row]];
            NSData *mydata = [[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:profilePicUrl1]] autorelease];
            if (mydata)
            {
                UIImage *myimage = [[[UIImage alloc] initWithData:mydata] autorelease];
                toimageview.image=myimage;
            }
            else
            {
                if ( ([searchedsortedgenderArray objectAtIndex:indexPath.row] == (id)[NSNull null])
                    || ([searchedsortedgenderArray objectAtIndex:indexPath.row] == NULL)
                    || ([[searchedsortedgenderArray objectAtIndex:indexPath.row] isEqual:@""])
                    || ([[searchedsortedgenderArray objectAtIndex:indexPath.row] length] == 0) )
                {
                    UIImage *myimage =[UIImage imageNamed:@"man.png"];
                    toimageview.image=myimage;
                }
                else
                {
                    if ([[searchedsortedgenderArray objectAtIndex:indexPath.row] intValue]==1)
                    {
                        UIImage *myimage =[UIImage imageNamed:@"women.png"];
                        toimageview.image=myimage;  
                    }
                    else if ([[searchedsortedgenderArray objectAtIndex:indexPath.row] intValue]==2)
                    {
                        UIImage *myimage =[UIImage imageNamed:@"man.png"];
                        toimageview.image=myimage;
                    }
                    else if ([[searchedsortedgenderArray objectAtIndex:indexPath.row] intValue]==4)
                    {
                        UIImage *myimage =[UIImage imageNamed:@"man_women.png"];
                        toimageview.image=myimage;
                    }
                    else if ([[searchedsortedgenderArray objectAtIndex:indexPath.row] intValue]==8)
                    {
                        UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                        toimageview.image=myimage;
                    }
                    else
                    {
                        UIImage *myimage =[UIImage imageNamed:@"man.png"];
                        toimageview.image=myimage;
                    }
                }
            }
        }
    }
    else
    { 
        if (([sortedgenderArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([sortedgenderArray objectAtIndex:indexPath.row]== NULL)||([[sortedgenderArray objectAtIndex:indexPath.row] length]==0)||([sortedgenderArray objectAtIndex:indexPath.row]== NULL))
        {
            if ( ([sortedgenderArray objectAtIndex:indexPath.row] == (id)[NSNull null])
                || ([sortedgenderArray objectAtIndex:indexPath.row] == NULL)
                || ([[sortedgenderArray objectAtIndex:indexPath.row] isEqual:@""])
                || ([[sortedgenderArray objectAtIndex:indexPath.row] length] == 0) )
            {
                UIImage *myimage =[UIImage imageNamed:@"man.png"];
                toimageview.image=myimage;
            }
            else
            {
                if ([[sortedgenderArray objectAtIndex:indexPath.row] intValue]==1)
                {
                    UIImage *myimage =[UIImage imageNamed:@"women.png"];
                    toimageview.image=myimage;
                }
                else if ([[sortedgenderArray objectAtIndex:indexPath.row] intValue]==2)
                {
                    UIImage *myimage =[UIImage imageNamed:@"man.png"];
                    toimageview.image=myimage;
                }
                else if ([[sortedgenderArray objectAtIndex:indexPath.row] intValue]==4)
                {
                    UIImage *myimage =[UIImage imageNamed:@"man_women.png"];
                    toimageview.image=myimage;
                }
                else if ([[sortedgenderArray objectAtIndex:indexPath.row] intValue]==8)
                {
                    UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                    toimageview.image=myimage;
                }
                else
                {
                    UIImage *myimage =[UIImage imageNamed:@"man.png"];
                    toimageview.image=myimage;
                }
            }
        }
        else
        {
            profilePicUrl1=[NSString stringWithFormat:@"%@/%@",domain,[sortedProfilePicImageArray objectAtIndex:indexPath.row]];
            NSData *mydata = [[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:profilePicUrl1]] autorelease];
            if (mydata)
            {
                UIImage *myimage = [[[UIImage alloc] initWithData:mydata] autorelease];
                toimageview.image=myimage;
            }
            else
            {
                if ( ([sortedgenderArray objectAtIndex:indexPath.row] == (id)[NSNull null])
                    || ([sortedgenderArray objectAtIndex:indexPath.row] == NULL)
                    || ([[sortedgenderArray objectAtIndex:indexPath.row] isEqual:@""])
                    || ([[sortedgenderArray objectAtIndex:indexPath.row] length] == 0) )
                {
                    UIImage *myimage =[UIImage imageNamed:@"man.png"];
                    toimageview.image=myimage;
                }
                else
                {
                    if ([[sortedgenderArray objectAtIndex:indexPath.row] intValue]==1)
                    {
                        UIImage *myimage =[UIImage imageNamed:@"women.png"];
                        toimageview.image=myimage;  
                    }
                    else if ([[sortedgenderArray objectAtIndex:indexPath.row] intValue]==2)
                    {
                        UIImage *myimage =[UIImage imageNamed:@"man.png"];
                        toimageview.image=myimage;
                    }
                    else if ([[sortedgenderArray objectAtIndex:indexPath.row] intValue]==4)
                    {
                        UIImage *myimage =[UIImage imageNamed:@"man_women.png"];
                        toimageview.image=myimage;
                    }
                    else if ([[sortedgenderArray objectAtIndex:indexPath.row] intValue]==8)
                    {
                        UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                        toimageview.image=myimage;
                    }
                    else
                    {
                        UIImage *myimage =[UIImage imageNamed:@"man.png"];
                        toimageview.image=myimage;
                    }
                }
            }
        }
        txtFldTo.text=[samplearray objectAtIndex:indexPath.row];
        selectedprofileid = [[sortedprofileIdArray objectAtIndex:indexPath.row] intValue];
    }
    [txtFldTo resignFirstResponder];
    table.hidden=YES;
    selec=YES; 
}


#pragma mark Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // for hiding the key board after entering the text in a text view
    UITouch *touch = [[event allTouches] anyObject];
    if ([txtViewReply isFirstResponder] && [touch view] != txtViewReply)
    {
        [txtViewReply resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma mark Text Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==txtFldTo)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"val"];
        val=[txtFldTo.text stringByReplacingCharactersInRange:range withString:string];
        NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        val = [val stringByTrimmingCharactersInSet:whitespace];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:val forKey:@"val"];
        return YES;
    }
    if (textField==txtFldSubject)
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if (newLength > 100)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"subject can not exceed 100 characters! Kindly press return key." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            return NO;
        }
        else
            return YES;
    }
    return YES;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    table.hidden=YES;
    
    if (textField==txtFldTo)
    {
        if (loading)
        {
            return;
        }
        
        table=[[UITableView alloc]initWithFrame:CGRectMake(0, 93, 320, 380) style:UITableViewStylePlain];
        table.backgroundColor = [UIColor colorWithRed:237.0/255.0
                                                green:237.0/255.0
                                                 blue:237.0/255.0
                                                alpha:1.0];
        /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if (self.interfaceOrientation==UIInterfaceOrientationLandscapeRight||self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft)
            {
                [table setFrame:CGRectMake(0,93,1028,675)];
            }
            else
            {
                [table setFrame:CGRectMake(0,93,768,935)];
            }
        }*/
        //else
        //{
            [table setFrame:CGRectMake(0,100,320,380)];
        //}
        
        [table setDelegate:self];
        [table setDataSource:self];
        [self.view addSubview:table];
        selec=NO;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark UITextViewDelegate

- (BOOL) textViewShouldReturn:(UITextView *)textView
{
	[textView resignFirstResponder];
	return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (txtViewReply.text.length>256)
    {
        txtViewReply.text=[txtViewReply.text substringToIndex:256];
        lblCharCount.text=@"0";
        [textView resignFirstResponder];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:[@"You have reached the maximum limit!" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    else
    {
        lblCharCount.text=[NSString stringWithFormat:@"%d", 256 - (int)txtViewReply.text.length ];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{ 
    NSString *textCount=lblCharCount.text;
    int currentTextCount=(int)text.length;
  
    if ([textCount intValue]<currentTextCount)
    {
        if([txtViewReply.text length]>=256)
        {
            [textView resignFirstResponder];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:[@"You have reached the maximum limit!" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return NO;
        }
        else
        {
            NSString *trimmedString=[text substringToIndex:[textCount intValue]];
            txtViewReply.text=[NSString stringWithFormat:@"%@%@",txtViewReply.text,trimmedString];
        }
    }
    lblCharCount.text=[NSString stringWithFormat:@"%d", 256 - (int)txtViewReply.text.length ];

    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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
    loading=NO;
    btnSend.enabled=YES;
    btnCancel.enabled=YES;
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
    [self.view setUserInteractionEnabled:YES];
	return;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    loading=NO;
    btnSend.enabled=YES;
    btnCancel.enabled=YES;
    indicatorView.hidden=YES;
    NSString *responseString = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
   	NSError *error;
	SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    CFRelease((CFTypeRef) parser);
    NSDictionary *json = [responseString JSONValue];
    [responseString release];
 
    if (sendFlag)
    {
        sendFlag=NO;
        NSString *sendMsg=(NSString*)[parsedData objectForKey:@"Message"];
        if([sendMsg isEqualToString:@"Site suspended"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            sessionAlertView.tag=2;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([sendMsg isEqualToString:@"Session Expired"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
            
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            sessionAlertView.tag=2;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([sendMsg isEqualToString:@"Membership Denied"]||[sendMsg isEqualToString:@"Membership Denied"])
        {
            UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to send the message." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            MembershipAlertView.tag=3;
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
            sendFlag=NO;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:[@"Successfully sent the message." description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alertView.tag=1;
            [alertView show];
            [alertView release];
        }
        else if ([sendMsg isEqualToString:@"Message Exceed"])
        {
            UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to send the message." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            MembershipAlertView.tag=3;
            [MembershipAlertView release];
            return;
        }
        else if ([sendMsg isEqualToString:@"Error"])
        {
            sendFlag=NO;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Failed to send message, try again" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }   
    }
    else
    {
        NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"];
        //For checking session validation
        if([messegeStr isEqualToString:@"Site suspended"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            sessionAlertView.tag=2;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([messegeStr isEqualToString:@"Session Expired"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            sessionAlertView.tag=2;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([messegeStr isEqualToString:@"Membership denied"]||[messegeStr isEqualToString:@"Membership Denied"])
        {
            UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to send message." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
        }
        NSString *resultCount = (NSString*)[parsedData objectForKey:@"count"];
        if([resultCount intValue]==0)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Contacts found"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
        else
        {
            samplearray=[[NSMutableArray alloc]init];
            profileIdArray=[[NSMutableArray alloc]init];
            NSArray *profileIds = [json valueForKeyPath:@"result.profile_id"];
            profileIdArray=[[NSMutableArray alloc] initWithArray:profileIds copyItems:YES];
            NSArray *genderId = [json valueForKeyPath:@"result.sex"];
            genderArray=[[NSMutableArray alloc] initWithArray:genderId copyItems:YES];
            NSMutableArray *usrName = [json valueForKeyPath:@"result.username"];
            samplearray=[[NSMutableArray alloc] initWithArray:usrName copyItems:YES];
            for (int n=0; n<[samplearray count]; n++)
            {
                if (([samplearray objectAtIndex:n]== (id)[NSNull null])||([samplearray objectAtIndex:n]==NULL))
                {
                    [samplearray replaceObjectAtIndex:n withObject:@" "];
                }
            }
            sortedArray = [samplearray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            NSArray *picURLs = [json valueForKeyPath:@"result.Profile_Pic"];
            thumbPicURLs=[[[NSMutableArray alloc] initWithArray:picURLs copyItems:YES] retain];
            for (int i=0; i<[genderArray count]; i++) 
            {
                if (([genderArray objectAtIndex:i]== (id)[NSNull null])||([genderArray objectAtIndex:i]== NULL)||([[genderArray objectAtIndex:i] length]==0)||([genderArray objectAtIndex:i]== NULL)) 
                {
                    [imagearray addObject:@"man.png"];
                }
                else
                {
                     if ([[genderArray objectAtIndex:i] intValue]==1) 
                     {
                         [imagearray addObject:@"women.png"];
                     }
                     else if ([[genderArray objectAtIndex:i] intValue]==2) 
                     {
                         [imagearray addObject:@"man.png"];
                     }
                     else if ([[genderArray objectAtIndex:i] intValue]==4) 
                     {
                         [imagearray addObject:@"man_women.png"];
                     }
                     else if ([[genderArray objectAtIndex:i] intValue]==8) 
                     {
                         [imagearray addObject:@"man_women_a.png"];
                     }
                     else 
                     {
                         [imagearray addObject:@"man.png"];
                     }
                 }
            }
            
            for(int i=0;i<[sortedArray count];i++)
            {
                for(int j=0;i<[samplearray count];j++)
                {
                    if([[sortedArray objectAtIndex:i] isEqualToString:[samplearray objectAtIndex:j]])
                    {
                        [sortedprofileIdArray addObject:[profileIdArray objectAtIndex:j]];
                        [sortedProfileImageArray addObject:[imagearray objectAtIndex:j]];
                        [sortedProfilePicImageArray addObject:[thumbPicURLs objectAtIndex:j]];
                        [sortedgenderArray addObject:[genderArray objectAtIndex:j]];
                        break;
                    }
                }
            }
            
            samplearray=[[NSMutableArray alloc] initWithArray:sortedArray copyItems:YES];
            [resultArray addObjectsFromArray:sortedArray];
            [searchedprofileIdArray addObjectsFromArray:sortedprofileIdArray];
            [searchedSortedProfilePicImageArray addObjectsFromArray:sortedProfilePicImageArray];
            [searchedSortedProfileImageArray addObjectsFromArray:sortedProfileImageArray ];
            [searchedsortedgenderArray addObjectsFromArray:sortedgenderArray];
            NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
            [def setObject:[NSKeyedArchiver archivedDataWithRootObject:searchedprofileIdArray] forKey:@"value"];
            [def setObject:[NSKeyedArchiver archivedDataWithRootObject:searchedSortedProfilePicImageArray] forKey:@"profileImage"];
            [def setObject:[NSKeyedArchiver archivedDataWithRootObject:searchedSortedProfileImageArray] forKey:@"image"];
            [def synchronize];
        }
        
        table.hidden=NO;
        [table reloadData];
        
    }
    
    [self.view setUserInteractionEnabled:YES];
    [txtFldTo setUserInteractionEnabled:YES];
    [txtFldTo becomeFirstResponder];
    clear=NO;
    
}

#pragma mark UIAlertViewDelegate

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


@end
