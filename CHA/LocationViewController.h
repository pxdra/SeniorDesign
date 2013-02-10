//
//  LocationViewController.h
//  CHA
//
//  Created by Brian Sun on 2/9/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "AddressViewController.h"

@interface LocationViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSArray* tableData;
@property Location* selectedLoc;
@end
