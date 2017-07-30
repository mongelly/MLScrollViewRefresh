//
//  MLRefreshViewComponent.h
//  MLScrollViewRefreshDemo
//
//  Created by MogLu on 30/07/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLRefreshViewProtocol.h"

typedef NS_ENUM(NSInteger,MLRefreshViewStatus) {
    MLRefreshViewStatusHidding = 0,
    MLRefreshViewStatusScrolling = 1,
    MLRefreshViewStatusFullyShow = 2,
    MLRefreshViewStatusActiving = 3
};

@interface MLRefreshViewComponent : NSObject<UIScrollViewDelegate>

-(instancetype)initWithScrollView:(UIScrollView*) scrollView;

#pragma mark -
#pragma mark UIScrollViewDelegate

#pragma mark -
#pragma mark topRefreshView
@property (nonatomic) UIView<MLRefreshViewProtocol> *topRefreshView;
@property (nonatomic,copy) void(^topRefreshViewActivityOperationBegin)();
-(void)topRefreshViewOperationComplete;


#pragma mark -
#pragma mark bottomRefreshView
@property (nonatomic) UIView<MLRefreshViewProtocol> *bottomRefreshView;
@property (nonatomic,copy) void(^bottomRefreshViewActivityOperationBegin)();
-(void)bottomRefreshViewOperationComplete;


#pragma mark -
#pragma mark TODO
//@property (nonatomic) UIView<MLRefreshViewProtocol> *leftRefreshView;
//@property (nonatomic) UIView<MLRefreshViewProtocol> *rightRefreshView;


@end
