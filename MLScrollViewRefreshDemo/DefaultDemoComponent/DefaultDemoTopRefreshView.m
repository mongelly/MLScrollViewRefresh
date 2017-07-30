//
//  DefaultDemoTopRefreshView.m
//  MLScrollViewRefreshDemo
//
//  Created by MogLu on 31/07/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import "DefaultDemoTopRefreshView.h"

@implementation DefaultDemoTopRefreshView
{
@private CGFloat _activeDistance;
@private UILabel *_titleLabel;
@private UIActivityIndicatorView *_activityView;
}

@synthesize activeDistance = _activeDistance;

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"";
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = UIColor.lightGrayColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.hidden = YES;
        _activeDistance = self.frame.size.height;
        [self addSubview:_titleLabel];
        [self addSubview:_activityView];
    }
    return self;
}

-(void)refreshViewWillDisplay
{
    _titleLabel.text = @"Dragging down and refresh data";
    [self resetTitleLableFrame];
    NSLog(@"DefaultDemoTopRefreshView refreshViewWillDisplay");
}

-(void)refreshViewDidScroll:(CGPoint)contentOffset
{
//    NSLog(@"DefaultDemoTopRefreshView refreshViewDidScroll contentOffset.X:%f contentOffset.Y:%f",contentOffset.x,contentOffset.y);
}

-(void)refreshViewFullyDisplay
{
    _titleLabel.text = @"Release and refresh data";
    [self resetTitleLableFrame];
    NSLog(@"DefaultDemoTopRefreshView refreshViewFullyDisplay");
}

-(void)refreshViewDidEndDDragging
{
    NSLog(@"DefaultDemoTopRefreshView refreshViewDidEndDDragging");
}

-(void)refreshViewActivetyOperation
{
    _titleLabel.text = @"Refresh data....";
    [self resetTitleLableFrame];
    CGFloat activityViewSize = _titleLabel.frame.size.height;
    CGFloat activityViewX = _titleLabel.frame.origin.x - activityViewSize - 5;
    CGFloat activityViewY = _titleLabel.frame.origin.y;
    _activityView.frame = CGRectMake(activityViewX, activityViewY, activityViewSize, activityViewSize);
    [_activityView startAnimating];
    _activityView.hidden = NO;
    NSLog(@"DefaultDemoTopRefreshView refreshViewActivetyOperation");
}

-(void)refreshViewOperationCompleted
{
    _titleLabel.text = @"Refresh completed";
    [self resetTitleLableFrame];
    if(_activityView.animating)
    {
        [_activityView stopAnimating];
        _activityView.hidden = YES;
    }
    NSLog(@"DefaultDemoTopRefreshView refreshViewOperationCompleted");
}

-(void)refreshViewWillHidding
{
    NSLog(@"DefaultDemoTopRefreshView refreshViewWillHidding");
}

-(void)resetTitleLableFrame
{
    [_titleLabel sizeToFit];
    CGFloat titleLabelX = (self.frame.size.width - _titleLabel.frame.size.width)/2;
    CGFloat titleLabelY = (self.frame.size.height - _titleLabel.frame.size.height)/2;
    _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, _titleLabel.frame.size.width, _titleLabel.frame.size.height);
}

@end
