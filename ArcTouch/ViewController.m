//
//  ViewController.m
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 31/07/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import "ViewController.h"
#import "ATWebService.h"


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
    // Dispose of any resources that can be recreated.
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
    // open a alert with an OK and cancel button
    NSDictionary *dictionary =   @{ @"routeId" : @"22"};
    
    ATWebService *atw =[ATWebService sharedInstance];
    AFHTTPRequestOperation *operation=   [atw callWebService:DEPARTURES_BY_ROUTE parameter:dictionary];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *json = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        id jsonOBJ = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        ATStreet *street;
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
        
        NSArray *streetArray = [jsonOBJ objectForKey:@"rows"];
        NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[streetArray count]];
        for (NSDictionary* str in streetArray) {
            street = [[ATStreet alloc] init];
            street.agencyId = [[str valueForKey:@"agencyId"] integerValue];
            street.uniqueId = [[str valueForKey:@"id"] integerValue];
            
            NSString* date =[str objectForKey:@"lastModifiedDate"] ;
            street.lastModifiedDate = [dateFormat dateFromString:date];
            
            street.longName = [str objectForKey:@"longName"];
            street.shortName = [str objectForKey:@"shortName"];
            
            [result addObject:street];
        }
        self.dataSource = result;
        [tableViewStreet reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [operation start];}
#pragma mark - Search Implementation

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
       
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
}


- (void)searchTableList {
    NSString *searchString = search.text;
    
    
     NSDictionary *dictionary =   @{ @"stopName" : [NSString stringWithFormat:@"%%%@%%",searchString]};
    
    ATWebService *atw =[ATWebService sharedInstance];
    AFHTTPRequestOperation *operation=   [atw callWebService:ROUTE_BY_STOP parameter:dictionary];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *json = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        id jsonOBJ = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        ATStreet *street;
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
        
        NSArray *streetArray = [jsonOBJ objectForKey:@"rows"];
        NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[streetArray count]];
        for (NSDictionary* str in streetArray) {
            street = [[ATStreet alloc] init];
            street.agencyId = [[str valueForKey:@"agencyId"] integerValue];
            street.uniqueId = [[str valueForKey:@"id"] integerValue];
            
            NSString* date =[str objectForKey:@"lastModifiedDate"] ;
            street.lastModifiedDate = [dateFormat dateFromString:date];
            
            street.longName = [str objectForKey:@"longName"];
            street.shortName = [str objectForKey:@"shortName"];
            
            [result addObject:street];
        }
        self.dataSource = result;
        [tableViewStreet reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [operation start];
}

@end
