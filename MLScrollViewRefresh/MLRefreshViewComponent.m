//
//  MLRefreshViewComponent.m
//  MLScrollViewRefreshDemo
//
//  Created by MogLu on 30/07/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import "MLRefreshViewComponent.h"

@implementation MLRefreshViewComponent
{
@private UIScrollView *_scrollView;
@private UIView<MLRefreshViewProtocol> *_topRefreshView;
@private UIView<MLRefreshViewProtocol> *_bottomRefreshView;
    
@private MLRefreshViewStatus _topRefreshViewStatus;
@private MLRefreshViewStatus _bottomRefreshViewStatus;
}

#pragma mark -
#pragma mark init
-(instancetype)initWithScrollView:(UIScrollView*) scrollView
{
    if(self = [super init])
    {
        _scrollView = scrollView;
        _scrollView.delegate = self;
        
        _topRefreshView = [[UIView<MLRefreshViewProtocol> alloc] init];
        _topRefreshView.hidden = YES;
        _topRefreshViewStatus = MLRefreshViewStatusHidding;
        
        
        _bottomRefreshView = [[UIView<MLRefreshViewProtocol> alloc] init];
        _bottomRefreshView.hidden = YES;
        _bottomRefreshViewStatus = MLRefreshViewStatusHidding;
    }
    return self;
}

#pragma mark -
#pragma mark properties

-(UIView<MLRefreshViewProtocol>*)topRefreshView
{
    return _topRefreshView;
}

-(void)setTopRefreshView:(UIView<MLRefreshViewProtocol> *)topRefreshView
{
    if(_topRefreshView != nil && _topRefreshView != topRefreshView)
    {
        [_topRefreshView removeFromSuperview];
    }
    _topRefreshView = topRefreshView;
    _topRefreshView.frame = CGRectMake(0, -_topRefreshView.frame.size.height, _scrollView.frame.size.width, _topRefreshView.frame.size.height);
    _topRefreshView.hidden = YES;
    _topRefreshViewStatus = MLRefreshViewStatusHidding;
    [_scrollView insertSubview:_topRefreshView atIndex:0];
}

-(UIView<MLRefreshViewProtocol>*)bottomRefreshView
{
    return _bottomRefreshView;
}

-(void)setBottomRefreshView:(UIView<MLRefreshViewProtocol> *)bottomRefreshView
{
    if(_bottomRefreshView != nil && _bottomRefreshView != bottomRefreshView)
    {
        [_bottomRefreshView removeFromSuperview];
    }
    _bottomRefreshView = bottomRefreshView;
    _bottomRefreshView.frame = CGRectMake(0, _scrollView.frame.size.height, _scrollView.frame.size.width, _bottomRefreshView.frame.size.height);
    _bottomRefreshView.hidden = YES;
    _bottomRefreshViewStatus = MLRefreshViewStatusHidding;
    [_scrollView insertSubview:_bottomRefreshView atIndex:0];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self topRefreshViewDidScrollHandle:scrollView.contentOffset];
    [self bottomRefreshViewDidScrollHandle:scrollView.contentOffset];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self topRefreshViewDidEndDraggingHandle:scrollView.contentOffset];
    [self bottomRefreshViewDidEndDraggingHandle:scrollView.contentOffset];
}

#pragma mark -
#pragma mark topRefreshViewHandleLogic

-(void)topRefreshViewDidScrollHandle:(CGPoint) scrollOffset
{
    if(_topRefreshViewStatus == MLRefreshViewStatusActiving || _bottomRefreshViewStatus == MLRefreshViewStatusActiving)
    {
        return;
    }
    CGFloat scrollOffsetY = -scrollOffset.y;
    //scrollOffsetY <= 0时_topRefreshView为隐藏状态
    if(scrollOffsetY<=0)
    {
        if(_topRefreshViewStatus != MLRefreshViewStatusHidding)
        {
            _topRefreshViewStatus = MLRefreshViewStatusHidding;
            if([_topRefreshView respondsToSelector:@selector(refreshViewWillHidding)])
            {
                [_topRefreshView refreshViewWillHidding];
                if(_refresViewdelegate != nil && [_refresViewdelegate respondsToSelector:@selector(refreshViewWillHidding:andViewType:)])
                {
                    [_refresViewdelegate refreshViewWillHidding:_topRefreshView andViewType:MLRefreshViewTypeTop];
                }
            }
        }
    }
    else //scrollOffsetY <= 0时_topRefreshView将会被滑出
    {
        _topRefreshView.frame = CGRectMake(0, -_topRefreshView.frame.size.height, _topRefreshView.frame.size.width, _topRefreshView.frame.size.height);
        if(_topRefreshViewStatus == MLRefreshViewStatusHidding)
        {
            //topRefreshViewStatus == MLRefreshViewStatusHidding时，触发refreshViewWillDisplay,并将_topRefreshViewStatus设为为MLRefreshViewStatusScrolling
            _topRefreshViewStatus = MLRefreshViewStatusScrolling;
            _topRefreshView.hidden = NO;
            if([_topRefreshView respondsToSelector:@selector(refreshViewWillDisplay)])
            {
                [_topRefreshView refreshViewWillDisplay];
                if(_refresViewdelegate != nil && [_refresViewdelegate respondsToSelector:@selector(refreshViewWillDisplay:andViewType:)])
                {
                    [_refresViewdelegate refreshViewWillDisplay:_topRefreshView andViewType:MLRefreshViewTypeTop];
                }
            }
        }
        
        if([_topRefreshView respondsToSelector:@selector(refreshViewDidScroll:)])
        {
            [_topRefreshView refreshViewDidScroll:CGPointMake(scrollOffset.x, scrollOffsetY)];
            if(_refresViewdelegate != nil && [_refresViewdelegate respondsToSelector:@selector(refreshViewDidScroll:andView:andViewType:)])
            {
                [_refresViewdelegate refreshViewDidScroll:CGPointMake(scrollOffset.x, scrollOffsetY) andView:_topRefreshView andViewType:MLRefreshViewTypeTop];
            }
        }
        
        //scrollOffsetY 滑动距离超过topRefreshView高度时执行refreshViewFullyDisplay，并将topRefreshViewStatus置为MLRefreshViewStatusFullyShow
        if(_topRefreshView.frame.size.height <= scrollOffsetY)
        {
            if(_topRefreshViewStatus != MLRefreshViewStatusFullyShow &&[_topRefreshView respondsToSelector:@selector(refreshViewFullyDisplay)])
            {
                _topRefreshViewStatus = MLRefreshViewStatusFullyShow;
                [_topRefreshView refreshViewFullyDisplay];
                if(_refresViewdelegate != nil && [_refresViewdelegate respondsToSelector:@selector(refreshViewFullyDisplay:andViewType:)])
                {
                    [_refresViewdelegate refreshViewFullyDisplay:_topRefreshView andViewType:MLRefreshViewTypeTop];
                }
            }
        }
        else
        {
            if(_topRefreshViewStatus != MLRefreshViewStatusFullyShow)
            {
                _topRefreshViewStatus = MLRefreshViewStatusScrolling;
            }
        }
    }
}

-(void)topRefreshViewDidEndDraggingHandle:(CGPoint)endScrollOffset
{
    CGFloat endScrollOffsetY = -endScrollOffset.y;
    //EndDragging时endScrollOffsetY>0才执行后续操作
    if(endScrollOffsetY>0)
    {
        if([_topRefreshView respondsToSelector:@selector(refreshViewDidEndDDragging)])
        {
            [_topRefreshView refreshViewDidEndDDragging];
            if(_refresViewdelegate != nil && [_refresViewdelegate respondsToSelector:@selector(refreshViewDidEndDDragging:andViewType:)])
            {
                [_refresViewdelegate refreshViewDidEndDDragging:_topRefreshView andViewType:MLRefreshViewTypeTop];
            }
        }
        
        //获取激活的滑动距离，默认为topRefreshView的高度，若topRefreshView实现了activeDistance这根据activeDistance获取
        CGFloat activeDistance = _topRefreshView.frame.size.height;
        if([_topRefreshView respondsToSelector:@selector(activeDistance)] && [_topRefreshView activeDistance]>0)
        {
            activeDistance = [_topRefreshView activeDistance];
        }
        
        //如果滑动距离大于等于激活距离则执行操作
        if(endScrollOffsetY>=activeDistance)
        {
            _topRefreshViewStatus = MLRefreshViewStatusActiving;
            //偏移ScrollView，保留topRefreshView显示的位置
            [UIView animateWithDuration:0.5 animations:^{
                _scrollView.contentInset = UIEdgeInsetsMake(_topRefreshView.frame.size.height, 0, 0, 0);
            }];
            
            if([_topRefreshView respondsToSelector:@selector(refreshViewActivetyOperation)])
            {
                [_topRefreshView refreshViewActivetyOperation];
                if(_refresViewdelegate != nil && [_refresViewdelegate respondsToSelector:@selector(refreshViewActivetyOperation:andViewType:)])
                {
                    [_refresViewdelegate refreshViewActivetyOperation:_topRefreshView andViewType:MLRefreshViewTypeTop];
                }
            }
            
            if(self.topRefreshViewActivityOperationBeginBlock != nil)
            {
                self.topRefreshViewActivityOperationBeginBlock();
            }
            else //如果topRefreshViewActivityOperationBegin未指定，则直接执行topRefreshViewOperationComplete
            {
                [self topRefreshViewOperationComplete];
            }
        }
    }
}

-(void)topRefreshViewOperationComplete
{
    if(_topRefreshViewStatus == MLRefreshViewStatusActiving)
    {
        if([_topRefreshView respondsToSelector:@selector(refreshViewOperationCompleted)])
        {
            [_topRefreshView refreshViewOperationCompleted];
            if(_refresViewdelegate != nil && [_refresViewdelegate respondsToSelector:@selector(refreshViewOperationCompleted:andViewType:)])
            {
                [_refresViewdelegate refreshViewOperationCompleted:_topRefreshView andViewType:MLRefreshViewTypeTop];
            }
        }
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            _topRefreshViewStatus = MLRefreshViewStatusHidding;
        }];
    }
}

#pragma mark -
#pragma mark bottomRefreshViewHandleLogic

-(void)bottomRefreshViewDidScrollHandle:(CGPoint) scrollOffset
{
    if(_topRefreshViewStatus == MLRefreshViewStatusActiving || _bottomRefreshViewStatus == MLRefreshViewStatusActiving)
    {
        return;
    }
    CGFloat endScrollOffsetY = 0;
    if(scrollOffset.y>0)
    {
        //计算bottomRefreshView相对滑动距离
        if(_scrollView.contentSize.height <= _scrollView.frame.size.height)
        {
            endScrollOffsetY = scrollOffset.y;
        }
        else
        {
            endScrollOffsetY = scrollOffset.y + _scrollView.frame.size.height - _scrollView.contentSize.height;
        }
        
        if(endScrollOffsetY<=0)
        {
            if(_bottomRefreshViewStatus != MLRefreshViewStatusHidding)
            {
                _bottomRefreshViewStatus = MLRefreshViewStatusHidding;
                if([_bottomRefreshView respondsToSelector:@selector(refreshViewWillHidding)])
                {
                    [_bottomRefreshView refreshViewWillHidding];
                    if(_refresViewdelegate != nil && [_refresViewdelegate respondsToSelector:@selector(refreshViewWillHidding:andViewType:)])
                    {
                        [_refresViewdelegate refreshViewWillHidding:_bottomRefreshView andViewType:MLRefreshViewTypeBottom];
                    }
                }
            }
        }
        else
        {
            _bottomRefreshView.frame = CGRectMake(0, _scrollView.contentSize.height <= _scrollView.frame.size.height?_scrollView.frame.size.height:_scrollView.contentSize.height, _bottomRefreshView.frame.size.width, _bottomRefreshView.frame.size.height);
            if(_bottomRefreshViewStatus == MLRefreshViewStatusHidding)
            {
                //bottomRefreshViewStatus == MLRefreshViewStatusHidding时，触发refreshViewWillDisplay,并将bottomRefreshViewStatus设为为MLRefreshViewStatusScrolling
                _bottomRefreshViewStatus = MLRefreshViewStatusScrolling;
                _bottomRefreshView.hidden = NO;
                if([_bottomRefreshView respondsToSelector:@selector(refreshViewWillDisplay)])
                {
                    [_bottomRefreshView refreshViewWillDisplay];
                    if(_refresViewdelegate != nil && [_refresViewdelegate respondsToSelector:@selector(refreshViewWillDisplay:andViewType:)])
                    {
                        [_refresViewdelegate refreshViewWillDisplay:_bottomRefreshView andViewType:MLRefreshViewTypeBottom];
                    }
                }
            }
            
            if(_bottomRefreshView.frame.size.height <= endScrollOffsetY)
            {
                if(_bottomRefreshViewStatus != MLRefreshViewStatusFullyShow && [_bottomRefreshView respondsToSelector:@selector(refreshViewFullyDisplay)])
                {
                    _bottomRefreshViewStatus = MLRefreshViewStatusFullyShow;
                    [_bottomRefreshView refreshViewFullyDisplay];
                    if(_refresViewdelegate != nil && [_refresViewdelegate respondsToSelector:@selector(refreshViewFullyDisplay:andViewType:)])
                    {
                        [_refresViewdelegate refreshViewFullyDisplay:_bottomRefreshView andViewType:MLRefreshViewTypeBottom];
                    }
                }
                
                if([_bottomRefreshView respondsToSelector:@selector(refreshViewDidScroll:)])
                {
                    [_bottomRefreshView refreshViewDidScroll:CGPointMake(scrollOffset.x, endScrollOffsetY)];
                    if(_refresViewdelegate != nil && [_refresViewdelegate respondsToSelector:@selector(refreshViewDidScroll:andView:andViewType:)])
                    {
                        [_refresViewdelegate refreshViewDidScroll:CGPointMake(scrollOffset.x, endScrollOffsetY) andView:_bottomRefreshView andViewType:MLRefreshViewTypeBottom];
                    }
                }
                
            }
            else
            {
                if(_bottomRefreshViewStatus != MLRefreshViewStatusFullyShow)
                {
                    _bottomRefreshViewStatus = MLRefreshViewStatusScrolling;
                }
            }
        }
    }
}

-(void)bottomRefreshViewDidEndDraggingHandle:(CGPoint)scrollOffset
{
    if(_topRefreshViewStatus == MLRefreshViewStatusActiving || _bottomRefreshViewStatus == MLRefreshViewStatusActiving)
    {
        return;
    }
    CGFloat endScrollOffsetY = 0;
    //计算bottomRefreshView相对滑动距离
    if(_scrollView.contentSize.height <= _scrollView.frame.size.height)
    {
        endScrollOffsetY = scrollOffset.y;
    }
    else
    {
        endScrollOffsetY = scrollOffset.y + _scrollView.frame.size.height - _scrollView.contentSize.height;
    }
    //EndDragging时endScrollOffsetY>0才执行后续操作
    if(endScrollOffsetY>0)
    {
        if([_bottomRefreshView respondsToSelector:@selector(refreshViewDidEndDDragging)])
        {
            [_bottomRefreshView refreshViewDidEndDDragging];
            if(_bottomRefreshView != nil && [_bottomRefreshView respondsToSelector:@selector(refreshViewDidScroll:andView:andViewType:)])
            {
                [_refresViewdelegate refreshViewDidScroll:CGPointMake(scrollOffset.x, endScrollOffsetY) andView:_bottomRefreshView andViewType:MLRefreshViewTypeBottom];
            }
        }
        //获取激活的滑动距离，默认为bottomRefreshView的高度，若bottomRefreshView实现了activeDistance这根据activeDistance获取
        CGFloat activeDistance = _topRefreshView.frame.size.height;
        if([_bottomRefreshView respondsToSelector:@selector(activeDistance)] && [_bottomRefreshView activeDistance]>0)
        {
            activeDistance = [_bottomRefreshView activeDistance];
        }
        
        if(endScrollOffsetY>=activeDistance)
        {
            _bottomRefreshViewStatus = MLRefreshViewStatusActiving;
            if(_scrollView.contentSize.height <= _scrollView.frame.size.height)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    _scrollView.contentInset = UIEdgeInsetsMake(-_bottomRefreshView.frame.size.height, 0, 0, 0);
                }];
            }
            else
            {
                [UIView animateWithDuration:0.5 animations:^{
                    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, _bottomRefreshView.frame.size.height, 0);
                }];
            }
            
            if([_bottomRefreshView respondsToSelector:@selector(refreshViewActivetyOperation)])
            {
                [_bottomRefreshView refreshViewActivetyOperation];
                if(_bottomRefreshView != nil && [_bottomRefreshView respondsToSelector:@selector(refreshViewActivetyOperation:andViewType:)])
                {
                    [_refresViewdelegate refreshViewActivetyOperation:_bottomRefreshView andViewType:MLRefreshViewTypeBottom];
                }
            }
            
            if(self.bottomRefreshViewActivityOperationBeginBlock != nil)
            {
                self.bottomRefreshViewActivityOperationBeginBlock();
            }
            else //如果bottomRefreshViewActivityOperationBegin未指定，则直接执行bottomRefreshViewOperationComplete
            {
                [self bottomRefreshViewOperationComplete];
            }
        }
    }
}

-(void)bottomRefreshViewOperationComplete
{
    if(_bottomRefreshViewStatus == MLRefreshViewStatusActiving)
    {
        if([_bottomRefreshView respondsToSelector:@selector(refreshViewOperationCompleted)])
        {
            [_bottomRefreshView refreshViewOperationCompleted];
            if(_bottomRefreshView != nil && [_bottomRefreshView respondsToSelector:@selector(refreshViewOperationCompleted:andViewType:)])
            {
                [_refresViewdelegate refreshViewOperationCompleted:_bottomRefreshView andViewType:MLRefreshViewTypeBottom];
            }
        }
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            _bottomRefreshViewStatus = MLRefreshViewStatusHidding;
        }];
    }
}

@end
