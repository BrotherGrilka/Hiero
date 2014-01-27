//
//  Strut.h
//  Hiero
//
//  Created by Dunc on 1/26/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Glyph;

@interface Strut : NSManagedObject

@property (nonatomic, retain) NSNumber * originX;
@property (nonatomic, retain) NSNumber * originY;
@property (nonatomic, retain) NSSet *glyphs;
@end

@interface Strut (CoreDataGeneratedAccessors)

- (void)addGlyphsObject:(Glyph *)value;
- (void)removeGlyphsObject:(Glyph *)value;
- (void)addGlyphs:(NSSet *)values;
- (void)removeGlyphs:(NSSet *)values;

@end
