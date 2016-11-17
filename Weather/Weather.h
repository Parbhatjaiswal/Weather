//
//  Weather.h
//  Weather
//
//  Created by Prabhat on 17/11/16.
//  Copyright © 2016 Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface Weather : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource,  NSFileManagerDelegate> {
    
    NSString * urlStr;
    
    NSMutableDictionary *json;
    NSMutableArray *minTemperatures;
    NSMutableArray *maxTemperatures;
    NSMutableArray *dayClimateImageArray;
    NSMutableArray *hourlyClimateImageArray;
    NSMutableArray *hourlyTempArray;
    NSMutableArray *timeArray;
    NSMutableArray *dayArray;
    
    NSString *CurrentTimeWithFormat;
    NSString *backgroundImage;
    NSString *dayClimateImage;
    NSString *hourClimateImage;
    NSString *tempInCelcius;
    NSString *hourlyTime;
}

@property (weak, nonatomic) IBOutlet UICollectionView *weatherCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *weatherTableView;

@property (weak, nonatomic) IBOutlet UILabel *weatherCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWeatherstatus;
@property (weak, nonatomic) IBOutlet UILabel *weatherTemperature;
@property (weak, nonatomic) IBOutlet UILabel *currentWeatherDay;
@property (weak, nonatomic) IBOutlet UILabel *weatherMaxTemp;
@property (weak, nonatomic) IBOutlet UILabel *weatherMinTemp;

@end
