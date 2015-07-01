//
//  PhotoFullView.m
//  Chk
//
//  Created by SODTechnologies on 24/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "PhotoFullView.h"
#import "SkadateAppDelegate.h"
#import "JSON.h"
#import "CommonStaticMethods.h"

@implementation PhotoFullView
@synthesize ActButt;

@synthesize btnMyPhotos, btnSave, btnNext, btnPrev;
@synthesize indicatorView,indicatorLabel,objIndicatorView;
@synthesize imgView;
@synthesize imgIndex;
@synthesize imgURLs;
@synthesize act;
@synthesize Actbut;
@synthesize navBar;
@synthesize lblTitle;
@synthesize objMyPhotosView;
@synthesize fromMyphotos;
@synthesize domain;
@synthesize imgIDArr,respData,profileId,strRep;
@synthesize resultCount,scrollView;
@synthesize imgArr;
@synthesize NewXval;


#pragma mark Memory Management

- (void)dealloc
{
    [ActButt release];
    [Actbut release];
    [super dealloc];
    [imgIDArr release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (BOOL)prefersStatusBarHidden {
    return YES;
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

-(void)loadThumbNail : (int) inexVal
{    
    NSString *imageName=[NSString stringWithFormat:@"%@",[imgURLs objectAtIndex:inexVal]];
    //imageName=[imageName stringByReplacingOccurrencesOfString:@"/$userfiles/" withString:@""];  // for old version
    imageName=[imageName stringByReplacingOccurrencesOfString:@"/userfiles/" withString:@""];  // for new version
    NSString *originalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
    NSString *localFilePath = [originalPath stringByAppendingPathComponent:imageName];
    BOOL isDir=[CommonStaticMethods directoryExistsAtAbsolutePath:[originalPath stringByAppendingPathComponent:@"profile.png"]];
   
    if(!isDir)
    {
        [[NSFileManager defaultManager]createDirectoryAtPath: originalPath withIntermediateDirectories: YES attributes: nil error: NULL];
    }
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:localFilePath];
    
    if (fileExists)
    {
        UIImage* image = [UIImage imageWithContentsOfFile:localFilePath];
        imgView.image=image;        
    }
    
}


// Pinch Zooming of images
- (void)scrollViewDidEndZooming:(UIScrollView *)aScrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
    CGSize imgViewSize = imgView.frame.size;
    CGSize imageSize = imgView.image.size;
    CGSize realImgSize;
   
    if(imageSize.width / imageSize.height > imgViewSize.width / imgViewSize.height) 
    {
        realImgSize = CGSizeMake(imgViewSize.width, imgViewSize.width / imageSize.width * imageSize.height);
    }
    else
    {
        realImgSize = CGSizeMake(imgViewSize.height / imageSize.height * imageSize.width, imgViewSize.height);
    }
    
    CGRect fr = CGRectMake(0, 0, 0, 0);
    fr.size = realImgSize;
    imgView.frame = fr;
    CGSize scrSize = scrollView.frame.size;
    float offx = (scrSize.width > realImgSize.width ? (scrSize.width - realImgSize.width) / 2 : 0);
    float offy = (scrSize.height > realImgSize.height ? (scrSize.height - realImgSize.height) / 2 : 0);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    scrollView.contentInset = UIEdgeInsetsMake(offy, offx, offy, offx);
    [UIView commitAnimations];
}


// Pinch Zooming of images
-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView 
{    
    return self.imgView;
}


-(void)loadPic 
{    
    NSAutoreleasePool *pool;
    pool = [[NSAutoreleasePool alloc] init];
    imgIDArr=[[NSMutableArray alloc]init];
    NSString *originalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
    BOOL isDir=[CommonStaticMethods directoryExistsAtAbsolutePath:[originalPath stringByAppendingPathComponent:@"profile.png"]];
   
    if(!isDir)
    {
        [[NSFileManager defaultManager]createDirectoryAtPath: originalPath withIntermediateDirectories: YES attributes: nil error: NULL];
    }  
    
    if (imgIndex < 0) 
    {
        imgIndex=[imgURLs count]-1;
    }
    
    if (imgIndex >= [imgURLs count])
    {
        imgIndex=0;
    }
    
    NSString *fullPath=(NSString*)[imgURLs objectAtIndex:imgIndex];
    fullPath=[fullPath stringByReplacingOccurrencesOfString:@"thumb_" withString:@"full_size_"];
    NSArray *arrSplit = [fullPath componentsSeparatedByString:@"_"];
    imgIDArr=[[NSMutableArray alloc] initWithArray:arrSplit copyItems:YES];
   
    if([[imgIDArr objectAtIndex:1]isEqualToString:@"size"])
    {
        reportItem.enabled=YES;
        profileId=[imgIDArr objectAtIndex:3];
    }
    else
    {
        //protected , only
        reportItem.enabled=NO;
    }
    
    NSArray *firstSplit = [fullPath componentsSeparatedByString:@"/"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[originalPath stringByAppendingPathComponent:[firstSplit objectAtIndex:([firstSplit count]-1)]]])
    { 
        imgView.image=[[[UIImage alloc] initWithContentsOfFile:[originalPath stringByAppendingPathComponent:[firstSplit objectAtIndex:([firstSplit count]-1)]]] autorelease];
    }
    else 
    {
        NSData *mydata = [[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",domain,fullPath]]] autorelease];
        UIImage *myimage = [[[UIImage alloc] initWithData:mydata] autorelease];
        imgView.image=myimage;
        [mydata writeToFile:[originalPath stringByAppendingPathComponent:[firstSplit objectAtIndex:([firstSplit count]-1)]]  atomically:YES];
    }
    
    lblTitle.font = [UIFont fontWithName:@"Helvetica" size:22];
    lblTitle.text = [NSString stringWithFormat:@"%d of %d", (int) imgIndex + 1, (int)[imgURLs count]];
    indicatorView.hidden=YES;
    reportItem.enabled=YES;
    btnSave.enabled=YES;
    [pool drain];
    
}

-(void)loading 
{
    [self ShowIndicatorView:@"Loading..."]; 
    act.hidden=NO;
    reportItem.enabled=NO;
    btnSave.enabled=NO;
    btnSave.enabled=NO;
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo 
{ 
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Saved" message:[@"Successfully saved" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}



#pragma mark View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
      
    // Pinch Zooming of images
    self.scrollView.minimumZoomScale=1.0;
    self.scrollView.maximumZoomScale=4.0;
    self.scrollView.contentSize=CGSizeMake(imgView.frame.size.width, imgView.frame.size.height);
    self.scrollView.clipsToBounds=YES;
    self.scrollView.delegate=self;
    imgView.userInteractionEnabled=YES;
    self.scrollView.canCancelContentTouches=NO;
    self.scrollView.delaysContentTouches=YES;
    swipeDone=YES;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    [self loadThumbNail: (int)imgIndex];
    lblTitle.font = [UIFont fontWithName:@"Helvetica" size:22];
    lblTitle.text=[NSString stringWithFormat:@"1 of %d", (int)[imgURLs count]];
    [self loading];
    
    if (resultCount<2)
    {
        lblTitle.hidden=YES;
        btnNext.hidden=YES;
        btnPrev.hidden=YES;
    }
    
    if (fromMyphotos) 
    {
        [btnMyPhotos setImage:[UIImage imageNamed:@"my_photos_black.png"] forState:UIControlStateNormal];
        Actbut.hidden=YES;
    }
    else 
    {
        [btnMyPhotos setImage:[UIImage imageNamed:@"photos_black.png"] forState:UIControlStateNormal];
    }
    
    [NSThread detachNewThreadSelector:@selector(loadPic) toTarget:self withObject:nil];
    UISwipeGestureRecognizer* gestureR;
    UISwipeGestureRecognizer* gesturel;
    gestureR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    gestureR.delegate=self;
    [gestureR setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.imgView addGestureRecognizer:gestureR];
    gesturel=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    gesturel.delegate=self;
    [gesturel setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.imgView addGestureRecognizer:gesturel];
}


- (void)viewDidUnload
{
    [self setActButt:nil];
    [self setActbut:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
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


#pragma mark -IBAction

-(IBAction)clickedMyPhotosButton:(id) sender
{    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clickedSaveButton:(id) sender
{    
    UIImageWriteToSavedPhotosAlbum(imgView.image, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
}


-(IBAction)clickedNextButton:(id) sender
{   
    imgIndex+=1;
    [self ShowIndicatorView:@"Loading..."];
    reportItem.enabled=NO;
    btnSave.enabled=NO;
    [NSThread detachNewThreadSelector:@selector(loadPic) toTarget:self withObject:nil];
}


-(IBAction)clickedPrevButton:(id) sender
{
    imgIndex-=1;
    [self ShowIndicatorView:@"Loading..."];
    reportItem.enabled=NO;
    btnSave.enabled=NO;
    [NSThread detachNewThreadSelector:@selector(loadPic) toTarget:self withObject:nil];
}

-(IBAction)clickedReportButton:(id) sender
{    
    if([[imgIDArr objectAtIndex:1]isEqualToString:@"size"])
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:@"Abuse"
                                      otherButtonTitles:@"Offence",@"Immoral",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        actionSheet.tag=1;
        [actionSheet showInView:self.view];
        [actionSheet release];
    }
}

#pragma mark ActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{    
    if (actionSheet.tag)
    {
        respData = [[NSMutableData data] retain];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        domain = [prefs stringForKey:@"URL"];
        switch (buttonIndex)
        {                
            case 0:
                    strRep=[NSString stringWithFormat:@"Abbusive"];
                    urlReq = [NSString stringWithFormat: @"%@/mobile/AddReport/?eid=%@&pid=%@&skey=%@&text=%@",domain,profileId,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,strRep];
                    NSURL *url = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
                    urlConnRep= [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];   
                    [self ShowIndicatorView:@"Reporting..."];
                    reportItem.enabled=NO;
                    btnSave.enabled=NO;
                    break;
            case 1:
                    strRep=[NSString stringWithFormat:@"Offensive"];
                    urlReq = [NSString stringWithFormat: @"%@/mobile/AddReport/?eid=%@&pid=%@&skey=%@&text=%@",domain,profileId,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,strRep];
                    NSURL *url1 = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    NSURLRequest *urlrequest1 = [NSURLRequest requestWithURL:url1];
                    urlConnRep= [[[NSURLConnection alloc] initWithRequest:urlrequest1 delegate:self] autorelease];   
                    [self ShowIndicatorView:@"Reporting..."];
                    reportItem.enabled=NO;
                    btnSave.enabled=NO;
                    break;  
                
             case 2:   
                    strRep=[NSString stringWithFormat:@"Immoral"];
                    urlReq = [NSString stringWithFormat: @"%@/mobile/AddReport/?eid=%@&pid=%@&skey=%@&text=%@",domain,profileId,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,strRep];
                    NSURL *url2 = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    NSURLRequest *urlrequest2 = [NSURLRequest requestWithURL:url2];
                    urlConnRep= [[[NSURLConnection alloc] initWithRequest:urlrequest2 delegate:self] autorelease];   
                    [self ShowIndicatorView:@"Reporting..."];
                    reportItem.enabled=NO;
                    btnSave.enabled=NO;
                    break;
                
            default:
                    break;
        }
    }
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
    reportItem.enabled=YES;
    btnSave.enabled=YES;
    indicatorView.hidden=YES;
   	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	return;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{    
    indicatorView.hidden=YES;
    reportItem.enabled=YES;
    btnSave.enabled=YES;
    NSString *responseString = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
    NSError *error;
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    CFRelease((CFTypeRef) parser);
    [responseString release];
    NSString *sendMsg=(NSString*)[parsedData objectForKey:@"Message"];
    
    if([sendMsg isEqualToString:@"Site suspended"])
    {
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
        UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        sessionAlertView.tag=1;
        [sessionAlertView show];
        [sessionAlertView release];
        return;
    }
    else if ([sendMsg isEqualToString:@"Session Expired"]) 
    {
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
        UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        sessionAlertView.tag=1;
        [sessionAlertView show];
        [sessionAlertView release];
        return;
    }
    else if ([sendMsg isEqualToString:@"Membership Denied"]||[sendMsg isEqualToString:@"Membership Denied"])
    {
        UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [MembershipAlertView show];
        [MembershipAlertView release];
        return;
    }
    else if ([sendMsg isEqualToString:@"Success"]) 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:[@"Successfully reported." description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"You can report only once." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }   
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{        
    if (actionSheet.tag==1&&buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


#pragma mark Swipe

- (void)handleSwipeFrom:(UISwipeGestureRecognizer*)recognizer 
{    
    if (recognizer.direction==UISwipeGestureRecognizerDirectionRight)
    {
        imgIndex-=1;
        fla=0;
        [self ShowIndicatorView:@"Loading..."];
        reportItem.enabled=NO;
        btnSave.enabled=NO;
        [NSThread detachNewThreadSelector:@selector(loadPic) toTarget:self withObject:nil];
                
    }
    else if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft)
    {
        imgIndex+=1;
        fla=1;
        [self ShowIndicatorView:@"Loading..."];
        reportItem.enabled=NO;
        btnSave.enabled=NO;
        
        [NSThread detachNewThreadSelector:@selector(loadPic) toTarget:self withObject:nil];
    }
}






@end
