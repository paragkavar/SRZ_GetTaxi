//
//  UMM_AlertLabel.m
//  ToDoNew
//
//  Created by Ucom mm5 on 25.01.13.
//
//

#import "UMM_AlertLabel.h"

@implementation UMM_AlertLabel
{
    UILabel* label;
}
@synthesize cg;
@synthesize text;
@synthesize font;
@synthesize textColor;
@synthesize type;
@synthesize editable;
@synthesize bgColour;
@synthesize image;

- (void)drawInView:(UIView *)view{
    label = [[UILabel alloc]initWithFrame:cg];
    label.backgroundColor = [UIColor clearColor];
   label.font = font;
   label.text = text;
    if (textColor == nil) {
        textColor = [UIColor blackColor];
    }
    label.textColor = textColor;
    
    [view addSubview:label];
    if (bgColour) {
        label.backgroundColor = bgColour;
    }
}
@end
