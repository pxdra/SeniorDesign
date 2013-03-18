//
//  TeamViewController.m
//  CHA
//
//  Created by Brian Sun on 3/18/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import "TeamViewController.h"

@interface TeamViewController ()

@end

@implementation TeamViewController

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
    [_Physicians addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_PAs addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_Nurses addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_CATs addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) buttonAction: (id) sender{
  if (sender == _Physicians){
    _selectedType=@"Physicians";
  }
  else if (sender == _PAs){
    _selectedType=@"Physician Assistants";
  }
  else if (sender == _Nurses){
    _selectedType=@"Nurse Practioners";
  }
  else if (sender == _CATs){
    _selectedType=@"Certified Athletic Trainers";
  }
  [self performSegueWithIdentifier:@"personListSegue" sender:self];
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  UIViewController* destination = [segue destinationViewController];
  if([destination isKindOfClass: [PersonViewController class]]) {
    PersonViewController* upcomingDataView = [segue destinationViewController];
    [upcomingDataView setType:_selectedType];
  }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
