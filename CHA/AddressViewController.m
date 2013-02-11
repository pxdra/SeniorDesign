//
//  AddressViewController.m
//  CHA
//
//  Created by Brian Sun on 2/9/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()

@end

@implementation AddressViewController

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

  CLLocationManager *locationManager = [[CLLocationManager alloc] init];
  locationManager.delegate = self;
  locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
  _pin = [[MKPointAnnotation alloc] init];
  NSArray* latArray = [_loc.getLocData componentsSeparatedByString:@","];
  CLLocation *pinLoc = [[CLLocation alloc] initWithLatitude:[(NSString*)[latArray objectAtIndex:0] doubleValue] longitude:[(NSString*)[latArray objectAtIndex:1] doubleValue]];
  _detailsLabel.numberOfLines = 0;
  _detailsLabel.text = [_loc getDisc];
  _titleBar.title = [_loc getName];
  _pin.title =_loc.getName;
  _pin.subtitle = _loc.getAddress;
  _pin.coordinate = pinLoc.coordinate;
  self.userLocUpdate=true;
  [self.mapView removeAnnotations:self.mapView.annotations];
  [self.mapView setDelegate:self];
  [self.mapView addAnnotation:_pin];
  [_directionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
  
  [locationManager startUpdatingLocation];

  
  self->_mapView.showsUserLocation = YES;
  [self recenterMap];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  // Unused atm
}

- (void)recenterMap{
  double deltaLat = fabs(_pin.coordinate.latitude - self.mapView.userLocation.coordinate.latitude);
  double deltaLong = fabs(_pin.coordinate.longitude - self.mapView.userLocation.coordinate.longitude);
  
  double centerLat = (_pin.coordinate.latitude + self.mapView.userLocation.coordinate.latitude)/2;
  double centerLong = (_pin.coordinate.longitude + self.mapView.userLocation.coordinate.longitude)/2;
  CLLocationCoordinate2D center;
  center.longitude = centerLong;
  center.latitude = centerLat;
  MKCoordinateRegion region;
  region.center = center;
  MKCoordinateSpan span = MKCoordinateSpanMake(deltaLat*2, deltaLong*2);
  region.span = span;
  [self.mapView setRegion:region animated:YES];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
  if (self.userLocUpdate){
    [self recenterMap];
    self.userLocUpdate = false;
  }
  //self.mapView.centerCoordinate = userLocation.location.coordinate;
}

- (void) buttonAction: (id) sender{
  NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey : [_loc getAddress]};
  MKPlacemark *placemark = [[MKPlacemark alloc]
                            initWithCoordinate:_pin.coordinate
                            addressDictionary:addressDict];
  
  MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
  mapItem.name =[_loc getName];
  
  NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
  [mapItem openInMapsWithLaunchOptions:launchOptions];
}



@end
