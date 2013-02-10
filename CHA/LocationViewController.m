//
//  LocationViewController.m
//  CHA
//
//  Created by Brian Sun on 2/9/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  _tableData = [self getData];
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
 
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSArray*) getData
{
  Location *loc1 = [Location alloc];
  loc1 = [loc1 initWithName:@"Meridian Mark" WithAddress:@"5445 Meridian Mark Road Suite 250 Atlanta, GA 30342" WithDisc:@"5445 Meridian Mark Road \nSuite 250 \nAtlanta, GA 30342" WithLocData:@"33.903645,-84.354127"];
  
  Location *loc2 = [Location alloc];
  loc2 = [loc2 initWithName:@"Alpharetta" WithAddress:@"5445 Meridian Mark Road Suite 250 Atlanta, GA 30342" WithDisc:@"" WithLocData:@""];
  
  Location *loc3 = [Location alloc];
  loc3 = [loc3 initWithName:@"Duluth" WithAddress:@"5445 Meridian Mark Road Suite 250 Atlanta, GA 30342" WithDisc:@"" WithLocData:@""];
  
  Location *loc4 = [Location alloc];
  loc4 = [loc4 initWithName:@"Fayette" WithAddress:@"5445 Meridian Mark Road Suite 250 Atlanta, GA 30342" WithDisc:@"" WithLocData:@""];
  
  return [NSArray arrayWithObjects:loc1, loc2, loc3, loc4, nil];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return [_tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"locationCells";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  UIButton *locButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  locButton.frame = CGRectMake(30.0f, 0.0f, 260.0f, 44.0f);
  //locButton.backgroundColor = [UIColor redColor];
  [locButton setTitle:[[_tableData objectAtIndex:indexPath.row] getName] forState:UIControlStateNormal];
  [locButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
  [cell addSubview:locButton];
  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  
  return cell;
}
- (void) buttonAction: (id) sender{
  UIButton *button = (UIButton *)sender;
  UITableViewCell* cell = (UITableViewCell*)[[button superview]superview];
  int row = [self.tableView indexPathForCell:cell].row;
  self.selectedLoc = [_tableData objectAtIndex:row];
  [self performSegueWithIdentifier:@"ViewMapSegue" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  UIViewController* destination = [segue destinationViewController];
  if([destination isKindOfClass: [AddressViewController class]]) {
    AddressViewController* upcomingDataView = [segue destinationViewController];
    [upcomingDataView setLoc:_selectedLoc];    
  }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
