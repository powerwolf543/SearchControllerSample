//
//  ContentTableViewController.m
//  SearchControllerHide
//
//  Created by NixonShih on 2017/1/3.
//  Copyright © 2017年 Nixon. All rights reserved.
//

#import "ContentTableViewController.h"

@interface ContentTableViewController ()

@end

@implementation ContentTableViewController


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = _dataSource[@"OccurDate"];
            break;
        case 1:
            cell.textLabel.text = _dataSource[@"OccurSeason"];
            break;
        case 2:
            cell.textLabel.text = _dataSource[@"INSURER_Name"];
            break;
        case 3:
            cell.textLabel.text = _dataSource[@"StockholderName"];
            break;
        case 4:
            cell.textLabel.text = _dataSource[@"Shares"];
            break;
        case 5:
            cell.textLabel.text = _dataSource[@"SharesRatio"];
            break;
        case 6:
            cell.textLabel.text = _dataSource[@"PledgeShares"];
            break;
        case 7:
            cell.textLabel.text = _dataSource[@"PledgeSharesRatio"];
            break;
            
        default:
            break;
    }
    
    return cell;
}

@end
