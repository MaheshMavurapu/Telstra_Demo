//
//  NetworkManager.h
//  Telestra_Demo
//
//  Created by Wipro on 17/05/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^callbackHandler) (NSError *error, id response, NSHTTPURLResponse *httpResponse); // Custom Completion handler. 

@interface NetworkManager : NSObject

+(instancetype)sharedInstance;
-(void)fetchDataFromServerWithUrl:(NSString *)url andCompletionHandler:(callbackHandler)completion;
-(void)downloadImageFromServerWithUrl:(NSURL *)imgURL andCompletionHandler:(callbackHandler)completion;

@end
