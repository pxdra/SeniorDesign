//
//  GreenBox.m
//  CHA
//
//  Created by mfong on 2/24/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import "GreenBox.h"

@implementation GreenBox

- (id) initWithTitle: (NSString * ) inTitle
{
    title = inTitle;
    bullets = [[NSMutableArray alloc] init];
    return self;
}
- (NSString*) getTitle
{
    return title;
}
- (NSMutableArray*) getBullets
{
    return bullets;
}
- (void) addBullet : (NSString * ) bullet
{
    [bullets addObject:bullet];
}


@end
