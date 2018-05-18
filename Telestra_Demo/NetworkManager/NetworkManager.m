//
//  NetworkManager.m
//  Telestra_Demo
//
//  Created by Wipro on 17/05/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

// Network Instance
+ (instancetype)sharedInstance {
    static NetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkManager alloc] init];
    });
    return sharedInstance;
}

// Get Request for List Details
- (void)fetchDataFromServerWithUrl:(NSString *)url andCompletionHandler:(callbackHandler)completion {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSError* error = nil;
        NSString *iso = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
        NSData *dutf8 = [iso dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:dutf8 options:0 error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (json != nil) {
                completion(nil, json, httpResponse);
            } else {
                NSLog(@"error: %@", error);
                completion(nil, nil, httpResponse);
            }
        });
    }];
}

// Downloading Image
-(void)downloadImageFromServerWithUrl:(NSURL *)imgURL andCompletionHandler:(callbackHandler)completion {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:imgURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if (!connectionError) {
            completion(nil, data, httpResponse);
        }else{
            completion(connectionError, nil, httpResponse);
            NSLog(@"%@",connectionError);
        }
    }];
}

@end
