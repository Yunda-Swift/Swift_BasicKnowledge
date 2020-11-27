//: [Previous](@previous)

import Foundation
import UIKit

var str = "面向协议编程"
/*
 面向协议编程(Protocol Oriented Programming, 简称POP)
 是Swift中一种编程范式， Apple于2015年WWDC提出
 在Swift的标准库中，能见到大量POP的影子
 
 同时,Swift也是一门面向对象的编程语言(Object Oriented Programming,简称OOP)
 Swift发开中，OOP和POP是相辅相成的，任何一方并不能取代另一方
 
 POP能弥补OOP一些设计上的不足
 
 */




// 回顾OOP
/*
 OOP的三大特性: 封装、继承、多态
 继承的经典使用场合
 当多个类(比如A、B、C类)具有很多共性时，可以将这些共性抽取到一个父类中(比如D类)，最后A、B、C、类继承D类
 */


/*
 OOP的不足
 但有些问题，使用OOP并不能很好解决，比如
 如何将BVC、DVC的公共方法run抽取出来
 
 
 // 基于OOP想到的一些解决方案
 1.将run方法放到另一个对象A中,然后BVC、DVC拥有对象A属性
 多了一些额外的依赖关系
 
 2.将run方法增加到UIViewController分类中
 UIViewController会越来越臃肿,而且会影响它的其他所有子类
 
 3.将run方法抽取到新的父类，采用多继承? (C++支持多继承)
 会增加程序设计复杂度，产生菱形继承等问题,需要开发者额外解决
 */
class BVC: UIViewController {
    func run() {
        print("run")
    }
}

class DVC: UITableViewController {
    func run() {
        print("run")
    }
}





// POP的解决方案
protocol Runnable {
    func run()
}

extension Runnable {
    func run() {
        print("run")
    }
}

class BVC1: UIViewController, Runnable {}
class BVC2: UITableViewController, Runnable {}




/*
 POP的注意点
 优先考虑创建协议，而不是父类(基类)
 优先考虑值类型(struct、enum),而不是引用类型(class)
 巧用——协议的扩展功能
 不要为了面向协议而使用协议，注意实质不是形式
 */



// 协议的具体应用:没看懂，待补充吧


//: [Next](@next)
