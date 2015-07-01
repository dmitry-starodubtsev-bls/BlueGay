//
//  ChatAutoUpdationClass.m
//  Skadate
//
//  Created by SOD TECH on 12/04/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ChatAutoUpdationClass.h"

@implementation ChatAutoUpdationClass
@synthesize domain;
@synthesize respData;
@synthesize chatConnection;
@synthesize chatDelegate;

#pragma mark Custom Method

-(void)updateChats:(NSString *) receipientProfileId
{    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    respData = [[NSMutableData data] retain];
    
    NSString *req = [NSString stringWithFormat:@"%@/mobile/PrivateChatMsgReceiving/?sid=%@&rid=%@&skey=%@",domain,receipientProfileId,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
                  
    NSURL *url = [NSURL URLWithString:[req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    chatConnection=[[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self] autorelease];
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
	   
    if (!responseString)
    {
        return;
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
	[respData release];
    CFRelease((CFTypeRef) parser);
           
    if (connection==chatConnection)
    {
        [chatDelegate loadChats:responseString];
    }
    [responseString release];
}


@end
