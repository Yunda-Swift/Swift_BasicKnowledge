//: [Previous](@previous)

import Foundation

var str = "可选链"


// 可选链(Optional Chaining)
class Car { var price = 0 }
class Dog { var weight = 0 }
class Person {
    var name: String = ""
    var dog : Dog? = Dog()
    var car: Car? = Car()
    func age() -> Int { 18 }
    func eat() { print("Person eat") }
    subscript(index: Int) -> Int {index}
}

var person: Person? = Person()
print(person!)

// 强行解包: 如果结果为空，则表示会失败。
var age1 = person!.age()
print(age1)

// 可选项
var age2 = person?.age()
print(age2 ?? 0)

// 属性
var name = person?.name
print(name as Any)

// 下标
var index = person?[6]
print(index ?? 0)

func getName() -> String {"jack"}
person?.name = getName()
var name1 = person?.name
print(name1 as Any)


/*
 如果可选项为nil,调用方法、下标、属性失败，结果为nil
 如果可选项不为nil,调用方法、下标、属性成功，结果会被包装成可选项
 如果结果本来就是可选项，不会进行再次包装
 */


if let _ = person?.eat {
    print("eat调用成功")
} else {
    print("eat调用失败")
}

var weight = person?.dog?.weight
var price = person?.car?.price


print(weight ?? 0)
print(price ?? 0)


// 多个？可以链接在一起
// 如果链中任何一个节点时nil, 那么整个链就会调用失败




// 可选链
var scores = ["Jack": [86, 82, 84], "Rose": [79, 94, 81]]
scores["Jack"]? [0] = 100
scores["Rose"]? [2] += 10
scores["Kate"]? [0] = 88

print(scores)

var num1: Int? = 5
num1? = 10

print(num1 ?? 0)


var num2: Int? = nil
num2? = 10
print(num2 ?? 0)


var dict: [String: (Int, Int) -> Int] = [
    "sum" : (+),
    "difference" : (-)
]
var result = dict["sum"]?(10, 20)
print(result as Any)





















//: [Next](@next)
