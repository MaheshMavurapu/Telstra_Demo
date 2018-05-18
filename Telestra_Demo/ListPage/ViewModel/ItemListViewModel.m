//
//  ItemListViewModel.m
//  Telestra_Demo
//
//  Created by Wipro on 17/05/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

#import "ItemListViewModel.h"
#import "ListTableViewCell.h"
#import "GlobalWidget.h"
#import "ItemListModel.h"
#import "APIList.h"

@implementation ItemListViewModel

ItemListAPICall *itemListAPICall; // API Call
NSString *cellIdentifier = @"ItemTableViewCell"; // Cell Identifier

-(void)sendListViewControllerToViewModel:(ListViewController *)listViewController {
    // ViewController+View = ViewModel
    self.listViewController = listViewController;
    // Spinner
    self.listViewController.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.listViewController.activityIndicatorView startAnimating];
    [self.listViewController.activityIndicatorView hidesWhenStopped];
    [self.listViewController.activityIndicatorView setColor:[UIColor redColor]];
    self.listViewController.activityIndicatorView.center = self.listViewController.view.center;
    [self.listViewController.view addSubview:self.listViewController.activityIndicatorView];
    // TableView Set
    self.listViewController.tableView.dataSource = self;
    self.listViewController.tableView.delegate = self;
    // API Call Set & Delegate
    itemListAPICall = [[ItemListAPICall alloc]init];
    itemListAPICall.listDelegate = self;
}

// Adding Table View to VIEW
-(void)addTableView {
    self.listViewController.tableView = [[UITableView alloc] initWithFrame:self.listViewController.view.bounds style:UITableViewStylePlain];
    self.listViewController.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // add clear bg color for spinner visible
    [self.listViewController.tableView setBackgroundColor:[UIColor clearColor]];
    
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    self.listViewController.tableView.delegate = self;
    self.listViewController.tableView.dataSource = self;
    [self.listViewController.view addSubview:self.listViewController.tableView];
    
    [self.listViewController.tableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    NSDictionary *views = @{@"tableView":self.listViewController.tableView};
    
    // tableviw auto layout
    [self.listViewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|[tableView]|" options:0 metrics:nil views:views]];
    [self.listViewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"V:|[tableView]|" options:0 metrics:nil views:views]];
    
    // dynamic height
    self.listViewController.tableView.rowHeight = UITableViewAutomaticDimension;
    self.listViewController.tableView.estimatedRowHeight = 44.0;
    self.listViewController.tableView.tableFooterView = nil;
    
    // pull down refresh
    self.listViewController.refreshControl = [[UIRefreshControl alloc]init];
    [self.listViewController.tableView addSubview:self.listViewController.refreshControl];
    [self.listViewController.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

// Refreshing Main table
- (void)refreshTable {
    [self.listViewController.itemsList removeAllObjects];
    [self.listViewController.tableView reloadData];
    [self fetchDetails];
}

// Get All Item Details
-(void)fetchDetails {
    // Url String
    [itemListAPICall getDetailsFromServer:List_Url]; // API Call
}

// Download Image From server with Image Url
-(void)downloadImageWithUrl:(NSURL *)imageUrl {
    // Url String
    [itemListAPICall getDownloadedImageFromServer:imageUrl]; // API Call
}

// Response - API Call - Delegate Methods
-(void)listOfResultsFromServer:(NSDictionary *)detailsList
                         error:(NSError *)error
                  responseCode:(NSInteger)code {
    typeof(self.listViewController) weakSelf = self.listViewController;
    // add white bg color for tableview display
    [self.listViewController.tableView setBackgroundColor:[UIColor whiteColor]];
    [weakSelf.activityIndicatorView stopAnimating];
    [[weakSelf tableView] reloadData];
    [[weakSelf refreshControl] performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.0];
    if (detailsList != nil) {
        [self updateDetail:detailsList];
    } else {
        [GlobalWidget alertMessage:@"Something went wrong. Please try again" title:@"Error" andCompletionHandler:^(UIAlertAction *action) {
        }];
    }
}

-(void)imageFromServer:(NSData *)imageData
                 error:(NSError *)error
          responseCode:(NSInteger)code {
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    [self.imageDelegate downloadedImage:image]; // Sending Downloaded Image to update UI.
}
//

-(void)updateDetail:(NSDictionary *)details {
    if ([details objectForKey:@"title"]) {
        self.listViewController.title = [details objectForKey:@"title"];
    }
    if (self.self.listViewController.itemsList == nil) {
        self.self.listViewController.itemsList = [NSMutableArray array];
    }
    if ([details objectForKey:@"rows"]) {
        self.self.listViewController.itemsList = nil;
        NSArray *rowItems = [details objectForKey:@"rows"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in rowItems) {
            [modelArray addObject:[ItemListModel modelObjectWithDictionary:dict]];
        }
        self.listViewController.itemsList = modelArray;
    }
    [self.self.listViewController.tableView reloadData];
}

// Table View Datasource & Delegate
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section {
    return self.listViewController.itemsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = (ListTableViewCell *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.titleLabel.text = @"";
    cell.descriptionLabel.text = @"";
    cell.itemImageView.image = nil;
    [cell setDetails:[self.listViewController.itemsList objectAtIndex:indexPath.row]];
    
    return cell;
}

// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected %ld row", (long)indexPath.row);
}


@end
