//
//  MKInfoPanel.m
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above
//  Read my blog post at http://mk.sg/8e on how to use this code

//  As a side note on using this code, you might consider giving some credit to me by
//	1) linking my website from your app's website 
//	2) or crediting me inside the app's credits page 
//	3) or a tweet mentioning @mugunthkumar
//	4) A paypal donation to mugunth.kumar@gmail.com
//
//  A note on redistribution
//	While I'm ok with modifications to this source code, 
//	if you are re-publishing after editing, please retain the above copyright notices

#import "MKEntryPanel.h"
#import <QuartzCore/QuartzCore.h>

// Private Methods
// this should be added before implementation block 

@interface MKEntryPanel (PrivateMethods)
+ (MKEntryPanel*) panel;
@end


@implementation DimView

- (id)initWithParent:(UIView*) aParentView onTappedSelector:(SEL) tappedSel
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        // Initialization code
        parentView = aParentView;
        onTapped = tappedSel;
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.0;
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [parentView performSelector:onTapped];
}
- (void)dealloc
{
    [super dealloc];
}
@end

@implementation MKEntryPanel
@synthesize closeBlock = _closeBlock;
@synthesize titleLabel = _titleLabel;
@synthesize entryField = _entryField;
@synthesize backgroundGradient = _backgroundGradient;
@synthesize dimView = _dimView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(MKEntryPanel*) panel
{
    MKEntryPanel *panel;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
    {
        panel = (MKEntryPanel*) [[[UINib nibWithNibName:@"MKEntryPanel6" bundle:nil]
                                  instantiateWithOwner:self options:nil] objectAtIndex:0];
    }else{
        panel = (MKEntryPanel*) [[[UINib nibWithNibName:@"MKEntryPanel" bundle:nil]
                          instantiateWithOwner:self options:nil] objectAtIndex:0];
    }
    
    panel.backgroundGradient.image = [[UIImage imageNamed:@"TopBar"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];

    CATransition *transition = [CATransition animation];
	transition.duration = kAnimationDuration;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;	
	transition.subtype = kCATransitionFromBottom;
	[panel.layer addAnimation:transition forKey:nil];
    
    return panel;
}

+(void) showPanelWithTitle:(NSString*) title inView:(UIView*) view onTextEntered:(CloseBlock) editingEndedBlock
{
    MKEntryPanel *panel = [MKEntryPanel panel];
    panel.closeBlock = editingEndedBlock;
    panel.titleLabel.text = title;
    [panel.entryField becomeFirstResponder];
    
    panel.dimView = [[[DimView alloc] initWithParent:panel onTappedSelector:@selector(cancelTapped:)] autorelease];
    CATransition *transition = [CATransition animation];
	transition.duration = kAnimationDuration;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionFade;
	[panel.dimView.layer addAnimation:transition forKey:nil];
    panel.dimView.alpha = 0.8;
    [view addSubview:panel.dimView];
    [view addSubview:panel];
}

- (IBAction) textFieldDidEndOnExit:(UITextField *)textField {
        
    [self performSelectorOnMainThread:@selector(hidePanel) withObject:nil waitUntilDone:YES];    
    self.closeBlock(self.entryField.text);
}

-(void) cancelTapped:(id) sender
{
    [self performSelectorOnMainThread:@selector(hidePanel) withObject:nil waitUntilDone:YES];    
}

-(void) hidePanel
{
    [self.entryField resignFirstResponder];
    CATransition *transition = [CATransition animation];
	transition.duration = kAnimationDuration;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;	
	transition.subtype = kCATransitionFromTop;
	[self.layer addAnimation:transition forKey:nil];
    self.frame = CGRectMake(0, -self.frame.size.height, 320, self.frame.size.height); 
    
    transition = [CATransition animation];
	transition.duration = kAnimationDuration;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionFade;
	self.dimView.alpha = 0.0;
	[self.dimView.layer addAnimation:transition forKey:nil];
    
    [self.dimView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.40];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.45];
}

- (void)dealloc
{
    [super dealloc];
}

@end


