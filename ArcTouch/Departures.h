//
//  Departures.h
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 03/08/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Departures : NSObject
{
    NSInteger uniqueId;
    NSString *calendar;
    NSString *time;
}
@property (nonatomic, assign) NSInteger uniqueId;
@property (nonatomic, readwrite) NSString *calendar;
@property (nonatomic, readwrite) NSString *time;

@end
