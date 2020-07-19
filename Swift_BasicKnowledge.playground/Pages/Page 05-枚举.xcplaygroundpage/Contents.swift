//: [Previous](@previous)

import Foundation

// 枚举的基本用法
enum Direction {
    case north
    case south
    case east
    case west
}
// 同上等价写法
enum DirectionSecond {
    case north, south, east, west
}

var dir = Direction.south
dir = Direction.north
dir = .west
print(dir)

switch dir {
case .north:
    print("north")
case .west:
    print("west")
case .east:
    print("east")
case .south:
    print("south")
}


// 关联值(Associated Values)
// 有时将枚举的成员值跟其他类型的值关联存储在一起，会非常有用
enum Score {
    case points(Int)
    case grade(Character)
}
var score = Score.points(96)
score = .grade("A")

switch score {
case let .points(i):
    print(i, "points")
case let .grade(i):
    print(i, "grade")
}

enum Date {
    case digit(year: Int, month: Int, day: Int)
    case string(String)
}

// 注意此处的两种写法
var date = Date.digit(year: 2020, month: 7, day: 6)
date = .string("KSJ 2020年7月6日")

// case单句的结束需要加":"
switch date {
case .digit(let year, let month, let day):
    print(year, month, day)
case let .string(value):
    print(value)
}
// 总结：必要时let也可以改成var


// 关联值举例
enum Password {
    case number(Int, Int, Int, Int)
    case gesture(String)
}

var pwd = Password.number(3, 5, 7, 8)
pwd = .gesture("2469")

switch pwd {
case let .number(n1, n2, n3, n4):
    print("number is", n1, n2, n3, n4)
case let .gesture(string):
    print("gesture is \(string)")
}



// 原始值(Raw Values)——RawValue的默认值
// 枚举成员变量可以使用相同类型的默认值预先对应这个默认值叫做：原始值
// 泛型枚举
// 原始值类型
enum PokeSuit : Character {
    case spade = "♠️"
    case heart = "♥️"
    case diamod = "♦️"
    case club = "♣️"
}

var suit = PokeSuit.spade
print(suit)
print(suit.rawValue)
print(PokeSuit.diamod.rawValue)


// 枚举的默认值赋值用的是"等=号"
enum Grade : String {
    case perfect = "A"
    case great = "B"
    case good = "C"
    case bad = "D"
}

print(Grade.perfect.rawValue)
print(Grade.great.rawValue)
print(Grade.good.rawValue)
print(Grade.bad.rawValue)
// 注意⚠️：原始值不占用枚举变量的内存



 
// 隐式原始值(Implicitly Assigned Raw Values)
// 如果枚举的原始值类型是  Int 、 String会自动分配原始值
// String类型的原始值是case的自身
enum DirectionA : String {
    case north = "north"
    case south = "south"
    case east = "east"
    case west = "west"
}

// 同上等价于
enum DirectionB : String {
    case north, south, east, west
}

print(DirectionA.north.rawValue)
print(DirectionB.north.rawValue);


// Int类型的枚举
// 默认值按顺序排列
enum SeasonA : Int {
    case spring, summer, autumn, winter
}

enum SeasonB : Int {
    case spring = 1, summer, autumn = 4, winter
}

print(SeasonA.spring.rawValue) // 0
print(SeasonA.summer.rawValue) // 1
print(SeasonA.autumn.rawValue) // 2
print(SeasonA.winter.rawValue) // 3
print("————————————————————")
print(SeasonB.spring.rawValue) // 1
print(SeasonB.summer.rawValue) // 2
print(SeasonB.autumn.rawValue) // 4
print(SeasonB.winter.rawValue) // 5




// 递归枚举(Recursive Enumeration)
// 必须添加 indirect字段
indirect enum ArithExpr {
    case number(Int)
    case sum(ArithExpr, ArithExpr)
    case difference(ArithExpr, ArithExpr)
}
// ⚠️: indirect字段添加到开头或者添加到具体case前面
enum ArithExprB {
    case number(Int)
    indirect case sum(ArithExprB, ArithExprB)
    indirect case difference(ArithExprB, ArithExprB)
}

let five = ArithExprB.number(5)
print(five)
let four = ArithExprB.number(4)
print(four)
let two = ArithExprB.number(2)
print(two)
let sum = ArithExprB.sum(five, four)
print(sum)
let difference = ArithExprB.difference(sum, two)
print(difference)




func calculate(_ expr: ArithExprB) -> Int {
    switch expr {
    case let .number(value):
        return value
    case let .sum(left, right):
        return calculate(left) + calculate(right)
    case let .difference(left, right):
        return calculate(left) - calculate(right)
    }
}

calculate(difference)
print(calculate(difference))
// 5 + 4 - 2 = 7





// MemoryLayout
// 可以使用MemoryLayout获取数据类型占用的内存大小
// Swift类大些开头，case：小写开头
enum PasswordA {
    case number(Int, Int, Int, Int)
    case other
}
MemoryLayout<PasswordA>.stride
// 40, 分配占用的空间大小
MemoryLayout<PasswordA>.size
// 33 实际用到的空间大小
MemoryLayout<PasswordA>.alignment
// 8 对齐参数
// 等价

var pwdA = PasswordA.number(9, 8, 6, 4)
pwdA = .other
MemoryLayout.stride(ofValue: pwdA)
MemoryLayout.size(ofValue: pwdA)
MemoryLayout.alignment(ofValue: pwdA)
// 等价
print(MemoryLayout.stride(ofValue: pwdA))
print(MemoryLayout.size(ofValue: pwdA))
print(MemoryLayout.alignment(ofValue: pwdA))



enum SeasonABD : Int {
    case spring, summer, autumn, winter
}
// 只给一个字节就行
var s = SeasonABD.spring

 
MemoryLayout<SeasonABD>.stride

MemoryLayout<SeasonABD>.size

MemoryLayout<SeasonABD>.alignment



// 思考题——关于枚举的内存——视频中继续学习吧




//: [Next](@next)
