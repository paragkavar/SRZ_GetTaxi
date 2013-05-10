//
//  UMM_Alert.h
//  Seasons
//
//  Created by Ucom mm4 on 24.10.12.
//  Copyright (c) 2012 Ucom mm4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMM_AlertText.h"
#import "UMM_AlertButton.h"
#import "UMM_AlertImgView.h"
#import "UMM_AlertScroll.h"
#import "UMM_AlertLabel.h"
@interface UMM_Alert : NSObject

@property (nonatomic) CGRect cg;
@property (nonatomic) NSMutableArray * texts;
@property (nonatomic) NSMutableArray * buttons;
@property (nonatomic) NSMutableArray * imgViews;
@property (nonatomic) NSMutableArray * lables;
@property (nonatomic) NSMutableArray * scrollViews;
@property (nonatomic) UIImage * background;
@property (nonatomic) NSString * title;
//@property (nonatomic) UIView * view;


-(void)addText:(UMM_AlertText *)text;
-(void)addLabel:(UMM_AlertLabel *)label;
-(void)addButton:(UMM_AlertButton *)button;
-(void)drawInView:(UIView *)view;
-(void)addSubview:(UIView *)view;
-(void)addImgViews:(UMM_AlertImgView*)imgView;
-(void)addScrollViews:(UMM_AlertScroll*)scrollView;

@end
