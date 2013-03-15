//
//  FormTableControllerViewController.h
//  CHA
//
//  Created by mfong on 3/10/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormTableController : UITableViewController<UITextFieldDelegate> {
	NSString* fname_ ; // john
    NSString* lname_ ; // doe
    NSString* dob_ ; // mm/dd/yyyy
    NSString* reason_ ; //reason for appointment
    NSString* referrer_ ; //who referred you
    NSString* contact_ ; // ocntact person
    NSString* relationship_ ; //relationship to child
    NSString* contactPhone_ ;
    NSString* mobilePhone_ ;
    NSString* contactEmail_ ;
    NSString* preferredDate_ ;

    
    UITextField* fnameField_;
    UITextField* lnameField_;
    UITextField* dobField_;
    UITextField* reasonField_;
    UITextField* referrerField_;
    UITextField* contactField_;
    UITextField* relationshipField_;
    UITextField* contactPhoneField_;
    UITextField* mobilePhoneField_;
    UITextField* contactEmailField_;
    UITextField* preferredDateField_;
    
//    NSString* newPatient_;
//    UIPickerView* newPatientField_;
    
}

// Creates a textfield with the specified text and placeholder text
-(UITextField*) makeTextField: (NSString*)text
                  placeholder: (NSString*)placeholder  ;

// Handles UIControlEventEditingDidEndOnExit
- (IBAction)textFieldFinished:(id)sender ;

@property (nonatomic,copy) NSString* fname ; // john
@property (nonatomic,copy) NSString* lname ; // doe
@property (nonatomic,copy) NSString* dob ; // mm/dd/yyyy
@property (nonatomic,copy) NSString* reason ; //reason for appointment
@property (nonatomic,copy) NSString* referrer ; //who referred you
@property (nonatomic,copy) NSString* contact ; // ocntact person
@property (nonatomic,copy) NSString* relationship ; //relationship to child
@property (nonatomic,copy) NSString* contactPhone ;
@property (nonatomic,copy) NSString* mobilePhone ;
@property (nonatomic,copy) NSString* contactEmail ;
@property (nonatomic,copy) NSString* preferredDate ;

//@property (nonatomic,copy) NSString* newPatient ;

@end
