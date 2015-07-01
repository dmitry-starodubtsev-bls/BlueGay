//
//  SearchMembersView.m
//  Chk
//
//  Created by SODTechnologies on 12/09/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "SearchMembersView.h"
#import "SearchSavedView.h"
#import "SearchResults.h"
#import "SkadateAppDelegate.h"
#import "JSON.h"
#import "HomeView.h"
#import "OnlineMembers.h"
#import <StoreKit/StoreKit.h>

@implementation SearchMembersView
@synthesize stateTxtField;
@synthesize countryTxtField;
@synthesize uiCountryPickerView;
@synthesize uiStatePickerView;
@synthesize uiCityPickerView;
@synthesize countryPicker;
@synthesize statePicker;
@synthesize cityPicker;
@synthesize strSelectedZipStore,strCityCodeStore,strPswStore,countrynamesArray,countryCodeArray,cityNamesArray,countryId,countryName;
@synthesize countryback;
@synthesize indicatorLabel,indicatorView,objIndicatorView;
@synthesize txtCity;
@synthesize lblCity;
@synthesize btnHome;
@synthesize scrollsearchedMembers,btnSearch;
@synthesize minAgePicker;
@synthesize maxAgePicker;
@synthesize minAgeLabel;
@synthesize maxAgeLabel;
@synthesize minAgeArray;
@synthesize lblsta;
@synthesize maxAgeArray,milesFrom,zipCode,control,domain;
@synthesize selectedCityLbl,selectedRegionLbl,selectedCountryLbl;
@synthesize uiMinAgePickerView, uiMaxAgePickerView, segmentCtrlMinAge, segmentCtrlMaxAge;
@synthesize imgBGAge;
@synthesize imgBGIam;
@synthesize imgBGLookingFor;
@synthesize imgBGCheckboxes;
@synthesize lblFrom;
@synthesize lblTo;
@synthesize lblYearsOld;
@synthesize lblMilesFrom;
@synthesize lblZip;
@synthesize lblOnlineOnly;
@synthesize btnMinAge;
@synthesize btnMaxAge;
@synthesize lblcontry;
@synthesize segmentControlCountry;
@synthesize segmentControlState;
@synthesize segmentControlCity;
@synthesize fromView;
@synthesize NewXval;

#pragma mark Memory Management

- (void)dealloc
{
    [countryback release];
    [lblsta release];
    [lblcontry release];
    [uiCountryPickerView release];
    [uiStatePickerView release];
    [uiCityPickerView release];
    [countryPicker release];
    [statePicker release];
    [cityPicker release];
    [countryTxtField release];
    [stateTxtField release];
    [segmentControlCountry release];
    [segmentControlState release];
    [segmentControlCity release];
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
-(void)HiddenAllPickers
{      
    
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
       
    
    uiCountryPickerView.hidden = YES;
    uiStatePickerView.hidden = YES;
    uiCityPickerView.hidden = YES;
    
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    
      
    btnMinAge.hidden = NO;
    btnMaxAge.hidden =  NO;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
    lblcontry.hidden=NO;

    scrollsearchedMembers.scrollEnabled=YES;
    txtCity.enabled=YES;
    stateTxtField.enabled=YES;
    countryTxtField.enabled=YES;
    btnMaxAge.enabled=YES;
    btnMinAge.enabled=YES;
    
    
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
        indicatorView = [[UIView alloc] initWithFrame:CGRectMake((85 + NewXval), 200,  (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30),(objIndicatorView.frame.size.height+20))];
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


-(void) orientationForIpad
{
    /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self HiddenAllPickers];
        
        if (self.interfaceOrientation==UIInterfaceOrientationPortrait || self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
        {
            [scrollsearchedMembers setFrame:(CGRectMake(0, 44, 768, 1200))];
            [imgBGIam setFrame:(CGRectMake(150, 60, 450, 125))];
            [btnMale setFrame:CGRectMake(200, 110, 60, 60)];
            [btnFemale setFrame:CGRectMake(300, 110, 60, 60)];
            [btnCouple setFrame:CGRectMake(400, 110, 60, 60)];
            [btnGroup setFrame:CGRectMake(500, 110, 60, 60)];
            [imgBGLookingFor setFrame:(CGRectMake(150, 195, 450, 125))];
            [btnLFMale setFrame:CGRectMake(200, 245, 60, 60)];
            [btnLFFemale setFrame:CGRectMake(300, 245, 60, 60)];
            [btnLFCouple setFrame:CGRectMake(400, 245, 60, 60)];
            [btnLFGroup setFrame:CGRectMake(500, 245, 60, 60)];
            [imgBGAge setFrame:(CGRectMake(150, 330, 450, 110))];
            [lblFrom setFrame:CGRectMake(200, 390, 40, 25)];
            [minAgeLabel setFrame:CGRectMake(260, 390, 40, 25)];
            [btnMinAge setFrame:CGRectMake(250, 390, 60, 25)];
            [lblTo setFrame:CGRectMake(360, 390, 40, 25)];
            [maxAgeLabel setFrame:CGRectMake(400, 390, 40, 25)];
            [btnMaxAge setFrame:CGRectMake(390, 390, 60, 25)];
            [lblYearsOld setFrame:CGRectMake(470+12, 370, 100, 60)];
            [selectedCountryLbl setFrame:(CGRectMake(320, 513, 250, 29))];
            countryTxtField.frame=CGRectMake(200, 512, 350, 30);
            [lblcontry setFrame:(CGRectMake(215, 513, 60, 27))];
            stateTxtField.frame=CGRectMake(200, 558, 350, 30);
            [selectedRegionLbl setFrame:(CGRectMake(320, 558, 250, 29))];
            [lblsta setFrame:(CGRectMake(215, 559, 60, 27))];
            [lblCity setFrame:CGRectMake(215, 600, 60, 40)];
            txtCity.frame=CGRectMake(200, 605, 350, 30);
            selectedCityLbl.frame=CGRectMake(320, 607, 200, 29);
            [uiCountryPickerView setFrame:CGRectMake(0, 540, 768, 270)];
            [uiStatePickerView setFrame:CGRectMake(0, 593, 768, 270)];
            [uiCityPickerView setFrame:CGRectMake(0, 645, 768, 270)];
            
            if(sta==YES)
            {
                countryback.image=[UIImage imageNamed:@"location_field2.PNG"];
                [countryback setFrame:(CGRectMake(150, 450, 450, 190))];
                [imgBGCheckboxes setFrame:(CGRectMake(150, 660, 450, 50))];
                [btnOnlineOnly setFrame:CGRectMake(200, 670, 30, 30)];
                [lblOnlineOnly setFrame:CGRectMake(240, 670, 100, 30)];
                [btnWithPhotoOnly setFrame:CGRectMake(395, 670, 30, 30)];
                [lblWithPhotoOnly setFrame:CGRectMake(437, 670, 150, 30)];
                [lblMilesFrom setFrame:CGRectMake(280, 593, 100, 40)];
                [milesFrom setFrame:CGRectMake(200, 603, 60, 25)];
                [lblZip setFrame:CGRectMake(530, 593, 100, 40)];
                [zipCode setFrame:CGRectMake(448, 603, 60, 25)];
                [btnSearch setFrame:(CGRectMake(220, 730, 300, 50))];
            }
            else
            {
                if(cit==YES)
                {
                    countryback.image=[UIImage imageNamed:@"location_field3.png"];
                    [countryback setFrame:(CGRectMake(150, 450, 450, 240))];
                    [imgBGCheckboxes setFrame:(CGRectMake(150, 700, 450, 50))];
                    [btnOnlineOnly setFrame:CGRectMake(200, 710, 30, 30)];
                    [lblOnlineOnly setFrame:CGRectMake(240, 710, 100, 30)];
                    [btnWithPhotoOnly setFrame:CGRectMake(395, 710, 30, 30)];
                    [lblWithPhotoOnly setFrame:CGRectMake(437, 710, 150, 30)];
                    [lblMilesFrom setFrame:CGRectMake(280, 635,100, 40)];
                    [milesFrom setFrame:CGRectMake(200, 645, 60, 25)];
                    [lblZip setFrame:CGRectMake(530, 635, 100, 40)];
                    [zipCode setFrame:CGRectMake(448, 645, 60, 25)];
                    [btnSearch setFrame:(CGRectMake(220, 770, 300, 50))];
                }
                else
                {
                    countryback.image=[UIImage imageNamed:@"location_field.png"];
                    [countryback setFrame:(CGRectMake(150, 450, 450, 140))];
                    [imgBGCheckboxes setFrame:(CGRectMake(150, 620, 450, 50))];
                    [btnOnlineOnly setFrame:CGRectMake(200, 630, 30, 30)];
                    [lblOnlineOnly setFrame:CGRectMake(240, 630, 100, 30)];
                    [btnWithPhotoOnly setFrame:CGRectMake(395, 630, 30, 30)];
                    [lblWithPhotoOnly setFrame:CGRectMake(437, 630, 150, 30)];
                    [lblMilesFrom setFrame:CGRectMake(280, 545, 100, 40)];
                    [milesFrom setFrame:CGRectMake(200, 555, 60, 25)];
                    [lblZip setFrame:CGRectMake(530, 545, 100, 40)];
                    [zipCode setFrame:CGRectMake(448, 555, 60, 25)];
                    [btnSearch setFrame:(CGRectMake(220, 690, 300, 50))];
                }
            }
        }
        
        else if (self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            [scrollsearchedMembers setFrame:(CGRectMake(0, 44, 1024, 1000))];
            [imgBGIam setFrame:(CGRectMake(280, 60, 450, 120))];
            [btnMale setFrame:CGRectMake(330, 110, 60, 60)];
            [btnFemale setFrame:CGRectMake(430, 110, 60, 60)];
            [btnCouple setFrame:CGRectMake(530, 110, 60, 60)];
            [btnGroup setFrame:CGRectMake(630, 110, 60, 60)];
            [imgBGLookingFor setFrame:(CGRectMake(280, 190, 450, 130))];
            [btnLFMale setFrame:CGRectMake(330, 245, 60, 60)];
            [btnLFFemale setFrame:CGRectMake(430, 245, 60, 60)];
            [btnLFCouple setFrame:CGRectMake(530, 245, 60, 60)];
            [btnLFGroup setFrame:CGRectMake(630, 245, 60, 60)];
            [imgBGAge setFrame:(CGRectMake(280, 330, 450, 110))];
            [lblFrom setFrame:CGRectMake(330, 390, 40, 25)];
            [minAgeLabel setFrame:CGRectMake(390, 390, 40, 25)];
            [btnMinAge setFrame:CGRectMake(380, 390, 60, 25)];
            [lblTo setFrame:CGRectMake(490, 390, 40, 25)];
            [maxAgeLabel setFrame:CGRectMake(530, 390, 40, 25)];
            [btnMaxAge setFrame:CGRectMake(520, 390, 60, 25)];
            [lblYearsOld setFrame:CGRectMake(616, 370, 100, 60)];
            [selectedCountryLbl setFrame:(CGRectMake(450, 513, 250, 30))];
            countryTxtField.frame=CGRectMake(315, 512, 372, 30);
            [lblcontry setFrame:(CGRectMake(330, 513, 60, 27))];
            stateTxtField.frame=CGRectMake(315, 558, 372, 30);
            [selectedRegionLbl setFrame:(CGRectMake(450, 558, 250, 30))];
            [lblsta setFrame:(CGRectMake(330, 559, 60, 27))];
            txtCity.frame=CGRectMake(315, 605, 372, 30);
            [lblCity setFrame:CGRectMake(330, 600, 70, 40)];
            selectedCityLbl.frame=CGRectMake(450, 607, 200, 29);
            [uiCountryPickerView setFrame:CGRectMake(0, 520, 1024, 270)];
            [uiStatePickerView setFrame:CGRectMake(0, 593, 1024, 270)];
            [uiCityPickerView setFrame:CGRectMake(0, 645, 1024, 270)];
            
            if(sta==YES)
            {
                countryback.image=[UIImage imageNamed:@"location_field2.PNG"];
                [countryback setFrame:(CGRectMake(280, 455, 450, 190))];
                [imgBGCheckboxes setFrame:(CGRectMake(280, 660, 450, 50))];
                [btnOnlineOnly setFrame:CGRectMake(330, 670, 30, 30)];
                [lblOnlineOnly setFrame:CGRectMake(370, 670, 100, 30)];
                [btnWithPhotoOnly setFrame:CGRectMake(530, 670, 30, 30)];
                [lblWithPhotoOnly setFrame:CGRectMake(570, 670, 150, 30)];
                [lblMilesFrom setFrame:CGRectMake(390, 593, 100, 40)];
                [milesFrom setFrame:CGRectMake(315, 603, 60, 25)];
                [lblZip setFrame:CGRectMake(661, 593, 100, 40)];
                [zipCode setFrame:CGRectMake(591, 603, 60, 25)];
                [btnSearch setFrame:(CGRectMake(350, 730, 300, 50))];
            }
            else
            {
                if(cit==YES)
                {
                    countryback.image=[UIImage imageNamed:@"location_field3.png"];
                    [countryback setFrame:(CGRectMake(280, 455, 450, 240))];
                    [imgBGCheckboxes setFrame:(CGRectMake(280, 710, 450, 50))];
                    [btnOnlineOnly setFrame:CGRectMake(330, 720, 30, 30)];
                    [lblOnlineOnly setFrame:CGRectMake(370, 720, 100, 30)];
                    [btnWithPhotoOnly setFrame:CGRectMake(530, 720, 30, 30)];
                    [lblWithPhotoOnly setFrame:CGRectMake(570, 720, 150, 30)];
                    [lblMilesFrom setFrame:CGRectMake(390,645, 100, 40)];
                    [milesFrom setFrame:CGRectMake(315, 655, 60, 25)];
                    [lblZip setFrame:CGRectMake(661, 645, 100, 40)];
                    [zipCode setFrame:CGRectMake(591, 655, 60, 25)];
                    [btnSearch setFrame:(CGRectMake(350, 780, 300, 50))];
                }
                else
                {
                    countryback.image=[UIImage imageNamed:@"location_field.png"];
                    [countryback setFrame:(CGRectMake(280, 455, 450, 140))];
                    [imgBGCheckboxes setFrame:(CGRectMake(280, 620, 450, 50))];
                    [btnOnlineOnly setFrame:CGRectMake(330, 630, 30, 30)];
                    [lblOnlineOnly setFrame:CGRectMake(370, 630, 100, 30)];
                    [btnWithPhotoOnly setFrame:CGRectMake(530, 630, 30, 30)];
                    [lblWithPhotoOnly setFrame:CGRectMake(570, 630, 150, 30)];
                    [btnSearch setFrame:(CGRectMake(350, 690, 300, 50))];
                    [lblMilesFrom setFrame:CGRectMake(390, 550, 100, 40)];
                    [milesFrom setFrame:CGRectMake(315, 560, 60, 25)];
                    [lblZip setFrame:CGRectMake(661, 550, 100, 40)];
                    [zipCode setFrame:CGRectMake(591, 560, 60, 25)];
                }
            }
        }
    }*/
    //else
    //{
        if(sta==YES)
        {
           [countryback setFrame:(CGRectMake(12, 281, 310, 153))];
            countryback.image=[UIImage imageNamed:@"location_field2.PNG"];
            [imgBGCheckboxes setFrame:(CGRectMake(13, 540, 308, 50))];
            [btnOnlineOnly setFrame:CGRectMake(30, 550, 25, 23)];
            [lblOnlineOnly setFrame:CGRectMake(58, 550, 100, 30)];
            [btnWithPhotoOnly setFrame:CGRectMake(163, 550, 25, 23)];
            [lblWithPhotoOnly setFrame:CGRectMake(191, 550, 150, 30)];
            milesFrom.frame=CGRectMake(20, 493, 80,31);
            lblMilesFrom.frame=CGRectMake(107,500, 82,21);
            zipCode.frame=CGRectMake(191, 493, 85,31);
            lblZip.frame=CGRectMake(285, 500, 30,21);
            btnSearch.frame=CGRectMake(17, 595, 300, 50);
        }
        else
        {
            if(cit==YES)
            {                 [countryback setFrame:(CGRectMake(12, 381, 310, 187))];
                countryback.image=[UIImage imageNamed:@"location_field3.png"];
                [imgBGCheckboxes setFrame:(CGRectMake(13, 575, 308, 50))];
                [btnOnlineOnly setFrame:CGRectMake(30, 585, 25, 23)];
                [lblOnlineOnly setFrame:CGRectMake(58, 585, 100, 30)];
                [btnWithPhotoOnly setFrame:CGRectMake(163, 585, 25, 23)];
                [lblWithPhotoOnly setFrame:CGRectMake(191, 585, 150, 30)];
                milesFrom.frame=CGRectMake(20, 529, 80,31);
                lblMilesFrom.frame=CGRectMake(107,532, 82,21);
                zipCode.frame=CGRectMake(191, 529, 85,31);
                lblZip.frame=CGRectMake(285, 532, 30,21);
                btnSearch.frame=CGRectMake(17, 635, 300, 50);
            }
            else
            {
                
                [countryback setFrame:(CGRectMake(12, 161, 310, 116))];
                countryback.image=[UIImage imageNamed:@"location_field.png"];
                [imgBGCheckboxes setFrame:(CGRectMake(13, 302, 308, 50))];
                [btnOnlineOnly setFrame:CGRectMake(30, 312, 25, 23)];
                [lblOnlineOnly setFrame:CGRectMake(58, 312, 100, 30)];
                [btnWithPhotoOnly setFrame:CGRectMake(163, 312, 25, 23)];
                [lblWithPhotoOnly setFrame:CGRectMake(191, 312, 150, 30)];
                milesFrom.frame=CGRectMake(20, 238, 80,31);
                lblMilesFrom.frame=CGRectMake(107,243, 82,21);
                zipCode.frame=CGRectMake(191, 238, 85,31);
                lblZip.frame=CGRectMake(285, 243, 30,21);
                btnSearch.frame=CGRectMake(17, 365, 300, 50);
            }
        }
        
        if ((selectedRegionLbl.hidden==YES) && (selectedCityLbl.hidden==YES) )
        {
            if(isStateCountZero)
            {
                 scrollsearchedMembers.contentSize=CGSizeMake(320,1088);
            }
            else
            {
                scrollsearchedMembers.contentSize=CGSizeMake(320,1095);
            }
        }
        else if ((selectedRegionLbl.hidden==NO) && (selectedCityLbl.hidden==YES) )
        {
            if(isCityCountZero)
            {
                scrollsearchedMembers.contentSize=CGSizeMake(320,1123);
            }
            else
            {
                scrollsearchedMembers.contentSize=CGSizeMake(320,1127);
            }
        }
        else if ((selectedRegionLbl.hidden==NO) && (selectedCityLbl.hidden==NO) )
        {
            scrollsearchedMembers.contentSize=CGSizeMake(320,1188);
        }
    //}
}

-(void) fillCountry 
{    
    countrynamesArray = [[NSMutableArray alloc] init];
    countryCodeArray= [[NSMutableArray alloc] init];
    NSString *Path = [[NSBundle mainBundle]bundlePath];
	NSString *DataPath = [Path stringByAppendingPathComponent:@"country.xml"];
	NSData *Data = [[NSData alloc]initWithContentsOfFile:DataPath];
    rssParser = [[NSXMLParser alloc] initWithData:Data];
	[Data release];
    [rssParser setDelegate:self];
    [rssParser setShouldProcessNamespaces:NO];
    [rssParser setShouldReportNamespacePrefixes:NO];
    [rssParser setShouldResolveExternalEntities:NO];
    [rssParser parse];
}

-(void) indicator
{
    // starting indicator view
    //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    //{
        indicatorView = [[UIView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
    //}
    /*else
    {
        if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft)
        {
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake(364, 234, 300, 300)];
        }
        else 
        {
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake(250, 310, 300, 300)];
        }
    }*/
    indicatorView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    indicatorView.clipsToBounds = YES;
    indicatorView.layer.cornerRadius = 10.0;
    objIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    //{
        objIndicatorView.frame = CGRectMake(65, 40, objIndicatorView.bounds.size.width, objIndicatorView.bounds.size.height);
    //}
    //else
    //{
    //    objIndicatorView.frame = CGRectMake(130, 100, objIndicatorView.bounds.size.width, objIndicatorView.bounds.size.height);
    //}
    [indicatorView addSubview:objIndicatorView];
    //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    //{
        indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
    //}
    //else
    //{
    //    indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 200, 150, 30)];
    //}
    indicatorLabel.backgroundColor = [UIColor clearColor];
    indicatorLabel.textColor = [UIColor whiteColor];
    indicatorLabel.adjustsFontSizeToFitWidth = YES;
    indicatorLabel.textAlignment = NSTextAlignmentCenter;
    indicatorLabel.text = @"Contacting server...";
    [indicatorView addSubview:indicatorLabel];
    [self.view addSubview:indicatorView];
    [self.view bringSubviewToFront:indicatorView];
    [objIndicatorView startAnimating];
}


#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //btnMinAge.placeholder = @"18";
    //btnMaxAge.placeholder = @"100";
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    
    // get configs
    responseData = [[NSMutableData data] retain];
    urlReqConfig=[NSString stringWithFormat:@"%@/mobile/getSearchConf/?",domain];
    
    NSURL *url = [NSURL URLWithString:[urlReqConfig stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    GetConfigURLConnection=[[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
    
    btnMaxAge.layer.cornerRadius = 5;
    btnMinAge.layer.cornerRadius = 5;
    [btnMinAge setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [btnMaxAge setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    selectedCityLbl.text=@"Please Select";
    selectedCountryLbl.text=@"Please Select";
    selectedRegionLbl.text=@"Please Select";
        
    milesFrom.frame=CGRectMake(20, 480, 80,31);
    lblMilesFrom.frame=CGRectMake(107,485, 82,21);
    zipCode.frame=CGRectMake(192, 480, 85,31);
    lblZip.frame=CGRectMake(285, 485, 30,21);
    sta=cit=NO;
    //control.segmentedControlStyle = UISegmentedControlStyleBar;
    
    [self performSelector:@selector(fillCountry) withObject:nil];
 
    /*if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if (self.interfaceOrientation==UIInterfaceOrientationPortrait || self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
        {           
            self.uiCountryPickerView.frame=CGRectMake(0, 546, 768, 46);
            self.uiStatePickerView.frame=CGRectMake(0, 590, 768, 46);
            self.uiCityPickerView.frame=CGRectMake(0, 535, 768, 46);
        }
        else if (self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {          
            self.uiCountryPickerView.frame=CGRectMake(0, 546, 1024, 46);
            self.uiStatePickerView.frame=CGRectMake(0, 590, 1024, 46);
            self.uiCityPickerView.frame=CGRectMake(0, 535, 1024, 46);
        }
    }*/
  
    selectedCountryLbl.text=@"Please Select";
    selectedCountryLbl.textColor=[UIColor darkGrayColor];
    selectedRegionLbl.textColor=[UIColor darkGrayColor];
    selectedCityLbl.text=@"Please Select";
    selectedCityLbl.textColor=[UIColor darkGrayColor];
  
    selectedRegionLbl.text=@"Please Select";
    UIColor *newTintColor = [UIColor colorWithRed: 245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    control.tintColor = newTintColor;
    UIColor *newSelectedTintColor = [UIColor colorWithRed: 245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
     [[[control subviews] objectAtIndex:0] setTintColor:newSelectedTintColor];
    flag = 0;
    segmentCtrlMinAge.momentary = YES;
    segmentCtrlMaxAge.momentary = YES;
    segmentControlCity.momentary=YES;
    segmentControlState.momentary=YES;
    segmentControlCountry.momentary=YES;
    
    
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    searchmemberlab.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [searchmemberlab setTextAlignment:NSTextAlignmentCenter];
    searchmemberlab.text=@"Search Members";
    //NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //domain = [prefs stringForKey:@"URL"];
    [milesFrom setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [countryTxtField setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [stateTxtField setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [txtCity setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [zipCode setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    UITapGestureRecognizer *tapMinAgePicker = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPicker:)];
    tapMinAgePicker.cancelsTouchesInView = NO;
    UITapGestureRecognizer *tapMaxAgePicker = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPicker:)];
    tapMaxAgePicker.cancelsTouchesInView = NO;
    [minAgePicker addGestureRecognizer:tapMinAgePicker];
    [maxAgePicker addGestureRecognizer:tapMaxAgePicker];
    [tapMinAgePicker release];
    [tapMaxAgePicker release];
    iamMaleBtnClicked=NO;
    lfFemaleBtnCLicked=NO;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.cancelsTouchesInView = NO;
    scrollsearchedMembers.canCancelContentTouches = NO;
    [scrollsearchedMembers flashScrollIndicators];
    iamMaleBtnClicked=YES;
    lfFemaleBtnCLicked=NO;
    onlineOnly=NO;
    withPhotoOnly=NO;
    
    /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        scrollsearchedMembers.scrollEnabled=YES;
        scrollsearchedMembers.contentSize=CGSizeMake(320,1095);
    }
    else
    {
        scrollsearchedMembers.contentSize=CGSizeMake(320,1130);
    }*/
    
    stateTxtField.hidden=YES;
    selectedRegionLbl.hidden=YES;
    selectedCityLbl.hidden=YES;
    lblsta.hidden=YES;
    txtCity.hidden=YES;
    lblCity.hidden=YES;
    
    selectedCountryId=@"";
    selectedRegionId=@"";
    strCityCodeStore=@"";
    
    CGRect frame = control.frame;
    [control setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 45)];
    
    UIImage* seg0 = [UIImage imageNamed:@"New_tab_over.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        seg0 = [seg0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [control setImage:seg0 forSegmentAtIndex:0];
    
    UIImage* seg1 = [UIImage imageNamed:@"Saved_tab.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        seg1 = [seg1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [control setImage:seg1 forSegmentAtIndex:1];
    
    segmentControlCountry.clipsToBounds = YES;
    segmentControlCountry.layer.cornerRadius = 7.0;
    segmentControlCountry.tintColor = [UIColor darkGrayColor];
    
    UIImage* segC0 = [UIImage imageNamed:@"Home_SignUp_5_03.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        segC0 = [segC0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [segmentControlCountry setImage:segC0 forSegmentAtIndex:0];
    
    UIImage* segC1 = [UIImage imageNamed:@"Home_SignUp_5_03-02.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        segC1 = [segC1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [segmentControlCountry setImage:segC1 forSegmentAtIndex:1];
    
    segmentControlState.clipsToBounds = YES;
    segmentControlState.layer.cornerRadius = 7.0;
    segmentControlState.tintColor = [UIColor darkGrayColor];
    
    UIImage* segS0 = [UIImage imageNamed:@"Home_SignUp_5_03.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        segS0 = [segS0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [segmentControlState setImage:segS0 forSegmentAtIndex:0];
    
    UIImage* segS1 = [UIImage imageNamed:@"Home_SignUp_5_03-02.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        segS1 = [segS1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [segmentControlState setImage:segS1 forSegmentAtIndex:1];
    
    segmentControlCity.clipsToBounds = YES;
    segmentControlCity.layer.cornerRadius = 7.0;
    segmentControlCity.tintColor = [UIColor darkGrayColor];
    
    UIImage* segCi0 = [UIImage imageNamed:@"Home_SignUp_5_03.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        segCi0 = [segCi0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [segmentControlCity setImage:segCi0 forSegmentAtIndex:0];
    
    UIImage* segCi1 = [UIImage imageNamed:@"Home_SignUp_5_03-02.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        segCi1 = [segCi1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [segmentControlCity setImage:segCi1 forSegmentAtIndex:1];
    
    segmentCtrlMinAge.clipsToBounds = YES;
    segmentCtrlMinAge.layer.cornerRadius = 7.0;
    segmentCtrlMinAge.tintColor = [UIColor darkGrayColor];
    
    UIImage* segMi0 = [UIImage imageNamed:@"Home_SignUp_5_03.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        segMi0 = [segMi0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [segmentCtrlMinAge setImage:segMi0 forSegmentAtIndex:0];
    
    UIImage* segMi1 = [UIImage imageNamed:@"Home_SignUp_5_03-02.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        segMi1 = [segMi1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [segmentCtrlMinAge setImage:segMi1 forSegmentAtIndex:1];
    
    segmentCtrlMaxAge.clipsToBounds = YES;
    segmentCtrlMaxAge.layer.cornerRadius = 7.0;
    segmentCtrlMaxAge.tintColor = [UIColor darkGrayColor];
    
    UIImage* segMa0 = [UIImage imageNamed:@"Home_SignUp_5_03.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        segMa0 = [segMa0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [segmentCtrlMaxAge setImage:segMa0 forSegmentAtIndex:0];
    
    UIImage* segMa1 = [UIImage imageNamed:@"Home_SignUp_5_03-02.png"];
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
        segMa1 = [segMa1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [segmentCtrlMaxAge setImage:segMa1 forSegmentAtIndex:1];
    
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
  //  request.testing = YES;
    [ _bannerView loadRequest:request];
    
    SKProductsRequest *request2 = [[SKProductsRequest alloc]
                                  initWithProductIdentifiers:[NSSet setWithArray:@[@"productid"]]];
    request2.delegate = self;
    [request2 start];

}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    for(SKProduct *product in response.products) {
        NSLog(@"%@", product);
    }
}

-(void) viewWillDisappear:(BOOL)animated 
{
    [super viewWillDisappear:animated];
	
    [[NSNotificationCenter defaultCenter]
	 removeObserver:self];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self orientationForIpad];
      
    if ( ![selectedCityLbl.text isEqual:@""] )
    {
    }
    else
    {
        txtCity.userInteractionEnabled=NO;
    }
}


- (void)viewDidUnload
{
    
    [self setCountryback:nil];
    [self setLblsta:nil];
   
    [self setLblcontry:nil];
    [self setUiCountryPickerView:nil];
    [self setUiStatePickerView:nil];
    [self setUiCityPickerView:nil];
    [self setCountryPicker:nil];
    [self setStatePicker:nil];
    [self setCityPicker:nil];
    [self setCountryTxtField:nil];
    [self setStateTxtField:nil];
    [self setSegmentControlCountry:nil];
    [self setSegmentControlState:nil];
    [self setSegmentControlCity:nil];
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
    
    /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self orientationForIpad];
        return YES;
    }
    else 
    {
        return NO;
    }*/
}

#pragma mark GestureRecognizer

- (void)handleTapPicker:(UIGestureRecognizer *)gestureRecognizer 
{
    
}

#pragma mark Managing API Calls

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{           
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{	
    [responseData appendData:data];
    indicatorView.hidden=YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    	NSLog(@"%@", error);
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
    self.view.userInteractionEnabled=YES;
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSError *error;
	SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    
    [responseData release];

	if(!responseString)
    {
        indicatorView.hidden=YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to retrieve data from the site. Kindly re-enter login credentials." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
    }
    
    NSString *MessageStr= (NSString*)[parsedData objectForKey:@"Message"];
    
    if([MessageStr isEqualToString:@"Site suspended"])
    {
        UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        sessionAlertView.tag=1;
        [sessionAlertView show];
        [sessionAlertView release];
        [responseString release];
        CFRelease((CFTypeRef) parser);
        return;
    }

    if (connection==GetConfigURLConnection)
    {
        btnMinAge.placeholder = [[parsedData objectForKey:@"minAge"] stringValue];
        btnMaxAge.placeholder = [[parsedData objectForKey:@"maxAge"] stringValue];
        
        minAgeArray = [[NSMutableArray alloc] init];
        
        for (int i = [[parsedData objectForKey:@"minAge"] intValue]; i <= [[parsedData objectForKey:@"maxAge"] intValue]; i ++)
        {
            NSString *myString = [NSString stringWithFormat:@"%d", i];
            [minAgeArray addObject:myString];
        }
        
        maxAgeArray = [[NSMutableArray alloc] init];
        
        for (int i = [[parsedData objectForKey:@"maxAge"] intValue]; i >= [[parsedData objectForKey:@"minAge"] intValue]; i --)
        {
            NSString *myString = [NSString stringWithFormat:@"%d", i];
            [maxAgeArray addObject:myString]; 
        }
        
        [minAgePicker reloadAllComponents];
        [maxAgePicker reloadAllComponents];
    }
    else if (connection==GetRegionURLConnection)
    {                  
        countrySelected=YES;
        NSString * count=(NSString *) [parsedData valueForKey:@"count"];
        if ([count intValue]==0)
        {
            isStateCountZero=YES;
            stateTxtField.hidden=YES;
            selectedRegionLbl.hidden=YES;
            selectedCityLbl.hidden=YES;
            lblsta.hidden=YES;
            txtCity.hidden=YES;
            lblCity.hidden=YES;
            sta=NO;
            cit=NO;
           [self orientationForIpad];
            
            txtCity.userInteractionEnabled=NO;
            selectedRegionLbl.text=@"";
            selectedRegionLbl.textColor=[UIColor darkGrayColor];
         
        }
        else
        {
            isStateCountZero=NO;
            stateTxtField.hidden=NO;
            selectedRegionLbl.hidden=NO;
            selectedCityLbl.hidden=YES;
            lblsta.hidden=NO;
            txtCity.userInteractionEnabled=NO;
            txtCity.hidden=YES;
            lblCity.hidden=YES;
            sta=YES;
            cit=NO;
            [self orientationForIpad];
            NSArray *sn = [parsedData valueForKeyPath:@"result.Name"];
            stateNamesArray=[[NSMutableArray alloc] initWithArray:sn copyItems:YES];
            int c = (int)[stateNamesArray count];
            NSArray *scodes = [parsedData valueForKeyPath:@"result.Code"];
            stateCodeArray=[[NSMutableArray alloc] initWithArray:scodes copyItems:YES];
            
            if(c>0)
            {
                if ([stateNamesArray objectAtIndex:c-1]==(id)[NSNull null]||[stateNamesArray objectAtIndex:c-1]==NULL)
                {
                }
                else
                {
                    if ([[stateNamesArray objectAtIndex:c-1] length]>0) 
                    {                        
                        if ([[stateNamesArray objectAtIndex:c-1] isEqualToString:@"(none)"])
                        {
                            [stateNamesArray removeLastObject];
                            [stateCodeArray removeLastObject];
                        }
                    }
                }
            }
           
            txtCity.userInteractionEnabled=YES;
            selectedRegionLbl.text=@"Please Select";
            selectedRegionLbl.textColor=[UIColor darkGrayColor];
          
        }
        [statePicker reloadAllComponents];
    }
    else if(connection==GetcityURLConnection)
    {          
        regionSelected=YES;
        countrySelected=YES;
        citySelected=YES;
        NSString * count=(NSString *) [parsedData valueForKey:@"count"];
        if ([count intValue]==0)
        {
            isCityCountZero=YES;
            txtCity.userInteractionEnabled=NO;
            txtCity.hidden=YES;
            lblCity.hidden=YES;
            selectedCityLbl.hidden=YES;
            sta=YES;
            cit=NO;
            [self orientationForIpad];
            
        }
        else
        {
            isCityCountZero=NO;
            txtCity.userInteractionEnabled=YES;
            txtCity.hidden=NO;
            lblCity.hidden=NO;
            selectedCityLbl.hidden=NO; 
            sta=NO;
            cit=YES;
            [self orientationForIpad];
            NSArray *cnames = [parsedData valueForKeyPath:@"result.Name"];
            cityNamesArray=[[NSMutableArray alloc] initWithArray:cnames copyItems:YES];
            NSArray *ccodes = [parsedData valueForKeyPath:@"result.Code"];
            cityCodeArray=[[NSMutableArray alloc] initWithArray:ccodes copyItems:YES];
            
            int c = (int)[cityNamesArray count];   // for handling none value
            
            if(c>0)
            {
                if ([cityNamesArray objectAtIndex:c-1]==(id)[NSNull null]||[cityNamesArray objectAtIndex:c-1]==NULL)
                {
                }
                else
                {
                    if ([[cityNamesArray objectAtIndex:c-1] length]>0) 
                    {                        
                        if ([[cityNamesArray objectAtIndex:c-1] isEqualToString:@"(none)"])
                        {
                            [cityNamesArray removeLastObject];
                            [cityCodeArray removeLastObject];
                        }
                    }
                }
            }              
        }
       
        selectedCityLbl.text=@"Please Select";
        [cityPicker reloadAllComponents];
    }
    
    [responseString release];
    CFRelease((CFTypeRef) parser);
}


#pragma mark AlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{        
    if (actionSheet.tag==1&&buttonIndex==0) 
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark NSXMLParserDelegat

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{    
    if ([elementName isEqualToString:@"Country_str_code"]) 
    {
        countryCodeFound=YES;
    }
    if ([elementName isEqualToString:@"Country_str_name"]) 
    {
        countryNameFound=YES;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{	
    if (countryCodeFound) 
    {
        [countryCodeArray addObject:string];
        countryCodeFound=NO;
    }
    if (countryNameFound)
    {
        [countrynamesArray addObject:string];
        countryNameFound=NO;
    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
}

#pragma mark IBActions

-(IBAction)regionSelBtnBtnClicked:(id)sender
{
}

-(IBAction)countrySelBtnBtnClicked:(id)sender
{
}

-(IBAction) clickedSegmentContol
{
	int selectedsegment = (int)control.selectedSegmentIndex;
	
	if (selectedsegment==0) 
	{
	}
	if (selectedsegment==1)
	{
        UIImage* seg0 = [UIImage imageNamed:@"New_tab_over.png"];
        if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
            seg0 = [seg0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [control setImage:seg0 forSegmentAtIndex:0];
        
        UIImage* seg1 = [UIImage imageNamed:@"Saved_tab.png"];
        if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)])
            seg1 = [seg1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [control setImage:seg1 forSegmentAtIndex:1];
        
        SearchSavedView *objSearchSavedView=[[SearchSavedView alloc]initWithNibName:@"SearchSavedView" bundle:nil];
        objSearchSavedView.fromView=fromView;
        control.selectedSegmentIndex=0;
        [self.navigationController pushViewController:objSearchSavedView animated:NO];
        [objSearchSavedView release];
    }
}

- (IBAction)minAgeAutoFill:(id)sender
{    
    NSString *chosenAge = [minAgeArray objectAtIndex:0];
    minAgeLabel.text = chosenAge;
    btnMinAge.placeholder = @"";
    indexMinAge = 0;
    [self minAgePickerDone:sender];
}

- (IBAction)maxAgeAutoFill:(id)sender
{    
    NSString *chosenAge = [maxAgeArray objectAtIndex:0];
    maxAgeLabel.text = chosenAge;
    indexMaxAge = 0;
    btnMaxAge.placeholder = @"";
    [self maxAgePickerDone:sender];
}

- (IBAction)countryAutoFill:(id)sender 
{    
    NSString *chosenAge = [countrynamesArray objectAtIndex:0];
    selectedCountryId=[countryCodeArray objectAtIndex:0];
    selectedCountryLbl.text = chosenAge;
    indexCountry = 0;
    [self countryPickerDone:sender];
}

- (IBAction)stateAutofill:(id)sender 
{    
    NSString *chosenAge = [stateNamesArray objectAtIndex:0];
    selectedRegionId=[stateCodeArray objectAtIndex:0];
    selectedRegionLbl.text = chosenAge;
    indexState = 0;
    [self statePickerDone:sender];
}

- (IBAction)cityAutoFill:(id)sender 
{    
    NSString *chosenAge = [cityNamesArray objectAtIndex:0];
    strCityCodeStore=[cityCodeArray objectAtIndex:0];
    selectedCityLbl.text=chosenAge;
    indexCity = 0;
    [self cityPickerDone:sender];
}

- (IBAction)clickedSegCtrlCountry:(id)sender
{    
    int selectedsegment = (int)segmentControlCountry.selectedSegmentIndex;
    if (selectedsegment==0) 
    {
        if (indexCountry!=0)
        {
            indexCountry--;
            [self pickerView:countryPicker didSelectRow:indexCountry inComponent:1];
            [countryPicker selectRow:indexCountry inComponent:0 animated:YES];
            [countryPicker reloadComponent:0];
        }
    }
    
    if (selectedsegment==1)
    {
        if (indexCountry<([countrynamesArray count]-1))
        {
            indexCountry++;
            [self pickerView:countryPicker didSelectRow:indexCountry inComponent:1];
            [countryPicker selectRow:indexCountry inComponent:0 animated:YES];
            [countryPicker reloadComponent:0];
        }
    }
    
}

- (IBAction)clickedSegCtrlState:(id)sender 
{
    int selectedsegment = (int)segmentControlState.selectedSegmentIndex;
    if (selectedsegment==0) 
    {
        if (indexState!=0)
        {
            indexState--;
            [self pickerView:statePicker didSelectRow:indexState inComponent:1];
            [statePicker selectRow:indexState inComponent:0 animated:YES];
            [statePicker reloadComponent:0];
        }
    }
    
    if (selectedsegment==1)
    {
        if (indexState<([stateNamesArray count]-1)) 
        {
            indexState++;
            [self pickerView:statePicker didSelectRow:indexState inComponent:1];
            [statePicker selectRow:indexState inComponent:0 animated:YES];
            [statePicker reloadComponent:0];
        }
    }
    
}


- (IBAction)clickedSegCtrlCity:(id)sender 
{    
    int selectedsegment = (int)segmentControlCity.selectedSegmentIndex;
    if (selectedsegment==0) 
    {
        if (indexCity!=0) 
        {
            indexCity--;
            [self pickerView:cityPicker didSelectRow:indexCity inComponent:1];
            [cityPicker selectRow:indexCity inComponent:0 animated:YES];
            [cityPicker reloadComponent:0];
        }
    }
    
    if (selectedsegment==1)
    {
        if (indexCity<([cityNamesArray count]-1)) 
        {
            indexCity++;
            [self pickerView:cityPicker didSelectRow:indexCity inComponent:1];
            [cityPicker selectRow:indexCity inComponent:0 animated:YES];
            [cityPicker reloadComponent:0];
        }
    }
    
}

-(IBAction)clickedHomeButton:(id) sender
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

- (IBAction)minAgePickerDone:(id)sender
{
    
    milesFrom.hidden = NO;
    zipCode.hidden = NO;
    lblOnlineOnly.hidden = NO;
    btnMinAge.hidden = NO;
    btnMaxAge.hidden =  NO;
    lblWithPhotoOnly.hidden = NO;
    btnOnlineOnly.hidden = NO;
    btnWithPhotoOnly.hidden = NO;
    btnSearch.hidden = NO;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
    scrollsearchedMembers.scrollEnabled=YES;
    btnMinAge.enabled=YES;
    btnMaxAge.enabled=YES;
    milesFrom.enabled=YES;
    zipCode.enabled=YES;
    countryTxtField.enabled=YES;
}

- (IBAction)maxAgePickerDone:(id)sender
{
    
    milesFrom.hidden = NO;
    zipCode.hidden = NO;
    btnMinAge.hidden = NO;
    btnMaxAge.hidden =  NO;
    lblOnlineOnly.hidden = NO;
    lblWithPhotoOnly.hidden = NO;
    btnOnlineOnly.hidden = NO;
    btnWithPhotoOnly.hidden = NO;
    btnSearch.hidden = NO;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
    scrollsearchedMembers.scrollEnabled=YES;
    btnMinAge.enabled=YES;
    btnMaxAge.enabled=YES;
    milesFrom.enabled=YES;
    zipCode.enabled=YES;
    countryTxtField.enabled=YES;
}


- (IBAction) clickedSegCtrlMinAge
{
    
    int selectedsegment = (int)segmentCtrlMinAge.selectedSegmentIndex;
    if (selectedsegment==0) 
    {
        if (indexMinAge!=0) 
        {
            indexMinAge--;
            [self pickerView:minAgePicker didSelectRow:indexMinAge inComponent:1];
            [minAgePicker selectRow:indexMinAge inComponent:0 animated:YES];
            [minAgePicker reloadComponent:0];
        }
    }
    
    if (selectedsegment==1)
    {
        if (indexMinAge<([minAgeArray count]-1)) 
        {
            indexMinAge++;
            [self pickerView:minAgePicker didSelectRow:indexMinAge inComponent:1];
            [minAgePicker selectRow:indexMinAge inComponent:0 animated:YES];
            [minAgePicker reloadComponent:0];
        }
    }
    
}

- (IBAction) clickedSegCtrlMaxAge
{    
    int selectedsegment = (int)segmentCtrlMaxAge.selectedSegmentIndex;
    if (selectedsegment==0) 
    {
        if (indexMaxAge!=0) 
        {
            indexMaxAge--;
            [self pickerView:maxAgePicker didSelectRow:indexMaxAge inComponent:1];
            [maxAgePicker selectRow:indexMaxAge inComponent:0 animated:YES];
            [maxAgePicker reloadComponent:0];
        }
    }
    
    if (selectedsegment==1)
    {
        if (indexMaxAge<([maxAgeArray count]-1)) 
        {
            indexMaxAge++;
            [self pickerView:maxAgePicker didSelectRow:indexMaxAge inComponent:1];
            [maxAgePicker selectRow:indexMaxAge inComponent:0 animated:YES];
            [maxAgePicker reloadComponent:0];
        }
    }
    
}

-(IBAction)btnSearchClicked:(id) sender
{    
    [milesFrom resignFirstResponder];
    [zipCode resignFirstResponder];
    int gender=0;
    int lookingfor=btnLFMale.tag;
    NSString *strOnlineOnly;
    NSString *strWithPhotoOnly;
   
   // if (iamMaleBtnClicked)
    //{
        gender = 2;
    //}
   /* else if (iamFemaleBtnCLicked)
    {
        gender = (int)btnFemale.tag;
    }
    else if (iamCoupleBtnClicked) 
    {
        gender = (int)btnCouple.tag;
    }
    else if (iamGroupBtnClicked) 
    {
        gender = (int)btnGroup.tag;
    }*/
    
   // if (lfMaleBtnClicked)
  //  {
         lookingfor+=2;
   // }
    
  /*  if (lfFemaleBtnCLicked)
    {
        lookingfor+=btnLFFemale.tag;
    }
    
    if (lfCoupleBtnClicked) 
    {
        lookingfor+=btnLFCouple.tag;
    }
    
    if (lfGroupBtnClicked) 
    {
        lookingfor+=btnLFGroup.tag;
    }*/
    
    if (gender==0) 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Please select your gender." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ; 
    }
    
    if (lookingfor==0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Please select looking for gender." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }
    
    if (onlineOnly == NO) 
    {
        strOnlineOnly = @"n";
    }
    else
    {
        strOnlineOnly = @"y";
    }
    
    if (withPhotoOnly == NO)
    {
        strWithPhotoOnly = @"n";
    }
    else
    {
        strWithPhotoOnly = @"y";
    }
    
    if([selectedCountryLbl.text length]==0||[selectedCountryLbl.text isEqualToString:@"Please Select"])
    {
        selectedCountryId=@"";
    }
    
    if([selectedRegionLbl.text length]==0||[selectedRegionLbl.text isEqualToString:@"Please Select"])
    {
        selectedRegionId=@"";
    }
    
    if([selectedCityLbl.text length]==0||[selectedCityLbl.text isEqualToString:@"Please Select"])
    {
        strCityCodeStore=@"";
    }
    
    SearchResults *objSearchResults=[[SearchResults alloc]initWithNibName:@"SearchResults" bundle:nil];
    objSearchResults.urlReq = [NSString stringWithFormat: @"%@//mobile/SearchByLimit/?id=%@&skey=%@&sex=%d&matchSex=%d&ageRangeFrom=%@&ageRangeTo=%@&country_id=%@&state_id=%@&city_id=%@&milesFrom=%@&zip=%@&onlineOnly=%@&withPhotoOnly=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,gender,lookingfor,minAgeLabel.text,maxAgeLabel.text,selectedCountryId,selectedRegionId,strCityCodeStore,milesFrom.text,zipCode.text,strOnlineOnly,strWithPhotoOnly];
  
    [self.navigationController pushViewController:objSearchResults animated:YES];
    [objSearchResults release];
    
}

- (IBAction)clickedOnlineOnly:(UIButton *)button
{      
    [milesFrom resignFirstResponder];
    [zipCode resignFirstResponder];
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    
    if (onlineOnly) 
    {
        [button setImage:[UIImage imageNamed:@"checkbox_normal.png"] forState:normal];
        onlineOnly=NO;
    }
    else 
    {
        [button setImage:[UIImage imageNamed:@"checkbox_cheched.png"] forState:normal];
        onlineOnly=YES;
    }
    
    milesFrom.hidden = NO;
    zipCode.hidden = NO;
    lblOnlineOnly.hidden = NO;
    lblWithPhotoOnly.hidden = NO;
    btnOnlineOnly.hidden = NO;
    btnWithPhotoOnly.hidden = NO;
    btnSearch.hidden = NO;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
    
}

- (IBAction)clickedWithPhotoOnly:(UIButton *)button
{    
  
    [milesFrom resignFirstResponder];
    [zipCode resignFirstResponder];
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
   
    if (withPhotoOnly) 
    {
        [button setImage:[UIImage imageNamed:@"checkbox_normal.png"] forState:normal];
        withPhotoOnly=NO;
    }
    else
    {
        [button setImage:[UIImage imageNamed:@"checkbox_cheched.png"] forState:normal];
        withPhotoOnly=YES;
    }
    
    milesFrom.hidden = NO;
    zipCode.hidden = NO;
    lblOnlineOnly.hidden = NO;
    lblWithPhotoOnly.hidden = NO;
    btnOnlineOnly.hidden = NO;
    btnWithPhotoOnly.hidden = NO;
    btnSearch.hidden = NO;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
    
}

- (IBAction)clickedIamButton:(UIButton *)button
{    
    
    if (button.tag==2 && iamMaleBtnClicked) 
    {
        [button setImage:[UIImage imageNamed:@"man.png"] forState:normal];
        iamMaleBtnClicked=NO;
    }
    else if (button.tag==2 && !iamMaleBtnClicked) 
    {
        [button setImage:[UIImage imageNamed:@"man_click.png"] forState:normal];
        [btnFemale setImage:[UIImage imageNamed:@"women.png"] forState:normal];
        [btnCouple setImage:[UIImage imageNamed:@"man_women.png"] forState:normal];
        [btnGroup setImage:[UIImage imageNamed:@"man_women_a.png"] forState:normal];
        iamMaleBtnClicked=YES;
        iamCoupleBtnClicked=NO;
        iamFemaleBtnCLicked=NO;
        iamGroupBtnClicked=NO;
    }
    else if (button.tag==1 && iamFemaleBtnCLicked)
    {
        [button setImage:[UIImage imageNamed:@"women.png"] forState:normal];
        iamFemaleBtnCLicked=NO;
    }
    else if (button.tag==1 && !iamFemaleBtnCLicked) 
    {
        [button setImage:[UIImage imageNamed:@"women_click.png"] forState:normal];
        [btnMale setImage:[UIImage imageNamed:@"man.png"] forState:normal];
        [btnCouple setImage:[UIImage imageNamed:@"man_women.png"] forState:normal];
        [btnGroup setImage:[UIImage imageNamed:@"man_women_a.png"] forState:normal];
        iamFemaleBtnCLicked=YES;
        iamMaleBtnClicked=NO;
        iamCoupleBtnClicked=NO;
        iamGroupBtnClicked=NO;
    }
    else if (button.tag==4 && iamCoupleBtnClicked)
    {
        [button setImage:[UIImage imageNamed:@"man_women.png"] forState:normal];
        iamCoupleBtnClicked=NO;
    }
    else if (button.tag==4 && !iamCoupleBtnClicked) 
    {
        [button setImage:[UIImage imageNamed:@"man_women_click.png"] forState:normal];
        [btnFemale setImage:[UIImage imageNamed:@"women.png"] forState:normal];
        [btnMale setImage:[UIImage imageNamed:@"man.png"] forState:normal];
        [btnGroup setImage:[UIImage imageNamed:@"man_women_a.png"] forState:normal];
        iamCoupleBtnClicked=YES;
        iamMaleBtnClicked=NO;
        iamFemaleBtnCLicked=NO;
        iamGroupBtnClicked=NO;
    }
    else if (button.tag==8 && iamGroupBtnClicked) 
    {
        [button setImage:[UIImage imageNamed:@"man_women_a.png"] forState:normal];
        iamGroupBtnClicked=NO;
    }
    else if (button.tag==8 && !iamGroupBtnClicked)
    {
        [button setImage:[UIImage imageNamed:@"man_women_a_click.png"] forState:normal];
        [btnFemale setImage:[UIImage imageNamed:@"women.png"] forState:normal];
        [btnCouple setImage:[UIImage imageNamed:@"man_women.png"] forState:normal];
        [btnMale setImage:[UIImage imageNamed:@"man.png"] forState:normal];
        iamGroupBtnClicked=YES;
        iamMaleBtnClicked=NO;
        iamCoupleBtnClicked=NO;
        iamFemaleBtnCLicked=NO;
    }
    
    milesFrom.hidden = NO;
    zipCode.hidden = NO;
    lblOnlineOnly.hidden = NO;
    lblWithPhotoOnly.hidden = NO;
    btnOnlineOnly.hidden = NO;
    btnWithPhotoOnly.hidden = NO;
    btnSearch.hidden = NO;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
    [milesFrom resignFirstResponder];
    [zipCode resignFirstResponder];
    scrollsearchedMembers.scrollEnabled=YES;
    
}

- (IBAction)clickedLookingForButton:(UIButton *)button
{     
  
    if (button.tag==2 && lfMaleBtnClicked) 
    {
        [button setImage:[UIImage imageNamed:@"man.png"] forState:normal];
        lfMaleBtnClicked=NO;
    }
    else if (button.tag==2 && !lfMaleBtnClicked) 
    {
        [button setImage:[UIImage imageNamed:@"man_click.png"] forState:normal];
        lfMaleBtnClicked=YES;
    }
    else if (button.tag==1 && lfFemaleBtnCLicked) 
    {
        [button setImage:[UIImage imageNamed:@"women.png"] forState:normal];
        lfFemaleBtnCLicked=NO;
    }
    else if (button.tag==1 && !lfFemaleBtnCLicked) 
    {
        [button setImage:[UIImage imageNamed:@"women_click.png"] forState:normal];
        lfFemaleBtnCLicked=YES;
    }
    else if (button.tag==4 && lfCoupleBtnClicked)
    {
        [button setImage:[UIImage imageNamed:@"man_women.png"] forState:normal];
        lfCoupleBtnClicked=NO;
    }
    else if (button.tag==4 && !lfCoupleBtnClicked) 
    {
        [button setImage:[UIImage imageNamed:@"man_women_click.png"] forState:normal];
        lfCoupleBtnClicked=YES;
    }
    else if (button.tag==8 && lfGroupBtnClicked)
    {
        [button setImage:[UIImage imageNamed:@"man_women_a.png"] forState:normal];
        lfGroupBtnClicked=NO;
    }
    else if (button.tag==8 && !lfGroupBtnClicked)
    {
        [button setImage:[UIImage imageNamed:@"man_women_a_click.png"] forState:normal];
        lfGroupBtnClicked=YES;
    }
    
    milesFrom.hidden = NO;
    zipCode.hidden = NO;
    lblOnlineOnly.hidden = NO;
    lblWithPhotoOnly.hidden = NO;
    btnOnlineOnly.hidden = NO;
    btnWithPhotoOnly.hidden = NO;
    btnSearch.hidden = NO;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
    [milesFrom resignFirstResponder];
    [zipCode resignFirstResponder];
    scrollsearchedMembers.scrollEnabled=YES;
    
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    
    milesFrom.hidden = NO;
    zipCode.hidden = NO;
    lblOnlineOnly.hidden = NO;
    lblWithPhotoOnly.hidden = NO;
    btnOnlineOnly.hidden = NO;
    btnWithPhotoOnly.hidden = NO;
    btnSearch.hidden = NO;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
    
    if (textField==countryTxtField) 
    {
        [milesFrom resignFirstResponder];
        [zipCode resignFirstResponder];
        uiStatePickerView.hidden=YES;
        uiCityPickerView.hidden=YES;
        [countryTxtField resignFirstResponder];
        uiCountryPickerView.hidden=NO;  
        countryPicker.hidden=NO;
        
        for (UITextField *textfield in [self.view subviews])
        {
            if ([textfield isFirstResponder])
            {
                [textfield resignFirstResponder]; 
            }
        }
        
        [self.view endEditing:YES];
        scrollsearchedMembers.scrollEnabled=NO;
        
        /*if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft)
            {
                [uiCountryPickerView setFrame:CGRectMake(0, 595, 1024, 270)];
            }
            else
            {
                [uiCountryPickerView setFrame:CGRectMake(0, 703, 768, 270)];
            }

        }*/
        //else
        //{
            int movementDistance = 0;
            if (scrollsearchedMembers.bounds.origin.y==0) 
            {
                movementDistance=310;
            }
            else
                movementDistance=310-scrollsearchedMembers.bounds.origin.y;
            
            const float movementDuration = 0.3f;
            // tweak as needed
            
            int movement = movementDistance ;
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            int mov=scrollsearchedMembers.bounds.origin.y + movement;
            [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
            [UIView commitAnimations];
            
        //}
       
    }
    if (textField==stateTxtField) 
    {
        [milesFrom resignFirstResponder];
        [zipCode resignFirstResponder];
        uiCountryPickerView.hidden=YES;
        uiCityPickerView.hidden=YES;
        [stateTxtField resignFirstResponder];
        uiStatePickerView.hidden=NO;  
        statePicker.hidden=NO;
        scrollsearchedMembers.scrollEnabled=NO;
        
        for (UITextField *textfield in [self.view subviews])
        {
            if ([textfield isFirstResponder])
            {
                [textfield resignFirstResponder]; 
            }
        }
        
        /*if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft)
            {
                [uiStatePickerView setFrame:CGRectMake(0, 620, 1024, 270)];
            }
            else
            {
                [uiStatePickerView setFrame:CGRectMake(0, 703, 768, 270)];
            }
        }*/
        //else
        //{
            int movementDistance = 0;
            
            if (scrollsearchedMembers.bounds.origin.y==0) 
            {
                movementDistance=350;
            }
            else
                movementDistance=350-scrollsearchedMembers.bounds.origin.y;
            
            const float movementDuration = 0.3f;
            // tweak as needed
            int movement = movementDistance ;
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            int mov=scrollsearchedMembers.bounds.origin.y + movement;
            [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
            [UIView commitAnimations];
        //}
        
       
    }
    if (textField==txtCity) 
    {                
        if(citySelected)
        {     
            [milesFrom resignFirstResponder];
            [zipCode resignFirstResponder];
            [txtCity resignFirstResponder];
            uiCountryPickerView.hidden=YES;
            uiStatePickerView.hidden=YES;
            uiCityPickerView.hidden=NO; 
            cityPicker.hidden=NO;
            
            for (UITextField *textfield in [self.view subviews])
            {
                if ([textfield isFirstResponder])
                {
                    [textfield resignFirstResponder]; 
                }
            }
            
            if ([cityNamesArray count]==0) 
            {
                uiCityPickerView.hidden=YES;
                cityPicker.hidden=YES;
                selectedCityLbl.text=@"Not Found";
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert!" message:@"No cities found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil ];
                [alert show];
                [alert release];
            }
            else
            {  
                uiCityPickerView.hidden=NO;
                cityPicker.hidden=NO;
            }
        } 
        
        scrollsearchedMembers.scrollEnabled=NO;
        
        /*if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft)
            {
                [uiCityPickerView setFrame:CGRectMake(0, 620, 1024, 270)];
            }
            else
            {
                [uiCityPickerView setFrame:CGRectMake(0, 703, 768, 270)];
            }

        }*/
        //else
        //{
            int movementDistance = 0;
            
            if (scrollsearchedMembers.bounds.origin.y==0) 
            {
                movementDistance=400;
            }
            else
                movementDistance=400-scrollsearchedMembers.bounds.origin.y;
            
            const float movementDuration = 0.3f;
            // tweak as needed
            
            int movement = movementDistance ;
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            int mov=scrollsearchedMembers.bounds.origin.y + movement;
            [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
            [UIView commitAnimations];
        //}
        
    }
    else if(textField==btnMinAge)
    {
        [btnMinAge resignFirstResponder];
        [milesFrom resignFirstResponder];
        [zipCode resignFirstResponder];
        btnMaxAge.enabled=NO;
        milesFrom.enabled=NO;
        zipCode.enabled=NO;
        uiCityPickerView.hidden=YES;
        uiCountryPickerView.hidden=YES;
        uiStatePickerView.hidden=YES;
        indexMinAge = 0;
        flag = 1;
        uiMaxAgePickerView.hidden = YES;
        uiMinAgePickerView.hidden = NO;
        minAgePicker.hidden = NO;
        /*[minAgeArray removeAllObjects];
        int maxAge;
      
        if([maxAgeLabel.text intValue] == 0)
        {
            maxAge = 100;
        }
        else
        {
            maxAge = [maxAgeLabel.text intValue];
        }
        
        for (int i = 18; i <= maxAge; i ++)
        {
            NSString *myString = [NSString stringWithFormat:@"%d", i];
            [minAgeArray addObject:myString]; 
        }
        
        [minAgePicker reloadAllComponents];*/
        [minAgePicker selectRow:0 inComponent:0 animated:NO];
        minAgePicker.showsSelectionIndicator = YES;
        scrollsearchedMembers.scrollEnabled=NO;
       
        /*if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft)
            {
                [uiMinAgePickerView setFrame:CGRectMake(0, 700, 1024, 270)];
                int movementDistance = 0;
               
                if (scrollsearchedMembers.bounds.origin.y==0)
                {
                    movementDistance=250;
                }
                else
                    movementDistance=250-scrollsearchedMembers.bounds.origin.y;
                
                const float movementDuration = 0.3f; // tweak as needed
                int movement = movementDistance ;
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=scrollsearchedMembers.bounds.origin.y + movement;
                [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations]; 
            }
            else
            {
                [uiMinAgePickerView setFrame:CGRectMake(0, 703, 768, 270)];
            }
        }*/
        //else
        //{
            int movementDistance = 0;
           
            if (scrollsearchedMembers.bounds.origin.y==0)
            {
                movementDistance=200;
            }
            else
                movementDistance=200-scrollsearchedMembers.bounds.origin.y;
            
            const float movementDuration = 0.3f; 
            // tweak as needed
            int movement = movementDistance ;
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            int mov=scrollsearchedMembers.bounds.origin.y + movement;
            [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
            [UIView commitAnimations];
        //}
    }
    else if(textField==btnMaxAge)
    {
        [btnMaxAge resignFirstResponder];
        [milesFrom resignFirstResponder];
        [zipCode resignFirstResponder];
        btnMinAge.enabled=NO;
        milesFrom.enabled=NO;
        zipCode.enabled=NO;
        countryTxtField.enabled=NO;
        uiCityPickerView.hidden=YES;
        uiCountryPickerView.hidden=YES;
        uiStatePickerView.hidden=YES;
        indexMaxAge = 0;
        flag = 1;
        uiMinAgePickerView.hidden = YES;
        uiMaxAgePickerView.hidden = NO;
        maxAgePicker.hidden = NO;
        /*[maxAgeArray removeAllObjects];
        int minAge; 
       
        if([minAgeLabel.text intValue] == 0)
        {
            minAge = 18;
        }
        else
        {
            minAge = [minAgeLabel.text intValue];
        }
        
        for (int i = 100; i >= minAge; i --)
        {
            NSString *myString = [NSString stringWithFormat:@"%d", i];
            [maxAgeArray addObject:myString]; 
        }
        
        [maxAgePicker reloadAllComponents];*/
        [maxAgePicker selectRow:0 inComponent:0 animated:NO];
        maxAgePicker.showsSelectionIndicator = YES;   
        scrollsearchedMembers.scrollEnabled=NO;
       
        /*if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft)
            {
                [uiMaxAgePickerView setFrame:CGRectMake(0, 700, 1024, 270)];
                int movementDistance = 0;
               
                if (scrollsearchedMembers.bounds.origin.y==0) 
                {
                    movementDistance=250;
                }
                else
                    movementDistance=250-scrollsearchedMembers.bounds.origin.y;
                
                const float movementDuration = 0.3f; 
                // tweak as needed
                int movement = movementDistance ;
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=scrollsearchedMembers.bounds.origin.y + movement;
                [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
            }
            else
            {
                [uiMaxAgePickerView setFrame:CGRectMake(0, 703, 768, 270)];
            }
        }*/
        //else
        //{
            int movementDistance = 0;
           
            if (scrollsearchedMembers.bounds.origin.y==0)
            {
                movementDistance=200;
            }
            else
                
                movementDistance=200-scrollsearchedMembers.bounds.origin.y;
            const float movementDuration = 0.3f;
            // tweak as needed
            
            int movement = movementDistance ;
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            int mov=scrollsearchedMembers.bounds.origin.y + movement;
            [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
            [UIView commitAnimations];
            
        //}
    }
    else if(textField==zipCode)
    {  
        uiCityPickerView.hidden=YES;
        uiCountryPickerView.hidden=YES;
        uiStatePickerView.hidden=YES;
        uiMinAgePickerView.hidden=YES;
        uiMaxAgePickerView.hidden=YES;
        btnMaxAge.enabled=NO;
        btnMinAge.enabled=NO;
        //milesFrom.enabled=NO;
        countryTxtField.enabled=NO;
        scrollsearchedMembers.scrollEnabled=NO;
        countryTxtField.enabled=NO;
        stateTxtField.enabled=NO;
        txtCity.enabled=NO;
        
         
      
        /*if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
            {
                int movementDistance = 0;
              
                if (scrollsearchedMembers.bounds.origin.y==0) 
                {
                    movementDistance=240;
                }
                else
                    movementDistance=240-scrollsearchedMembers.bounds.origin.y;
                
                const float movementDuration = 0.3f; 
                // tweak as needed
                
                int movement = movementDistance ;
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=scrollsearchedMembers.bounds.origin.y + movement;
                [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations]; 
            }
        }*/
        //else
        //{
            int movementDistance = 0;
          
            
            if (txtCity.hidden==NO) 
            {         
                    if (scrollsearchedMembers.bounds.origin.y==0) 
                    {
                        movementDistance=400;
                    }
                    else
                        movementDistance=400-scrollsearchedMembers.bounds.origin.y;
                    
                    const float movementDuration = 0.3f;
                    // tweak as needed
                    
                    int movement = movementDistance ;
                    [UIView beginAnimations: @"anim" context: nil];
                    [UIView setAnimationBeginsFromCurrentState: YES];
                    [UIView setAnimationDuration: movementDuration];
                    int mov=scrollsearchedMembers.bounds.origin.y + movement;
                    [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
                    [UIView commitAnimations];
                
            }
            else if(stateTxtField.hidden==NO)
            {                        
                                
                if (scrollsearchedMembers.bounds.origin.y==0) 
                {
                    movementDistance=370;
                }
                else
                    movementDistance=370-scrollsearchedMembers.bounds.origin.y;
                
                const float movementDuration = 0.3f;
                // tweak as needed
                
                int movement = movementDistance ;
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=scrollsearchedMembers.bounds.origin.y + movement;
                [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];

            }
            else
            {
                
              if (scrollsearchedMembers.bounds.origin.y==0) 
                {
                  movementDistance=325;
                }
              else
                movementDistance=325-scrollsearchedMembers.bounds.origin.y;
            
              const float movementDuration = 0.3f;
            // tweak as needed
            
              int movement = movementDistance ;
              [UIView beginAnimations: @"anim" context: nil];
              [UIView setAnimationBeginsFromCurrentState: YES];
              [UIView setAnimationDuration: movementDuration];
              int mov=scrollsearchedMembers.bounds.origin.y + movement;
              [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
              [UIView commitAnimations];
            }
        //}
    }
    else if(textField==milesFrom)
    {  
        uiCityPickerView.hidden=YES;
        uiCountryPickerView.hidden=YES;
        uiStatePickerView.hidden=YES;
        uiMinAgePickerView.hidden=YES;
        uiMaxAgePickerView.hidden=YES;
        btnMaxAge.enabled=NO;
        btnMinAge.enabled=NO;
        countryTxtField.enabled=NO;
        //zipCode.enabled=NO;
        scrollsearchedMembers.scrollEnabled=NO;
        countryTxtField.enabled=NO;
        stateTxtField.enabled=NO;
        txtCity.enabled=NO;
       
        /*if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
            {
                int movementDistance = 0;
                if (scrollsearchedMembers.bounds.origin.y==0)
                {
                    movementDistance=240;
                }
                else
                    movementDistance=240-scrollsearchedMembers.bounds.origin.y;
                
                const float movementDuration = 0.3f; 
                // tweak as needed
                
                int movement = movementDistance ;
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=scrollsearchedMembers.bounds.origin.y + movement;
                [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations]; 
            }
        }*/
        //else
        //{
            int movementDistance = 0;
          
            if (txtCity.hidden==NO) 
            {
                 if (scrollsearchedMembers.bounds.origin.y==0) 
                {
                    movementDistance=400;
                }
                else
                    movementDistance=400-scrollsearchedMembers.bounds.origin.y;
                
                const float movementDuration = 0.3f;
                // tweak as needed
                
                int movement = movementDistance ;
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=scrollsearchedMembers.bounds.origin.y + movement;
                [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
                
            }
            else if(stateTxtField.hidden==NO)
            {                                                
                if (scrollsearchedMembers.bounds.origin.y==0) 
                {
                    movementDistance=370;
                }
                else
                    movementDistance=370-scrollsearchedMembers.bounds.origin.y;
                
                const float movementDuration = 0.3f;
                // tweak as needed
                
                int movement = movementDistance ;
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=scrollsearchedMembers.bounds.origin.y + movement;
                [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
                 
            }
            else
            {               
                if (scrollsearchedMembers.bounds.origin.y==0) 
                {
                    movementDistance=325;
                }
                else
                    movementDistance=325-scrollsearchedMembers.bounds.origin.y;
            
                const float movementDuration = 0.3f; 
                // tweak as needed
            
                int movement = movementDistance ;
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=scrollsearchedMembers.bounds.origin.y + movement;
                [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
            }
        //}
    }
}


- (IBAction)textFieldDidEndEditing:(UITextField *)textField
{    
    btnMinAge.enabled=YES;
    btnMaxAge.enabled=YES;
    milesFrom.enabled=YES;
    zipCode.enabled=YES;
    countryTxtField.enabled=YES;
    stateTxtField.enabled=YES;
    txtCity.enabled=YES;
    scrollsearchedMembers.scrollEnabled=YES;
    
}

- (IBAction)countryPickerDone:(id)sender 
{    
    selectedRegionId=@"";
    strCityCodeStore=@"";
    milesFrom.hidden = NO;
    zipCode.hidden = NO;
    lblOnlineOnly.hidden = NO;
    lblWithPhotoOnly.hidden = NO;
    btnOnlineOnly.hidden = NO;
    btnWithPhotoOnly.hidden = NO;
    btnSearch.hidden = NO;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
    countryPicker.hidden=YES;
    statePicker.hidden=YES;
    cityPicker.hidden=YES;
    uiCountryPickerView.hidden=YES;
    uiStatePickerView.hidden=YES;
    uiCityPickerView.hidden=YES;
    scrollsearchedMembers.scrollEnabled=YES;
    btnMinAge.enabled=YES;
    btnMaxAge.enabled=YES;
    milesFrom.enabled=YES;
    zipCode.enabled=YES;
    countryTxtField.enabled=YES;
    
    //if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    //{
    //     scrollsearchedMembers.contentSize=CGSizeMake(320,1150);
    //}
       
        
    if ([selectedCountryId isEqualToString:@""]) 
    {
        selectedCountryLbl.text=@"Please Select";
        isStateCountZero=YES;
        [self orientationForIpad];
    }
    else
    {       
        isStateCountZero=NO;
        responseData = [[NSMutableData data] retain];
        urlReqRegion=[NSString stringWithFormat:@"%@/mobile/getState/?id=%@",domain,selectedCountryId];
        
        NSURL *url = [NSURL URLWithString:[urlReqRegion stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
        [self ShowIndicatorView:@"Loading..."];
        GetRegionURLConnection=[[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
        self.view.userInteractionEnabled=NO;

    }
    
}

- (IBAction)statePickerDone:(id)sender 
{
    
    strCityCodeStore=@"";
    milesFrom.hidden = NO;
    zipCode.hidden = NO;
    lblOnlineOnly.hidden = NO;
    lblWithPhotoOnly.hidden = NO;
    btnOnlineOnly.hidden = NO;
    btnWithPhotoOnly.hidden = NO;
    btnSearch.hidden = NO;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
    countryPicker.hidden=YES;
    statePicker.hidden=YES;
    cityPicker.hidden=YES;
    uiCountryPickerView.hidden=YES;
    uiStatePickerView.hidden=YES;
    uiCityPickerView.hidden=YES;
    scrollsearchedMembers.scrollEnabled=YES;
    
    //if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    //{
    //    scrollsearchedMembers.contentSize=CGSizeMake(320,1200);
    //}
    
         
    if ([selectedRegionId isEqualToString:@""])
    {
        selectedRegionLbl.text=@"Please Select";
        isCityCountZero=YES;
        [self orientationForIpad];
    }
    else
    {       
        isCityCountZero=NO;
        responseData = [[NSMutableData data] retain];
        urlReqRegion=[NSString stringWithFormat:@"%@/mobile/getCity/?id=%@",domain,selectedRegionId];      
        
        NSURL *url = [NSURL URLWithString:[urlReqRegion stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
        [self ShowIndicatorView:@"Loading..."];
        GetcityURLConnection=[[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
        self.view.userInteractionEnabled=NO;
        
    }
    
}

- (IBAction)cityPickerDone:(id)sender 
{
    
    milesFrom.hidden = NO;
    zipCode.hidden = NO;
    lblOnlineOnly.hidden = NO;
    lblWithPhotoOnly.hidden = NO;
    btnOnlineOnly.hidden = NO;
    btnWithPhotoOnly.hidden = NO;
    btnSearch.hidden = NO;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
    countryPicker.hidden=YES;
    statePicker.hidden=YES;
    cityPicker.hidden=YES;
    uiCountryPickerView.hidden=YES;
    uiStatePickerView.hidden=YES;
    uiCityPickerView.hidden=YES;
    scrollsearchedMembers.scrollEnabled=YES;
    
    if ([strCityCodeStore isEqualToString:@""])
    {
        selectedCityLbl.text=@"Please Select";
    }
    else
    { 
        //if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        //{
            scrollsearchedMembers.contentSize=CGSizeMake(320,1183);
        //}
        //else
        //{
        //     scrollsearchedMembers.contentSize=CGSizeMake(320,1200);
        //}
        
    }
    
}

- (IBAction)countryTextEdited:(id)sender
{        
    [countryTxtField resignFirstResponder];
}

#pragma mark PickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == minAgePicker)	
    {
        NSString *chosenAge = [minAgeArray objectAtIndex:row];
        minAgeLabel.text = chosenAge;
        btnMinAge.placeholder = @"";
        indexMinAge = row;
    }
    else if(pickerView == maxAgePicker)
    {
        NSString *chosenAge = [maxAgeArray objectAtIndex:row];
        maxAgeLabel.text = chosenAge;
        btnMaxAge.placeholder = @"";
        indexMaxAge = row;
    }
    else if(pickerView == countryPicker)
    {
        selectedCountryId=[countryCodeArray objectAtIndex:row];
        NSString *chosenAge = [countrynamesArray objectAtIndex:row];
        selectedCountryLbl.text = chosenAge;
        indexCountry = row;
        statePicker.hidden=YES;
        cityPicker.hidden=YES;
        uiStatePickerView.hidden=YES;
        uiCityPickerView.hidden=YES;
    }
    else if(pickerView == statePicker)
    {
        NSString *chosenAge = [stateNamesArray objectAtIndex:row];
        selectedRegionLbl.text = chosenAge;
        selectedRegionId=[stateCodeArray objectAtIndex:row];
        indexState = row;
        countryPicker.hidden=YES;
        cityPicker.hidden=YES;
        uiCountryPickerView.hidden=YES;
        uiCityPickerView.hidden=YES;
    }
    else if(pickerView == cityPicker)
    {
        strCityCodeStore=[cityCodeArray objectAtIndex:row];
        NSString *chosenAge = [cityNamesArray objectAtIndex:row];
        selectedCityLbl.text=chosenAge;
        indexCity = row;
        countryPicker.hidden=YES;
        statePicker.hidden=YES;
        uiCountryPickerView.hidden=YES;
        uiStatePickerView.hidden=YES;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
        
    if(pickerView == minAgePicker) 
    {
        // return number of components in first picker  
        return [minAgeArray count];
    } 
    else if(pickerView == maxAgePicker)
    {    
        // return number of components in second picker    
        return [maxAgeArray count];
    } 
    else if(pickerView == countryPicker)
    {
        return [countrynamesArray count];
    } 
    else if(pickerView == statePicker)
    {
        return [stateNamesArray count];
    } 
    else if(pickerView == cityPicker)
    {
        return [cityNamesArray count];
    } 
    else
        return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView == minAgePicker)	
    {
        return [minAgeArray objectAtIndex:row];
    }
    else if(pickerView == maxAgePicker)
    {
        return [maxAgeArray objectAtIndex:row];
    }
    else if(pickerView == countryPicker)
    {
        return [countrynamesArray objectAtIndex:row];
    }
    else if(pickerView == statePicker)
    {
        return [stateNamesArray objectAtIndex:row];
    }
    else if(pickerView == cityPicker)
    {
        return [cityNamesArray objectAtIndex:row];
    }
    else
        return NULL;
    
}

#pragma mark Text Field Delegate


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    /*if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
        {
               
            if ((textField==milesFrom)||(textField==zipCode)||(textField==countryTxtField)||(textField==txtCity)||(textField==stateTxtField))
            {
                if(textField==countryTxtField)
                {
                    int movementDistance = 0;
                    
                    if (scrollsearchedMembers.bounds.origin.y==0) 
                    {
                        movementDistance=150;
                    }
                    else
                        movementDistance=150-scrollsearchedMembers.bounds.origin.y;
                    
                    const float movementDuration = 0.3f;
                    // tweak as needed
                    
                    int movement = movementDistance ;
                    [UIView beginAnimations: @"anim" context: nil];
                    [UIView setAnimationBeginsFromCurrentState: YES];
                    [UIView setAnimationDuration: movementDuration];
                    int mov=scrollsearchedMembers.bounds.origin.y + movement;
                    [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
                    [UIView commitAnimations];
                }
                else if(textField==stateTxtField)
                {
                    int movementDistance = 0;
                    
                    if (scrollsearchedMembers.bounds.origin.y==0) 
                    {
                        movementDistance=180;
                    }
                    else
                        movementDistance=180-scrollsearchedMembers.bounds.origin.y;
                    
                    const float movementDuration = 0.3f;
                    // tweak as needed
                    
                    int movement = movementDistance ;
                    [UIView beginAnimations: @"anim" context: nil];
                    [UIView setAnimationBeginsFromCurrentState: YES];
                    [UIView setAnimationDuration: movementDuration];
                    int mov=scrollsearchedMembers.bounds.origin.y + movement;
                    [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
                    [UIView commitAnimations];
                }
                else if(textField==txtCity)
                {
                    int movementDistance = 0;
                    
                    if (scrollsearchedMembers.bounds.origin.y==0) 
                    {
                        movementDistance=180;
                    }
                    else
                        movementDistance=180-scrollsearchedMembers.bounds.origin.y;
                    
                    const float movementDuration = 0.3f;
                    // tweak as needed
                    
                    int movement = movementDistance ;
                    [UIView beginAnimations: @"anim" context: nil];
                    [UIView setAnimationBeginsFromCurrentState: YES];
                    [UIView setAnimationDuration: movementDuration];
                    int mov=scrollsearchedMembers.bounds.origin.y + movement;
                    [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
                    [UIView commitAnimations];
                }
                else
                {
                    CGPoint bott=CGPointMake(0,scrollsearchedMembers.contentSize.height-self.scrollsearchedMembers.bounds.size.height);
                    
                    [scrollsearchedMembers setContentOffset:bott animated:YES]; 
                }
                
            }
                    
        }
        else
        {
            if (textField==txtCity)
            { 
                CGPoint bott=CGPointMake(0,scrollsearchedMembers.contentSize.height-self.scrollsearchedMembers.bounds.size.height);
                [scrollsearchedMembers setContentOffset:bott animated:YES];
            }
                    
        }
    }*/
    
    return YES;
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    
    /*if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
        {
            if (scrollsearchedMembers.bounds.origin.y>225) 
            {
                return;
            }
            
            int movementDistance = 0;
            
            if (scrollsearchedMembers.bounds.origin.y==0) 
            {
                movementDistance=225;
            }
            else
                movementDistance=225-scrollsearchedMembers.bounds.origin.y;
            
            const float movementDuration = 0.3f; 
            // tweak as needed
            
            int movement = (up ? movementDistance : -movementDistance);
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            int mov=scrollsearchedMembers.bounds.origin.y + movement;
            [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
            [UIView commitAnimations];
        }    
        else
        {            
            if (scrollsearchedMembers.bounds.origin.y>320) 
            {
                return;
            }
        }
        return;
    }*/
    
    if (scrollsearchedMembers.bounds.origin.y>350) 
    {
        return;
    }
    
    int movementDistance = 0;
  
    if (scrollsearchedMembers.bounds.origin.y==0)
    {
        movementDistance=350;
    }
    else
        movementDistance=350-scrollsearchedMembers.bounds.origin.y;
    
    const float movementDuration = 0.3f;
    // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    int mov=scrollsearchedMembers.bounds.origin.y + movement;
    [scrollsearchedMembers setContentOffset:CGPointMake(0,mov) animated:YES];
    [UIView commitAnimations];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField 
{    
	[textField resignFirstResponder];
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == milesFrom)
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
   
    if(textField == txtCity)
    {      
        return NO;
    }
    else
        return YES;
}

@end