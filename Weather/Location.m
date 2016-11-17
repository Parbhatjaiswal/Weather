//
//  Location.m
//  Weather
//
//  Created by Prabhat on 17/11/16.
//  Copyright © 2016 Training. All rights reserved.
//

#import "Location.h"

@interface Location () {
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

@end

@implementation Location

@synthesize locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arrayOfDictionary = [[NSMutableArray alloc]init];
    self.navigationController.navigationBarHidden = YES;
    dictionary =[[NSMutableDictionary alloc]init];
//    _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [self.view addSubview: _activityIndicator];
    //    [self disableButton];
}

-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark Update Location
-(void)startUpadatingLocation{
    
    geocoder = [[CLGeocoder alloc] init];
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Turn off the location manager to save power.
    
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManager delegate methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
    newLocation = [locations lastObject];
    [self fetchTheCurrentLocation];
    
    // Turn off the location manager to save power.
    [manager stopUpdatingLocation];
}

-(void)fetchTheCurrentLocation {
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            NSString *lattitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
            NSString *longitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
            NSString * city = placemark.locality;
            NSString * state = placemark.administrativeArea;
            NSString * country = placemark.country;
            NSString * pincode = placemark.postalCode;
            
            _cityTextField.text = placemark.locality;
            _stateTextField.text = placemark.administrativeArea;
            _countryTextField.text = placemark.country;
            _pinCodeTextField.text = placemark.postalCode;
            //            [self disableButton];
            
            //Storing the values in NSUserDefaults.
            dictionary = [NSMutableDictionary                                               dictionaryWithDictionary: @{  @"lattitude" :lattitude,@"longitude" : longitude, @"city": city , @"state" :  state ,@"country" : country , @"pinCode" : pincode
                                                                                                                          }];
            [arrayOfDictionary addObject:dictionary];
            
            [[NSUserDefaults standardUserDefaults] setObject:arrayOfDictionary forKey:@"userLocationData"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"%@",arrayOfDictionary);
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
}


// fetch the location of the user values.
-(void)getLocationString {
    cityEnteredByUser = _cityTextField.text;
    stateEnteredByUser = _stateTextField.text;
    countryEnteredByUser = _countryTextField.text;
    pincodeEnteredByUser= _pinCodeTextField.text;
}

-(void)fetchLocationOfUserData {
    
    [self getLocationString];
    
    NSString *addressString = [NSString stringWithFormat:@"%@,%@,%@,%@", cityEnteredByUser, stateEnteredByUser, countryEnteredByUser, pincodeEnteredByUser ];
    
    [self getLocationFromAddressString :addressString];
    
    
    
    dictionary = [NSMutableDictionary                                               dictionaryWithDictionary: @{   @"lattitude" :LattitudeFound,@"longitude" : LongitudeFound,  @"city": cityEnteredByUser , @"state" :  stateEnteredByUser ,@"country" : countryEnteredByUser , @"pinCode" : pincodeEnteredByUser
                                                                                                                   }];
    
    [arrayOfDictionary addObject:dictionary];
    
    [[NSUserDefaults standardUserDefaults] setObject:arrayOfDictionary forKey:@"userLocationData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"%@",arrayOfDictionary);
}


//convert string address to lattitude and longitude

-(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) addressStr {
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [addressStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    
    LattitudeFound = [NSString stringWithFormat: @"%f",center.latitude];
    LongitudeFound = [NSString stringWithFormat: @"%f",center.longitude];
    //    NSLog(@"getting Location Logitute : %@",LattitudeFound);
    //    NSLog(@"getting Location Latitute : %@",LongitudeFound);
    return center;
    
}

// For Any error
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Cannot find the location.");
}


- (IBAction)switchBtn:(UISwitch *)sender {
    switchCase = (UISwitch *) sender;
    
    if(switchCase.isOn){
        NSLog(@"Switch State is Enabled");
        [self startUpadatingLocation];
    }
    else{
        NSLog(@"Switch State is Disabled");
        _cityTextField.text = nil;
        _stateTextField.text = nil;
        _pinCodeTextField.text =nil;
        _countryTextField.text =nil;
        
        //        [self fetchLocationOfUserData];
    }

}

- (IBAction)showLocationBtn:(UIButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
