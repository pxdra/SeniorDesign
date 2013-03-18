//
//  Person.m
//  CHA
//
//  Created by mfong on 2/24/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id) initWithName: (NSString *) inName WithPicString: (NSString *) inPicString
{
    name = inName;
    picString = inPicString;
    paragraphs = [[NSMutableArray alloc] init];
    greenBoxes = [[NSMutableArray alloc] init];
    return self;
}
- (NSString *) getName
{
    return name;
}
- (NSString *) getPicString
{
    return picString;
}
- (NSMutableArray *) getParagraphs
{
    return paragraphs;
}
- (NSMutableArray *) getGreenBoxes
{
    return greenBoxes;
}

- (void) addGreenBox : (NSObject *) gbox
{
    [greenBoxes addObject:gbox];
}
- (void) addParagraph : (NSString *) paragraph
{
    [paragraphs addObject:paragraph];
}

@end
