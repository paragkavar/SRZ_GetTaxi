//
//  UMM_AlertButton.h
//  Seasons
//
//  Created by Ucom mm4 on 24.10.12.
//  Copyright (c) 2012 Ucom mm4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMM_AlertButton : NSObject

@property (nonatomic) CGRect cg;
@property (nonatomic) NSString * text;
@property (nonatomic) SEL selector;
@property (nonatomic) NSInteger ctag;
@property (nonatomic) NSString * background;
@property (nonatomic) UIImage * bg;
@property (nonatomic) BOOL disable;
@property (nonatomic) UIFont * font;
@property (nonatomic) UIColor * color;


-(void)drawInView:(UIView *)view;

@end
