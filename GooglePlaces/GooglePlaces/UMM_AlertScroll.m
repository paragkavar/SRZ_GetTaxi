//
//  UMM_AlertScroll.m
//  ToDoNew
//
//  Created by Ucom mm5 on 24.01.13.
//
//

#import "UMM_AlertScroll.h"

@implementation UMM_AlertScroll
{
   UIScrollView *scrollView;
    UIView * mainView;
   //UMM_AlertButton* button;
}
@synthesize cg;
@synthesize text;
@synthesize font;
@synthesize textColor;
@synthesize type;
@synthesize editable;
@synthesize bgColour;
@synthesize image;
@synthesize contentSize;
@synthesize buttons;


- (void)drawInView:(UIView *)view{
    scrollView = [[UIScrollView alloc]initWithFrame:cg];
    [scrollView setContentSize:contentSize];
    [self drawButtons];
    [view addSubview:scrollView];
    
}
-(void)addButton:(UMM_AlertButton *)button{
    if (buttons == nil) {
        buttons = [NSMutableArray arrayWithCapacity:10];
    }
    [buttons addObject:button];
}
-(void)drawButtons{
        for (UMM_AlertButton * b in buttons){
            [b drawInView:scrollView];
        }
    }

@end
