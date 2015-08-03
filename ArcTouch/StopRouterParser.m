//
//  StopRouterParser.m
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 03/08/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import "StopRouterParser.h"


@implementation StopRouterParser


-(NSArray*)parse:(NSString *)json{
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    id jsonOBJ = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    StopRouter *router;
    
    NSArray *streetArray = [jsonOBJ objectForKey:@"rows"];
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[streetArray count]];
    for (NSDictionary* str in streetArray) {
        router = [[StopRouter alloc] init];
        router.uniqueId = [[str valueForKey:@"id"] integerValue];
        
        router.route_id = [[str objectForKey:@"route_id"] integerValue];
        router.name = [str objectForKey:@"name"];
        router.sequence =[[str valueForKey:@"sequence"] integerValue];
        
        [result addObject:router];
    }

    return result;
}

@end
