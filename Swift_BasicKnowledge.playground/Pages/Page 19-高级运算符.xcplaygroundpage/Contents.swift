//: [Previous](@previous)

import Foundation

var str = "高级运算符"
// 溢出运算符(Overflow Operator)
// Swift的 算数运算符出现溢出时会抛出运行时错误
// Swift有一处运算符(&+、&-、&*)，用来支持溢出运算
var min = UInt8.min
print(min &- 1)
// Int8.max = 255

var max = UInt8.max

print(max &+ 1)
// Int8.min = 0

print(max &* 2)
// max &+ max = 254

// UInt8.min = 0 ——> UInt8.max = 255


// 运算符重载(Operator Overload)
// 类、结构体、枚举可以为现有的运算符提供自定义的实现，这个操作叫做:运算符重载
//struct Point {
//    var x: Int, y: Int
//}
//
//func +(p1: Point, p2: Point) -> Point {
//    Point(x: p1.x + p2.x, y: p1.y + p2.y)
//}
//
//let p = Point(x: 10, y: 20) + Point(x: 11, y: 22)
//print(p)


//struct Point {
//    var x: Int, y: Int
//    static func +(p1: Point, p2: Point) -> Point {
//        Point(x: p1.x + p2.x, y: p1.y + p2.y)
//    }
//}
//let p = Point(x: 10, y: 20) + Point(x: 11, y: 22)
//print(p)



// Equatable
// 要想得知2个实例是否等价，一般做法是遵守Equatable协议，重载：==运算符
// 与此同时，等价于重载了 != 运算符
// 告诉别人这个可以进行等号运算符进行计算的
struct Point: Equatable {
    var x: Int, y: Int
}


var p1 = Point(x: 10, y: 20)
var p2 = Point(x: 11, y: 22)
print(p1 == p2)
print(p1 != p2)
// 如果数值是完全一样的，则是相等的

// Swift为以下类型提供默认的Equatable实现
// 没有关联类型的枚举
// 只拥有遵守Equatable协议关联类型的枚举
// 只拥有遵守Equatable协议存储属性的结构体


// 引用类型比较存储的地址值是否相等(是否引用着同一个对象）,使用恒等运算符===、 !==







// Comparable
// score大的比较大，若score相等，age小的比较大
struct Student: Comparable {
    var age: Int
    var score: Int
    init(score: Int, age: Int) {
        self.score = score
        self.age = age
    }
    static func < (lhs: Student, rhs: Student) -> Bool {
        (lhs.score < rhs.score) || (lhs.score == rhs.score && lhs.age > rhs.age)
    }
    static func > (lhs: Student, rhs: Student) -> Bool {
        (lhs.score > rhs.score) || (lhs.score == rhs.score && lhs.age > rhs.age)
    }
    static func <= (lhs: Student, rhs: Student) -> Bool {
        !(lhs > rhs)
    }
    static func >= (lhs: Student, rhs: Student) -> Bool {
        !(lhs < rhs)
    }
}
// 要相比较2个实例的大小，一般做法是:
// 遵守Comparable协议
// 重载相应的运算符
var stu1 = Student(score: 100, age: 20)
var stu2 = Student(score: 98, age: 18)
var stu3 = Student(score: 100, age: 20)
print("___________________________")
print(stu1 > stu2)
print(stu1 >= stu2)
print(stu1 >= stu3)
print(stu1 <= stu3)
print(stu1 > stu2)
print(stu1 >= stu2)






// 自定义运算符(Custom Operator)
// 可以自定义新的运算符: 在全局啊作用域使用operator进行声明
// prefix operator 前缀运算符
// postfix operator 后缀运算符
// infix operator 中级运算符:


// 优先级组
/*
 precedencegroup 优先级组 {
    associativity: 结合性(left\right\none)
    higherThan: 比谁的优先级高
    lowerThan: 比谁的优先级低
    assignment: true代表在可选链操作中拥有跟赋值运算符一样的优先级
 }
 */










//: [Next](@next)
