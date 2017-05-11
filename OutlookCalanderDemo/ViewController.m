//
//  ViewController.m
//  OutlookCalanderDemo
//
//  Created by Krishana on 12/6/16.
//  Copyright © 2016 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//
#import "Authentication.h"
#import "AuthenticationConstants.h"
#import "ViewController.h"
#import <MSGraphSDK/MSGraphSDK.h>
#import <MSGraphSDK-NXOAuth2Adapter/MSGraphSDKNXOAuth2.h>

@interface ViewController () {
}

@property (strong, nonatomic) MSGraphClient *client;
@property (strong, nonatomic) Authentication *authentication;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _authentication = [[Authentication alloc]init];

    
    

}

- (IBAction)connectTapped:(id)sender {
    
    ////////////////
    //METHOD 1
    ////////////////

    NSArray *scopes = [kScopes componentsSeparatedByString:@","];
    [self.authentication connectToGraphWithClientId:kClientId scopes:scopes completion:^(NSError *error) {
        if (!error) {
            NSLog(@"Authentication successful.");
            //self.client = [MSGraphClient client];
            
            [self createEventForUser];
        }
        else{
            NSLog(@"Authentication failed - %@", error.localizedDescription);
        };
    }];
    ////////////////
    //METHOD 2
    ////////////////
    
    [NXOAuth2AuthenticationProvider setClientId:@"9e9e42d3-d788-4cb0-ac2d-837c605246a3"
                                         scopes:@[@"https://graph.microsoft.com/Files.ReadWrite",
                                                  @"https://graph.microsoft.com/Calendars.ReadWrite"]];
    
    [[NXOAuth2AuthenticationProvider sharedAuthProvider] loginWithViewController:nil completion:^(NSError *error) {
        if (!error) {
            [MSGraphClient setAuthenticationProvider:[NXOAuth2AuthenticationProvider sharedAuthProvider]];
            self.client = [MSGraphClient client];
            [self createEventForUser];
            //[self getEventsOfCurrentUser];
        }
    }];
}

- (void)createEventForUser {
    // Create an event in the signed in user's calendar. Applies to personal or work accounts.    
    MSGraphEvent *event = [[MSGraphEvent alloc] init];
    [event setSubject:@"Adding An Extra Event (Checking Session)"];
    [event setCreatedDateTime:[NSDate date]];
    //[event setValue:@"Description here" forKey:@"desc"];
    MSGraphEventType *eventType = [MSGraphEventType singleInstance];
    [event setType:eventType];
    
    MSGraphItemBody *itemBody = [[MSGraphItemBody alloc] init];
    [itemBody setContentType:[MSGraphBodyType text]];
    [itemBody setContent:@"Body of event goes here"];
    [event setBody:itemBody];
    // Params: addEvent - MSGraphEvent
    [[[[[MSGraphClient client] me] events] request] addEvent:event withCompletion:^(MSGraphEvent *response, NSError *error) {
        if (error) {
            NSLog(@"error in adding event -> %@", error.localizedDescription);
        }
        else {
            NSLog(@"success-> %@", response.iCalUId);
        }
    }];
}

- (void)getEventsOfCurrentUser {
    // Gets the signed-in user's events. Applies to personal or work accounts.
    // Params: none
    [[[[self.client me] events] request] getWithCompletion:^(MSCollection *response, MSGraphUserEventsCollectionRequest *nextRequest, NSError *error) {
        if (error) {
            NSLog(@"error in adding event -> %@", error.localizedDescription);
        }
        else {
            NSLog(@"success-> %@", nextRequest.description);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
