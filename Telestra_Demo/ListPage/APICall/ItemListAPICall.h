//
//  ItemListAPICall.h
//  Telestra_Demo
//
//  Created by Wipro on 17/05/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"

@protocol ListProtocol <NSObject>
-(void)listOfResultsFromServer:(NSDictionary *)detailsList
                        error:(NSError *)error
                 responseCode:(NSInteger)code;
@end

@interface ItemListAPICall : NSObject

@property (weak, nonatomic) id<ListProtocol> listDelegate;
-(void)getDetailsFromServer:(NSString *)url;

@end
