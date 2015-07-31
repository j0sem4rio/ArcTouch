//
//  ViewController.h
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 31/07/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *tableViewStreet;
    IBOutlet UISearchBar* search;
}

@property (nonatomic, retain) UITableView *tableViewStreet;
@property (nonatomic, retain) NSArray* dataSource;
@property (nonatomic, retain) UISearchBar* search;



@end

