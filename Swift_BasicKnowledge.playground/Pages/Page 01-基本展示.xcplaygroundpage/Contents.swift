


// 开发进度指示器:>>>>>>>>>>>>>>>>>>>> ——> 3视/06可选项



import Foundation
import UIKit

print("Hello world")
// Swift中不用编写main函数，Swift将全局首句可执行代码作为程序的入口
// 同行多句代码添加分号;隔开，其他情况可以省略

// 变量类型的使用
var number1 = 11
print(number1)
number1 = 12
print(number1)
number1 = 13
print(number1)

// let只能赋值1次
// let保证只赋值一次, 初次指定类型可以不赋值: 也可以直接赋值不指定类型自行推导

let age: Int    // 间接赋值需要先指定类型，否则会因不知道类型报错
age = 10
print(number1, age)
print("文字的拼接展示效果...\(number1)", age)

// Swift相对于OC而言更加的安全，例如：常量、变量在初始化之前，都不能使用，使用就会直接报错，不是运行报错，安全安全性——OC中则没有
// 学习了汇编代码会有助于理解和学习OC和Swift代码具体做了些什么内容、掌握编程语言的本质

var str = "Hello, playground"
let a = 10
let b = 20
var c = a + b
c += 10
c += 20
let bianyi = c  // let它的值不要求在编译时期确定，但使用之前必须赋值1次, 相当于可以动态的进行赋值



import PlaygroundSupport

// 可以展示单一的view: 1
let view = UIView()
view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
view.backgroundColor = UIColor.red
PlaygroundPage.current.liveView = view

// 可以展示图片: 2
let imageView = UIImageView(image: UIImage(named: "logo"))
PlaygroundPage.current.liveView = imageView

// 可以展示控制器: 3
let vc = UITableViewController()
vc.view.backgroundColor = UIColor.lightGray
PlaygroundPage.current.liveView = vc

// 标识符
// 标识符(比如常量名、变量名、函数名)几乎可以使用任何字符
// 标识符不能以数字开头，不能包含空白字符、制表符、箭头等特殊字符



// 常见数据类型
/*
 值类型(value type): 枚举(enum) Optional
                    结构体(struct): Bool、Int、Float、Double、Character
                                 : String、 Array、 Dictionary、Set
 
 引用类型(reference type) 类: class
 
 整数类型: Int8, Int16, Int32, Int64, UInt8、UInt16、UInt32、UInt64
 
 
 // 在32bit平台,Int等价于Int32，Int等价于64
 // 整数的最值: UInt8.max、Int16.min
 // 定义成结构体可以直接带一些属性
 // 一般情况下，都是直接使用Int即可
 
 
 // 浮点类型: Float,32位，精度只有6位； Double，64位，精度至少15位
 
 
 
 */


// 用结构体数据类型不一定就大，不一定占用内存就大
// 基本数据类型不一定就比结构体小，Swift中有自己的优化



//: [Next](@next)

// 单行注释

/*
 1
 /* 多行注释的嵌套*/
 2
 */

//: #   一级标题:——单行markup的用法

/*:
 #   一级标题—-多行markup的用法：冒号下面开始写
 ##  二级标题
 ### 三级标题
 #   学习Swift
 ##  基础变量
 - 变量
 - 常量
 ##  面向对象
 1.  类
 2.  属性
 3.  方法
 ##  汇编分析
 - 变量
 - 常量
 [苹果官方](http://www.apple.com)
 */


//: [下一页](@next)
