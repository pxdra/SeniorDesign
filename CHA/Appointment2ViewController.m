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
UISegmentedControl *locationSegment;
UISegmentedControl *locationSegment2;
UISegmentedControl *xraySegment;
UISegmentedControl *timeSegment;
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

NSString* preferredLocation;
NSString* newPatient;
NSString* xrayTaken;
NSString* preferredDate ;
NSString* preferredTime;
NSString* additionalInformation ;

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

UITextField * preferred_;
UITextField *additional_;

NSMutableArray *yourItemsArray;
NSMutableArray *placeholderArray;
NSMutableArray *patientTitleArray;
NSMutableArray *locationNames;
NSMutableArray *locationNames2;
NSMutableArray *timeArray;

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
    UIColor * maroonBG = [UIColor colorWithRed:74/255.0f green:30/255.0f blue:40/255.0f alpha:1.0f];
    // text.borderStyle = UITextBorderStyleRoundedRect;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action: @selector(buttonAction1)];
    self.navigationItem.rightBarButtonItem = rightButton;
//    NSLog(@"float value is: %f", self.view.frame.size.height);
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,
                                                                self.view.frame.size.height)];
    NSInteger viewcount = 3;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *viewcount);
    [self.view addSubview:scrollView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,300,90)];
    label1.font = [UIFont systemFontOfSize:14];
    label1.text = @"If this is an emergency do NOT use this appointment request form. Instead, please go to the emerency room or use the numbers in the \"Call Us\" tab below.";
    [label1 setLineBreakMode:(NSLineBreakByWordWrapping)];
    label1.numberOfLines = 5;
    label1.backgroundColor = [UIColor clearColor];
    
    [scrollView addSubview:label1];
    
    UILabel *first = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 300, 30)];
    first.font = [UIFont systemFontOfSize:14];
    first.text = @"Patient Information [REQUIRED]";
    first.backgroundColor = maroonBG;
    [first setLineBreakMode:(NSLineBreakByWordWrapping)];
    first.numberOfLines = 2;
    first.textColor = [UIColor whiteColor];
    [scrollView addSubview:first];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 90+30, 300, 30)];
    label2.font = [UIFont systemFontOfSize:14];
    label2.text = @"Is your child new to our practice?";
    [label2 setLineBreakMode:(NSLineBreakByWordWrapping)];
    label2.numberOfLines = 5;
    label2.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:label2];
    
    yourItemsArray = [[NSMutableArray alloc] initWithObjects:@"item 01", @"item 02", @"item 03", nil];
    placeholderArray = [[NSMutableArray alloc] initWithObjects:@"John", @"Doe", @"01/01/1990",
                        @"Reason", @"Referrer", @"Contact Person", @"Mother/Father/etc",
                        @"(###)-###-####", @"(###)-###-####", @"me@example.com",nil];
    patientTitleArray = [[NSMutableArray alloc] initWithObjects:@"First name", @"Last name", @"Child DOB",
                         @"Reason", @"Referrer", @"Contact person", @"Relationship",
                         @"Contact phone #", @"Mobile phone #", @"Contact email",nil];
    timeArray = [[NSMutableArray alloc] initWithObjects:@"First Available", @"AM", @"PM", nil];
    
    
    NSArray *buttonNames = [NSArray arrayWithObjects:
                            @"Yes", @"No", nil];
    newPatientSegment = [[UISegmentedControl alloc]
                         initWithItems:buttonNames];
    newPatientSegment.frame = CGRectMake(10, 150, 300, 30);
    newPatientSegment.momentary = NO;
    [newPatientSegment addTarget:self action:@selector(newPatientAction:) forControlEvents:UIControlEventValueChanged];
    newPatientSegment.segmentedControlStyle = UISegmentedControlStyleBar;
    [scrollView addSubview:newPatientSegment];
    
    UITableView *patientTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 190, 300, 440) style:UITableViewStylePlain];
    patientTableView.delegate = self; // not sure if needed
    patientTableView.dataSource = self; // definitely needed
    [scrollView addSubview:patientTableView];
    
    UILabel *second = [[UILabel alloc] initWithFrame:CGRectMake(10, 200+440, 300, 30)];
    second.font = [UIFont systemFontOfSize:14];
    second.text = @"Appointment Information";
    second.backgroundColor = maroonBG;
    [second setLineBreakMode:(NSLineBreakByWordWrapping)];
    second.numberOfLines = 2;
    second.textColor = [UIColor whiteColor];
    [scrollView addSubview:second];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 230+440, 300, 25)];
    label3.textAlignment=NSTextAlignmentCenter;
    label2.textAlignment=NSTextAlignmentCenter;
    first.textAlignment=NSTextAlignmentCenter;
    second.textAlignment=NSTextAlignmentCenter;
    label1.textAlignment=NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:14];
    label3.text = @"Location Preference";
    [label3 setLineBreakMode:(NSLineBreakByWordWrapping)];
    label3.numberOfLines = 5;
    
    label3.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:label3];
    
    
    locationNames = [[NSMutableArray alloc] initWithObjects:
                     @"Meridian Mark ", @"Alpharetta", @"Duluth",nil];
    locationNames2 = [[NSMutableArray alloc] initWithObjects:
                      @"Marietta", @"Fayetteville", @"Forsyth", nil];
    locationSegment = [[UISegmentedControl alloc]
                       initWithItems:locationNames];
    locationSegment.frame = CGRectMake(10, 230+440+30, 300, 30);
    locationSegment.momentary = NO;
    [locationSegment addTarget:self action:@selector(locationAction:) forControlEvents:UIControlEventValueChanged];
    locationSegment.segmentedControlStyle = UISegmentedControlStyleBar;
    [scrollView addSubview:locationSegment];
    
    locationSegment2 = [[UISegmentedControl alloc]
                        initWithItems:locationNames2];
    locationSegment2.frame = CGRectMake(10, 230+440+60, 300, 30);
    locationSegment2.momentary = NO;
    [locationSegment2 addTarget:self action:@selector(locationAction:) forControlEvents:UIControlEventValueChanged];
    locationSegment2.segmentedControlStyle = UISegmentedControlStyleBar;
    [scrollView addSubview:locationSegment2];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 230+530, 300, 30)];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = [UIFont systemFontOfSize:14];
    label4.text = @"Preferred Date?";
    [label4 setLineBreakMode:(NSLineBreakByWordWrapping)];
    label4.numberOfLines = 5;
    label4.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:label4];
    
    preferred_ = [[UITextField alloc] initWithFrame:CGRectMake(10, 230+500+60, 300, 30)];
    preferred_.placeholder = @"\t01/01/2013";
    preferred_.backgroundColor = [UIColor whiteColor];
    [preferred_.layer setCornerRadius:5.0f]; //rounded corners
    [preferred_.layer setMasksToBounds:YES];
    [preferred_.layer setBorderWidth:0.5f];
	preferred_.autocorrectionType = UITextAutocorrectionTypeNo ;
	preferred_.autocapitalizationType = UITextAutocapitalizationTypeNone;
	preferred_.adjustsFontSizeToFitWidth = YES;
    preferred_.delegate = self;
    [scrollView addSubview:preferred_];
    
    UILabel *label15 = [[UILabel alloc] initWithFrame:CGRectMake(10, 230+560+30, 300, 30)];
    label15.textAlignment = NSTextAlignmentCenter;
    label15.font = [UIFont systemFontOfSize:14];
    label15.text = @"Preferred Time?";
    [label15 setLineBreakMode:(NSLineBreakByWordWrapping)];
    label15.numberOfLines = 5;
    label15.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:label15];
    
    timeSegment = [[UISegmentedControl alloc]
                         initWithItems:timeArray];
    timeSegment.frame = CGRectMake(10, 230+560+30+30, 300, 30);
    timeSegment.momentary = NO;
    [timeSegment addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventValueChanged];
    timeSegment.segmentedControlStyle = UISegmentedControlStyleBar;
    [scrollView addSubview:timeSegment];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(10, 230+560+90, 300, 60)];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.font = [UIFont systemFontOfSize:14];
    label5.text = @"***We are not contracted with Peachstate or out of state Medicaid";
    [label5 setLineBreakMode:(NSLineBreakByWordWrapping)];
    label5.numberOfLines = 5;
    label5.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(10, 290+560+90, 300, 30)];
    label6.textAlignment = NSTextAlignmentCenter;
    label6.font = [UIFont systemFontOfSize:14];
    label6.text = @"Have x-rays been taken?";
    [label6 setLineBreakMode:(NSLineBreakByWordWrapping)];
    label6.numberOfLines = 5;
    label6.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:label6];
    
    xraySegment = [[UISegmentedControl alloc]
                   initWithItems:buttonNames];
    xraySegment.frame = CGRectMake(10, 290+560+120, 300, 30);
    xraySegment.momentary = NO;
    [xraySegment addTarget:self action:@selector(xrayAction:) forControlEvents:UIControlEventValueChanged];
    xraySegment.segmentedControlStyle = UISegmentedControlStyleBar;
    [scrollView addSubview:xraySegment];
    
    UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(10, 290+560+150, 300, 30)];
    label7.textAlignment = NSTextAlignmentCenter;
    label7.font = [UIFont systemFontOfSize:14];
    label7.text = @"If yes please bring them to your appointment.";
    [label7 setLineBreakMode:(NSLineBreakByWordWrapping)];
    label7.numberOfLines = 5;
    label7.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:label7];
    
    UILabel *label8 = [[UILabel alloc] initWithFrame:CGRectMake(10, 290+560+180, 300, 30)];
    label8.textAlignment = NSTextAlignmentCenter;
    label8.font = [UIFont systemFontOfSize:14];
    label8.text = @"Additional Information";
    [label8 setLineBreakMode:(NSLineBreakByWordWrapping)];
    label8.numberOfLines = 5;
    label8.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:label8];
    
    additional_ = [[UITextField alloc] initWithFrame:CGRectMake(10, 290+560+210, 300, 100)];
    additional_.placeholder = @"\tAdditional information";
    additional_.backgroundColor = [UIColor whiteColor];
    [additional_.layer setCornerRadius:5.0f]; //rounded corners
    [additional_.layer setMasksToBounds:YES];
    [additional_.layer setBorderWidth:0.5f];
	additional_.autocorrectionType = UITextAutocorrectionTypeNo ;
	additional_.autocapitalizationType = UITextAutocapitalizationTypeNone;
	additional_.adjustsFontSizeToFitWidth = YES;
    additional_.delegate = self;
    [scrollView addSubview:additional_];
    
    UILabel *label9 = [[UILabel alloc] initWithFrame:CGRectMake(10, 290+560+210+100, 300, 90)];
    label9.textAlignment = NSTextAlignmentCenter;
    label9.font = [UIFont systemFontOfSize:14];
    label9.text = @"A member of our scheduling team will contact you by 5 PM unless request is received after 3 PM, in which case you will be contacted on the next business day.";
    [label9 setLineBreakMode:(NSLineBreakByWordWrapping)];
    label9.numberOfLines = 5;
    label9.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:label9];
    
    //    UIPickerView *myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    //    myPickerView.delegate = self;
    //    myPickerView.showsSelectionIndicator = YES;
    //    [patient addSubview:myPickerView];
    
    
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
//    NSLog(@"text field should return");
//    if(textField.text.length < 1)
//        NSLog(@"Oops still empty string");
//    else
//        NSLog(textField.text);
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
    else if(textField == preferred_)
        preferredDate = textField.text;
    else if(textField == additional_)
        additionalInformation = textField.text;
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
    newPatient = [segmentedControl selectedSegmentIndex] == 0 ? @"Yes" : @"No";
    NSLog([segmentedControl selectedSegmentIndex] == 0 ? @"Yes" : @"No");
}

-(IBAction) timeAction:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    switch([segmentedControl selectedSegmentIndex])
    {
        case 0: preferredTime = @"First available"; break;
        case 1: preferredTime = @"AM" ; break;
        case 2: preferredTime = @"PM" ; break;
    }
}

-(IBAction) xrayAction:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    xrayTaken = [segmentedControl selectedSegmentIndex] == 0 ? @"Yes" : @"No";
    NSLog([segmentedControl selectedSegmentIndex] == 0 ? @"Yes" : @"No");
}

-(IBAction) locationAction:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    preferredLocation = locationNames[ [segmentedControl selectedSegmentIndex] ];
    if(segmentedControl == locationSegment)
    {
        [locationSegment2 setSelectedSegmentIndex:UISegmentedControlNoSegment];
    }
    else // locationSegment2
    {
        [locationSegment setSelectedSegmentIndex:UISegmentedControlNoSegment];
    }
//    NSLog(preferredLocation);
    
}

-(IBAction)buttonAction1
{
    NSLog(@"Pressed done.");
    BOOL b = newPatient!=nil && newPatient.length > 0;
    b &= fname!=nil && fname.length > 0;
    b &= lname!=nil && lname.length > 0;
    b &= dob!=nil && dob.length > 0;
    b &= reason!=nil && reason.length > 0;
    b &= referrer!=nil && referrer.length > 0;
    b &= contact!=nil && contact.length > 0;
    b &= relationship!=nil && relationship.length > 0;
    b &= cPhone!=nil && cPhone.length > 0;
    b &= mPhone!=nil && mPhone.length > 0;
    b &= email!=nil && email.length > 0;
//    b &= preferredLocation!=nil && preferredLocation.length > 0;
//    b &= preferredDate!=nil && preferredDate.length>0;
    if(b == TRUE)
        NSLog(@"All okay!");
    else
        NSLog(@"Something's amiss...");
//    NSLog(fname!=nil && fname.length > 0 ? @"Valid" : @"Invalid");
//    NSLog(lname!=nil && lname.length > 0 ? @"Valid" : @"Invalid");
//    NSLog(dob!=nil && dob.length > 0 ? @"Valid" : @"Invalid");
//    NSLog(reason!=nil && reason.length > 0 ? @"Valid" : @"Invalid");
//    NSLog(referrer!=nil && referrer.length > 0 ? @"Valid" : @"Invalid");
//    NSLog(contact!=nil && contact.length > 0 ? @"Valid" : @"Invalid");
//    NSLog(relationship!=nil && relationship.length > 0 ? @"Valid" : @"Invalid");
//    NSLog(cPhone!=nil && cPhone.length > 0 ? @"Valid" : @"Invalid");
//    NSLog(mPhone!=nil && mPhone.length > 0 ? @"Valid" : @"Invalid");
//    NSLog(email!=nil && email.length > 0 ? @"Valid" : @"Invalid");
}

-(NSString*) notEmpty: (NSString *)field
{
    return field!=nil && field.length > 0 ? @"Valid" : @"Invalid";
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
