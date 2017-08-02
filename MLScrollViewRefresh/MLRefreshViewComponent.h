//
//  MLRefreshViewComponent.h
//  MLScrollViewRefreshDemo
//
//  Created by MogLu on 30/07/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLScrollViewRefresh.h"

typedef void(^topRefreshViewActivityOperationBegin)();
typedef void(^bottomRefreshViewActivityOperationBegin)();

@interface MLRefreshViewComponent : NSObject<UIScrollViewDelegate>

-(instancetype)initWithScrollView:(UIScrollView*) scrollView;

#pragma mark -
#pragma mark UIScrollViewDelegate

#pragma mark -
#pragma mark topRefreshView
@property (nonatomic) UIView<MLRefreshViewProtocol> *topRefreshView;
@property (nonatomic,copy) topRefreshViewActivityOperationBegin topRefreshViewActivityOperationBeginBlock;
-(void)topRefreshViewOperationComplete;


#pragma mark -
#pragma mark bottomRefreshView
@property (nonatomic) UIView<MLRefreshViewProtocol> *bottomRefreshView;
@property (nonatomic,copy) bottomRefreshViewActivityOperationBegin bottomRefreshViewActivityOperationBeginBlock;
-(void)bottomRefreshViewOperationComplete;

#pragma mark -
#pragma mark delegate
@property (nonatomic,weak) id<MLRefreshViewDelegate> refresViewdelegate;

#pragma mark -
#pragma mark TODO
//@property (nonatomic) UIView<MLRefreshViewProtocol> *leftRefreshView;
//@property (nonatomic) UIView<MLRefreshViewProtocol> *rightRefreshView;


@end
