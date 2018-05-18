//
//  ItemListViewModel.h
//  Telestra_Demo
//
//  Created by Wipro on 17/05/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListViewController.h"
#import "ItemListAPICall.h"

@protocol ImageProtocol <NSObject>
-(void)downloadedImage:(UIImage*)image;
@end

@interface ItemListViewModel : NSObject <UITableViewDataSource, UITableViewDelegate, ListProtocol>

@property ListViewController *listViewController;
-(void)sendListViewControllerToViewModel:(ListViewController *)listViewController;

@property (weak, nonatomic) id<ImageProtocol> imageDelegate;

// Helper Methods - Public
-(void)addTableView; // Adding TableView programmatically - Not using IB.
-(void)fetchDetails; // Fetching of Details
-(void)downloadImageWithUrl:(NSURL*)imageUrl; // Fetching of Image

@end
