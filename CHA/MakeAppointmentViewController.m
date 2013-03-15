//
//  MakeAppointmentViewController.m
//  CHA
//
//  Created by mfong on 3/10/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import "MakeAppointmentViewController.h"

@interface MakeAppointmentViewController ()

@end

@implementation MakeAppointmentViewController

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
    NSString * URLMakeAppString = @"http://childrensortho.com/online.html";
    NSURL * URLMakeApp = [NSURL URLWithString:URLMakeAppString];
    NSURLRequest * URLReqMakeApp = [NSURLRequest requestWithURL:URLMakeApp];
    [_MakeAppointmentWebView loadRequest:URLReqMakeApp];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
