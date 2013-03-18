//
//  PersonViewController.m
//  CHA
//
//  Created by Brian Sun on 3/17/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import "PersonViewController.h"

@interface PersonViewController ()

@end

@implementation PersonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  _tableData = [self getData];
  self.navigationItem.title = _type;
}

- (NSArray*) getData{
  NSArray *information = [self getJSONArray:_type];
  NSMutableArray *peopleArray = [[NSMutableArray alloc] init];
  for (NSDictionary * personInfo in information){
    NSString *name = [personInfo objectForKey:@"name"];
    NSString *picString = [personInfo objectForKey:@"picString"];
    Person * person = [[Person alloc] initWithName:name WithPicString:picString];
    NSArray *paragraphs = [personInfo objectForKey:@"paragraphs"];
    for (NSString * paragraph in paragraphs){
      [person addParagraph:paragraph];
    }
    NSArray *greenBoxes = [personInfo objectForKey:@"greenBoxes"];
    for (NSDictionary * greenBox in greenBoxes){
      GreenBox* item =[[GreenBox alloc] initWithTitle:[greenBox objectForKey:@"title"]];
      NSArray* bullets = [greenBox objectForKey:@"bullets"];
      for (NSString * bullet in bullets){
        [item addBullet:bullet];
      }
    [person addGreenBox:item];
    }
    [peopleArray addObject:person];
  }
  return peopleArray;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return [_tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"personCells";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  UIButton *locButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  locButton.frame = CGRectMake(30.0f, 0.0f, 260.0f, 44.0f);
  [locButton setTitle:[[_tableData objectAtIndex:indexPath.row] getName] forState:UIControlStateNormal];
  [locButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
  [cell addSubview:locButton];
  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  
  return cell;
}

- (void) buttonAction: (id) sender{
  UIButton *button = (UIButton *)sender;
  UITableViewCell* cell = (UITableViewCell*)[button superview];
  int row = [self.tableView indexPathForCell:cell].row;
  _selectedPerson = [_tableData objectAtIndex:row];
  NSLog(@"Button selected:%d", row);
  [self performSegueWithIdentifier:@"personDetailSegue" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  UIViewController* destination = [segue destinationViewController];
  if([destination isKindOfClass: [PersonDetailViewController class]]) {
    PersonDetailViewController* upcomingDataView = [segue destinationViewController];
    [upcomingDataView setPerson:_selectedPerson];
  }
}


-(NSArray*)getJSONArray:(NSString*)type{
  NSString* fileName;
  if ([type isEqualToString:@"Physicians"]){
    fileName = @"Physicians";
  }
  else if ([type isEqualToString:@"Physician Assistants"]){
    fileName = @"PhysicianAssistants";
  }
  else if ([type isEqualToString:@"Nurse Practioners"]){
    fileName = @"NursePractioners";
  }
  else if ([type isEqualToString:@"Certified Athletic Trainers"]){
    fileName = @"CertifiedAthleticTrainers";
  }
  NSString *path = [[NSBundle mainBundle] pathForResource:fileName
                                                   ofType:@"json"];
  NSData* data = [NSData dataWithContentsOfFile:path];
  NSError *e = nil;
  NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
  
  return jsonArray;
}

@end
