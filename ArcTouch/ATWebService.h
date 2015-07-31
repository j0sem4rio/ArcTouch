//
//  ATWebService.h
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 31/07/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import <Foundation/Foundation.h>


/* Urls */
static NSString * const  ROUTE_BY_STOP = @"/v1/queries/findRoutesByStopName/run";
static NSString * const  STOP_BY_ROUTE = @"/v1/queries/findStopsByRouteId/run";
static NSString * const  DEPARTURES_BY_ROUTE = @"/v1/queries/findDeparturesByRouteId/run";

@interface ATWebService : NSObject

+ (instancetype)sharedInstance;

@end
