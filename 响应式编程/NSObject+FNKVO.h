//
//  NSObject+FNKVO.h
//  响应式编程
//
//  Created by 新闻 on 2017/12/24.
//  Copyright © 2017年 新闻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FNKVO)

- (void)fn_addObserver:(NSObject *_Nullable)observer
            forKeyPath:(NSString *_Nullable)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(nullable void *)context;

@end
