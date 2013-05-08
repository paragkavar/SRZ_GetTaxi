//
//  SRZ_TaxiCallViewController.h
//  GooglePlaces
//
//  Created by Ucom mm5 on 08.05.13.
//
//

#import <UIKit/UIKit.h>

@interface SRZ_TaxiCallViewController : UIViewController <UIAlertViewDelegate>
{
    
}
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *vicinity;
@property (strong, nonatomic) IBOutlet UITextField *NameTF;
@property (strong, nonatomic) IBOutlet UITextField *AdressTF;

@end
