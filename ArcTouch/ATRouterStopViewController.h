//
//  ATRouterStopViewController.h
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 03/08/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATStreet.h"

@interface ATRouterStopViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    IBOutlet UITableView *tableViewStreet;
}
@property (nonatomic, retain) UITableView *tableViewStreet;
@property (nonatomic, retain) NSArray* dataSource;
@property (nonatomic, retain) ATStreet *streetF;
-(void)findRouterByStop:(ATStreet*)street;
@end
