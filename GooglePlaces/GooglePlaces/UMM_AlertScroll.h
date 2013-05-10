//
//  UMM_AlertScroll.h
//  ToDoNew
//
//  Created by Ucom mm5 on 24.01.13.
//
//

#import <Foundation/Foundation.h>
#import "UMM_AlertButton.h"

@interface UMM_AlertScroll : NSObject
@property (nonatomic) CGRect cg;
@property (nonatomic) NSString * text;
@property (nonatomic) UIFont * font;
@property (nonatomic) UIColor * textColor;
@property (nonatomic) NSString * type;
@property (nonatomic) BOOL editable;
@property (nonatomic) UIColor * bgColour;
@property (nonatomic) UIImage * image;
@property (nonatomic) CGSize contentSize;
@property (nonatomic) NSMutableArray * buttons;
-(void)drawInView:(UIView *)view;
-(void)addButton:(UMM_AlertButton *)button;
@end
