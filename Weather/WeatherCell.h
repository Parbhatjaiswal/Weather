//
//  WeatherCell.h
//  Weather
//
//  Created by Prabhat on 17/11/16.
//  Copyright © 2016 Training. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *weatherDayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *weatherMaxTemp;
@property (weak, nonatomic) IBOutlet UILabel *weatherMinTemp;

@end
