//: [Previous](@previous)

import Foundation

// 方法(Method)
// 枚举、结构体、类都可以定义实例方法、类型方法
// 实例方法(Instance Methond): 通过实例对象调用
// 类型方法(Type Methond): 通过类型调用，用static或者class关键字定义


class Car {
    static var count = 0
    init() {
        Car.count += 1
    }
    static func getCount() -> Int { count }
}
let c0 = Car()
print(Car.getCount())
let c1 = Car()
print(Car.getCount())
let c2 = Car()
print(Car.getCount())
let c3 = Car()
print(Car.getCount())



// self
// 在实例方法中代表实例对象
// 在类型方法中代表类型

// 在类型方法static func getCount中
// count等价于self.count、 Car.self.count、Car.count



// mutating
// 结构体和枚举是值类型，默认情况下，值类型的属性不能被自身的实例方法修改
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(deltaX: Double, deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

// mutating——修改枚举和结构体属性
enum StateSwitch {
    case low, middle, hight
    mutating func next() {
        switch self {
        case .low:
            self = .middle
        case .middle:
            self = .hight
        case .hight:
            self = .low
        }
    }
}




// @discardableResult
// 在func前面加个@discardableResult，可以消除: 函数调用后返回值未被使用的警告
@discardableResult
func getAA() -> Int {
    return 10
}
getAA()


struct PointBB {
    var x = 0.0, y = 0.0
    // 结构体中改变属性值必须加mutating
    @discardableResult mutating
    func moveX(deltaX: Double) -> Double {
        x += deltaX
        return x
    }
}

var p = PointBB()
p.moveX(deltaX: 19)
























//: [Next](@next)
