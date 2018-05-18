//
//  ItemListAPICall.m
//  Telestra_Demo
//
//  Created by Wipro on 17/05/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

#import "ItemListAPICall.h"

@implementation ItemListAPICall

// Fetching Item Details
-(void)getDetailsFromServer:(NSString *)url {
    NetworkManager *networkManager = [NetworkManager sharedInstance];
    [networkManager fetchDataFromServerWithUrl:url
                   andCompletionHandler:^(NSError *error, id response, NSHTTPURLResponse *httpResponse) {
        [self.listDelegate listOfResultsFromServer:response error:error responseCode:[httpResponse statusCode]];
    }];
}

// Downloading of Image
-(void)getDownloadedImageFromServer:(NSURL *)url {
    NetworkManager *networkmanager = [NetworkManager sharedInstance];
    [networkmanager downloadImageFromServerWithUrl:url andCompletionHandler:^(NSError *error, id response, NSHTTPURLResponse *httpResponse) {
        [self.listDelegate imageFromServer:response error:error responseCode:[httpResponse statusCode]];
    }];
}

@end
