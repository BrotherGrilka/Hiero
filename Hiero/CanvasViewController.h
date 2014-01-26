//
//  RockyCanvasViewController.h
//  Hiero
//
//  Created by Dunc on 1/11/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlyphButton.h"

@class GlyphStrut;

@interface CanvasViewController : UIViewController

@property (nonatomic, strong) GlyphStrut *focusedStrut;

- (void)addGlyph:(GlyphButton *)glyphButton;
- (void)clearGlyphs;

@end
