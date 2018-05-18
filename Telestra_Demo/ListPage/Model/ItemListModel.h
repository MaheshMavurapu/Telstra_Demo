//
//  ItemListModel.h
//  Telestra_Demo
//
//  Created by Wipro on 17/05/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemListModel : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *detail;
@property(nonatomic, strong) NSURL *imageURL;

+(instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
