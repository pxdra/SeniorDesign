//
//  PersonDetailViewController.m
//  CHA
//
//  Created by Brian Sun on 3/18/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import "PersonDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PersonDetailViewController ()

@end

@implementation PersonDetailViewController

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
  int width = self.view.frame.size.width;
  int height = 0;
  [super viewDidLoad];
  //set navigation title
  self.navigationItem.title=[_person getName];
  //add profile picture
  UIImage *profilePic = [UIImage imageNamed:[_person getPicString]];
  UIImageView *profilePicView = [[UIImageView alloc] initWithImage:profilePic];
  [profilePicView setFrame:CGRectMake(width/2 - 105, 0, 210, 253)];
  [self.view addSubview:profilePicView];

  //Add name label;
  UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 -110, 253, 220, 20)];
  nameLabel.text = [_person getName];
  nameLabel.numberOfLines=0;
  [nameLabel sizeToFit];
  nameLabel.backgroundColor = self.view.backgroundColor;
  [self.view addSubview:nameLabel];
  height+= 260 + nameLabel.frame.size.height+5;
  
  
  //Add paragraph
  UILabel* bioLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 -150, height, 220, 20)];
  bioLabel.text = @"Biography";
  bioLabel.numberOfLines=0;
  [bioLabel sizeToFit];
  bioLabel.backgroundColor = self.view.backgroundColor;
  bioLabel.shadowColor = [UIColor grayColor];
  bioLabel.shadowOffset = CGSizeMake(0, -1.0);
  [self.view addSubview:bioLabel];
  height+= bioLabel.frame.size.height+5;
  
  UIView* subviewBio = [[UIView alloc] initWithFrame:CGRectMake(width/2 -153, height-3, 306, 20)];
  subviewBio.layer.cornerRadius =8;
  
  UILabel * paragraphLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 2, 300, 20)];
  for (NSString *paragraph in [_person getParagraphs])
    if ([paragraphLabel.text isEqualToString:@""] || paragraphLabel.text==NULL)
      paragraphLabel.text = paragraph;
    else paragraphLabel.text = [NSString stringWithFormat:@"%@\n\n%@", paragraphLabel.text,paragraph];
  paragraphLabel.numberOfLines=0;
  [paragraphLabel sizeToFit];
  paragraphLabel.backgroundColor = self.view.backgroundColor;
  height += paragraphLabel.frame.size.height+10;

  [subviewBio addSubview:paragraphLabel];
  CGRect frame = subviewBio.frame;
  frame.size.height = paragraphLabel.frame.size.height+6;
  subviewBio.frame=frame;
  subviewBio.layer.borderColor = [UIColor grayColor].CGColor;
  subviewBio.layer.borderWidth = 1;
  [self.view addSubview: subviewBio];
    
  //Add greenboxes
  for (GreenBox* greenbox in [_person getGreenBoxes]){
    UILabel* greenBoxLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 -150, height, 220, 20)];
    greenBoxLabel.text = [greenbox getTitle];
    greenBoxLabel.numberOfLines=0;
    [greenBoxLabel sizeToFit];
    greenBoxLabel.backgroundColor = self.view.backgroundColor;
    greenBoxLabel.shadowColor = [UIColor grayColor];
    greenBoxLabel.shadowOffset = CGSizeMake(0, -1.0);
    [self.view addSubview:greenBoxLabel];
    height+= greenBoxLabel.frame.size.height+5;
    
    UIView* subviewGreenBox = [[UIView alloc] initWithFrame:CGRectMake(width/2 -153, height-3, 306, 20)];
    UILabel * greenboxbulletsLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 2, 300, 20)];
    subviewGreenBox.layer.cornerRadius =8;
    for (NSString* bullet in [greenbox getBullets]){
      if (greenboxbulletsLabel.text == NULL)
        greenboxbulletsLabel.text = [NSString stringWithFormat:@"\u2022 %@", bullet];
      else
        greenboxbulletsLabel.text = [NSString stringWithFormat:@"%@\n\u2022 %@", greenboxbulletsLabel.text, bullet];
    }
    greenboxbulletsLabel.numberOfLines = 0;
    [greenboxbulletsLabel sizeToFit];
    greenboxbulletsLabel.backgroundColor = self.view.backgroundColor;
    height+=greenboxbulletsLabel.frame.size.height+10;
    [subviewGreenBox addSubview:greenboxbulletsLabel];
    
    CGRect greenBoxframe = subviewGreenBox.frame;
    greenBoxframe.size.height = greenboxbulletsLabel.frame.size.height+6;
    subviewGreenBox.frame=greenBoxframe;
    subviewGreenBox.layer.borderColor = [UIColor grayColor].CGColor;
    subviewGreenBox.layer.borderWidth = 1;
    [self.view addSubview: subviewGreenBox];
  }
  
  //readjust scrollView
  [(UIScrollView*)self.view setContentSize:CGSizeMake(width, height)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
