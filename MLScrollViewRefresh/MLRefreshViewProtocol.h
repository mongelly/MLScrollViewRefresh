//
//  MLRefreshViewProtocol.h
//  MLScrollViewRefreshDemo
//
//  Created by MogLu on 30/07/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MLRefreshViewProtocol <NSObject>

@optional

@property (nonatomic) CGFloat activeDistance;

-(void)refreshViewWillDisplay;

-(void)refreshViewDidScroll:(CGPoint)contentOffset;

-(void)refreshViewFullyDisplay;

-(void)refreshViewDidEndDDragging;

-(void)refreshViewActivetyOperation;

-(void)refreshViewOperationCompleted;

-(void)refreshViewWillHidding;

@end
