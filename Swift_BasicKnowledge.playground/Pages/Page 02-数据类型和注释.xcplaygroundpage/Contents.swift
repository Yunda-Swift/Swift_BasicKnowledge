//: [Previous](@previous)

// 基本数据类型

import Foundation

var str = "Hello, playground"

// 值类型 -> 结构体 -> 结构体可以有属性和方法
print(UInt8.max)

print(UInt16.min)

let bool = true

let string = "凯司机"

// 字符(可存储ASCII字符、Unicode字符)
let character: Character = "🐶"

// 整数
// 十进制
let intDecimal = 17

// 数组
let array = [1, 3, 5, 7, 9]

// 字典
let dictionary = ["age" : 18, "height" : 168, "weight" : 120]

// 强制类型转换
// 整数转换
let int1:UInt16 = 2_000
let int2: UInt8 = 1
let int3 = int1 + UInt16(int2)


// 整数、浮点数转换
let int = 3
let double = 0.14159
let pi = Double(int) + double
let intPi = Int(pi)

// 带类型：不同类型数据不可以直接运算，会报错
// 字面量可以直接相加，因为数字字面量本身没有明确的类型
let result = 3 + 0.1415926


// Swift元祖的使用
let http404Error = (404, "Not Found")
print("The status code is \(http404Error.0)")
print("The status content is \(http404Error.1)")

// 元祖赋值间的一一对应
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")

// 元组赋值忽略
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")

// 元组赋值带角标取值——不实用0、1、2等取值
let http202Status = (statusCode: 200, description: "OK")
print("The status code is \(http202Status.statusCode)")
print("The status content is \(http202Status.description)")




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
 - 类
 - 属性
 - 方法
 ##  汇编分析
 - 变量
 - 常量
 [苹果官方](http://www.apple.com)
 */

//: [下一页](@next)



