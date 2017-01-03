//
//  TableViewDataSource.h
//  SearchControllerHide
//
//  Created by NixonShih on 2017/1/3.
//  Copyright © 2017年 Nixon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewDataSource : NSObject <UITableViewDataSource>
@property (strong, nonatomic) NSArray<NSDictionary*> *dataProvider;
@property (strong, nonatomic) NSArray<NSDictionary*> *filteredDataProvider;
@property (weak, nonatomic) UISearchController *searchContollerReference;
@end
