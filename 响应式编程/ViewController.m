//
//  ViewController.m
//  响应式编程
//
//  Created by 新闻 on 2017/12/2.
//  Copyright © 2017年 新闻. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@property(nonatomic, strong)Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     KVO底层实现
     1.自定义被监听类的子类!
     2.重写被监听属性的set:方法,在内部恢复父类做法,通知观察者
     3.如何让外界调用自定义子类的方法？修改当前对象的isa指针,指向自定义的子类!
     */
    self.person = [[Person alloc] init];
    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"name=%@",self.person.name);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int i = 0;
    i++;
    self.person.name = [NSString stringWithFormat:@"news-%d",i];
//    self.person->_name = [NSString stringWithFormat:@"news-%d",i];
}


@end
