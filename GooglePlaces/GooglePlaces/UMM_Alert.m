//
//  UMM_Alert.m
//  Seasons
//
//  Created by Ucom mm4 on 24.10.12.
//  Copyright (c) 2012 Ucom mm4. All rights reserved.
//

#import "UMM_Alert.h"
//#import "HandyUtils.h"
#import <QuartzCore/QuartzCore.h>

@interface UMM_BackgroundView : UIView
@end

@implementation UMM_BackgroundView

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesCancelled:touches withEvent:event];
    NSLog(@"BEGAN");
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"Cancelled");
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"End");
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Moved");
}

@end

@implementation UMM_Alert{
    UIButton * cover;
    UIView * mainView;
}

@synthesize cg;
@synthesize background;
@synthesize texts;
@synthesize buttons;
@synthesize title;
@synthesize imgViews;
@synthesize scrollViews;
@synthesize lables;

-(void)addScrollViews:(UMM_AlertScroll *)scrollView
{
    if (scrollViews == nil) {
        scrollViews = [NSMutableArray arrayWithCapacity:10];
    }
    [scrollViews addObject:scrollView];
}

-(void)addImgViews:(UMM_AlertImgView*)imgView
{
    if (imgViews == nil) {
        imgViews = [NSMutableArray arrayWithCapacity:10];
    }
    [imgViews addObject:imgView];
}
-(void)addText:(UMM_AlertText *)text{
    if (texts == nil) {
        texts = [NSMutableArray arrayWithCapacity:10];
    }
    [texts addObject:text];
}

-(void)addButton:(UMM_AlertButton *)button{
    if (buttons == nil) {
        buttons = [NSMutableArray arrayWithCapacity:10];
    }
    [buttons addObject:button];
}
-(void)addLabel:(UMM_AlertLabel *)label{
    if (lables == nil) {
        lables = [NSMutableArray arrayWithCapacity:10];
    }
    [lables addObject:label];
}

-(void)drawInView:(UIView *)view{
    
   // [UIView beginAnimations:nil context:nil];
  //  [UIView setAnimationDuration:1.0f];
  //  [UIView setAnimationCurve:UIViewAnimationTransitionFlipFromRight];
    
    [self createCover:view];
    [self createMain:cover];
    [self drawTexts];
    [self drawLabel];
    [self drawButtons];
    [self drawImgView];
    [self drawScollView];
    
  //  [UIView commitAnimations];
}
-(void)drawScollView{
    for (UMM_AlertScroll * s in scrollViews) {
        [s drawInView:mainView];
    }
   
}
-(void)drawLabel{
    for (UMM_AlertLabel * l in lables) {
        [l drawInView:mainView];
    }
    
}

-(void)drawImgView{
    for (UMM_AlertImgView * i in imgViews) {
        [i drawInView:mainView];
    }
}
-(void)drawTexts{
    for (UMM_AlertText * t in texts){
        [t drawInView:mainView];
    }
}

-(void)drawButtons{
    for (UMM_AlertButton * b in buttons){
        [b drawInView:mainView];
    }
}

-(void)addSubview:(UIView *)view{
    [mainView addSubview:view];
}

-(void)createMain:(UIView *)view{
    UIView * win = [[UIView alloc]initWithFrame:cg];
    UIImageView * win2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cg.size.width, cg.size.height)];
    win2.image = background;
    mainView = win;
    [win addSubview:win2];
    [view addSubview:win];
}

-(void)createCover:(UIView *) view
{
    CGRect screenRect =[[UIScreen mainScreen] bounds];// [[UIScreen mainScreen] applicationFrame];
    
    screenRect.size = CGSizeMake(screenRect.size.height, screenRect.size.width);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =screenRect;
    cover = button;
    [view addSubview:button];
    
    UMM_BackgroundView * backgroundView = [[UMM_BackgroundView alloc] initWithFrame:screenRect];
    [backgroundView setUserInteractionEnabled:NO];
    [backgroundView setBackgroundColor:[UIColor clearColor]];
    //[backgroundView setAlpha:0.5];
    [button addSubview:backgroundView];
    [[backgroundView layer] setZPosition:1000];
    [[button layer] setZPosition:1001];
    /*
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = screenRect; //CGRectMake(0, 0, 1024, 768);
    button2.backgroundColor = [UIColor grayColor];
    button2.alpha = 0.5f;
    [button addSubview:button2];
    */
}
@end
