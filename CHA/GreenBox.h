//
//  GreenBox.h
//  CHA
//
//  Created by mfong on 2/24/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GreenBox : NSObject
{
    NSString *title;
    NSMutableArray *bullets;
}

- (id) initWithTitle: (NSString * ) inTitle;
- (NSString*) getTitle;
- (NSMutableArray*) getBullets;
- (void) addBullet : (NSString * ) bullet ;

@end
