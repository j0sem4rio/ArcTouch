//
//  ATStreet.h
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 31/07/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATStreet : NSObject{
    
}
@property (nonatomic, assign) NSInteger uniqueId;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, copy) NSString *longName;
@property (nonatomic, copy) NSDate *lastModifiedDate;
@property (nonatomic, assign) NSInteger agencyId;

@end
