
//
//  SecondViewController.m
//  CHA
//
//  Created by Brian Sun on 1/15/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import "AppointmentWebViewController.h"

@interface AppointmentWebViewController ()

@end

@implementation AppointmentWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString * URLFacebookString = @"http://childrensortho.com/online.html";
    NSURL * URLFacebook = [NSURL URLWithString:URLFacebookString];
    NSURLRequest * URLRequestFacebook = [NSURLRequest requestWithURL:URLFacebook];
    [_FacebookWebView loadRequest:URLRequestFacebook];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
