//
//  ViewController.m
//  Rotation
//
//  Created by 杨凡 on 2018/6/3.
//  Copyright © 2018年 byteD. All rights reserved.
//

#import "ViewController.h"
#import "myView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"view loaded successfully.");
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    GLView *myView = [[GLView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    [myView setup];
    [myView inintScene];// set non-changing vals
//    [myView setupVAO];//setup objA
    
    [self.view addSubview:myView];  //add to root view as a subview    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:myView selector:@selector(render)];
    
    
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [displayLink addToRunLoop:loop forMode:NSDefaultRunLoopMode];
    
    //creat 
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
