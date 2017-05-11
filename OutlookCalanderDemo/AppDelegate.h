//
//  AppDelegate.h
//  OutlookCalanderDemo
//
//  Created by Krishana on 12/6/16.
//  Copyright © 2016 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MSGraphSDK/MSGraphSDK.h>
#import <MSGraphSDK-NXOAuth2Adapter/MSGraphSDKNXOAuth2.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MSGraphClient *graphClient;


@end

