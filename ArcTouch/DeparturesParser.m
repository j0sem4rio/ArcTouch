//
//  DeparturesParser.m
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 03/08/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import "DeparturesParser.h"
#import "Departures.h"

@implementation DeparturesParser



-(NSArray*)parse:(NSString *)json{
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    id jsonOBJ = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    Departures *departures;
    
    NSArray *streetArray = [jsonOBJ objectForKey:@"rows"];
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[streetArray count]];
    for (NSDictionary* str in streetArray) {
        departures = [[Departures alloc] init];
        departures.uniqueId = [[str valueForKey:@"id"] integerValue];
        departures.calendar = [str objectForKey:@"calendar"];
        departures.time = [str objectForKey:@"time"];
        
        
        [result addObject:departures];
    }
    [result sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first = [(Departures*)a calendar];
        NSString *second = [(Departures*)b calendar];
        return [first compare:second];
    }];
    
    return result;
}






@end
