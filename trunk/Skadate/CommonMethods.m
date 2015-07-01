//
//  CommonMethods.m
//  Skadate
//
//  Created by SodiPhone_7 on 24/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CommonMethods.h"

@implementation CommonMethods
@synthesize domain;
@synthesize respData;
@synthesize NotificationCountConnection;
@synthesize delegate;
@synthesize ProfilePhotConnection;

#pragma mark Memory Management

- (void)dealloc
{	
	[super dealloc];
}

#pragma mark Custom Methods

-(void )fetchNotification
{    
    if (((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        domain = [prefs stringForKey:@"URL"];
        NSString *urlReq = [NSString stringWithFormat:@"%@/mobile/NotificationCount/?pid=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID];
        respData = [[NSMutableData data] retain];
        NSURL *url = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
        NotificationCountConnection=[[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
    }
}

-(void)fetchProfilePhoto:(NSString *) profileId
{    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    respData = [[NSMutableData data] retain];
    NSString *req = [NSString stringWithFormat:@"%@/mobile/ViewPhotos/?id=%@&vid=%@&skey=%@",domain,profileId,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID];
    NSURL *url = [NSURL URLWithString:[req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    ProfilePhotConnection=[[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
}

#pragma mark -Managing API Calls

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{    
	[respData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    
	[respData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    
	NSString *responseString = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
	NSError *error;
   
    if (!responseString)
    {
        return;
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    [responseString release];
    [respData release];
    CFRelease((CFTypeRef) parser);
   
    if(!parsedData)
    {
        return;
    }
    
    if (connection==NotificationCountConnection)
    {
       [delegate loadNotificatonCounts:parsedData];
    }
    else if (connection==ProfilePhotConnection)
    {
        [delegate loadNotificatonCounts:parsedData];
    }
     
}
    
@end
