//
//  MKEntryPanel.h
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above

#import <UIKit/UIKit.h>
typedef void (^CloseBlock)(NSString *inputString);

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kAnimationDuration 0.35

@interface DimView : UIView {
    
    SEL onTapped;
    UIView *parentView;
}

- (id)initWithParent:(UIView*) aParentView onTappedSelector:(SEL) tappedSel;
@end

@interface MKEntryPanel : UIView {
    
    CloseBlock _closeBlock;
    UILabel *_titleLabel;
    UITextField *_entryField;

    UIImageView *_backgroundGradient;
    
    DimView *_dimView;
}

@property (nonatomic, copy) CloseBlock closeBlock;
@property (nonatomic, assign) DimView *dimView;
@property (nonatomic, assign) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) IBOutlet UITextField *entryField;
@property (nonatomic, assign) IBOutlet UIImageView *backgroundGradient;

+(void) showPanelWithTitle:(NSString*) title inView:(UIView*) view onTextEntered:(CloseBlock) editingEndedBlock;
- (IBAction) textFieldDidEndOnExit:(UITextField *)textField;
@end
