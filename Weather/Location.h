//
//  Location.h
//  Weather
//
//  Created by Prabhat on 17/11/16.
//  Copyright © 2016 Training. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

@interface Location : UIViewController <CLLocationManagerDelegate,UITextFieldDelegate> {
    NSMutableArray* arrayOfDictionary;
    
    NSMutableDictionary *dictionary;
    NSString * cityEnteredByUser;
    NSString * stateEnteredByUser;
    NSString * countryEnteredByUser;
    NSString * pincodeEnteredByUser;
    NSString *LattitudeFound;
    NSString *LongitudeFound;
    CLLocation *newLocation;
    UISwitch *switchCase;

}

@property (nonatomic, retain) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;
@property (weak, nonatomic) IBOutlet UITextField *pinCodeTextField;

- (IBAction)switchBtn:(UISwitch *)sender;
- (IBAction)showLocationBtn:(UIButton *)sender;

@end
