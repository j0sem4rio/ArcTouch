//
//  ViewController.m
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 31/07/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import "ViewController.h"
#import "ATWebService.h"
#import "StreetParser.h"
#import "ProgressHUD.h"

#import "ATRouterStopViewController.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize tableViewStreet;
@synthesize search;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    self.navigationItem.titleView = search;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    ATStreet *street = [self.dataSource objectAtIndex:indexPath.row];
    // Set up the cell...
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    cell.textLabel.text = [street longName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   ATStreet *street = [self.dataSource objectAtIndex:indexPath.row];
    
    
    ATRouterStopViewController *vc2 = [[ATRouterStopViewController alloc] initWithNibName:@"ATRouterStopViewController" bundle:nil];
    [vc2 findRouterByStop:street];
    
    [self.navigationController pushViewController:vc2 animated:YES];
    
    

}
#pragma mark - Search Implementation

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
       
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [ProgressHUD show:@"Please wait..."];
    [self searchTableList];
}


- (void)searchTableList {
    NSString *searchString = search.text;
    
    
     NSDictionary *dictionary =   @{ @"stopName" : [NSString stringWithFormat:@"%%%@%%",searchString]};
    
    ATWebService *atw =[ATWebService sharedInstance];
    AFHTTPRequestOperation *operation=   [atw callWebService:ROUTE_BY_STOP parameter:dictionary];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *json = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        
        StreetParser *sp = [[StreetParser alloc] init];
        
        
        self.dataSource = [sp parse:json];
        
        [tableViewStreet reloadData];
        [ProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [ProgressHUD dismiss];
    }];
    
    [operation start];
}

@end
