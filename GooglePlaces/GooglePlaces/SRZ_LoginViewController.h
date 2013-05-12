//
//  SRZ_LoginViewController.h
//  GooglePlaces
//
//  Created by Svyat Zubyak on 10.05.13.
//
//

#import <UIKit/UIKit.h>
#import "UMM_Alert.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface SRZ_LoginViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
     UMM_Alert *all;
    UMM_AlertText *textfield;
    CGFloat animatedDistance;
}
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *passTF;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end
