//
//  MLRefreshViewEnum.h
//  MLScrollViewRefreshDemo
//
//  Created by MogLu on 02/08/2017.
//  Copyright © 2017 Mog Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,MLRefreshViewStatus) {
    MLRefreshViewStatusHidding = 0,
    MLRefreshViewStatusScrolling = 1,
    MLRefreshViewStatusFullyShow = 2,
    MLRefreshViewStatusActiving = 3
};

typedef NS_ENUM(NSInteger,MLRefreshViewType)
{
    MLRefreshViewTypeTop = 0,
    MLRefreshViewTypeBottom = 1
};
