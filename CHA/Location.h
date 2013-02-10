//
//  Location.h
//  CHA
//
//  Created by Brian Sun on 2/9/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Location : NSObject
{
  NSString *name;
  NSString *address;
  NSString *locData;
  NSString *disc;
}
- (id) initWithName: (NSString *) inName WithAddress: (NSString *) inAddress WithDisc: (NSString *) inDisc WithLocData: (NSString *) inLocData;
- (NSString*) getName;
- (NSString*) getAddress;
- (NSString *) getDisc;
- (NSString *) getLocData;

@end
