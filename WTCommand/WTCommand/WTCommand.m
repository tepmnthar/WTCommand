//
//  WTCommand.m
//
//  Created by tepmnthar on 16/7/21.
//  Copyright © 2016年 tepmnthar All rights reserved.
//

#import "WTCommand.h"

@interface WTCommand()
@property (nonatomic)NSUInteger status;
@property (nonatomic,strong)WTCommandConsumeBlock consumeHandler;
@property (nonatomic,strong)WTCommandCancelBlock cancelHandler;
@property (nonatomic,strong)WTCommandSuccessBlock successHandler;
@property (nonatomic,strong)WTCommandErrorBlock errorHandler;
@property (nonatomic,strong)WTCommandErrorBlock finalHandler;
@property (nonatomic,strong)WTCommandChangeStatusCallback changeStatusCallback;
@end

@implementation WTCommand
-(instancetype)initWithConsumeHandler:(WTCommandConsumeBlock)consumeHandler successHandler:(WTCommandSuccessBlock)successHandler errorHandler:(WTCommandErrorBlock)errorHandler{
    self=[super init];
    if (!self) return nil;
    _status=COMMAND_IDLE;  //unused
    _consumeHandler=consumeHandler;
    __weak typeof(self)weakself=self;
    _successHandler=^(id result){
        __strong typeof(self)strongself=weakself;
        strongself.status=COMMAND_SUCCESS;
        successHandler(result);
        strongself.changeStatusCallback(COMMAND_SUCCESS);
        strongself.finalHandler(result);
    };
    _errorHandler=^(id error){
        __strong typeof(self)strongself=weakself;
        strongself.status=COMMAND_ERROR;
        errorHandler(error);
        strongself.changeStatusCallback(COMMAND_ERROR);
        strongself.finalHandler(error);
    };
    _changeStatusCallback=^(CommandStatus status){
      //nothing happen
    };
    _finalHandler=^(id output){
        //nothing happen
    };
    return self;
}
-(instancetype)initWithConsumeHandler:(WTCommandConsumeBlock)consumeHandler  successHandler:(WTCommandSuccessBlock)successHandler errorHandler:(WTCommandErrorBlock)errorHandler cancelHandler:(WTCommandCancelBlock)cancelHandler{
    self=[super init];
    if (!self)return nil;
    _status=COMMAND_IDLE;  //unused
    _consumeHandler=consumeHandler;
    _cancelHandler=cancelHandler;
    __weak typeof(self)weakself=self;
    _successHandler=^(id result){
        __strong typeof(self)strongself=weakself;
        strongself.status=COMMAND_SUCCESS;
        successHandler(result);
        strongself.changeStatusCallback(COMMAND_SUCCESS);
        strongself.finalHandler(result);
    };
    _errorHandler=^(id error){
        __strong typeof(self)strongself=weakself;
        strongself.status=COMMAND_ERROR;
        errorHandler(error);
        strongself.changeStatusCallback(COMMAND_ERROR);
        strongself.finalHandler(error);
    };
    _changeStatusCallback=^(CommandStatus status){
        //nothing happen
    };
    _finalHandler=^(id output){
        //nothing happen
    };
    return self;
}
-(void)excute:(id)input{
    if (_status==COMMAND_PENDING)return;
    _status=COMMAND_PENDING;
    _changeStatusCallback(COMMAND_PENDING);
    _consumeHandler(input);
}
-(void)cancel{
    if (_status!=COMMAND_PENDING) return ;
    if (_cancelHandler){
        _cancelHandler();
    }
    _status=COMMAND_CANCEL;
    _changeStatusCallback(COMMAND_CANCEL);
}
-(instancetype)finalHandler:(WTCommandFinalCallback)finalHandler{
    if (finalHandler){
        _finalHandler=finalHandler;
    }
    return self;
}
-(instancetype)initChangeStatusCallback:(WTCommandChangeStatusCallback)changeStatusCallback{
    if (changeStatusCallback){
        _changeStatusCallback=changeStatusCallback;
    }
    return self;
}

@end
