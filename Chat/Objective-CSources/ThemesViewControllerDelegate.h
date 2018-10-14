//
//  ThemesViewControllerDelegate.h
//  Chat
//
//  Created by Семен Кривоносов on 14/10/2018.
//  Copyright © 2018 Семен Кривоносов. All rights reserved.
//

#ifndef ThemesViewControllerDelegate_h
#define ThemesViewControllerDelegate_h

#import "ThemesViewController.h"

@class ThemesViewController;

@protocol ThemesViewControllerDelegate<NSObject>
-(void) themesViewController: (ThemesViewController *)controller didSelectTheme:(UIColor *)selectedTheme;
@end

#endif /* ThemesViewControllerDelegate_h */
