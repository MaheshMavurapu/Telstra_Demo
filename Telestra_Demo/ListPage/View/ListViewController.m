//
//  ListViewController.m
//  Telestra_Demo
//
//  Created by Wipro on 17/05/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

#import "ListViewController.h"
#import "ItemListViewModel.h"

@interface ListViewController ()

@property ItemListViewModel *itemListViewModel; // Item List ViewModel Reference object.

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemListViewModel = [[ItemListViewModel alloc]init];
    [self.itemListViewModel sendListViewControllerToViewModel:self]; // Creating View and Model as ViewModel reference.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.itemListViewModel addTableView]; // Adding TableView programmatically - Not using IB.
    if (self.itemListViewModel.listViewController.itemsList == nil) {
        [self.itemListViewModel fetchDetails];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
