//
//  ViewController.m
//  MLScrollViewRefreshDemo
//
//  Created by MogLu on 30/07/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import "ViewController.h"
#import "DefaultDemoComponent.h"
#import "DefaultDemoTopRefreshView.h"
#import "DefaultDemoBottomRefreshView.h"

@interface ViewController ()

@end

@implementation ViewController
{
@private UITableView *_demoTableView;
@private DefaultDemoComponent *_demoComponent;
@private DefaultDemoTopRefreshView *_demoTopRefreshView;
@private DefaultDemoBottomRefreshView *_demoBottomRefreshView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _demoTableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 50, self.view.frame.size.width - 100, self.view.frame.size.height - 100)];
    _demoTableView.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    _demoTableView.separatorStyle = UITableViewCellAccessoryNone;

    _demoComponent = [[DefaultDemoComponent alloc] initWithTableView:_demoTableView];
    
    _demoTopRefreshView = [[DefaultDemoTopRefreshView alloc] initWithFrame:CGRectMake(0, 0, _demoTableView.frame.size.width, 50)];
    
    _demoBottomRefreshView = [[DefaultDemoBottomRefreshView alloc] initWithFrame:CGRectMake(0, 0, _demoTableView.frame.size.width, 50)];
    
    _demoComponent.topRefreshView = _demoTopRefreshView;
    _demoComponent.bottomRefreshView = _demoBottomRefreshView;
    
    __weak id weakSelf = self;
    
    _demoComponent.topRefreshViewActivityOperationBegin = ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:5];
            [weakSelf performSelectorOnMainThread:@selector(topRefreshViewOperationComplete) withObject:nil waitUntilDone:NO];
        });
    };
    
    _demoComponent.bottomRefreshViewActivityOperationBegin = ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:5];
            [weakSelf performSelectorOnMainThread:@selector(bottomRefreshViewOperationComplete) withObject:nil waitUntilDone:NO];
        });
    };

    
    [self.view addSubview:_demoTableView];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)topRefreshViewOperationComplete
{
    [_demoComponent topRefreshViewOperationComplete];
}

-(void)bottomRefreshViewOperationComplete
{
    [_demoComponent bottomRefreshViewOperationComplete];
}


@end
