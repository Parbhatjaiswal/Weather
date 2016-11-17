//
//  Weather.m
//  Weather
//
//  Created by Prabhat on 17/11/16.
//  Copyright © 2016 Training. All rights reserved.
//

#import "Weather.h"


#import "WeatherCell.h"
#import "WeatherCollectionViewCell.h"

#define BaseUrl "https://api.darksky.net/forecast"
#define APIKEY "3b40eebca8068aa34b55ef5297df8167"

@interface Weather ()

@end

@implementation Weather

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    minTemperatures = [[NSMutableArray alloc]init];
    maxTemperatures = [[NSMutableArray alloc]init];
    
    [self callApi];
}

#pragma mark Call Api
- (void)callApi {
    NSDictionary *savedValue = [[NSUserDefaults standardUserDefaults]
                                objectForKey:@"userLocationData"];
    
    NSLog(@"%@",savedValue);
    NSString *api = [NSString stringWithFormat:@"%s/%s",BaseUrl,APIKEY];
    NSString *lattitude = savedValue [@"lattitude"];
    NSString *longitude = savedValue [@"longitude"];

    
    urlStr = [NSString stringWithFormat: @"%@/%@,%@",api,lattitude,longitude];
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    [[session dataTaskWithURL:[NSURL URLWithString:urlStr]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                if (data){
                    //Converting responce data into NSDictionary
                    json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: nil];
                    
                    NSLog(@"%@",json);
                    
                    //Updating UI
//                    [self loadData];
//                    [self writeStringToFile:data];
                }
                else {
                    NSLog(@"Error In Parsing the JSON");
                }
            }]resume];
}



//- (void)fetchGreeting;
//{
//    NSURL *url = [NSURL URLWithString:@"https://api.darksky.net/forecast/3b40eebca8068aa34b55ef5297df8167/30.900965,75.8572758"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response,
//                                               NSData *data, NSError *connectionError)
//     {
//         if (data.length > 0 && connectionError == nil)
//         {
//             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
//                                                                      options:0
//                                                                        error:NULL];
//             
//             NSLog(@"%@",greeting);
//         }
//     }];
//}

//Implementing For The collectionView
#pragma mark Collection DataSource/Delegate

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WeatherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WeatherCollectionViewCellID" forIndexPath:indexPath];
//    
//    if (indexPath.row == 0)
//    {
//        cell.weatherCollectionHourlyLabel.text = @"Now";
//    }
//    else
//    {
//        cell.weatherCollectionHourlyLabel.text = timeArray [indexPath.row];
//    }
//    cell.weatherCollectionTemp.text = hourlyTempArray [indexPath.row];
//    cell.weatherCollectionIcon.image = [UIImage imageNamed:hourlyClimateImageArray [indexPath.row]];
    return cell;
}

// Implementing For The tableView
#pragma mark TableView DataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 1;
}// Default is 1 if not implemented




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"WeatherCellID";
    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    cell.dayLbl.text = dayArray [indexPath.row];
//    cell.minTempLbl.text = [NSString stringWithFormat:@"Min : %@",minTemperatures[indexPath.row]];
//    cell.maxTempLbl.text = [NSString stringWithFormat:@"Max : %@",maxTemperatures[indexPath.row]];
//    cell.dayClimateImage.image = [UIImage imageNamed:dayClimateImageArray[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
