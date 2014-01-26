//
//  GlyphStrut.h
//  Hiero
//
//  Created by Dunc on 1/25/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Strut;
@class GlyphButton;

@interface GlyphStrut : UIViewController

- (id)initWithStrut:(Strut *)strut;
- (id)initWithGlyphButton:(GlyphButton *)glyphButton withinCanvas:(CGRect)canvasFrame;
- (void)addGlyph:(GlyphButton *)glyphButton;

@end
