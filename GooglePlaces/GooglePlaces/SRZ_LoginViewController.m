//
//  SRZ_LoginViewController.m
//  GooglePlaces
//
//  Created by Svyat Zubyak on 10.05.13.
//
//

#import "SRZ_LoginViewController.h"

@interface SRZ_LoginViewController ()
{
    UIView *  dimView;
}
@end

@implementation SRZ_LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SignUpButton:(id)sender {
    [self customAlertView];
   
}
/*
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
 */
-(void)customAlertView
{
    dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    dimView.backgroundColor = [UIColor blackColor];
    dimView.alpha = 0.6f;
    dimView.userInteractionEnabled = NO;
    [self.view addSubview:dimView];
    
    all = [UMM_Alert new];
    all.cg = CGRectMake(10,18,300,200);
    all.title = @"Sign Up";
    all.background = [UIImage imageNamed:@"msg_bg"];
    //all.background = [self imageWithColor:[UIColor darkGrayColor]];
    
    UMM_AlertLabel * label1 = [ UMM_AlertLabel new];
    [label1 setCg:CGRectMake(50, 12, 180, 25)];
    UIFont *lblFont1 = [UIFont fontWithName:@"Futura" size:19.0];
    label1.font = lblFont1;
    label1.textColor = [UIColor whiteColor];
    label1.text = @"Getting new accaunt";
    [all addLabel:label1];
    
    UMM_AlertLabel *label2 = [UMM_AlertLabel new];
    [label2 setCg:CGRectMake(15, 55, 150, 25)];
    UIFont *lblFont2 = [UIFont fontWithName:@"Futura" size:19.0];
    label2.font = lblFont2;
    label2.textColor = [UIColor whiteColor];
    label2.text = @"enter your e-mail";
    [all addLabel:label2];
    
    UMM_AlertLabel *label3 = [UMM_AlertLabel new];
    [label3 setCg:CGRectMake(15, 70, 290, 25)];
    UIFont *lblFont3 = [UIFont fontWithName:@"Futura" size:10.0];
    label3.font = lblFont3;
    label3.textColor = [UIColor whiteColor];
    label3.text = @"your credentials for authorization will be sent to your email";
    [all addLabel:label3];

    
    
    textfield = [UMM_AlertText new];
    [textfield setCg:CGRectMake(10, 100, 280, 25)];
    textfield.font = [UIFont fontWithName:@"Futura" size:16.0];
    textfield.textColor = [UIColor blackColor];
    textfield.text = @"";
    textfield.editable = YES;
    textfield.bgColour = [UIColor whiteColor];
    [all addText:textfield];


    
    UMM_AlertButton * b1 = [UMM_AlertButton new];
    UIImage *backgC1 = [UIImage imageNamed:@"msg_ok_next"];
    [b1 setBg:backgC1];
    [b1 setCg:CGRectMake(16,150,131,30)];
    b1.ctag = 1;
    UIFont *buttonFont1 = [UIFont fontWithName:@"Futura" size:19.0];
    b1.font = buttonFont1;
    b1.color = [UIColor whiteColor];
    b1.text = @"Sign Up";
    b1.selector = @selector(SignUp:);
    [all addButton:b1];
    
    UMM_AlertButton * b2 = [UMM_AlertButton new];
    UIImage *backgC2 = [UIImage imageNamed:@"msg_cancel"];
    [b2 setBg:backgC2];
    [b2 setCg:CGRectMake(155,150,131,30)];
    UIFont *buttonFont2 = [UIFont fontWithName:@"Futura" size:19.0];
    b2.font = buttonFont2;
    b2.color = [UIColor whiteColor];
    b2.ctag = 2;
    b2.text = @"Cancel";
    b2.selector = @selector(Cancel:);
    [all addButton:b2];
    
    [all drawInView:[self view]];
    
}
- (IBAction)LogButton:(id)sender {
    
    
    [self performSegueWithIdentifier:@"tomapview" sender:self];
    
}

- (void)viewDidUnload {
    [self setEmailTF:nil];
    [self setPassTF:nil];
    [self setLoginButton:nil];
    [super viewDidUnload];
}
@end
