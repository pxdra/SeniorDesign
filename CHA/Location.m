//
//  Location.m
//  CHA
//
//  Created by Brian Sun on 2/9/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import "Location.h"

@implementation Location

- (id) initWithName: (NSString *) inName WithAddress: (NSString *) inAddress WithDisc: (NSString *) inDisc WithLocData:(NSString *)inLocData
{
  name=inName;
  address = inAddress;
  disc = inDisc;
  locData = inLocData;
  return self;
}

-(NSString *) getName
{
  return name;
}

- (NSString *) getDisc
{
  return disc;
}

- (NSString*) getAddress
{
  return address;
}

- (NSString *) getLocData
{
  return locData;
}

@end
