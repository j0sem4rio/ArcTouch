//
//  ATRouterStopViewController.m
//  ArcTouch
//
//  Created by Jose Mario Fernandes on 03/08/15.
//  Copyright (c) 2015 Jose Mario Fernandes. All rights reserved.
//

#import "ATRouterStopViewController.h"
#import "ATWebService.h"
#import "StopRouterParser.h"
#import "TableViewController.h"



@interface ATRouterStopViewController ()

@end

@implementation ATRouterStopViewController
@synthesize tableViewStreet;
@synthesize streetF;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Departures"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(departuresClicked:)];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)findRouterByStop:(ATStreet*)street{
    
    NSDictionary *dictionary =   @{ @"routeId" : [NSString stringWithFormat:@"%ld",(long)street.uniqueId]};
    streetF = street;
    
    ATWebService *atw =[ATWebService sharedInstance];
    AFHTTPRequestOperation *operation=   [atw callWebService:STOP_BY_ROUTE parameter:dictionary];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *json = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        
        StopRouterParser *srp = [[StopRouterParser alloc] init];
        
        self.dataSource = [srp parse:json];
        [tableViewStreet reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [operation start];
    
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
    
    StopRouter *router = [self.dataSource objectAtIndex:indexPath.row];
    // Set up the cell...
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    cell.textLabel.text = [router name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

-(void)departuresClicked:(UIBarButtonItem *)sender
{
    TableViewController *vc2 = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    vc2.street = streetF;
    
    [self.navigationController pushViewController:vc2 animated:YES];
}

@end
