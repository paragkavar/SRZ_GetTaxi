//
//  UMM_AlertText.h
//  Seasons
//
//  Created by Ucom mm4 on 24.10.12.
//  Copyright (c) 2012 Ucom mm4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMM_AlertText : NSObject

@property (nonatomic) CGRect cg;
@property (nonatomic) NSString * text;
@property (nonatomic) UIFont * font;
@property (nonatomic) UIColor * textColor;
@property (nonatomic) NSString * type;
@property (nonatomic) BOOL editable;
@property (nonatomic) UIColor * bgColour;

-(void)drawInView:(UIView *)view;
-(void)showkb;
-(void)hidekb;
@end
