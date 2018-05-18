//
//  Telestra_DemoTests.m
//  Telestra_DemoTests
//
//  Created by Wipro on 18/05/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ListViewController.h"
#import "ListTableViewCell.h"
#import "ItemListViewModel.h"

@interface Telestra_DemoTests : XCTestCase
@property (nonatomic, strong) ItemListViewModel *listViewModel;
@end

@implementation Telestra_DemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.listViewModel = [[ItemListViewModel alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.listViewModel.listViewController];
    window.rootViewController = navController;
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    
    [self.listViewModel.listViewController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    [self.listViewModel.listViewController viewDidAppear:NO];
}

// Custom Test Methods
- (void)testTableViewCellCellReuseIdentifier {
    ListTableViewCell *listTableViewCell = (ListTableViewCell *)[self.listViewModel tableView:self.listViewModel.listViewController.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *reuseIdentifier = @"ItemTableViewCell";
    XCTAssertTrue([listTableViewCell.reuseIdentifier isEqualToString:reuseIdentifier], @"Table does not create reusable cells");
}

- (void)testViewConformsToUITableViewDataSource {
    XCTAssertTrue([self.listViewModel conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}

- (void)testViewConformsToUITableViewDelegate {
    XCTAssertTrue([self.listViewModel conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}
//

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.listViewModel.listViewController = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
