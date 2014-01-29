//
//  RockyKeyboardViewController.m
//  Hiero
//
//  Created by Dunc on 1/11/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "KeyboardViewController.h"
#import "HieroViewController.h"
#import "GlyphButton.h"
#import "UIStoryboard+ViewControllerById.h"

@interface KeyboardViewController ()

@end

@implementation KeyboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
	if ([keyPath isEqualToString:@"droppedGlyphs"]) {
		HieroViewController *hieroViewController = (HieroViewController *) object;
		
		NSLog(@"Hi Manny, report dropped glyph count please. Manny says %@. %@ %@", hieroViewController.droppedGlyphs, NSStringFromSelector(_cmd), NSStringFromCGRect(self.view.frame));
	}
}

- (void)copy:(id)sender {
	NSLog(@"Copy Miss Tikky from KeyboardViewController: %@", sender);
}

- (void)hiManny:(id)sender {
	NSLog(@"Hi Manny: %@", sender);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
