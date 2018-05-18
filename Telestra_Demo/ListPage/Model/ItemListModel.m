//
//  ItemListModel.m
//  Telestra_Demo
//
//  Created by Wipro on 17/05/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

#import "ItemListModel.h"

@implementation ItemListModel

+(instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

// Instance method
-(instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        if ([dict objectForKey:@"title"] != [NSNull null] || [dict objectForKey:@"description"] != [NSNull null] || [dict objectForKey:@"imageHref"] != [NSNull null]) {
            if ([dict objectForKey:@"title"] != [NSNull null]) {
                self.title = [dict objectForKey:@"title"];
            }
            
            if ([dict objectForKey:@"description"] != [NSNull null]) {
                self.detail = [dict objectForKey:@"description"];
            }
            
            if ([dict objectForKey:@"imageHref"] != [NSNull null]) {
                NSString *strImgURLAsString = [dict objectForKey:@"imageHref"];
                [strImgURLAsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *imgURL = [NSURL URLWithString:strImgURLAsString];
                self.imageURL = imgURL;
            }
        }
    }
    return self;
}

// Helper method - Use if needed
-(id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
