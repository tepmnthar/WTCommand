//
//  ViewController.m
//  WTCommand
//
//  Created by tepmnthar on 16/9/3.
//  Copyright © 2016年 tepmnthar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WTCommand* command=[WebCommands constructCommandFromCommand:WEB_COMMAND_TEST_GET successHandler:^(id result) {
        NSLog(@"result in WebCommand callback:: %@",result);
    } errorHandler:^(id error) {
        NSLog(@"error in WebCommand callback:: %@",error);
    }];
    [command excute:nil];
    
    [[[[WebCommands constructCommandFromCommand:WEB_COMMAND_TEST_POST successHandler:^(id result) {
        NSLog(@"result in WebCommand callback:: %@",result);
    } errorHandler:^(id error) {
        NSLog(@"error in WebCommand callback:: %@",error);
    }] finalHandler:^(id output) {
        NSLog(@"final in WebCommand callback:: %@",output);
    }] initChangeStatusCallback:^(CommandStatus status) {
        switch (status) {
            case COMMAND_SUCCESS:
                NSLog(@"successStatus");
                break;
            case COMMAND_ERROR:
                NSLog(@"errorStatus");
                break;
            case COMMAND_PENDING:
                NSLog(@"pendingStatus");
                break;
            default:
                break;
        }
    }] excute:@{@"mobile":@"18217520748",@"passwd":@"123456"}];
    
    [WebCommands pingGet:@"http://www.baidu.com" successHandler:^(id result) {
        NSLog(@"result in WebCommand callback:: %@",result);
    } errorHandler:^(id error) {
        NSLog(@"error in WebCommand callback:: %@",error);
    }];
    
    [WebCommands pingPost:@"http://www.baidu.com" successHandler:^(id result) {
        NSLog(@"result in WebCommand callback:: %@",result);
    } errorHandler:^(id error) {
        NSLog(@"error in WebCommand callback:: %@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
