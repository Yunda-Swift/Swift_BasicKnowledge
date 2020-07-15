//: [Previous](@previous)

import Foundation

var str = "模式匹配"
// 模式(Pattern)
/*
 什么是模式？
 模式是用于匹配的规则，比如switch的case、捕捉错误的catch、if\guard\while\for语句的条件等
 
 Swift中的模式有
 通配符模式(wildcard Pattern)
 标识符模式(Identifier Pattern)
 值绑定模式(Value-Binding Pattern)
 元组模式(Tuple Pattern)
 枚举Case模式(Enumeration Case Pattern)
 可选模式(Optional Pattern)
 类型转换模式(Type-Casting Pattern)
 表达式模式(Expression Pattern)
 */




// 通配符模式(wildcard Pattern)
// _ 匹配任何值
// _? 匹配非nil值
enum Life {
    case human(name: String, age: Int?)
    case animal(name: String, age: Int?)
}

func check(_ life:Life) {
    switch life {
    case .human(let name, _):
        print("human", name)
    case .animal(let name, _?):
        print("animal", name)
    default:
        print("other")
    }
}
// human Rose
check(.human(name: "Rose", age: 20))
check(.human(name: "Jack", age: nil))
check(.animal(name: "Dog", age: 5))
check(.animal(name: "Cat", age: nil))






// 标识符模式(Identifier Pattern)
// 给对应的变量、常量名赋值
var age = 10
let name = "Jack"






// 值绑定模式(Value-Binding pattern)
let point = (3, 2)
switch point {
case let(x, y):
    print("The points is at(\(x),\(y))")
}






// 元组模式(Tuple Pattern)

// 元组对数组元组的匹配
let points = [(0, 0), (1, 0), (2, 0)]
for (x, _) in points {
    print(x)
}


// 元组对多个字符串
let nameA: String? = "jack"
let ageA = 18
let infoA: Any = [1, 2]
switch (nameA, ageA, infoA) {
case (_?, _, _ as String):
    print("case")
default:
    print("default")
}


// 元组对数组
var scores = ["jack" : 98, "rose" : 100, "kate" : 86]
for (name, score) in scores {
    print(name, score)
}








// 枚举Case模式(Enumeration Case Pattern)
// if case语句等价于只有1个case的switch语句
let ageB = 2
// 原来写法
if ageB >= 0 && ageB <= 9 {
    print("[0, 9]")
}

// 枚举Case模式
if case 0...9 = ageB {
    print("[0, 9]")
}

//guard case 0...9 = ageB else {
//
//}
//print("[0, 9]")





switch age {
case 0...9:
    print("[0, 9]")
default:
    break
}

let agesC: [Int?] = [2, 3, nil, 5]
for case nil in agesC {
    print("有nil值")
    break
}

let pointsC = [(1, 0), (2, 1), (3, 0)]
for case let(x, 0) in pointsC {
    print(x)
}






// 可选模式(Optional Pattern)
let ageD: Int? = 42
if case .some(let x) = ageD {
    print(x)
}
if case let x? = ageD {
    print(x)
}

let ages: [Int?] = [nil, 2, 3, nil, 5]
for case let age? in ages {
    print(age)
}
for item in ages {
    if let age = item {
        print(age)
    }
}



func check(_ num: Int?) {
    switch num {
    case 2?:
        print("2")
    case 4?:
        print("4")
    case 6?:
        print("6")
    case _?:
        print("other")
    case _:
        print("nil")
    }
}

check(4)
check(8)
check(nil)




// 类型转换模式(Type-Casting pattern)
let numE: Any = 6
switch numE {
case is Int:
    // 编译器依然认为num是Any类型
    print("is Int", numE)
default:
    break
}


class AnimalE { func eat() { print(type(of: self), "eat") }}
class DogE :AnimalE { func run() { print(type(of: self), "run") }}
class CatE:AnimalE { func jump() { print(type(of: self), "jump") }}
func checkE(_ animal: AnimalE) {
    // 子类和父类的显示关系
    switch animal {
    case let dog as DogE:
        dog.eat()
        dog.run()
    case is CatE:
        animal.eat()
    default: break
    }
}

checkE(DogE())
checkE(CatE())









// F
// 表达式模式(Expression Pattern)
let pointF = (1, 2)
switch pointF {
case (0, 0):
    print("(0, 0) is at the origin.")
case (-2...2, -2...2):
    print("\(pointF.0), \(pointF.1) is near the origin.")
default:
    print("The point is at(\(pointF.0), \(pointF.1))")
}





// F
// 自定义表达式

// 可以通过重载运算符, 自定义表达式模式的匹配规则
// 看不懂有什么用，后面再处理









// G
// 自定义表达式是干嘛用的？？？？？？






























//: [Next](@next)
