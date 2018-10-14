//
//  ThemesViewController.m
//  Chat
//
//  Created by Семен Кривоносов on 14/10/2018.
//  Copyright © 2018 Семен Кривоносов. All rights reserved.
//

#import "ThemesViewController.h"
#import "Themes.h"
#import "ThemesViewControllerDelegate.h"

@implementation ThemesViewController



- (void) setDelegate:(id<ThemesViewControllerDelegate>)delegate{
    _delegate = delegate;
}

- (id<ThemesViewControllerDelegate>) delegate {
    return _delegate;
}
@synthesize model = _model;
-(Themes *) model {
    return [[_model retain] autorelease];
}
-(void) setModel:(Themes *)model {
    [_model autorelease];
    _model = [model retain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _model = [[Themes alloc] init];
}

-(void) changeThemeTo: (UIColor *)theme {
    [_delegate themesViewController:self didSelectTheme:theme];
    if (self.navigationController != nil) {
        [[self.navigationController navigationBar] setBarTintColor:theme];
    }
}
@synthesize delegate = _delegate;
- (IBAction)buttonTapped:(UIButton *)sender {
    if (sender == [themeButtons objectAtIndex:0]) {
        [self changeThemeTo: [_model theme1]];
    } else if (sender == [themeButtons objectAtIndex:1]) {
         [self changeThemeTo: [_model theme2]];
    } else {
         [self changeThemeTo: [_model theme3]];
    }
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[[self.navigationController navigationBar] barTintColor]];
}

- (void)dealloc {
    [themeButtons release];
    [_model release];
    [super dealloc];
}
@end
