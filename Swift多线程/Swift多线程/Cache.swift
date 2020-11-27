//
//  Cache.swift
//  Swift多线程
//
//  Created by 郎烨 on 2020/11/25.
//  Copyright © 2020 郎烨. All rights reserved.
//

import Foundation

public class Cache {
    private static var data = [String: Any]()
    // 同时只能有一条线程访问
//    private static var lock = DispatchSemaphore(value: 1)
    
    
    // 递归调用会产生死锁
//    private static var lock = NSLock()
    
    // 递归锁
    private static var lock = NSRecursiveLock()
    
    
    public static func get(_ key: String) -> Any? {
        data[key]
    }
    
    public static func set(_ key: String, _ value: Any) {
//        lock.wait()
//        defer { lock.signal()}
        
        lock.lock()
        defer { lock.unlock()}
        data[key] = value
    }
}
