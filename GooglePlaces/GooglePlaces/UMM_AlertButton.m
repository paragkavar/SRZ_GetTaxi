//
//  UMM_AlertButton.m
//  Seasons
//
//  Created by Ucom mm4 on 24.10.12.
//  Copyright (c) 2012 Ucom mm4. All rights reserved.
//

#import "UMM_AlertButton.h"
//#import "HandyUtils.h"

@implementation UMM_AlertButton

@synthesize cg;
@synthesize text;
@synthesize selector;
@synthesize background;
@synthesize ctag;
@synthesize disable;
@synthesize bg;
@synthesize font;
@synthesize color;

- (void)drawInView:(UIView *)view{
  /*  UIViewController * control = [[[[(id)[[UIApplication sharedApplication] delegate] window]rootViewController]navigationController] topViewController];
    [button addTarget:control action:selector forControlEvents:UIControlEventTouchUpInside];*/
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = cg;
    button.tag = ctag;
    if (disable) {
        [button setEnabled:NO];
    }
    
    [button addTarget:nil action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:nil action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setTitleColor:color forState:UIControlStateNormal];
   // UIImage *bgImage = [UIImage imageNamed:background];
    UIImage *bgImage = bg;
        [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    [view addSubview:button];
}

-(void)close:(id)sender{
   // [[[sender superview] superview] removeFromSuperview];
}



@end
