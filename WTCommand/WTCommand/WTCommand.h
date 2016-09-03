//
//  WTCommand.h
//
//  Created by tepmnthar on 16/7/21.
//  Copyright © 2016年 tepmnthar All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    COMMAND_IDLE=-1,
    COMMAND_PENDING=0,
    COMMAND_SUCCESS,
    COMMAND_ERROR,
    COMMAND_CANCEL
} CommandStatus;

typedef void(^WTCommandConsumeBlock)(id input);
typedef void(^WTCommandCancelBlock)(void);
typedef void(^WTCommandSuccessBlock)(id result);
typedef void(^WTCommandErrorBlock)(id error);
typedef void(^WTCommandFinalCallback)(id output);
typedef void(^WTCommandChangeStatusCallback)(CommandStatus status);

@interface WTCommand : NSObject
@property (nonatomic,readonly)WTCommandSuccessBlock successHandler;
@property (nonatomic,readonly)WTCommandErrorBlock errorHandler;
-(instancetype)initWithConsumeHandler:(WTCommandConsumeBlock)consumeHandler successHandler:(WTCommandSuccessBlock)successHandler errorHandler:(WTCommandErrorBlock)errorHandler;
-(instancetype)initWithConsumeHandler:(WTCommandConsumeBlock)consumeHandler successHandler:(WTCommandSuccessBlock)successHandler errorHandler:(WTCommandErrorBlock)errorHandler cancelHandler:(WTCommandCancelBlock)cancelHandler;
-(instancetype)finalHandler:(WTCommandFinalCallback)finalHandler;
-(instancetype)initChangeStatusCallback:(WTCommandChangeStatusCallback)changeStatusCallback;
-(void)excute:(id) input;
-(void)cancel;

@end
