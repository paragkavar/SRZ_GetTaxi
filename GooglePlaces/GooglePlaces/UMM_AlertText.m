//
//  UMM_AlertText.m
//  Seasons
//
//  Created by Ucom mm4 on 24.10.12.
//  Copyright (c) 2012 Ucom mm4. All rights reserved.
//

#import "UMM_AlertText.h"
#import <QuartzCore/QuartzCore.h>

@implementation UMM_AlertText{
    UITextView *  textView;
    CATextLayer * tmp;
}
@synthesize cg;
@synthesize text;
@synthesize font;
@synthesize textColor;
@synthesize type;
@synthesize editable;
@synthesize bgColour;


- (void)drawInView:(UIView *)view{
     textView = [[UITextView alloc]initWithFrame:cg];
    textView.backgroundColor = [UIColor clearColor];
    textView.font = font;
    textView.text = text;
    if (textColor == nil) {
        textColor = [UIColor blackColor];
    }
    textView.textColor = textColor;
    textView.editable = editable;
    textView.bouncesZoom = NO;
    textView.delaysContentTouches = NO;
    [view addSubview:textView];
    if (bgColour) {
        textView.backgroundColor = bgColour;
    }
    
/*    CATextLayer * tmp = [CATextLayer layer];
    tmp.alignmentMode = kCAAlignmentJustified; //kCTTextAlignmentJustified;
    [tmp drawInContext: (__bridge CGContextRef)(textView) ];*/
}

-(NSString *) text{
    return textView.text;
}

-(void) setText:(NSString *)txt{
    textView.text = txt;
    text = txt;
}
-(void)showkb
{
    [textView becomeFirstResponder];
}

@end
