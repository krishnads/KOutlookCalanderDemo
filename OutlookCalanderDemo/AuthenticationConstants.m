/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See LICENSE in the project root for license information.
 */

#import "AuthenticationConstants.h"

@implementation AuthenticationConstants

// You will set your application's clientId
NSString * const kClientId = @"9e9e42d3-d788-4cb0-ac2d-837c605246a3";

//Important: These scoped are configured for non-admin users of the tenant. There are specific snippets that require admin privilieges for
//them to run properly, and they will be marked as so in the UI. To run these admin-only snippets you'll need to add these additional scopes:
//"https://graph.microsoft.com/Directory.AccessAsUser.All",
//"https://graph.microsoft.com/User.ReadWrite.All"
//https://graph.microsoft.com/User.ReadWrite,                                 https://graph.microsoft.com/User.ReadBasic.All,                             https://graph.microsoft.com/Mail.Send,https://graph.microsoft.com/Mail.ReadWrite,
NSString * const kScopes = @"https://graph.microsoft.com/User.Read,https://graph.microsoft.com/Calendars.ReadWrite,https://graph.microsoft.com/Files.ReadWrite";

@end
