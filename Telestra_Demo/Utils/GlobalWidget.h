//
//  GlobalWidget.h
//  Telestra_Demo
//
//  Created by Wipro on 17/05/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^actionHandler) (UIAlertAction *action);

@interface GlobalWidget : NSObject

// Alert
+(UIAlertController *)alertMessage:(NSString *)message
                              title:(NSString *)title andCompletionHandler:(actionHandler)completion;

@end
