//
//  WebCommands.h
//
//  Created by tepmnthar on 16/7/21.
//  Copyright © 2016年 tepmnthar All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTCommand.h"
#import "AFNetworking.h"
//#import <AFNetworking.h>

typedef enum {
    WEB_COMMAND_NONE,
    WEB_COMMAND_TEST_GET,
    WEB_COMMAND_TEST_POST
}WEB_COMMANDS_TYPE;

@interface WebCommands : NSObject
+ (WTCommand*)constructCommandFromCommand:(WEB_COMMANDS_TYPE)type successHandler:(WTCommandSuccessBlock)successHandler errorHandler:(WTCommandErrorBlock)errorHandler;
+ (void)pingGet:(NSString*)urlString successHandler:(WTCommandSuccessBlock)successHandler errorHandler:(WTCommandErrorBlock)errorHandler;
+ (void)pingPost:(NSString*)urlString successHandler:(WTCommandSuccessBlock)successHandler errorHandler:(WTCommandErrorBlock)errorHandler;
@end
