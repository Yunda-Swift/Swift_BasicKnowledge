//: [Previous](@previous)

import Foundation
import UIKit

// 属性
/*
 Swift中跟实例相关的属性可以分为2大类
 存储属性(Store property)
 类似于成员变量这个概念
 存储在实例的内存中
 结构体、类可以定义存储属性
 枚举 不可以 定义存储属性
 
 
 计算属性(Computed Property)
 本质就是方法(函数)
 不占用实例的内存
 枚举、结构体、类都可以定义计算属性
*/

struct Circle {
    // 存储属性
    var radius: Double
    
    // 计算属性
    var diameter: Double {
        // set方法里面有一个newValue的属性可以用，拿到赋值然后操作后再赋值
        set {
            radius = newValue / 2
        }
        get {
            radius * 2
        }
    }
}

// 自动生成这个方法
var circle = Circle(radius: 5)
print(circle.radius)
print(circle.diameter)

circle.diameter = 12
print(circle.radius)
print(circle.diameter)
print("分割线............46")
print("Circle内存:\(MemoryLayout<Circle>.stride)")


// 存储属性
// 关于存储属性，Swift有个明确的规定
// 在创建类或结构体的实例时，必须为所有的存储属性设置一个合适的初始值
// 可以在初始化器里为存储属性设置一个初始值
// 可以分配一个默认的属性值作为属性定义的一部分



// 计算属性
// set传入的新值默认叫做newValue，也可以自定义
struct CircleA {
    var radius: Double
    var diameter: Double {
        // 默认是newValue: 可以自定义
        set(newDiameter) {
            radius = newDiameter / 2
        }
        get {
            radius * 2
        }
    }
}



// 只读计算属性: 只有get, 没有set
struct CircleB {
    var radius: Double
    var diameter: Double {
        get {
            radius * 2
        }
    }
}

// 只读计算属性: 只有get, 没有set——   get简写样式
struct CircleC {
    var radius: Double
    var diameter: Double { radius * 2 }
}


// 属性定义要求：
// 定义计算属性只能用var，不能用let
// let代表常量: 值是一成不变的
// 计算属性的值是可能发生变化的(即使是只读计算属性)





// 枚举rawValue的原理
// 枚举原始值rawValue的本质是： 只读计算属性
// 这个特殊调用方法
enum TestEnum: Int {
    case test1 = 1, test2 = 2, test3 = 3
    var rawValue: Int {
        switch self {
        case .test1:
            return 10
        case .test2:
            return 11
        case .test3:
            return 12
        }
    }
}
print(TestEnum.test3.rawValue)





// 延迟存储属性(lazy Stored Property)
// 使用lazy可以定义一个延迟存储属性, 在第一次用到属性的时候才会进行初始化
class Car {
    init() {
        print("Car init!")
    }
    func run() {
        print("Car is running!")
    }
}

class Person {
    // Swift的懒加载也是只有在用到时才去加载这个对象
    lazy var car = Car()
    init() {
        print("Person init")
    }
    func goOut() {
        car.run()
    }
}

let p = Person()
print("_________")
p.goOut()
// 执行过程
// Person init
// _________
// Car init!
// Car is running!



// lazy属性必须是var, 不能是let
// let必须在实例的初始化方法完成之前就拥有值

// 如果多条线程同时第一次访问lazy属性
// 无法保证属性只被初始化一次，也就是说线程是不安全的





// 延迟存储属性注意点
// 当结构体包含一个延迟存储属性时，只有var才能访问延迟存储属性
// 因为延迟属性初始化时需要改变结构体的内存
struct Point {
    var x = 0
    var y = 0
    lazy var z = 0
}

// 错误写法
// let p1 = Point()
// print(p1.z)
// 因为延迟属性初始化时需要改变结构体的内存——报错原因：因为变了所以要变

// 正确写法
var p1 = Point()
print(p1.z)
// 报错内容: Cannot use mutating getter on immutable value: 'p1' is a 'let' constant




// 属性观察器
// 可以为非lazy的var存储属性设置属性观察器
struct CircleCC {
    var radius: Double {
        willSet {
            print("willSet", newValue)
        }
        didSet {
            print("didSet", oldValue, radius)
        }
    }
    init() {
        self.radius = 1.0
        print("Circle init!")
    }
}

var circlecc = CircleCC()
circlecc.radius = 10.5
print(circlecc.radius)
// willSet会传递新值，默认叫newValue
// didSet会传递旧值,默认叫oldValue
// 在初始化器中设置属性值不会触发willSet和didSet
// 在属性定义时设置初始化值也不会出发willSet和didSet






// 全局变量和局部变量
// 属性观察器、计算属性的功能，同样可以应用在全局变量、局部变量身上


// 全局属性 / 计算属性的功能
var number: Int {
    get {
        return 10
    }
    set {
        print("setNum", newValue)
    }
}
number = 11
print(number)



// 局部变量 / 属性观察器
func test() {
    var age = 10 {
        willSet {
            print("willSet", newValue)
        }
        didSet {
            print("didSet", oldValue, age)
        }
    }
    age = 111
}
test()




// inout的再次研究
struct Shape {
    var width: Int
    var side: Int {
        willSet {
            print("willSetSide", newValue)
        }
        didSet {
            print("didSet", oldValue, side)
        }
    }
    
    var grith: Int {
        set {
            width = newValue / side
            print("setGrith", newValue)
        }
        get {
            print("getGrith")
            return width * side
        }
    }
    
    func show() {
        print("width\(width), side\(side), grith\(grith)")
    }
}

func testAA(_ num: inout Int) {
    num = 20
}

// 为什么没有grith呢？
var s = Shape(width: 10, side: 4)
print("...........")
testAA(&s.width)
s.show()
print("...........")
testAA(&s.side)
s.show()
print("...........")
testAA(&s.grith)
s.show()

/*
 inout的本质总结
 如果实参有物理地址，且没有设置属性观察器
 直接将实参的内存地址传入函数(实参进行引用传递)
 
 如果实参是计算属性或者设置了属性观察器
 采取了Copy In Copy Out的做法
 调用该函数时，先复制实参的值，产生副本[get]
 将副本的内存地址传入函数(副本进行引用传递)，在函数内部可以修改副本的值
 函数返回后，再将副本的值覆盖实参的值[set]
 
 // 总结：inout的本质就是引用传递(地址传递)
 */





/*
 类型属性(Type Property)
 严格来说，属性可以分为:
 实例属性(instance Property):只能通过实例去访问
    存储实例属性(Stored instance Property) : 存储在实例的内存中，每个实例都有一份
    计算实例属性(Computed Instance Property)
 
 类型属性(Type property): 只能通过类型去访问
    存储类型属性(Stored Type Property): 整个程序运行过程中，就只有1份内存(类似于全局变量)
    计算类型属性(Computed Type Property)
 */
// 可以通过static定义类型属性
// 如果是类，也可以用关键字class



// 是线程安全的
struct CarTest {
    // 默认就是lazy, 会在第一次使用的时候才初始化 / 保证只会初始化一次 / 存储类型属性可以是let
    static var count: Int = 0
    init() {
        CarTest.count += 1
    }
}
print(".....................")
print(CarTest.count)
let c1 = CarTest()
print(CarTest.count)
let c2 = CarTest()
print(CarTest.count)
let c3 = CarTest()
print(CarTest.count)
let c4 = CarTest()
print(CarTest.count)
// 每初始化一次，静态类属性增加1






/*
 类型属性细节
 不同于存储实例属性，你必须给存储类型属性设定初始值
 因为类型没有像实例那样的init初始化器来初始化存储属性
 
 存储类型属性默认就是lazy，会在第一次使用的时候才初始化
 就算被多个线程同时访问，保证只会初始化一次
 存储类型属性可以是let
 
 枚举类型也可以定义类型属性(存储类型属性、 计算类型属性)
 */





// 单例模式
public class FileManager {
    public static let shared = FileManager()
    private init(){}
}

public class FileManagerA {
    public static let shared = {
        return FileManagerA()
    }()
    private init() {}
}







//: [Next](@next)
