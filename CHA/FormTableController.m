//
//  FormTableControllerViewController.m
//  CHA
//
//  Created by mfong on 3/10/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import "FormTableController.h"

@implementation FormTableController
//@synthesize name = fname_ ;
//@synthesize address = address_ ;
//@synthesize password = password_ ;
//@synthesize description = description_ ;

@synthesize  fname =  fname_ ; // john
@synthesize lname = lname_ ; // doe
@synthesize dob= dob_ ; // mm/dd/yyyy
@synthesize reason= reason_ ; //reason for appointment
@synthesize referrer= referrer_ ; //who referred you
@synthesize contact= contact_ ; // ocntact person
@synthesize relationship= relationship_ ; //relationship to child
@synthesize contactPhone= contactPhone_ ;
@synthesize mobilePhone= mobilePhone_ ;
@synthesize contactEmail= contactEmail_ ;
@synthesize preferredDate= preferredDate_ ;


#pragma mark -
#pragma mark Initialization

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.fname = @"";
    self.lname = @"";
    self.dob = @"";
    self.reason = @"";
    self.referrer = @"";//5
    self.contact = @"";
    self.relationship = @"";
    self.contactPhone = @"";
    self.mobilePhone = @"";
    self.contactEmail = @"";
    self.preferredDate = @"";
    
//    self.newPatient = @"";
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;// 1
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 11;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] ;
    
    // Make cell unselectable
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	UITextField* tf = nil ;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 2;
	switch ( indexPath.row ) {
		case 0: {
			cell.textLabel.text = @"First Name" ;
			tf = fnameField_ = [self makeTextField:self.fname placeholder:@"John"];
			[cell addSubview:fnameField_];
			break ;
		}
        case 1: {
			cell.textLabel.text = @"Last Name" ;
			tf = lnameField_ = [self makeTextField:self.lname placeholder:@"Doe"];
			[cell addSubview:lnameField_];
			break ;
		}
        case 2: {
			cell.textLabel.text = @"DOB" ;tf =dobField_= [self makeTextField:self.lname placeholder:@"mm/dd/yyyy"];
			[cell addSubview:dobField_];
			break ;
		}
        case 3: {
			cell.textLabel.text = @"Reason" ;
			tf = reasonField_ = [self makeTextField:self.reason placeholder:@"Reason"];
			[cell addSubview:reasonField_];
			break ;
		}
        case 4: {
			cell.textLabel.text = @"Referrer" ;
			tf = referrerField_ = [self makeTextField:self.referrer placeholder:@"Referrer"];
			[cell addSubview:referrerField_];
			break ;
		}case 5: {
			cell.textLabel.text = @"Contact" ;
			tf = contactField_ = [self makeTextField:self.contact placeholder:@"Contact"];
			[cell addSubview:contactField_];
			break ;
		}case 6: {
			cell.textLabel.text = @"Relationship" ;
			tf = relationshipField_ = [self makeTextField:self.relationship placeholder:@"Mother/Father/etc"];
			[cell addSubview:relationshipField_];
			break ;
		}case 7: {
			cell.textLabel.text = @"Contact #" ;
			tf = contactPhoneField_ = [self makeTextField:self.contactPhone placeholder:@"xxx-xxx-xxxx"];
			[cell addSubview:contactPhoneField_];
			break ;
		}case 8: {
			cell.textLabel.text = @"Mobile #" ;
			tf = mobilePhoneField_ = [self makeTextField:self.mobilePhone placeholder:@"xxx-xxx-xxxx"];
			[cell addSubview:mobilePhoneField_];
			break ;
		}case 9: {
			cell.textLabel.text = @"Contact Email" ;
			tf = contactEmailField_ = [self makeTextField:self.contactEmail placeholder:@"name@example.com"];
			[cell addSubview:contactEmailField_];
			break ;
		}case 10: {
			cell.textLabel.text = @"Preferred Date" ;
			tf = preferredDateField_ = [self makeTextField:self.preferredDate placeholder:@"mm/dd/yyyy"];
			[cell addSubview:preferredDateField_];
			break ;
		}
	}
    
	// Textfield dimensions
	tf.frame = CGRectMake(120, 12, 170, 30);
	
	// Workaround to dismiss keyboard when Done/Return is tapped
	[tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
	
	// We want to handle textFieldDidEndEditing
	tf.delegate = self ;
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
//    [super dealloc];
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

-(UIPickerView*) makePickerField: (NSString *)text
                placeholder: (NSString*) placeholder
{
    UIPickerView *pv = [[UIPickerView alloc] init];
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    [arr addObject:@"Yes"];
    [arr addObject:@"No"];
    return pv;
}

// Workaround to hide keyboard when Done is tapped
- (IBAction)textFieldFinished:(id)sender {
    // [sender resignFirstResponder];
}

// Textfield value changed, store the new value.
- (void)textFieldDidEndEditing:(UITextField *)textField {
	if ( textField == fnameField_ )
		self.fname = textField.text ;
    else if ( textField == lnameField_ )
		self.lname = textField.text ;
    else if(textField == dobField_)
        self.dob = textField.text;
    else if(textField == reasonField_)
        self.reason = textField.text;
    else if(textField == referrerField_)
        self.referrer = textField.text;
    else if(textField == contactEmailField_)
        self.contactEmail = textField.text;
    else if(textField == contactField_)
        self.contact = textField.text;
    else if(textField == contactPhoneField_)
        self.contactPhone = textField.text;
    else if(textField == relationshipField_)
        self.relationship = textField.text;
    else if(textField == mobilePhoneField_)
        self.mobilePhone = textField.text;
    else if(textField == preferredDateField_)
        self.preferredDate = textField.text;
//    else if(textField == newPatientField_)
//        self.newPatient = textField.text;
}





@end

