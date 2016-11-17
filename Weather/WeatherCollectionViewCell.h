//
//  WeatherCollectionViewCell.h
//  Weather
//
//  Created by Prabhat on 17/11/16.
//  Copyright © 2016 Training. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *weatherCollectionHourlyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherCollectionIcon;
@property (weak, nonatomic) IBOutlet UILabel *weatherCollectionTemp;

@end
