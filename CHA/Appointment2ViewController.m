//
//  Appointment2ViewController.m
//  CHA
//
//  Created by mfong on 3/16/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import "Appointment2ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface Appointment2ViewController ()

@end

UIScrollView *scrollView;
UISegmentedControl *newPatientSegment;
NSString* fname;
NSString* lname;
NSString* dob;
NSString* reason;
NSString* referrer;
NSString* contact;
NSString* relationship;
NSString* cPhone; // contact Phone
NSString* mPhone; // mobile Phone
NSString* email;

UITextField *fname_;
UITextField *lname_;
UITextField* dob_;
UITextField* reason_;
UITextField* referrer_;
UITextField* contact_;
UITextField* relationship_;
UITextField* cPhone_; // contact Phone
UITextField* mPhone_; // mobile Phone
UITextField* email_;

NSMutableArray *yourItemsArray;
NSMutableArray *placeholderArray;
NSMutableArray *patientTitleArray;

@implementation Appointment2ViewController

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
	// Do any additional setup after loading the view.
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action: @selector(buttonAction1)];
    self.navigationItem.rightBarButtonItem = rightButton;
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSInteger viewcount = 2;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *viewcount);
    [self.view addSubview:scrollView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,300,100)];
    label1.font = [UIFont systemFontOfSize:14];
    label1.text = @"If this is an emergency do NOT use this appointment request form. Instead, please go to the emerency room or use the numbers in the \"Call Us\" tab below.";
    [label1 setLineBreakMode:(NSLineBreakByWordWrapping)];
    label1.numberOfLines = 5;
    label1.backgroundColor = [UIColor clearColor];

    [scrollView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 200)];
    label2.font = [UIFont systemFontOfSize:14];
    label2.text = @"Is your child new to our practice?";
    [label2 setLineBreakMode:(NSLineBreakByWordWrapping)];
    label2.numberOfLines = 50;
    label2.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:label2];
    
    yourItemsArray = [[NSMutableArray alloc] initWithObjects:@"item 01", @"item 02", @"item 03", nil];
    placeholderArray = [[NSMutableArray alloc] initWithObjects:@"John", @"Doe", @"01/01/1990",
                        @"Reason", @"Referrer", @"Contact Person", @"Mother/Father/etc",
                        @"(###)-###-####", @"(###)-###-####", @"me@example.com",nil];
    patientTitleArray = [[NSMutableArray alloc] initWithObjects:@"First name", @"Last name", @"Child DOB",
                        @"Reason", @"Referrer", @"Contact person", @"Relationship",
                        @"Contact phone #", @"Mobile phone #", @"Contact email",nil];

    
    NSArray *buttonNames = [NSArray arrayWithObjects:
                            @"Yes", @"No", nil];
    newPatientSegment = [[UISegmentedControl alloc]
                                            initWithItems:buttonNames];
    newPatientSegment.frame = CGRectMake(10, 120, 300, 30);
    newPatientSegment.momentary = NO;
    [newPatientSegment addTarget:self action:@selector(newPatientAction:) forControlEvents:UIControlEventValueChanged];
    newPatientSegment.segmentedControlStyle = UISegmentedControlStyleBar;
    [scrollView addSubview:newPatientSegment];
    
    UITableView *patientTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 160, 300, 440) style:UITableViewStylePlain];
    UITableViewCell *patientFNameCell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 300, 0)];
    fname_=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 300, patientFNameCell.frame.size.height)];
    fname_.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    fname_.autoresizesSubviews=YES;
    [fname_ setBorderStyle:UITextBorderStyleRoundedRect];
    [fname_ setPlaceholder:@"First name"];
    [fname_ addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    fname_.delegate = self;
    
    lname_=[[UITextField alloc]initWithFrame:CGRectMake(0, patientFNameCell.frame.size.height, 300, patientFNameCell.frame.size.height)];
    lname_.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    lname_.autoresizesSubviews=YES;
    [lname_ setBorderStyle:UITextBorderStyleRoundedRect];
    [lname_ setPlaceholder:@"Last name"];
    [lname_ addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    lname_.delegate = self;
    
//    [patientFNameCell addSubview:fname_]; // not needed
//    [patientTableView addSubview:patientFNameCell];
    patientTableView.delegate = self; // not sure if needed
    patientTableView.dataSource = self; // definitely needed
//    [patientTableView addSubview: patientFNameCell]; // not needed
    [scrollView addSubview:patientTableView];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [placeholderArray count];
}
- (IBAction)textFieldFinished:(id)sender {
    NSLog(@"text field finished");
    [sender resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"text field should return");
    if(textField.text.length < 1)
        NSLog(@"Oops still empty string");
    else
        NSLog(textField.text);
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
	if ( textField == fname_ )
		fname = textField.text ;
    else if ( textField == lname_ )
		lname = textField.text ;
    else if(textField == dob_)
        dob = textField.text;
    else if(textField == reason_)
        reason = textField.text;
    else if(textField == referrer_)
        referrer = textField.text;
    else if(textField == email_)
        email = textField.text;
    else if(textField == contact_)
        contact = textField.text;
    else if(textField == cPhone_)
        cPhone = textField.text;
    else if(textField == relationship_)
        relationship = textField.text;
    else if(textField == mPhone_)
        mPhone = textField.text;    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITextField* tf = nil ;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 2;
    [cell.layer setCornerRadius:5.0f]; //rounded corners
    [cell.layer setMasksToBounds:YES];
    [cell.layer setBorderWidth:0.5f];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = patientTitleArray[indexPath.row];
			tf = fname_ = [self makeTextField:fname placeholder:placeholderArray[indexPath.row]];
			[cell addSubview:fname_];
            break;
        case 1:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = lname_ = [self makeTextField:lname placeholder:placeholderArray[indexPath.row]];
            [cell addSubview:lname_];
            break;
        case 2:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = dob_ = [self makeTextField:dob placeholder:placeholderArray[indexPath.row]];
            [cell addSubview:dob_];
            break;
        case 3:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = reason_ = [self makeTextField:reason placeholder:placeholderArray[indexPath.row]];
            [cell addSubview:reason_];
            break;
        case 4:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = referrer_ = [self makeTextField:referrer placeholder:placeholderArray[indexPath.row]];
            [cell addSubview:referrer_];
            break;
        case 5:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = contact_ = [self makeTextField:contact placeholder:placeholderArray[indexPath.row]];
            [cell addSubview:contact_];
            break;
        case 6:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = relationship_ = [self makeTextField:relationship placeholder:placeholderArray[indexPath.row]];
            [cell addSubview:relationship_];
            break;
        case 7:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = cPhone_ = [self makeTextField:cPhone placeholder:placeholderArray[indexPath.row]];
            [cell addSubview:cPhone_];
            break;
        case 8:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = mPhone_ = [self makeTextField:mPhone placeholder:placeholderArray[indexPath.row]];
            [cell addSubview:mPhone_];
            break;
        case 9:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = email_ = [self makeTextField:email placeholder:placeholderArray[indexPath.row]];
            [cell addSubview:email_];
            break;

    }
	tf.frame = CGRectMake(120, 12, 170, 30);
	[tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
	tf.delegate = self ;
    return cell;
}


-(IBAction) newPatientAction:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    switch ([segmentedControl selectedSegmentIndex])
    {
        case 0:
        {
            NSLog(@"Yes new patient");
            break;
        }
        case 1:
        {
            NSLog(@"No, old patient");
            break;
        }
    }
}
-(IBAction)buttonAction1
{
    NSLog(@"Pressed done.");
    NSLog(fname);
    NSLog(lname);
    NSLog(dob);
    NSLog(reason);
    NSLog(referrer); // 5
    NSLog(contact);
    NSLog(relationship);
    NSLog(cPhone);
    NSLog(mPhone);
    NSLog(email); // 10
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITextField*) makeTextField: (NSString*)text
                  placeholder: (NSString*)placeholder  {
	UITextField *tf = [[UITextField alloc] init] ;
	tf.placeholder = placeholder ;
	tf.text = text ;
	tf.autocorrectionType = UITextAutocorrectionTypeNo ;
	tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
	tf.adjustsFontSizeToFitWidth = YES;
	tf.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
	return tf ;
}

@end
