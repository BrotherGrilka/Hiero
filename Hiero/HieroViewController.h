//
//  RockyViewController.h
//  Hiero
//
//  Created by Dunc on 1/10/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "GlyphButton.h"

@interface HieroViewController : UIViewController

@property (nonatomic, strong) NSNumber *droppedGlyphs;

- (void)cloneGlyphButton:(GlyphButton *)glyphButton;

@end
