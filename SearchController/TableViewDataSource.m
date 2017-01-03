//
//  TableViewDataSource.m
//  SearchControllerHide
//
//  Created by NixonShih on 2017/1/3.
//  Copyright © 2017年 Nixon. All rights reserved.
//

#import "TableViewDataSource.h"

@implementation TableViewDataSource

- (instancetype)init {
    self = [super init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"json-05030310" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *jsonError;
    _dataProvider = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
    
    if (jsonError) {
        return nil;
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchContollerReference.active ? _filteredDataProvider.count : _dataProvider.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *dic;
    
    if (_searchContollerReference.active) {
        dic = _filteredDataProvider[indexPath.row];
    }else{
        dic = _dataProvider[indexPath.row];
    }
    
    cell.textLabel.text = dic[@"StockholderName"];
    
    return cell;
}

@end
