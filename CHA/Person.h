//
//  Person.h
//  CHA
//
//  Created by mfong on 2/24/13.
//  Copyright (c) 2013 Brian Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSString *picString;
    NSString *name;
    
    NSMutableArray *paragraphs;
    NSMutableArray *greenBoxes;
}

- (id) initWithName: (NSString *) inName WithPicString: (NSString *) inPicString;
- (NSString *) getName ;
- (NSString *) getPicString ;
- (NSMutableArray *) getParagraphs ;
- (NSMutableArray *) getGreenBoxes ;

- (void) addGreenBox : (NSObject *) gbox ;
- (void) addParagraph : (NSString *) paragraph;



@end
