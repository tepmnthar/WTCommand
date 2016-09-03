//
//  WebCommands.m
//
//  Created by tepmnthar on 16/7/21.
//  Copyright © 2016年 tepmnthar All rights reserved.
//

#import "WebCommands.h"
@interface WebCommands()
@property (nonatomic,strong) WTCommand* testCommand;
@end
@implementation WebCommands
+ (WTCommand*)constructCommandFromCommand:(WEB_COMMANDS_TYPE)type successHandler:(WTCommandSuccessBlock)successHandler errorHandler:(WTCommandErrorBlock)errorHandler{
    WebCommands* ret=[[WebCommands alloc] init];
    if (!ret) return nil;
    switch (type) {
        case WEB_COMMAND_TEST_GET:{
            return [ret constructTestGetDataCommandSuccessHandler:successHandler errorHandler:errorHandler];
            break;
        }
        case WEB_COMMAND_TEST_POST:{
            return [ret constructTestPostDataCommandSuccessHandler:successHandler errorHandler:errorHandler];
            break;
        }
        default:
            return nil;
            break;
    }
//    return ret;
}
+ (void)pingGet:(NSString*)urlString successHandler:(WTCommandSuccessBlock)successHandler errorHandler:(WTCommandErrorBlock)errorHandler{
    __block WTCommand* command=[[WTCommand alloc] initWithConsumeHandler:^(id input) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:urlString parameters:input progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            command.successHandler(nil);
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            command.errorHandler(nil);
        }];
    } successHandler:successHandler errorHandler:errorHandler];
    [command excute:nil];
}
+ (void)pingPost:(NSString*)urlString successHandler:(WTCommandSuccessBlock)successHandler errorHandler:(WTCommandErrorBlock)errorHandler{
    __block WTCommand* command=[[WTCommand alloc] initWithConsumeHandler:^(id input) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"Success: %@",responseObject);
            command.successHandler(nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error: %@",error);
            command.errorHandler(nil);
        }];
    } successHandler:successHandler errorHandler:errorHandler];
    [command excute:nil];
}
-(WTCommand*)constructTestGetDataCommandSuccessHandler:(WTCommandSuccessBlock)successHandler errorHandler:(WTCommandErrorBlock)errorHandler{
    __block WTCommand* command=[[WTCommand alloc]initWithConsumeHandler:^(id input) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:@"http://www.baidu.com" parameters:input progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            command.successHandler(responseObject);
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            command.errorHandler(error);
        }];
    } successHandler:successHandler errorHandler:errorHandler];
    return command;
}
-(WTCommand*)constructTestPostDataCommandSuccessHandler:(WTCommandSuccessBlock)successHandler errorHandler:(WTCommandErrorBlock)errorHandler{
    __block WTCommand* command=[[WTCommand alloc]initWithConsumeHandler:^(id input) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager POST:@"http://115.28.180.117:8080/imitationShy/login.do" parameters:input progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"Success: %@",responseObject);
            command.successHandler(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error: %@",error);
            command.errorHandler(error);
        }];
    } successHandler:successHandler errorHandler:errorHandler];
    return command;
}
@end
