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

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
CGFloat animatedDistance;

UIActionSheet *actionSheet;
UIDatePicker * datePickerView;

UIScrollView *scrollView;
UISegmentedControl *newPatientSegment;
UISegmentedControl *locationSegment;
UISegmentedControl *locationSegment2;
UISegmentedControl *xraySegment;
UISegmentedControl *timeSegment;
NSDate* chosenDate;
NSString* chosenDateStirng;
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

UITextField *chosen_;
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

UIToolbar* numberToolbar;

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
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissSheet) name:UIApplicationWillResignActiveNotification object:nil];
  UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
  
  gestureRecognizer.cancelsTouchesInView = NO;
  [self.view addGestureRecognizer:gestureRecognizer];
  
  numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
  numberToolbar.barStyle = UIBarStyleBlackTranslucent;
  numberToolbar.items = [NSArray arrayWithObjects:
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                         nil];
  [numberToolbar sizeToFit];
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
    placeholderArray = [[NSMutableArray alloc] initWithObjects:@"John", @"Doe", @"Jan 01, 1990",
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
    patientTableView.delegate = (id)self; // not sure if needed
    patientTableView.dataSource = (id)self; // definitely needed
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
    else if(textField == dob_){
        dob = chosenDateStirng;
        dob_.text = chosenDateStirng;
    }
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
    else if(textField == preferred_){
        preferredDate = chosenDateStirng;
        textField.text = chosenDateStirng;
    }
    else if(textField == additional_)
        additionalInformation = textField.text;
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textView {
  if (textView == dob_ || textView == preferred_){
    [self getDate:textView];
  } else if (textView == mPhone_ || textView == cPhone_){
    chosen_=textView;
  }
  CGRect textFieldRect = [self.view.window convertRect:textView.bounds fromView:textView];
  CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
  CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
  CGFloat numerator =
  midline - viewRect.origin.y
  - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
  CGFloat denominator =
  (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
  * viewRect.size.height;
  CGFloat heightFraction = numerator / denominator;
  UIInterfaceOrientation orientation =
  [[UIApplication sharedApplication] statusBarOrientation];
  if (orientation == UIInterfaceOrientationPortrait ||
      orientation == UIInterfaceOrientationPortraitUpsideDown)
  {
    animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
  }
  else
  {
    animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
  }
  
  CGRect viewFrame = scrollView.frame;
  viewFrame.origin.y -= animatedDistance;
  
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
  
  [self.view setFrame:viewFrame];
  
  [UIView commitAnimations];

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
        [fname_ setReturnKeyType:UIReturnKeyDone];
			[cell addSubview:fname_];
            break;
        case 1:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = lname_ = [self makeTextField:lname placeholder:placeholderArray[indexPath.row]];
            [lname_ setReturnKeyType:UIReturnKeyDone];
            [cell addSubview:lname_];
            break;
        case 2:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = dob_ = [self makeTextField:dob placeholder:placeholderArray[indexPath.row]];
            [dob_ addTarget:self action:@selector(getD) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:dob_];
            break;
        case 3:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = reason_ = [self makeTextField:reason placeholder:placeholderArray[indexPath.row]];
            [reason_ setReturnKeyType:UIReturnKeyDone];
            [cell addSubview:reason_];
            break;
        case 4:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = referrer_ = [self makeTextField:referrer placeholder:placeholderArray[indexPath.row]];
            [referrer_ setReturnKeyType:UIReturnKeyDone]; 
            [cell addSubview:referrer_];
            break;
        case 5:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = contact_ = [self makeTextField:contact placeholder:placeholderArray[indexPath.row]];
            [contact_ setReturnKeyType:UIReturnKeyDone];
            [cell addSubview:contact_];
            break;
        case 6:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = relationship_ = [self makeTextField:relationship placeholder:placeholderArray[indexPath.row]];
            [relationship_ setReturnKeyType:UIReturnKeyDone];
            [cell addSubview:relationship_];
            break;
        case 7:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = cPhone_ = [self makeTextField:cPhone placeholder:placeholderArray[indexPath.row]];
            cPhone_.keyboardType = UIKeyboardTypeNumberPad;
            cPhone_.inputAccessoryView = numberToolbar;
            [cell addSubview:cPhone_];
            break;
        case 8:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = mPhone_ = [self makeTextField:mPhone placeholder:placeholderArray[indexPath.row]];
            mPhone_.keyboardType = UIKeyboardTypeNumberPad;
            mPhone_.inputAccessoryView = numberToolbar;
            [mPhone_ setReturnKeyType:UIReturnKeyDone];

            [cell addSubview:mPhone_];
            break;
        case 9:
            cell.textLabel.text = patientTitleArray[indexPath.row];
            tf = email_ = [self makeTextField:email placeholder:placeholderArray[indexPath.row]];
            email_.keyboardType = UIKeyboardTypeEmailAddress;
            [email_ setReturnKeyType:UIReturnKeyDone];
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
    {
        NSString *to = @"appointments@childrensortho.com";
        NSString *subject = @"CHA Online Appointment";
        NSString *body = @"Child's name: ";
        body = [body stringByAppendingString:fname];
        body = [body stringByAppendingString:@" "];
        body = [body stringByAppendingString:lname];
        body = [body stringByAppendingString:@"\n"];
        body = [body stringByAppendingString:@"Date of birth: "];
        body = [body stringByAppendingString:dob];
        body = [body stringByAppendingString:@"\n"];
        body = [body stringByAppendingString:@"Reason: "];
        body = [body stringByAppendingString:reason];
        body = [body stringByAppendingString:@"\n"];
        body = [body stringByAppendingString:@"Referrer: "];
        body = [body stringByAppendingString:referrer];
        body = [body stringByAppendingString:@"\n"];
        body = [body stringByAppendingString:@"Contact: "];
        body = [body stringByAppendingString:contact];
        body = [body stringByAppendingString:@"\n"];
        body = [body stringByAppendingString:@"Relationship to child: "];
        body = [body stringByAppendingString:relationship];
        body = [body stringByAppendingString:@"\n"];
        body = [body stringByAppendingString:@"Contact phone: "];
        body = [body stringByAppendingString:cPhone];
        body = [body stringByAppendingString:@"\n"];
        body = [body stringByAppendingString:@"Mobile phone: "];
        body = [body stringByAppendingString:mPhone];
        body = [body stringByAppendingString:@"\n"];
        body = [body stringByAppendingString:@"Email: "];
        body = [body stringByAppendingString:email];
        body = [body stringByAppendingString:@"\n"];
        if(preferredLocation!=nil && preferredLocation.length >0)
        {
            body = [body stringByAppendingString:@"Preferred Location: "];
            body = [body stringByAppendingString:preferredLocation];
            body = [body stringByAppendingString:@"\n"];
        }
        if(preferredDate!=nil && preferredDate.length >0)
        {
            body = [body stringByAppendingString:@"Preferred Date: "];
            body = [body stringByAppendingString:preferredDate];
            body = [body stringByAppendingString:@"\n"];
        }
        if(preferredTime!=nil && preferredTime.length >0)
        {
            body = [body stringByAppendingString:@"Preferred Time: "];
            body = [body stringByAppendingString:preferredTime];
            body = [body stringByAppendingString:@"\n"];
        }
        if(xrayTaken!=nil && xrayTaken.length >0)
        {
            body = [body stringByAppendingString:@"Xray taken: "];
            body = [body stringByAppendingString:xrayTaken];
            body = [body stringByAppendingString:@"\n"];
        }
        if(additionalInformation!=nil && additionalInformation.length >0)
        {
            body = [body stringByAppendingString:@"Additional information: "];
            body = [body stringByAppendingString:additionalInformation];
            body = [body stringByAppendingString:@"\n"];
        }
        [self sendEmailTo:to withSubject:subject withBody:body];
        //        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You have not filled in all required sections."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
                NSLog(@"Something's amiss...");
        [alert show];
//        [alert release];
    }

}

- (void) sendEmailTo:(NSString *)to withSubject:(NSString *) subject withBody:(NSString *)body {
	NSString *mailString = [NSString stringWithFormat:@"mailto:?to=%@&subject=%@&body=%@",
							[to stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
							[subject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
							body = [body stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
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

-(NSString*) noSpaces: (NSString*)text
{
    NSString *newString =[text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    return newString;
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

- (void)getDate:(UITextField*) textField {
  actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                            delegate:nil
                                   cancelButtonTitle:nil
                              destructiveButtonTitle:nil
                                   otherButtonTitles:nil];
  
  [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
  
  CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];  
  [dateFormat setDateFormat:@"MMM d, YYYY"];
  NSDate *defaultDate = [dateFormat dateFromString:@"Jan 1, 1995"];  
  datePickerView = [[UIDatePicker alloc] initWithFrame:pickerFrame];
  datePickerView.datePickerMode = UIDatePickerModeDate;
  if (textField == dob_){
    datePickerView.date = defaultDate;
    datePickerView.maximumDate = [NSDate date];
  } else {
    datePickerView.minimumDate = [NSDate date];
  }

  
  [actionSheet addSubview:datePickerView];
  
  UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
  closeButton.momentary = YES;
  closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
  closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
  closeButton.tintColor = [UIColor blackColor];
  [closeButton addTarget:actionSheet action:@selector(dismissWithClickedButtonIndex: animated: ) forControlEvents:UIControlEventValueChanged];
  actionSheet.delegate=self;
  [actionSheet addSubview:closeButton];
  
  [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
  
  [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
  
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"MMM d, YYYY"];
  NSString *dateString = [dateFormat stringFromDate:datePickerView.date];
  chosenDate= [[NSDate alloc] initWithTimeInterval:0 sinceDate:datePickerView.date];
  chosenDateStirng=dateString;
  [self.view endEditing:YES];
}
//Hide Keyboard
- (void) hideKeyboard {
  [self.view endEditing:YES];
}

-(void)doneWithNumberPad{
  if (chosen_.text.length!=10){
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Phone numbers have to be 10 digits. Please make sure you included area code."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    chosen_.text=@"";
  } else{
    chosen_.text=[NSString stringWithFormat:@"(%@) %@-%@", [chosen_.text substringWithRange:NSMakeRange(0, 3)], [chosen_.text substringWithRange:NSMakeRange(3, 3)], [chosen_.text substringFromIndex:6]];
    [chosen_ resignFirstResponder];
    
  }
}

@end
