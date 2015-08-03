//
//  TableViewController.h
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 03/08/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATStreet.h"

@interface TableViewController : UITableViewController

@property (nonatomic, strong) NSArray *departuresArray;
@property (nonatomic, retain) ATStreet *street;

@end
