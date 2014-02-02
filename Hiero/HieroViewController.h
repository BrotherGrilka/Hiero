//
//  RockyViewController.h
//  Hiero
//
//  Created by Dunc on 1/10/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "GlyphButton.h"
#import "KeyboardViewController.h"

@interface HieroViewController : UIViewController

@property (nonatomic, strong) NSNumber *droppedGlyphs;

- (IBAction)clearGlyphs:(id)sender;
- (void)setzenGlyphPanning:(UIView *)glyphView;

@end
