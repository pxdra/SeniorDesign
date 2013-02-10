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
  _detailsLabel.numberOfLines = 0;
  _detailsLabel.text = [_loc getDisc];
  _titleBar.title = [_loc getName];
  CLLocationManager *locationManager = [[CLLocationManager alloc] init];
  locationManager.delegate = self;
  locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
  _pin = [[MKPointAnnotation alloc] init];
  NSArray* latArray = [_loc.getLocData componentsSeparatedByString:@","];
  CLLocation *pinLoc = [[CLLocation alloc] initWithLatitude:[(NSString*)[latArray objectAtIndex:0] doubleValue] longitude:[(NSString*)[latArray objectAtIndex:1] doubleValue]];
  _pin.title =_loc.getName;
  _pin.subtitle = _loc.getAddress;
  _pin.coordinate = pinLoc.coordinate;
    
  [self.mapView addAnnotation:_pin];
  
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
  double minLatitude, maxLatitude, minLongitude, maxLongitude;
  if (self.mapView.userLocation.coordinate.longitude > _pin.coordinate.longitude){
    minLongitude = _pin.coordinate.longitude;
    maxLongitude =self.mapView.userLocation.coordinate.longitude;
  }
  else
  {
    maxLongitude = _pin.coordinate.longitude;
    minLongitude =self.mapView.userLocation.coordinate.longitude;
  }
  
  if (self.mapView.userLocation.coordinate.latitude > _pin.coordinate.latitude){
    minLatitude = _pin.coordinate.latitude;
    maxLatitude =self.mapView.userLocation.coordinate.latitude;
  }
  else
  { 
    maxLatitude = _pin.coordinate.latitude;
    minLatitude =self.mapView.userLocation.coordinate.latitude;
  }
  MKCoordinateRegion region = self.mapView.region;
  region.center.latitude = (minLatitude + maxLatitude) / 2;
  region.center.longitude = (minLongitude + maxLongitude) / 2;
  
  region.span.latitudeDelta = (maxLatitude - minLatitude) * MAP_PADDING;
  
  //region.span.latitudeDelta = region.span.latitudeDelta;
  
  region.span.longitudeDelta = (maxLongitude - minLongitude) * MAP_PADDING;
  
  //MKCoordinateRegion scaledRegion = [self.mapView regionThatFits:region];
  [self.mapView setRegion:region animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)sender viewForAnnotation:(id < MKAnnotation >)annotation
{
  static NSString *reuseId = @"StandardPin";
  MKPinAnnotationView *aView = (MKPinAnnotationView *)[sender dequeueReusableAnnotationViewWithIdentifier:reuseId];
  if ([annotation isKindOfClass:[MKPointAnnotation class]]){
    if (aView == nil)
      aView = aView = (MKPinAnnotationView *)[sender dequeueReusableAnnotationViewWithIdentifier:reuseId];
    [aView setPinColor:MKPinAnnotationColorRed];
    aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    aView.canShowCallout = YES;
    aView.annotation = annotation;
  }
  if ([annotation isKindOfClass:[MKUserLocation class]]){
    [self recenterMap];
    return nil;
  }
  return aView;
}

@end
