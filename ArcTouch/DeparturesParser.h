//
//  DeparturesParser.h
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 03/08/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeparturesParser : NSObject

-(NSArray*)parse:(NSString *)json;
@end
