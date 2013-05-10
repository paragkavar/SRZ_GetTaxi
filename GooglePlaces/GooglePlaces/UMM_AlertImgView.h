//
//  UMM_AlertImgView.h
//  ToDoNew
//
//  Created by Ucom mm5 on 24.01.13.
//
//

#import <Foundation/Foundation.h>

@interface UMM_AlertImgView : NSObject

@property (nonatomic) CGRect cg;
@property (nonatomic) NSString * text;
@property (nonatomic) UIFont * font;
@property (nonatomic) UIColor * textColor;
@property (nonatomic) NSString * type;
@property (nonatomic) BOOL editable;
@property (nonatomic) UIColor * bgColour;
@property (nonatomic) UIImage * image;

-(void)drawInView:(UIView *)view;

@end
