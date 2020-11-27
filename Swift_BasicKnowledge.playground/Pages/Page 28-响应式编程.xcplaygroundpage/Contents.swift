//: [Previous](@previous)

import Foundation

var str = "响应式编程"
/*
 响应式编程(Reactive Programming, 简称RP)
 也是一种编程范式, 于1997年提出，可以简化异步编程，提供更优雅的数据绑定
 一般于函数式融合在一起，所以也会叫做:函数响应式编程(Functional Reactive Programming,简称FRP)
 
 // 比较著名的、成熟的响应式框架
 // ReactiveCocoa
 // 简称RAC，有Objective-C、Swift版本
 
 // ReactiveX
    简称Rx，有众多编程语言的版本, 比如RxJava、Rxkotlin、RxJs、RxCpp、RxGo、RxSwift等等
    
 
 RxSwift(ReactiveX for Swift), ReactiveX的Swift版本
 模块说明
 RxSwift: Rx标准API的Swift实现, 不包括任何iOS的相关的内容
 RxCocoa: 基于RxSwift，给iOS UI控件扩展了很多Rx特性
 
 */





// Observable：负责发送事件(Event)
// Observer: 负责订阅Observable, 监听Observable发送的事件(Event)
public enum Event<Element> {
    case next(Element)
    
    case error(Swift.Error)
    
    case completed
}

/**
 Event有3种
 1. next：携带具体数据
 2. error: 携带错误信息，表明Observable终止，不会再发生事件
 3. completed：表明Obsetvable终止，不会再发生事件
 */

//: [Next](@next)
