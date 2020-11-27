//: [Previous](@previous)

import Foundation

var str = "函数式编程"

// A
// Array的常见操作
var arrA = [1, 2, 3, 4]
var arrA1 = arrA.map{ $0 * 2 }
print(arrA1)

var arrA2 = arrA.filter { $0 % 2 == 0 }
print(arrA2)

// 数组相加
var arrA3 = arrA.reduce(0) { $0 + $1 }
print(arrA3)

// 数组元素相加
var arrA4 = arrA.reduce(0, +)
print(arrA4)

func double(_ i: Int) -> Int { i * 2 }
var arrA5 = [1, 2, 3, 4]
print(arrA5.map(double))



// B
var arrB = [1, 2, 3]
// 二级数组
var arrB1 = arrB.map { Array.init(repeating: $0, count: $0) }
print(arrB1)

// 全部整合到一个数组
var arrB2 = arrB.flatMap { Array.init(repeating: $0, count: $0) }
print(arrB2)



// C
var arrC = ["123", "test", "jack", "-30"]
var arrC1 = arrC.map { Int($0) }
print(arrC1)
var arrC2 = arrC.compactMap { Int($0) }
print(arrC2)




// D
var arrD = [1, 2, 4, 3]
print(arrD.map { $0 * 2 })
print(arrD.reduce([]) { $0 + [$1 * 2] })
    
print(arrD.filter { $0 % 2 == 0 })
print(arrD.reduce([]) {$1 % 2 == 0 ? $0 + [$1] : $0})




// E
// lazy的优化
// 用的时候才去调用这个函数
let arrE = [1, 2, 3]
let result = arrE.lazy.map {
    (i: Int) -> Int in
    print("mapping\(i)")
    return i * 2
}

print("begin.....")
print("mapped", result[0])
print("mapped", result[1])
print("mapped", result[2])
print("end....")






// OPtional的map和flatMap1
var numAA1: Int? = 10
var numAA2 = numAA1.map { $0 + 2 }
print(numAA2 ?? 0)


var numAA3: Int? = nil
var numAA4 = numAA3.map { $0 * 2 }
print(numAA4 ?? 0)


var numBB1: Int? = 10
var numBB2 = numBB1.map { Optional.some($0 * 2) }
print(numBB2!!)

var numBB3 = numBB1.flatMap { Optional.some($0 * 2) }
print(numBB3 ?? 0)




var numCC1: Int? = 11
var numCC2 = (numCC1 != nil) ? (numCC1! + 10) : nil
print(numCC2)
var numCC3 = numCC1.map { $0 + 10 }
print(numCC3)
// numCC2 等价于 numCC3


var fmtDD = DateFormatter()
fmtDD.dateFormat = "yyyy-MM-dd"
var strDD: String? = "2011-09-10"
var dateDD1 = strDD != nil ? fmtDD.date(from: strDD!) : nil
print(dateDD1)
var dateDD2 = strDD.flatMap(fmtDD.date)
print(dateDD2)




var scoreEE: Int? = 98
var strDD1 = scoreEE != nil ? "score is \(scoreEE!)" : "No score"
print(strDD1)
var strDD2 = scoreEE.map { "score is \($0)" ?? "No score" }
print(strDD2)






// EE
// Optional的map和flatMap
struct PersonEE {
    var name: String
    var age: Int
}

var items = [
    PersonEE(name: "jack1", age: 21),
    PersonEE(name: "jack2", age: 22),
    PersonEE(name: "jack3", age: 23)
]

func getPerson1(_ name: String) -> PersonEE? {
    let index = items.firstIndex { $0.name == name }
    return index != nil ? items[index!] : nil
}

func getPerson2(_ name: String) -> PersonEE? {
    return items.firstIndex { $0.name == name }.map {items[$0]}
}



// FF
// Optional的map和flatMap
struct PersonFF {
    var name: String
    var age: Int
    init?(_ json: [String : Any]) {
        guard let name = json["name"] as? String,
              let age = json["age"] as? Int else {
                return nil
        }
        self.name = name
        self.age = age
    }
}

var json: Dictionary? = ["name" : "Jack", "age" : 10]
var pFF1 = json != nil ? PersonFF(json!) : nil
var pFF2 = json.flatMap(PersonFF.init)
print(pFF1)
print(pFF2)






// 函数式编程(Funtional Programming)

// 函数式编程(Funtional Programming, 简称FP)是一种编程范式，也就是如何编写程序的方法论
// 主要思想: 把计算过程尽量分解成一系列可复用函数的调用
// 主要特征: 函数是"第一等公民"
// 函数与其他数据类型一样的地位，可以赋值给其他变量，也可以作为函数参数、函数返回值

// 函数式编程最早出现在LISP语言，绝大部分的现代编程语言也对函数式编程做了不同程度的支持，比如
// HasKell、JavaScript、Python、Swift、Kotlin、Scala等


// 函数式编程中几个常用的概念
// Higher-Order Function、 Function Currying
// Functor、Applicative Functor、Monad



// GG
// FP实践-传统写法
// 假设要实现一下功能: [(num + 3) * 5 - 1] % 10 / 2
var numGG = 1
func add(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
func sub(_ v1: Int, _ v2: Int) -> Int { v1 - v2 }
func multiple(_ v1: Int, _ v2: Int) -> Int { v1 * v2 }
func divide(_ v1: Int, _ v2: Int) -> Int { v1 / v2 }
func mod(_ v1: Int, _ v2: Int) -> Int { v1 % v2 }
var numGG1 = divide(mod(sub(multiple(add(numGG, 3), 5), 1), 10), 2)
print("Funtional Programming传统写法", numGG1)




// 函数编程的实践、高阶函数、柯力化的分析























//: [Next](@next)
