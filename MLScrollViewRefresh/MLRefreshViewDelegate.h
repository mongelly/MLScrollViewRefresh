//
//  MLRefreshViewDelegate.h
//  MLScrollViewRefreshDemo
//
//  Created by MogLu on 02/08/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLRefreshViewEnum.h"

@protocol MLRefreshViewDelegate <NSObject>

@optional

-(void)refreshViewWillDisplay:(UIView*) view andViewType:(MLRefreshViewType) viewtype;

-(void)refreshViewDidScroll:(CGPoint)contentOffset andView:(UIView*) view andViewType:(MLRefreshViewType) viewtype;

-(void)refreshViewFullyDisplay:(UIView*) view andViewType:(MLRefreshViewType) viewtype;

-(void)refreshViewDidEndDDragging:(UIView*) view andViewType:(MLRefreshViewType) viewtype;

-(void)refreshViewActivetyOperation:(UIView*) view andViewType:(MLRefreshViewType) viewtype;

-(void)refreshViewOperationCompleted:(UIView*) view andViewType:(MLRefreshViewType) viewtype;

-(void)refreshViewWillHidding:(UIView*) view andViewType:(MLRefreshViewType) viewtype;

@end
