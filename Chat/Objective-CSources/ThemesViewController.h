//
//  ThemesViewController.h
//  Chat
//
//  Created by Семен Кривоносов on 14/10/2018.
//  Copyright © 2018 Семен Кривоносов. All rights reserved.
//

#ifndef ThemesViewController_h
#define ThemesViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class Themes;
@protocol ThemesViewControllerDelegate;

@interface ThemesViewController : UIViewController
{
    IBOutletCollection(UIButton) NSArray *themeButtons;
}

@property(retain) Themes* model;
@property(weak) id<ThemesViewControllerDelegate> delegate;

-(void) viewDidLoad;
- (IBAction)buttonTapped:(UIButton *)sender;

@end

#endif /* ThemesViewControllerDelegate_h */
