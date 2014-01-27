//
//  Glyph.h
//  Hiero
//
//  Created by Dunc on 1/26/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Strut;

@interface Glyph : NSManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSNumber * originX;
@property (nonatomic, retain) NSNumber * originY;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) Strut *strut;

@end
