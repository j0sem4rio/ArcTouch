//
//  StopRouter.h
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 03/08/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopRouter : NSObject{
    NSInteger uniqueId;
    NSString *name;
    NSInteger route_id;
    NSInteger sequence;
}
@property (nonatomic, assign) NSInteger uniqueId;
@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, assign) NSInteger route_id;
@property (nonatomic, assign) NSInteger sequence;

@end
