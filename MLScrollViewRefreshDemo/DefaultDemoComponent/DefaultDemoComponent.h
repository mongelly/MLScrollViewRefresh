//
//  DefaultDemoComponent.h
//  MLScrollViewRefreshDemo
//
//  Created by MogLu on 31/07/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLRefreshViewComponent.h"

@interface DefaultDemoComponent : MLRefreshViewComponent<UITableViewDataSource,UITableViewDelegate>

-(instancetype)initWithTableView:(UITableView*) tableView;

@end
