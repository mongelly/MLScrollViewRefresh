//
//  DefaultDemoComponent.m
//  MLScrollViewRefreshDemo
//
//  Created by MogLu on 31/07/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import "DefaultDemoComponent.h"

@implementation DefaultDemoComponent

-(instancetype)initWithTableView:(UITableView*) tableView
{
    if(self = [super initWithScrollView:tableView])
    {
        tableView.dataSource = self;
        tableView.delegate = self;
    }
    return self;
}

#pragma mark -
#pragma mark UIScrollViewDelegate

/*
 如果需要重写MLRefreshViewComponent中相关的协议，需要优先执行MLRefreshViewComponent中默认的协议实现
 MLRefreshViewComponent当前包含以下协议：
 
 -(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
 -(void)scrollViewDidScroll:(UIScrollView *)scrollView;
 -(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
 
 */

#pragma mark override sample
 -(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    NSLog(@"DefaultDemoComponent scrollViewDidEndDragging");
}


#pragma mark -
#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Select The Cell index of %li",(long)indexPath.row);
}


#pragma mark -
#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor = UIColor.whiteColor;
    
    UILabel *cellLabel = [UILabel new];
    cellLabel.text = [NSString stringWithFormat:@"Cell Index: %li",(long)indexPath.row];
    cellLabel.font = [UIFont systemFontOfSize:13];
    cellLabel.textColor = UIColor.lightGrayColor;
    cellLabel.textAlignment = NSTextAlignmentCenter;
    [cellLabel sizeToFit];
    cellLabel.frame = CGRectMake((tableView.frame.size.width - cellLabel.frame.size.width)/2, (50-cellLabel.frame.size.height)/2, cellLabel.frame.size.width, cellLabel.frame.size.height);
    [cell addSubview:cellLabel];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UIColor.lightGrayColor;
    lineView.frame = CGRectMake(0, cell.frame.size.height-0.5, cell.frame.size.width, 0.5);
    [cell addSubview:lineView];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



@end
