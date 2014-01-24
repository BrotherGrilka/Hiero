//
//  Glyph.h
//  Hiero
//
//  Created by Dunc on 1/16/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Glyph : NSManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSNumber * originX;
@property (nonatomic, retain) NSNumber * originY;

@end
