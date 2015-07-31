//
//  ATWebService.m
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 31/07/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import "ATWebService.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@implementation ATWebService


static NSString * const APIBaseURL = @"https://api.appglu.com";


+ (instancetype)sharedInstance
{
    static dispatch_once_t predicate;
    static ATWebService *_sharedInstance = nil;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[self alloc] init];
        ;
        
    });
    
    return _sharedInstance;
}



- (void)RoutesByStop
{
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    

    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APIBaseURL,ROUTE_BY_STOP]]];
    
    
    [httpClient clearAuthorizationHeader];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    //    [httpClient setAuthorizationHeaderWithUsername:[defaults valueForKey:@"LOGIN"] password:[defaults valueForKey:@"SENHA"]];
    [httpClient setAuthorizationHeaderWithUsername:@"WKD4N7YMA1uiM8V" password:@"DtdTtzMLQlA0hk2C1Yi5pLyVIlAQ68"];
    
    
    NSDictionary *dictionary =  @{ @"params" :  @{ @"stopName" : @"%lauro linhares%"}};
    
    [httpClient setDefaultHeader:@"content-type" value:@"application/json"];
    [httpClient setDefaultHeader:@"X-AppGlu-Environment" value:@"staging"];
    

    
    NSMutableURLRequest *request   = [httpClient requestWithMethod:@"POST"
                                                              path:nil
                                                        parameters:dictionary];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [request setTimeoutInterval:2.0];
    
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        
        NSLog(@"TorrentList %@", html);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [operation start];
}
@end
