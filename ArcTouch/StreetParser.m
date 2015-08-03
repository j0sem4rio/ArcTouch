//
//  StreetParser.m
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 03/08/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import "StreetParser.h"
#import "ATStreet.h"

@implementation StreetParser

-(NSArray*)parse:(NSString *)json{
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    id jsonOBJ = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    ATStreet *street;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    
    
    NSArray *streetArray = [jsonOBJ objectForKey:@"rows"];
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[streetArray count]];
    for (NSDictionary* str in streetArray) {
        street = [[ATStreet alloc] init];
        street.agencyId = [[str valueForKey:@"agencyId"] integerValue];
        street.uniqueId = [[str valueForKey:@"id"] integerValue];
        
        NSString* date =[str objectForKey:@"lastModifiedDate"] ;
        street.lastModifiedDate = [dateFormat dateFromString:date];
        
        street.longName = [str objectForKey:@"longName"];
        street.shortName = [str objectForKey:@"shortName"];
        
        [result addObject:street];
    }
    
    return result;

}

@end
