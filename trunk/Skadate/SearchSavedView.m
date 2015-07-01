//
//  SearchSavedView.m
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchSavedView.h"
#import "SearchMembersView.h"
#import "SearchResults.h"
#import "HomeView.h"
#import "SkadateAppDelegate.h"
#import "JSON.h"
#import "OnlineMembers.h"

@implementation SearchSavedView
@synthesize btnBack;
@synthesize listOfNames;
@synthesize table;
@synthesize control1,searchId,respData,urlReq,indicatorView,indicatorLabel,objIndicatorView;
@synthesize navBar;
@synthesize searchsavedlab,domain,fromView;
@synthesize NewXval;

#pragma mark Memory Management

- (void)dealloc
{    
    [listOfNames release];
    [searchId release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{    
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
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

#pragma mark View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //control1.segmentedControlStyle = UISegmentedControlStyleBar;
    control1.frame = CGRectMake (10, 50, 300,35);
    UIColor *newTintColor = [UIColor colorWithRed: 175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
    control1.tintColor = newTintColor;
    UIColor *newSelectedTintColor = [UIColor colorWithRed: 175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
    [[[control1 subviews] objectAtIndex:0] setTintColor:newSelectedTintColor];
    respData = [[NSMutableData data] retain];
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    searchsavedlab.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [searchsavedlab setTextAlignment:NSTextAlignmentCenter];
    searchsavedlab.text=@"Search Members";
    urlReq=[NSString stringWithFormat:@"%@/mobile/RetriveSearch/?id=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
    NSURL *url = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    [[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
    [self ShowIndicatorView:@"Loading..."]; 
    self.view.userInteractionEnabled=NO;
    
    CGRect frame = control1.frame;
    [control1 setFrame:CGRectMake(10, 9, frame.size.width, 45)];
    
    UIImage* seg0 = [UIImage imageNamed:@"New_tab.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        seg0 = [seg0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [control1 setImage:seg0 forSegmentAtIndex:0];
    
    UIImage* seg1 = [UIImage imageNamed:@"Saved_tab_over.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        seg1 = [seg1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [control1 setImage:seg1 forSegmentAtIndex:1];
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
    
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    { 
        if (interfaceOrientation==UIDeviceOrientationLandscapeRight ||interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
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
    self.view.userInteractionEnabled=YES;
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	return;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{    
    self.view.userInteractionEnabled=YES;
    indicatorView.hidden=YES;
     
	NSString *responseString = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
    NSError *error;
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    CFRelease((CFTypeRef) parser);
    
    listOfNames=[[NSMutableArray alloc]init];
    searchId=[[NSMutableArray alloc]init];
    
    NSDictionary *json = [responseString JSONValue];
    [responseString release];
    
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
        UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to view the saved search results." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [MembershipAlertView show];
        [MembershipAlertView release];
        return;
    }   
    
    NSString *resultCount = (NSString*)[parsedData objectForKey:@"count"];
    if ([resultCount intValue] == 0 ) 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"No saved search results." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    } 
    else
    {
        NSArray *searchIDs = [json valueForKeyPath:@"result.criterion_id"];
        searchId=[[NSMutableArray alloc] initWithArray:searchIDs copyItems:YES];
        NSArray *nameArr = [json valueForKeyPath:@"result.criterion_name"];
        listOfNames=[[NSMutableArray alloc] initWithArray:nameArr copyItems:YES];
        [table reloadData];
    }
    
}

#pragma mark IBActions

-(IBAction) clickedSegmentControllerSearchedSaved
{
    
	int selectedsegment = (int)control1.selectedSegmentIndex;
    if (selectedsegment==0)
    {
		[control1 setImage:[UIImage imageNamed:@"New_tab.png"] forSegmentAtIndex:0];
        [control1 setImage:[UIImage imageNamed:@"Saved_tab_over.png"] forSegmentAtIndex:1];
		SearchMembersView *view=[[SearchMembersView alloc]initWithNibName:@"SearchMembersView" bundle:nil];
        view.fromView=fromView;
        [self.navigationController pushViewController:view animated:NO];
        [view release];
    }
   
}

-(IBAction)clickedBackButton:(id) sender
{             
    NSArray *viewControllers=[[self navigationController] viewControllers];
    if (fromView==1)
    {
        for( int i=0;i<[ viewControllers count];i++)
        {
            id obj=[viewControllers objectAtIndex:i];
            if([obj isKindOfClass:[HomeView class]] )
            {
                [[self navigationController] popToViewController:obj animated:YES];
                return;
            }
        }
    }
    else if ((fromView==2) || (fromView==3) || (fromView==4) || (fromView==5) || (fromView==6))
    {
        if (fromView==2)
        {
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
			[prefs setValue:@"New" forKey:@"MemberType"];
        }
        else if (fromView==3)
        {
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
			[prefs setValue:@"Online" forKey:@"MemberType"];
        }
        else if (fromView==4)
        {
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
			[prefs setValue:@"My Watches" forKey:@"MemberType"];
        }
        else if (fromView==5)
        {
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
			[prefs setValue:@"Featured" forKey:@"MemberType"];
        }
        else if (fromView==6)
        {
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
			[prefs setValue:@"Bookmarked" forKey:@"MemberType"];        
        }
        
        for( int i=0;i<[ viewControllers count];i++)
        {
            id obj=[viewControllers objectAtIndex:i];
            if([obj isKindOfClass:[OnlineMembers class]] )
            {
                [[self navigationController] popToViewController:obj animated:YES];
                return;
            }
        }
    }
}

#pragma mark AlertView Delegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag==1&&buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark Table view Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [listOfNames count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//return 40;
    return 50;
}

// Customize the appearance of table view cells.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    cell = nil;
   
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CGRect frameName =CGRectMake(20,15, 200,20 );
    UILabel *lblOfName=[[UILabel alloc]initWithFrame:frameName];
    lblOfName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:18];
    
    if([listOfNames count]>0)
    {
        if (([listOfNames objectAtIndex:indexPath.row]== (id)[NSNull null])||([listOfNames objectAtIndex:indexPath.row]==NULL))
        {
            lblOfName.text=@"";
        }
        else
        {
            lblOfName.text=[listOfNames objectAtIndex:indexPath.row];
        }
    }
    
    lblOfName.textColor =[UIColor blackColor]; 
    [cell addSubview: lblOfName];
    [lblOfName release];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    theCell.selectionStyle = UITableViewCellSelectionStyleGray;
    NSString *retreiveSearchId=[searchId objectAtIndex:indexPath.row];
    SearchResults *objSearchResults=[[SearchResults alloc]initWithNibName:@"SearchResults" bundle:nil];
    objSearchResults.urlReq=[ NSString stringWithFormat:@"%@/mobile/Fetch_SearchByLimit/?id=%@&pid=%@&skey=%@",domain,retreiveSearchId,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
    objSearchResults.searchsavedflag=YES;
    [self.navigationController pushViewController:objSearchResults animated:YES];
    [objSearchResults release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    if (theCell.isSelected == YES)
    {
        theCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        theCell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
}


@end
