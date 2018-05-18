//
//  ListViewController.h
//  Telestra_Demo
//
//  Created by Wipro on 17/05/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ListViewController : BaseViewController // Inheritance

@property(nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) NSMutableArray *itemsList; // Fetched Items List
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end
