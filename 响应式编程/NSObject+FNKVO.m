//
//  NSObject+FNKVO.m
//  响应式编程
//
//  Created by 新闻 on 2017/12/24.
//  Copyright © 2017年 新闻. All rights reserved.
//

#import "NSObject+FNKVO.h"
#import <objc/message.h>

@implementation NSObject (FNKVO)

// self: 被观察者(Person)
// observer: 观察者
- (void)fn_addObserver:(NSObject *_Nullable)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(nullable void *)context {
    
    /*
     1.自定义子类
     2.重写setName,在方法中,调用super的,通知观察者!
     3.修改当前对象的isa指针!!指向自定义的子类!!
     */
    // 动态的生成一个类,获取类名
    NSString * oldClassName = NSStringFromClass([self class]);
    NSString * newClassName =[@"fnKVO_" stringByAppendingString:oldClassName];
    const char * newName = [newClassName UTF8String];
    // 创建一个类的Class
    Class MyClass = objc_allocateClassPair([self class], newName, 0);
    // 注册类
    objc_registerClassPair(MyClass);
    // 添加set方法
    class_addMethod(MyClass, @selector(setName:), (IMP)setName, "v@:@");
    // 修改isa指针
    object_setClass(self, MyClass);
    // 保存观察者对象
    objc_setAssociatedObject(self, @"objc", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 1.调用super的set方法
 2.通知外界!
 */
void setName(id self,SEL _cmd,NSString * newName) {
    // 保存子类类型
    id class = [self class];
    // 改变self的isa指针
    object_setClass(self, class_getSuperclass(class));
    // 调用父类的set方法
    objc_msgSend(self, @selector(setName:),newName);
    // 拿到观察者
    id objc = objc_getAssociatedObject(self, @"objc");
    // 通知观察者
    objc_msgSend(objc, @selector(observeValueForKeyPath:ofObject:change:context:),self,@"name",nil,nil);
    // 改回子类类型
    object_setClass(self, class);
}

@end
