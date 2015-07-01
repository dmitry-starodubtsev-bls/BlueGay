//
//  NewsFeedsController.m
//  Skadate
//
//  Created by SOD MAC4 on 24/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsFeedsController.h"
#import "SkadateAppDelegate.h"
#import "JSON.h"
#import "blogPostCell.h"
#import "newsPostAddCell.h"
#import "friendsAddCell.h"
#import "profileAvatarChangeCell.h"
#import "profileEdit.h"
#import "profileJoinCell.h"
#import "profileCommentCell.h"
#import "userComment.h"
#import "postClassifiedsItemCell.h"
#import "eventAttendCell.h"
#import "eventAddCell.h"
#import "groupAddCell.h"
#import "groupJoinCell.h"
#import "photoUpload.h"
#import "mediaUploadCell.h"
#import "musicUploadCell.h"
#import "forumAddTopicCell.h"
#import "statusUpdateCell.h"
#import "DetailedCommentViewController.h"
#import "LikeListViewController.h"
#import "UploadedPhotoFullView.h"
#import "photoUploadDeleted.h"
#import "MyProfileView.h"

#define REFRESH_HEADER_HEIGHT 52.0f

@implementation NewsFeedsController

@synthesize newsFeedTV;
@synthesize newsFeedUrlconnection;
@synthesize domain;
@synthesize respData;
@synthesize newsFeedsItemArray;
@synthesize ProfilePicURLs;
@synthesize ProfilePicImages;
@synthesize Friend_Pics;
@synthesize Friend_PicUrls;
@synthesize indicatorView,indicatorLabel,objIndicatorView;
@synthesize likeUrlconnection;
@synthesize UnlikeUrlconnection;
@synthesize imgUpload_PicsUrls;
@synthesize imgUpload_Pics;
@synthesize navBar;
@synthesize navLable;
@synthesize selectedLike;
@synthesize fromCommentView;
@synthesize youLiked;
@synthesize smallIndicatorView;
@synthesize NewXval;
// pull down refresh.........//
@synthesize textPull, textRelease, textLoading, refreshHeaderView, refreshLabel, refreshArrow, refreshSpinner;

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

#pragma mark Memory Management

- (void)dealloc
{    
    [ProfilePicURLs release];
    [ProfilePicImages release];
    [Friend_Pics release];
    [Friend_PicUrls release];
    [indicatorView release];
    [indicatorLabel release];
    [objIndicatorView release];
    [imgUpload_PicsUrls release];
    [imgUpload_Pics release];
    [newsFeedsItemArray release];
    [super dealloc];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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

- (void)addItem
{        
    newsFeedsItemArray=[[NSMutableArray alloc]init];
    respData = [[NSMutableData data] retain];
    
    ProfilePicURLs=[[NSMutableArray alloc]init];
    ProfilePicImages=[[NSMutableArray alloc]init];
    
    Friend_PicUrls=[[NSMutableArray alloc]init];
    Friend_Pics=[[NSMutableArray alloc]init];
    
    Friend_PicUrls=[[NSMutableArray alloc]init];
    Friend_Pics=[[NSMutableArray alloc]init];
    
    imgUpload_PicsUrls=[[NSMutableArray alloc]init];
    imgUpload_Pics=[[NSMutableArray alloc]init];
    domain=@"http://blugay.net";
    NSString *req = [NSString stringWithFormat:@"%@/mobile/News_Feed_View/?pid=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
    NSLog(req);
    NSURL *url = [NSURL URLWithString:[req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    newsFeedUrlconnection=[[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
    
    self.view.userInteractionEnabled=NO;
    
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


-(void)likeButtonClicked:(id)sender
{
    
    if (likesConnected) 
    {
        return;
    }
    
    likesConnected=YES;
    smallIndicatorView.hidden=NO;
    [smallIndicatorView startAnimating];
    
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_liked=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_Unliked=NO;
    
    respData = [[NSMutableData data] retain];
    selectedLike = (int)[sender tag];
    
    NSString *entityId=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"id"];
    NSString *likeStr = [[(UIButton*)sender titleLabel] text];
    
    if ([likeStr isEqualToString:@"Like"])
    {domain=@"http://blugay.net";
        NSString *req = [NSString stringWithFormat:@"%@/mobile/News_Like/?pid=%@&skey=%@&eid=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,entityId];
        NSURL *url = [NSURL URLWithString:[req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
        likeUrlconnection=[[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
        [self ShowIndicatorView:@"Contacting Server..."]; 
        self.view.userInteractionEnabled=NO;
        
    }
    else if([likeStr isEqualToString:@"Unlike"])
    {       domain=@"http://blugay.net";
        NSString *req = [NSString stringWithFormat:@"%@/mobile/News_UnLike/?pid=%@&skey=%@&eid=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,entityId];
        NSURL *url = [NSURL URLWithString:[req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
        UnlikeUrlconnection=[[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
        [self ShowIndicatorView:@"Please Wait..."]; 
        self.view.userInteractionEnabled=NO;     
        
    }    
}

-(void)commentButtonClicked:(id)sender
{    
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromCommentView=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_liked=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_Unliked=NO;
    
    selectedLike = (int)[sender tag];
    NSString *entityId=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"id"];
    NewsFeedCommentViewController *objcommentView=[[NewsFeedCommentViewController alloc]initWithNibName:@"NewsFeedCommentViewController" bundle:nil];
    objcommentView.entityId=entityId;
    [self.navigationController presentViewController:objcommentView animated:YES completion:nil];
    [objcommentView release];
    
}

-(void)commentsCountButtonClicked:(id)sender
{
    selectedLike = (int)[sender tag];
    
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromCommentView=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_liked=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_Unliked=NO;
    
    NSString *CommentCountStr=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] valueForKey:@"Comment"];
    int CommentCount=[CommentCountStr intValue];
    
    if (CommentCount>0)
    {               
        NSString *entityId=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"id"];
        
        DetailedCommentViewController *objDetailedCommentViewController=[[DetailedCommentViewController alloc]initWithNibName:@"DetailedCommentViewController" bundle:nil];
        objDetailedCommentViewController.entityId=entityId;
        [self.navigationController pushViewController:objDetailedCommentViewController animated:YES];
        [objDetailedCommentViewController release];
                
    }
    
}

-(void)likesCountButtonClicked:(id)sender
{    
    
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_liked=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_Unliked=NO;
    selectedLike = (int)[sender tag];
    
    if (((NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"LikeStatusID"]==(id)[NSNull null])||(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"LikeStatusID"]==NULL||[(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"LikeStatusID"] isEqualToString:@"UnLiked"])
    {
        youLiked=NO;  
    }
    else
    {        
        youLiked=YES;        
    }
    
    NSString *entityType=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] valueForKey:@"likecount"];
    int likecount=[entityType intValue];
    
    if (likecount>0) 
    {        
        NSString *entityId=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"id"];
        
        LikeListViewController *objLikeListViewController=[[LikeListViewController alloc]initWithNibName:@"LikeListViewController" bundle:nil];
        objLikeListViewController.entityId=entityId;
        objLikeListViewController.youLiked=youLiked;
        
        if (([(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"userId"] isEqualToString:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID]))
        {                        
            objLikeListViewController.myFeed=YES;
        }
        else
        {            
            objLikeListViewController.myFeed=NO;
        }
        
        [self.navigationController pushViewController:objLikeListViewController animated:YES];
        
        [objLikeListViewController release];
        
    }
    
}

-(void)profileButtonClicked:(id)sender
{        
    selectedLike = (int)[sender tag];
    
    NSString *profileId=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"userId"];
    
    if([((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID isEqualToString:profileId])
    {
        MyProfileView *objMyProfileView=[[MyProfileView alloc]initWithNibName:@"MyProfileView" bundle:nil];
        objMyProfileView.profileID=profileId;
        [self.navigationController pushViewController:objMyProfileView animated:YES];
        [objMyProfileView release];
    }
    else
    {
        ProfileView *objProfileView=[[ProfileView alloc]initWithNibName:@"ProfileView" bundle:nil];
        objProfileView.profileID=profileId;
        [self.navigationController pushViewController:objProfileView animated:YES];
        [objProfileView release];
        
    }
}


-(void)FrdProfileButtonClicked:(id)sender
{    
    selectedLike = (int)[sender tag];
    
    NSString *profileId=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"FriendID"];
    
    if([((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID isEqualToString:profileId])
    {
        
    }
    else
    {
        ProfileView *objProfileView=[[ProfileView alloc]initWithNibName:@"ProfileView" bundle:nil];
        objProfileView.profileID=profileId;
        
        [self.navigationController pushViewController:objProfileView animated:YES];
        [objProfileView release];
    }
    
}

-(void)uploadedImageButtonClicked:(id)sender
{    
    selectedLike = (int)[sender tag];
    
    if ( ([imgUpload_PicsUrls objectAtIndex:selectedLike] == (id)[NSNull null])
        || ([imgUpload_PicsUrls objectAtIndex:selectedLike] == NULL)
        || ([[imgUpload_PicsUrls objectAtIndex:selectedLike] isEqual:@""])
        || ([[imgUpload_PicsUrls objectAtIndex:selectedLike] length] == 0) )
    {
        
        return;
    }
    else
    {
        UploadedPhotoFullView *objUploadedPhotoFullView=[[UploadedPhotoFullView alloc]initWithNibName:@"UploadedPhotoFullView" bundle:nil];
        objUploadedPhotoFullView.strImageUpload=[imgUpload_PicsUrls objectAtIndex:selectedLike];
        [self.navigationController pushViewController:objUploadedPhotoFullView animated:YES];
        [objUploadedPhotoFullView release];
    }
}

#pragma mark Pull to refresh Related Methods & Delegates

- (void)startLoading 
{
    isLoading = YES;
    
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        newsFeedTV.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        refreshLabel.text = self.textLoading;
        refreshArrow.hidden = YES;
        [refreshSpinner startAnimating];
    }];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading 
{
    isLoading = NO;
    self.view.userInteractionEnabled=YES;
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        newsFeedTV.contentInset = UIEdgeInsetsZero;
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    } 
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
}

- (void)stopLoadingComplete 
{
    // Reset the header
    refreshLabel.text = self.textPull;
    refreshArrow.hidden = NO;
    [refreshSpinner stopAnimating];
    
}


- (void)refresh 
{
    self.view.userInteractionEnabled=NO;
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}


- (void)setupStrings
{
    textPull = [[NSString alloc] initWithString:@"Pull down to refresh..."];
    textRelease = [[NSString alloc] initWithString:@"Release to refresh..."];
    textLoading = [[NSString alloc] initWithString:@"Loading..."];
}

- (void)addPullToRefreshHeader 
{
    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    
    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
                                    (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
                                    27, 44);
    
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
    int xvalue=floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2) +85;
    
    refreshSpinner.frame = CGRectMake(xvalue, floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    
    refreshSpinner.hidesWhenStopped = YES;
    
    [refreshHeaderView addSubview:refreshLabel];
    [refreshHeaderView addSubview:refreshArrow];
    [refreshHeaderView addSubview:refreshSpinner];
    [newsFeedTV addSubview:refreshHeaderView];
    
}

#pragma mark ScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView 
{
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isLoading) 
    {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            newsFeedTV.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            newsFeedTV.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } 
    else if (isDragging && scrollView.contentOffset.y < 0) 
    {
        // Update the arrow direction and label
        [UIView animateWithDuration:0.25 animations:^{
            if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) 
            {
                // User is scrolling above the header
                refreshLabel.text = self.textRelease;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            } 
            else 
            { 
                // User is scrolling somewhere within the header
                refreshLabel.text = self.textPull;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            }
        }];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate 
{
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT)
    {
        // Released above the header
        [self startLoading];
    }
}


#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    
    [smallIndicatorView stopAnimating];
    smallIndicatorView.hidden=YES;
    
    if (((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromCommentView) 
    {
        
        NSString *CommentCountStr=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] valueForKey:@"Comment"];
     
        int CommentCount=[CommentCountStr intValue]+1;
        
        NSString *cmtcountStr=[NSString stringWithFormat:@"%d",CommentCount];
        
        [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:cmtcountStr forKey:@"Comment"];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedLike inSection:0];
        [newsFeedTV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    else if(((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_liked)
    {        
        
        NSString *entityType=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] valueForKey:@"likecount"];
        int likecount=[entityType intValue]+1;
        NSString *likecountStr=[NSString stringWithFormat:@"%d",likecount];
        
        [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:likecountStr forKey:@"likecount"];
        [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:@"Liked" forKey:@"LikeStatusID"];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedLike inSection:0];
        
        [newsFeedTV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    else if(((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_Unliked)
    {    
        
        NSString *entityType=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] valueForKey:@"likecount"];
        int likecount=[entityType intValue]-1;
        NSString *likecountStr=[NSString stringWithFormat:@"%d",likecount];
        
        [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:likecountStr forKey:@"likecount"];
        [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:@"UnLiked" forKey:@"LikeStatusID"];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedLike inSection:0];
        
        [newsFeedTV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
    }
 
}


- (void)viewDidLoad
{
    //// pull to refresh
    
    [self setupStrings];
    [super viewDidLoad];
    
    [self addPullToRefreshHeader];
        
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    navLable.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    
    [navLable setTextAlignment:NSTextAlignmentCenter];
    navLable.text=@"News Feed";
    likesConnected=NO;
    
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromCommentView=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_liked=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_Unliked=NO;

    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain=@"http://blugay.net";
       
    newsFeedsItemArray=[[NSMutableArray alloc]init];
    respData = [[NSMutableData data] retain];
    
    ProfilePicURLs=[[NSMutableArray alloc]init];
    ProfilePicImages=[[NSMutableArray alloc]init];
    
    Friend_PicUrls=[[NSMutableArray alloc]init];
    Friend_Pics=[[NSMutableArray alloc]init];

    Friend_PicUrls=[[NSMutableArray alloc]init];
    Friend_Pics=[[NSMutableArray alloc]init];

    imgUpload_PicsUrls=[[NSMutableArray alloc]init];
    imgUpload_Pics=[[NSMutableArray alloc]init];
      domain=@"http://blugay.net";
    NSString *req = [NSString stringWithFormat:@"%@/mobile/News_Feed_View/?pid=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
    NSLog(req);
    NSURL *url = [NSURL URLWithString:[req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    newsFeedUrlconnection=[[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
         
    indicatorView = [[UIView alloc] init];
    objIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorLabel = [[UILabel alloc] init];
           
    [self ShowIndicatorView:@"Loading..."]; 
    
    self.view.userInteractionEnabled=NO;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {       
        
        if (interfaceOrientation==UIInterfaceOrientationLandscapeRight||interfaceOrientation==UIInterfaceOrientationLandscapeLeft) 
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

- (void)viewDidUnload
{    
    
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark Table View Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [newsFeedsItemArray count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSString *entityType=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row] valueForKey:@"entityType"];
    
    NSString *PhotoStatus=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row] valueForKey:@"ActionImage"];
       
    return [self heightForNewsFeedCell:entityType andPhotoUploadStatus:PhotoStatus];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
        
    static NSString *CellIdentifier = @"Cells";
        
    UITableViewCell *objCustTabViewCell=nil;
    objCustTabViewCell=[tableView dequeueReusableCellWithIdentifier:@"cells"];
    
    if([newsFeedsItemArray count]==0)
    {
        return objCustTabViewCell;
    }
    
    NSString *entityType=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row] valueForKey:@"entityType"];
        
    if ([entityType isEqualToString:@"blog_post_add"]) 
    {       
        blogPostCell *cell=nil;
        cell=(blogPostCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[blogPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
        }
        
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.index_row = (int)indexPath.row;
                
        return cell;

    }
    else if ([entityType isEqualToString:@"news_post_add"]) 
    {                
        newsPostAddCell *cell=nil;
        cell=(newsPostAddCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[newsPostAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
        }

        return cell;

    }
    else if ([entityType isEqualToString:@"friend_add"])
    {        
        friendsAddCell *cell=nil;
        cell=(friendsAddCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil)
        {            
            cell = [[[friendsAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
        }
                
        cell.friend_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.index_row = (int)indexPath.row;
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];

        return cell;

    }
    else if ([entityType isEqualToString:@"profile_avatar_change"]) 
    {        
        profileAvatarChangeCell *cell=nil;
        cell=(profileAvatarChangeCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil)
        {            
            cell = [[[profileAvatarChangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.index_row = (int)indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];

        return cell;

    }
    else if ([entityType isEqualToString:@"profile_edit"])
    {        
        profileEdit *cell=nil;
        cell=(profileEdit*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[profileEdit alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        cell.index_row = (int)indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        
        return cell;
        
    }
    else if ([entityType isEqualToString:@"profile_join"]) 
    {        
        profileJoinCell *cell=nil;
        cell=(profileJoinCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[profileJoinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.index_row = (int)indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
             
        return cell;
        
    }
    else if ([entityType isEqualToString:@"profile_comment"]) 
    {        
        profileCommentCell *cell=nil;
        cell=(profileCommentCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil)
        {            
            cell = [[[profileCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.index_row = (int)indexPath.row;
        
        return cell;

    }
    else if ([entityType isEqualToString:@"user_comment"]) 
    {        
        userComment *cell=nil;
        cell=(userComment*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[userComment alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.index_row = (int)indexPath.row;
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];

        return cell;
        
    }
    else if ([entityType isEqualToString:@"post_classifieds_item"]) 
    {        
        postClassifiedsItemCell *cell=nil;
        cell=(postClassifiedsItemCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[postClassifiedsItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
        }

        return cell;

    }
    else if ([entityType isEqualToString:@"event_attend"])
    {               
        eventAttendCell *cell=nil;
        cell=(eventAttendCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil)
        {            
            cell = [[[eventAttendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.event_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.index_row = (int)indexPath.row;
           
        return cell;

    }
    else if ([entityType isEqualToString:@"event_add"]) 
    {        
        eventAddCell *cell=nil;
        cell=(eventAddCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil)
        {            
            cell = [[[eventAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.event_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.index_row = (int)indexPath.row;
         
        return cell;
        
    }
    else if ([entityType isEqualToString:@"group_add"])
    {        
        groupAddCell *cell=nil;
        cell=(groupAddCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[groupAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }

        cell.index_row = (int)indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.group_img=[UIImage imageNamed:@"ImageLoading.png"];
    
        return cell;

    }
    else if ([entityType isEqualToString:@"group_join"])
    {        
        groupJoinCell *cell=nil;
        cell=(groupJoinCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[groupJoinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }

        cell.index_row = (int)indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.group_img=[UIImage imageNamed:@"ImageLoading.png"];
        
        return cell;
        
    }
    else if ([entityType isEqualToString:@"photo_upload"]) 
    {
        
        NSString *PhotoStatus=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row] valueForKey:@"ActionImage"];
        
        if ([PhotoStatus isEqualToString:@"(null)"]||[PhotoStatus isEqualToString:@""]||(PhotoStatus == (id)[NSNull null])||([PhotoStatus length] == 0)||(PhotoStatus==NULL))
        {
            PhotoStatus=@"";
        }
        
        if([PhotoStatus isEqualToString:@"Deleted Photo"])
        {
            photoUploadDeleted *cell=nil;
            cell=(photoUploadDeleted*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
            
            if (cell == nil) 
            {                
                cell = [[[photoUploadDeleted alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
                
            }
            
            cell.index_row = (int)indexPath.row;
            cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
            cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
                        
            return cell;

        }
        else
        {
            photoUpload *cell=nil;
            cell=(photoUpload*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
            
            if (cell == nil) 
            {                
                cell = [[[photoUpload alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
                
            }
            
            cell.index_row = (int)indexPath.row;
            cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
           
            cell.uploadedImg=[UIImage imageNamed:@"ImageLoading.png"];
            cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
            
            
            return cell;

        }
                        
    }
    else if ([entityType isEqualToString:@"media_upload"]) 
    {
        
        mediaUploadCell *cell=nil;
        cell=(mediaUploadCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[mediaUploadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.index_row = (int)indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];

        return cell;

    }
    else if ([entityType isEqualToString:@"music_upload"]) 
    {        
        musicUploadCell *cell=nil;
        
        cell=(musicUploadCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[musicUploadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.index_row = (int)indexPath.row;
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];

        return cell;

    }
    else if ([entityType isEqualToString:@"forum_add_topic"]) 
    {        
        forumAddTopicCell *cell=nil;
        cell=(forumAddTopicCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[forumAddTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.index_row = (int)indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.group_img=[imgUpload_Pics objectAtIndex:indexPath.row];
                      
        return cell;

    }
    else if ([entityType isEqualToString:@"status_update"])
    {        
        statusUpdateCell *cell=nil;
        cell=(statusUpdateCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[statusUpdateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                        
            NSString *nameStr=[NSString stringWithFormat:@"Updated status as %@",[statusArray objectAtIndex:indexPath.row]];
           
            cell.updatedStatus=nameStr;
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
            
        }
        
        cell.index_row = (int)indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];

        return cell;
        
    }
    
    return objCustTabViewCell;
    
}


-(CGFloat)heightForNewsFeedCell:(NSString *)type andPhotoUploadStatus:(NSString *)uploadStatus
{    
    
    if ([type isEqualToString:@"blog_post_add"]) 
    {               
        return 200;
    }
    else if ([type isEqualToString:@"news_post_add"]) 
    {        
        return 150;
    }
    else if ([type isEqualToString:@"friend_add"]) 
    {                
        return 190;
    }
    else if ([type isEqualToString:@"profile_avatar_change"]) 
    {        
        return 130;
    }
    else if ([type isEqualToString:@"profile_edit"]) 
    {        
        return 130;
    }
    else if ([type isEqualToString:@"profile_join"]) 
    {        
        return 130;
    }
    else if ([type isEqualToString:@"profile_comment"])
    {                
        return 175;
    }
    else if ([type isEqualToString:@"user_comment"]) 
    {        
        return 175;
    }
    else if ([type isEqualToString:@"post_classifieds_item"]) 
    {        
        return 50;
    }
    else if ([type isEqualToString:@"event_attend"]) 
    {        
        return 225;
    }
    else if ([type isEqualToString:@"event_add"]) 
    {        
        return 225;
    }
    else if ([type isEqualToString:@"group_add"])
    {        
        return 215;
    }
    else if ([type isEqualToString:@"group_join"])
    {        
        return 215;
    }
    else if ([type isEqualToString:@"photo_upload"]) 
    {       
        
        if ([uploadStatus isEqualToString:@"(null)"]||[uploadStatus isEqualToString:@""]||(uploadStatus == (id)[NSNull null])||([uploadStatus length] == 0)||(uploadStatus==NULL))
        {
            uploadStatus=@"";
        }
        
        if ([uploadStatus isEqualToString:@"Deleted Photo"]) 
        {
            return 160;
        }
        else
        {
            return 197;
        }
        
    }
    else if ([type isEqualToString:@"media_upload"]) 
    {        
        return 200;
    }
    else if ([type isEqualToString:@"music_upload"]) 
    {                
        return 200;
    }
    else if ([type isEqualToString:@"forum_add_topic"]) 
    {        
        return 200;
    }
    else if ([type isEqualToString:@"status_update"]) 
    {        
        return 130;
    }
    return 100;
}


#pragma mark IBAction

-(IBAction)clickedBackButton:(id)sender
{    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark Managing API Calls

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{    
	[respData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{   
    self.view.userInteractionEnabled=YES;
    likesConnected=NO;
    indicatorView.hidden=YES;
    [self stopLoading];
    self.view.userInteractionEnabled=YES;
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	return;
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{    
    likesConnected=NO;
    indicatorView.hidden=YES;
    self.view.userInteractionEnabled=YES;
    
	NSString *responseString = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
    
    NSError *error;
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *json = [responseString JSONValue];
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    [responseString release];
    CFRelease((CFTypeRef) parser);
          
    if (connection==newsFeedUrlconnection) 
    {
                     
        NSString *msgStr=(NSString*)[parsedData objectForKey:@"Message"];
        
        if([msgStr isEqualToString:@"Site suspended"])
        {            
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=1;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
            
        }
        else if ([msgStr isEqualToString:@"Session Expired"]) 
        {            
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
            
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=1;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
            
        }
        else if ([msgStr isEqualToString:@"Membership Denied"]) 
        {            
            UIAlertView * MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to view newsfeed." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
        }
        
        NSString *resultCount = (NSString*)[parsedData objectForKey:@"count"];
        
        if([resultCount intValue]==0)
        {
            [self stopLoading];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No newsfeeds found"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            
        }
        else
        {            
            NSArray *newsFeed = [json valueForKeyPath:@"result"];
            newsFeedsItemArray=[newsFeed copy];
            
            NSArray *picUrls = [json valueForKeyPath:@"result.Profile_Pic"];
            ProfilePicURLs=[picUrls copy];
            
            NSArray *FrdpicUrls = [json valueForKeyPath:@"result.Friend_Pic"];
            Friend_PicUrls=[FrdpicUrls copy];
            
            NSArray *uploadimgPicUrls=[json valueForKeyPath:@"result.ActionImage"];
            imgUpload_PicsUrls=[uploadimgPicUrls copy];
            
          
            NSArray *status=[json valueForKeyPath:@"result.Title"];
            statusArray=[[NSMutableArray alloc]initWithArray:status copyItems:YES];
                                             
            for (int i=0; i<[imgUpload_PicsUrls count]; i++)
            {               
                
                if (([imgUpload_PicsUrls objectAtIndex:i]== (id)[NSNull null])||([imgUpload_PicsUrls objectAtIndex:i]==NULL))
                {
                    
                    NSString *str=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:i] valueForKey:@"entityType"];
                                        
                    if ([str isEqualToString:@"event_attend"]||[str isEqualToString:@"event_add"]) 
                    {                        
                        UIImage *myimage =[UIImage imageNamed:@"event_default.png"];
                        [imgUpload_Pics addObject:myimage];
                    }
                    else
                    {
                        UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                        [imgUpload_Pics addObject:myimage];
                    }
                    
                }
                else
                {   domain=@"http://blugay.net";
                    NSString *fullpath_picurl=[NSString stringWithFormat:@"%@/%@",domain,[imgUpload_PicsUrls objectAtIndex:i]];
                    NSData *mydata = [[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:fullpath_picurl]] autorelease];
                                        
                    if (mydata)
                    {                        
                        UIImage *myimage = [[[UIImage alloc] initWithData:mydata] autorelease];
                        
                        if (myimage) 
                        {                            
                            [imgUpload_Pics addObject:myimage];
                        }
                        else 
                        {                            
                            NSString *str=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:i] valueForKey:@"entityType"];
                            
                            
                            if ([str isEqualToString:@"event_attend"]||[str isEqualToString:@"event_add"]) 
                            {                                
                                UIImage *myimage =[UIImage imageNamed:@"event_default.png"];
                                [imgUpload_Pics addObject:myimage];
                                
                            }
                            else
                            {
                                UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                                [imgUpload_Pics addObject:myimage];
                            }
                        }
                        
                    }
                    else 
                    {                        
                        NSString *str=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:i] valueForKey:@"entityType"];
                                                
                        if ([str isEqualToString:@"event_attend"]||[str isEqualToString:@"event_add"]) 
                        {                            
                            UIImage *myimage =[UIImage imageNamed:@"event_default.png"];
                            [imgUpload_Pics addObject:myimage];
                            
                        }
                        else
                        {
                            UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                            [imgUpload_Pics addObject:myimage];
                        }
                        
                    }
                    
                }
                
            }
                        
        }
        
        [newsFeedTV reloadData];
        [self stopLoading];

    }
    else if(connection==likeUrlconnection)
    {        
        NSString *msgStr=(NSString*)[parsedData objectForKey:@"Message"];
        
        if([msgStr isEqualToString:@"Site suspended"])
        {            
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=1;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
            
        }
        else if ([msgStr isEqualToString:@"Session Expired"]) 
        {            
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
            
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=1;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
            
        }
        else if ([msgStr isEqualToString:@"Membership Denied"]) 
        {            
            UIAlertView * MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
            
        }
        else if([msgStr isEqualToString:@"Success"])
        {            
            NSString *entityType=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] valueForKey:@"likecount"];
            if ( (entityType == (id)[NSNull null])
                || (entityType == NULL)
                || ([entityType isEqualToString:@""])
                || ([entityType length] == 0) )
            {
            }
            else
            {            
                int likecount=[entityType intValue]+1;
                NSString *likecountStr=[NSString stringWithFormat:@"%d",likecount];
            
                [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:likecountStr forKey:@"likecount"];
                [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:@"Liked" forKey:@"LikeStatusID"];
            
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedLike inSection:0];

                [newsFeedTV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
            }
           
        }
        else
        {
            UIAlertView * alertFailed = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Failed to like the post." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertFailed show];
            [alertFailed release];
        }
        
    }
    else if(connection==UnlikeUrlconnection)
    {        
        NSString *msgStr=(NSString*)[parsedData objectForKey:@"Message"];
        
        if([msgStr isEqualToString:@"Site suspended"])
        {            
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=1;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
            
        }
        else if ([msgStr isEqualToString:@"Session Expired"]) 
        {            
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
            
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=1;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
            
        }
        else if ([msgStr isEqualToString:@"Membership Denied"]) 
        {            
            UIAlertView * MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
            
        }
        else if([msgStr isEqualToString:@"Success"])
        {            
            NSString *entityType=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] valueForKey:@"likecount"];
            if ( (entityType == (id)[NSNull null])
                || (entityType == NULL)
                || ([entityType isEqualToString:@""])
                || ([entityType length] == 0) )
            {
            }
            else
            {
                int likecount=[entityType intValue]-1;
                NSString *likecountStr=[NSString stringWithFormat:@"%d",likecount];
            
                [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:likecountStr forKey:@"likecount"];
                [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:@"UnLiked" forKey:@"LikeStatusID"];
            
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedLike inSection:0];
                [newsFeedTV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
            
            }
        }
        else
        {
            UIAlertView * alertFailed = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Failed to unlike the post." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];          
            [alertFailed show];
            [alertFailed release];
        }

        
    }
        
}


#pragma mark Alert View Delegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    
    if (actionSheet.tag==1) 
    {
        if (buttonIndex == 0)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
    }
    
}

@end
