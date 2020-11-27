//
//  ViewController.swift
//  Swift多线程
//
//  Created by 郎烨 on 2020/11/25.
//  Copyright © 2020 郎烨. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Thread.current, "main")
        
        // gcd
        DispatchQueue.global().async {
            print(Thread.current, "async")
            DispatchQueue.main.async {
                print(Thread.current, "mainIn")
            }
        }
        
        // 异步子线程事件
        let item = DispatchWorkItem {
            print(Thread.current, "DispatchWorkItem")
        }
        DispatchQueue.global().async(execute: item)
        
        // 异步延迟执行事件
        let time = DispatchTime.now() + 3
        print(time,"执行时间1",Thread.current)
        DispatchQueue.global().asyncAfter(deadline: time) {
            item.cancel()
            print(time,"执行时间2",Thread.current)
        }
        
        // 多线程的加锁
        // 多线程要保证线程的安全你就必须的加锁
        
    }
    
    // 多线程开发-once
    // dispatch_once在Swift中已被废弃，取而代之
    // 第一种办法: 闭包表达式
    // lazy
    // static
    static var age: Int = {
        // 会放在dispatchd_onece中执行
        print(">>>>>>>>",1)
        return 0
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        print(Self.age)
        print(Self.age)
        print(Self.age)
    }
}

