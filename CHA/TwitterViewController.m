//
//  TwitterViewController.m
//  CHA
//
//  Created by Brian Sun on 1/15/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import "TwitterViewController.h"

@interface TwitterViewController ()

@end

@implementation TwitterViewController

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
  NSString * URLTwitterString = @"https://mobile.twitter.com/childrens_ortho";
  NSURL * URLTwitter = [NSURL URLWithString:URLTwitterString];
  NSURLRequest * URLRequestTwitter = [NSURLRequest requestWithURL:URLTwitter];
  [_TwitterWebView loadRequest:URLRequestTwitter];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
