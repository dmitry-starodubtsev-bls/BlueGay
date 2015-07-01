//
//  ChkViewController.h
//  Chk
//
//  Created by SODTechnologies on 19/08/10.
//  Copyright 2010 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "LocationGetter.h"
#import <CoreLocation/CoreLocation.h>
#import "SkadateAppDelegate.h"

@implementation LocationGetter

@synthesize locationManager, delegate,responseData,connectionLatLong,domain,count;

BOOL didUpdate = NO;

#pragma mark Memory Management

- (void)dealloc
{
    [locationManager release];
    [super dealloc];
}

#pragma mark Custom Methods

- (void)startUpdates
{     
    if (locationManager == nil)
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
    
        // You have some options here, though higher accuracy takes longer to resolve.
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;  
        locationManager.distanceFilter=2.0f;
        [locationManager startUpdatingLocation];   
}

#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manage didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
   if(((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID)
    {
        if ([((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfileID isEqualToString:@""])
        {
        }
        else
        {
            // Disable future updates to save power.
            if ([newLocation distanceFromLocation:oldLocation]>50)
            {
                locUpdate=YES;
            }
            if (count==0||locUpdate==YES)
            {
                [locationManager stopUpdatingLocation];
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                domain = [prefs stringForKey:@"URL"];
                NSUserDefaults *MyLoc=[NSUserDefaults standardUserDefaults];
                [MyLoc setDouble:newLocation.coordinate.latitude forKey:@"lat"];
                [MyLoc setDouble:newLocation.coordinate.longitude forKey:@"lng"];
            
                // let our delegate know we're done
                NSString  *urlReq =[NSString stringWithFormat:@"%@/mobile/insertlocation/?pid=%@&lon=%f&lat=%f&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,newLocation.coordinate.longitude,newLocation.coordinate.latitude,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
                               
                responseData = [[NSMutableData data]retain];
                NSURL *url = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
                connectionLatLong=[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self];
                locationManager.delegate = nil;
                locUpdate=NO;
            }
        }
    }
}


#pragma mark Managing API Calls

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
	[responseData setLength:0 ];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{   
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSError *error;
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    [responseData release];
    [responseString release];
    CFRelease((CFTypeRef) parser);
    NSString  *resultCount=(NSString*)[parsedData objectForKey:@"Message"];
    if ([resultCount isEqualToString:@"Success"]) 
    {
    }
}



@end
