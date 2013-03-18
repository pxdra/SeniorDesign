//
//  PersonViewController.h
//  CHA
//
//  Created by Brian Sun on 3/17/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "PersonDetailViewController.h"
#import "GreenBox.h"

@interface PersonViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSArray* tableData;
@property Person* selectedPerson;
@property NSString* type;

-(NSArray*)getJSONArray:(NSString*)fileName;
@end
