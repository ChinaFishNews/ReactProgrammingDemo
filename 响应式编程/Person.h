//
//  Person.h
//  响应式编程
//
//  Created by 新闻 on 2017/12/2.
//  Copyright © 2017年 新闻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {
    @public;
    NSString *_name;
}
@property (nonatomic, copy) NSString *name;

@end
