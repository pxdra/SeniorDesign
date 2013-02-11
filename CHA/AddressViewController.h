//
//  AddressViewController.h
//  CHA
//
//  Created by Brian Sun on 2/9/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CLLocation.h>
#import <AddressBook/AddressBook.h>

#import "Location.h"


@interface AddressViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *directionButton;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleBar;
@property Boolean userLocUpdate;

@property MKPointAnnotation * pin;
@property Location* loc;

#define MAP_PADDING 1.1
#define MINIMUM_VISIBLE_LATITUDE 0.01


- (void) setLoc:(Location *)loc;


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation;

@end
