//
//  ViewController.m
//  SearchControllerHide
//
//  Created by NixonShih on 2017/1/3.
//  Copyright © 2017年 Nixon. All rights reserved.
//

#import "ViewController.h"
#import "TableViewDataSource.h"
#import "ContentTableViewController.h"

@interface ViewController ()  <UISearchResultsUpdating>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UISearchController *searchController;
@end

@implementation ViewController {
    TableViewDataSource *dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchController = [self searchControllerUseCustomSetting];
    
    dataSource = [TableViewDataSource new];
    dataSource.searchContollerReference = _searchController;
    self.tableView.dataSource = dataSource;
}

- (void)dealloc {
    // 消除一些警告
    [_searchController.view removeFromSuperview];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = self.storyboard;
    ContentTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ContentTableViewControllerSID"];
    NSDictionary *dic = _searchController.active ? dataSource.filteredDataProvider[indexPath.row] : dataSource.dataProvider[indexPath.row];
    vc.dataSource = dic;
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark - Private Methods

- (UISearchController*)searchControllerUseCustomSetting {
    
    // Setup the Search Controller，SearchResultsController為nil的話，則會使用本頁TableView。
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    // definesPresentationContext 預設為false，把它設定為true的話searchController就不會影響到下一頁和上一頁。原理為他自己就是負責Present動作的頁面，不會委託給最外層的框架，所以當自己有任何動作的時候，也會影響到自己Present出來的頁面。可以調整此參數看看差異在哪邊。
    self.definesPresentationContext = true;
    // present出來的SearchController是否顯示背景，可以調整此參數看看差異在哪邊。
    searchController.dimsBackgroundDuringPresentation = false;
    // 這行決定NavigationBar會不會隱藏，官方預設值為True，可以調整此參數看看差異在哪邊。
    searchController.hidesNavigationBarDuringPresentation = true;
    
    self.tableView.tableHeaderView = searchController.searchBar;
    
    /* 一些其他的設定
     
     searchController.searchBar.placeholder = @"請輸入您要搜尋的文字";
     
     searchController.searchBar.tintColor = [UIColor whiteColor];
     searchController.searchBar.barTintColor = [UIColor colorWithRed:15.0/255.0 green:115.0/255.0 blue:97.0/255.0 alpha:1.0];
     [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setBackgroundColor:[UIColor colorWithRed:5.0/255.0 green:60.0/255.0 blue:45.0/255.0 alpha:1.0]];
     [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];
     
     // 讓 SearchController 新增一些篩選的功能
     searchController.searchBar.scopeButtonTitles = @[@"選項1",@"選項2",@"選項3"];
     */
    
    return searchController;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    // 在Block中設定篩選條件
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        NSDictionary *dic = evaluatedObject;
        
        NSString *searchText = searchController.searchBar.text;
        
        if (searchText.length == 0) {
            return false;
        }else{
            NSString *sourceText = dic[@"StockholderName"];
            return [sourceText.lowercaseString containsString:searchText.lowercaseString];
        }
    }];
    
    dataSource.filteredDataProvider = [dataSource.dataProvider filteredArrayUsingPredicate:predicate]; // 取出陣列中符合條件的物件
    [self.tableView reloadData];
}

@end
