//
//  SRZ_TaxiCallViewController.m
//  GooglePlaces
//
//  Created by Ucom mm5 on 08.05.13.
//
//

#import "SRZ_TaxiCallViewController.h"

@interface SRZ_TaxiCallViewController ()
{
    UIView* dimView;
}
@end

@implementation SRZ_TaxiCallViewController
@synthesize name, vicinity;
@synthesize NameTF,AdressTF;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)BackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)CallTaxiButton:(id)sender {
    dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    dimView.backgroundColor = [UIColor blackColor];
    dimView.alpha = 0.7f;
    dimView.userInteractionEnabled = NO;
    [self.view addSubview:dimView];
    NSArray* arr = [[NSArray alloc]initWithObjects:@"Your taxi is on the way",@"No free taxi", @"Your taxi will retire in a couple of minutes", nil];
    NSUInteger randomIndex = arc4random() % [arr count];
    
    NSString * texta = [arr objectAtIndex:randomIndex];
        UIAlertView *simpleAlert = [[UIAlertView alloc] initWithTitle:@"Getting Taxi"
                                                          message:texta
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"OK",nil];
    [simpleAlert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 1){
        [dimView removeFromSuperview];
        [self.navigationController popToRootViewControllerAnimated:YES];
        NSLog(@"OK");
    }else{
        [dimView removeFromSuperview];
    }
        // Do something
       
            
        }
- (void)viewDidLoad
{
    [super viewDidLoad];
    NameTF.text = name;
    AdressTF.text = vicinity;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNameTF:nil];
    [self setAdressTF:nil];
    [super viewDidUnload];
}
@end
