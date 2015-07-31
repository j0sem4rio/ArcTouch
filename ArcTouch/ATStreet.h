//
//  ATStreet.h
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 31/07/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATStreet : NSObject{
     NSInteger uniqueId;
     NSString *shortName;
     NSString *longName;
     NSDate *lastModifiedDate;
     NSInteger agencyId;
}
@property (nonatomic, assign) NSInteger uniqueId;
@property (nonatomic, readwrite) NSString *shortName;
@property (nonatomic, readwrite) NSString *longName;
@property (nonatomic, readwrite) NSDate *lastModifiedDate;
@property (nonatomic, assign) NSInteger agencyId;

@end
