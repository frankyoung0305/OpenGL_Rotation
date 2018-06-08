//
//  main.m
//  Rotation
//
//  Created by 杨凡 on 2018/6/3.
//  Copyright © 2018年 byteD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSLog(@"main fuc is running.");

    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        //后两个参数分别表示程序的主要类(principal class)和代理类(delegate class)。如果主要类(principal class)为nil，将从Info.plist中获取，如果Info.plist中不存在对应的key，则默认为UIApplication；如果代理类(delegate class)将在新建工程时创建。
        // 根据UIApplicationMain函数，程序将进入AppDelegate.m，这个文件是xcode新建工程时自动生成的。下面看一下AppDelegate.m文件，这个关乎着应用程序的生命周期。
    }
}
