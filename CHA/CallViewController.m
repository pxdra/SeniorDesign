//
//  CallViewController.m
//  CHA
//
//  Created by mfong on 1/15/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import "CallViewController.h"

#define OFFICE 1
#define CONCUSSION 2

@interface CallViewController ()

@end

@implementation CallViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }

    return self;
}
/*
- (void)viewDidLoad
{
  /*
  
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // make buttons
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    // positions
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    CGFloat middleOffset = 100.0;
    CGFloat leftRightOffset = 10;
    CGFloat buttonHeight = 30;
    button.frame = CGRectMake(leftRightOffset, screenHeight/2 - middleOffset, screenWidth - leftRightOffset*2, buttonHeight);
    button2.frame = CGRectMake(leftRightOffset, screenHeight/2 , screenWidth - leftRightOffset*2, buttonHeight);
    // titles
    NSString * msg1 = @"Call office: 404-255-1933";
    NSString * msg2 = @"Concussion Hotline: 678-686-6867";
    [button setTitle:msg1 forState:UIControlStateNormal];
    [button2 setTitle:msg2 forState:UIControlStateNormal];
    
    // clicklisteners
}
   */

-(IBAction)buttonAction1
{
    NSString * question = @"Call office: 404-255-1933?";
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:question delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES",nil];
    [alert setTag:1];
    [alert show];
//    [alert release];
}
-(IBAction)buttonAction2
{
    NSString * question = @"Call Concussion Hotline: 678-686-6867";
    UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"" message:question delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES",nil];
    [alert2 show];
//    [alert release];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == OFFICE)
    {
        if(buttonIndex == 1)
        {
            NSLog(@"Attempting to call office.");
            [[UIApplication sharedApplication]
             openURL:[NSURL URLWithString:@"tel://404-255-1933"]];
        }
        else
        {
            NSLog(@"Did not call office.");
        }
    }
    else
    {
        if(buttonIndex == 1)
        {
            NSLog(@"Attempting to call concussion hotline.");
            [[UIApplication sharedApplication]
             openURL:[NSURL URLWithString:@"tel://678-686-6867"]];
        }
        else
        {
            NSLog(@"Did not call concussion hotline.");
        }
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [_CallOffice addTarget:self action:@selector(buttonAction1)
        forControlEvents:UIControlEventTouchUpInside];
    [_CallConcussion addTarget:self action:@selector(buttonAction2)
            forControlEvents:UIControlEventTouchUpInside];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
