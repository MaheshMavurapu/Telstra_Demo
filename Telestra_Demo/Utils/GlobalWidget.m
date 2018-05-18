//
//  GlobalWidget.m
//  Telestra_Demo
//
//  Created by Wipro on 17/05/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

#import "GlobalWidget.h"

@implementation GlobalWidget

// Alert
+(UIAlertController *)alertMessage:(NSString *)message
                             title:(NSString *)title andCompletionHandler:(actionHandler)completion {
    // Step-1
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    // Step-2
    id rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        rootViewController = ((UINavigationController *)rootViewController).viewControllers.firstObject;
    }
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
    }
    [rootViewController presentViewController:alertController animated:YES completion:nil];
    return  alertController;
}

@end
