//
//  TeamViewController.h
//  CHA
//
//  Created by Brian Sun on 3/18/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonViewController.h"

@interface TeamViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIButton *Physicians;
@property (weak, nonatomic) IBOutlet UIButton *PAs;
@property (weak, nonatomic) IBOutlet UIButton *Nurses;
@property (weak, nonatomic) IBOutlet UIButton *CATs;

@property NSString* selectedType;
@end
