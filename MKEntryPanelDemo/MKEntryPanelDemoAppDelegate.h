//
//  MKEntryPanelDemoAppDelegate.h
//  MKEntryPanelDemo
//
//  Created by Mugunth on 07/05/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKEntryPanelDemoViewController;

@interface MKEntryPanelDemoAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MKEntryPanelDemoViewController *viewController;

@end
