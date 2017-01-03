//
//  MenuTableViewController.m
//  SearchControllerHide
//
//  Created by NixonShih on 2017/1/3.
//  Copyright © 2017年 Nixon. All rights reserved.
//

#import "MenuTableViewController.h"
#import "CustomNavigationController.h"

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = self.storyboard;
    
    if (indexPath.section == 0) {
        
        UIViewController *vc;

        switch (indexPath.row) {
            case 0:
                vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewControllerSID"];
                break;
            case 1:
                vc = [storyboard instantiateViewControllerWithIdentifier:@"TableViewControllerSID"];
                break;
            default:
                break;
        }
        
        if (vc) {
            [self.navigationController pushViewController:vc animated:true];
        }
    }else if (indexPath.section == 1) {
        
        CustomNavigationController *nav;
        
        switch (indexPath.row) {
            case 0:
                nav = [storyboard instantiateViewControllerWithIdentifier:@"NavViewControllerSID"];
                break;
            case 1:
                nav = [storyboard instantiateViewControllerWithIdentifier:@"NavTableViewControllerSID"];
                break;
            default:
                break;
        }
        
        if (nav) {
            UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:nav action:@selector(dismissViewController)];
            [nav.topViewController.navigationItem setRightBarButtonItem:button];
            [self presentViewController:nav animated:true completion:nil];
        }
    }
    
}

@end
