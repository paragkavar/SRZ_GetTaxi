//
//  UMM_AlertImgView.m
//  ToDoNew
//
//  Created by Ucom mm5 on 24.01.13.
//
//

#import "UMM_AlertImgView.h"

@implementation UMM_AlertImgView
{
    UIImageView * imgView;
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
    imgView = [[UIImageView alloc]initWithFrame:cg];
    [imgView setImage:image];
    [view addSubview:imgView];
    
}
@end
