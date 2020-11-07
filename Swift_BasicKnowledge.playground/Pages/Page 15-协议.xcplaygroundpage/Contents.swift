//: [Previous](@previous)

import Foundation

var str = "Hello, playground"
// 协议(Protocol)
// 协议可以用来定义方法、属性、下标的声明，协议可以被枚举、结构体、类遵守(多个协议用逗号隔开)

// 协议内可以包含: 方法、属性、下标的声明
protocol Drawable {
    func draw()
    var x: Int {get set}
    var y: Int {get}
    subscript(index: Int) -> Int {get set}
}


// 协议可以被枚举、结构体、类遵守
protocol Test1 {}
protocol Test2 {}
protocol Test3 {}
protocol Test4 {}
protocol Test5 {}
// 多个协议的遵守用逗号隔开
class TestClass: Test1, Test2, Test3, Test4, Test5 {}



// 协议中定义方法时不能有默认参数值
// 默认情况下，协议中定义的内容必须全部都实现
// 也有办法做到只实现部分内容，以后的课程会讲到





/*
 协议中定义属性时必须用var关键字
 实现协议时的属性权限要不小于协议中定义的属性权限
 协议定义get、set,用var存储属性或get、set计算属性去实现
 协议定义get，用任何属性都可以实现
 **/
protocol DrawableA {
    func draw()
    var x: Int { get set}
    var y: Int {get}
    subscript(index: Int) -> Int { get set }
}

// 存储属性实现
class PersonA: DrawableA {
    func draw() {
        print("PersonA draw")
    }
    var x: Int = 0
    var y: Int = 0
    subscript(index: Int) -> Int {
        set {}
        get {index}
    }
}

// 计算属性实现
class PersonB: DrawableA {
    func draw() {
        print("PersonB draw")
    }
    var x: Int {
        get { 0 }
        set {}
    }
    var y: Int { 0 }
    subscript(index: Int) -> Int {
        set {}
        get {index}
    }
}







// static、 class
// 为了保证通用，协议中必须用static定义类型方法、类型属性、类型下标
protocol DrawableC {
    static func draw()
}

class PersonC: DrawableC {
    class func draw() {
        print("Person1 draw")
    }
}

class PersonD: DrawableC {
    static func draw() {
        print("Person2 draw")
    }
}




// mutating
// 只有将协议中的实例方法标记为mutaing
// 才允许结构体、枚举的具体实现修改自身内存
// 类在实现方法时不用加mutating, 枚举、结构体才需要加mutating

protocol DrawableD {
    mutating func draw()
}

class Size: DrawableD {
    var width: Int = 0
    func draw() {
        width = 10
    }
}

struct Point: DrawableD {
    var x: Int = 0
    mutating func draw() {
        x = 10
    }
}







// init
/*
 协议中还可以定义初始化器init
 非final类实现时必须加上required
 */
protocol DrawableE {
    init(x: Int, y: Int)
}

// 非final类实现时必须加上required
class PointA: DrawableE {
    required init(x: Int, y: Int) {}
}


// final类不用加required
final class SizeA: DrawableE {
    init(x: Int, y: Int) {}
}





/*
 如果从协议实现的初始化器，刚好是重写了父类的指定初始化器
 那么这个初始化必须同时加required、override
 */
protocol Livable {
    init(age: Int)
}

class PersonE {
    init(age: Int) {}
}

class Student: PersonE, Livable {
    required override init(age: Int) {
        super.init(age: age)
    }
}




// init、 init?、 init！
// 协议中定义的init？、init、!可以用init、init?、init！去实现
// 协议中定义的init, 可以用init、init！去实现
protocol LiveableA {
    init()
    init?(age: Int)
    init!(no: Int)
}

class PersonF: LiveableA {
    required init() {}
    required init?(age: Int) {}
    required init!(no: Int) {}
}








// 协议的继承
// 一个协议可以继承其他协议——协议的传递性
protocol Runnable {
    func run()
}

protocol LiveableB: Runnable {
    func breath()
}

class PersonG: LiveableB {
    func breath() {}
    func run() {}
}





// 协议组合 —— 被接受
// 协议组合，可以包含1个类型(最多1个)
protocol LivableC {}
protocol RunnableC {}
class PersonH {}

// 接受Person或者子类的实例
func fn0(obj: PersonH){}

// 接收遵守Livable协议的实例
func fn1(obj: LivableC) {}

// 接受同时遵守Livable、Runnable协议的实例
func fn2(obj: LivableC & RunnableC) {}

// 接收同时遵守Livable、Runnable协议、并且是Person或者其子类的实例/必须同时遵守，没有或的概念
func fn3(obj: PersonH & LivableC & RunnableC) {}

// 重新进行定义
typealias RealPerson = PersonH & LivableC & RunnableC

func fn4(obj: RealPerson){}


// CaseIterable
// 让枚举遵守CaseIterable协议，可以实现遍历枚举值
enum Season: CaseIterable {
    case spring, summer, autumn, winter
}

let seasons = Season.allCases
print(seasons.count)

for season in seasons {
    print(season)
}







// CustomStringConvertiable
// 遵守CustomStringConvertible、CustomDebugStringConvertible协议，都可以自定义实例的打印字符串
// 遵守协议可以重写description的方法
class PersonI: CustomStringConvertible, CustomDebugStringConvertible {
    var age = 0
    var description: String {"Person_\(age)"}
    var debugDescription: String {"debug_person_\(age)"}
}
var person = PersonI()
print(person)
debugPrint(person)





// Any、 AnyObject
// Swift提供了2种特殊的类型: Any、AnyObject
// Any: 可以代表任意类型(枚举、结构体、类，也包括函数类型)
// AnyObject: 可以代表任意类类型(在协议后面写上: AnyObject代表只有类能遵守这个协议)
//  在协议后面写上: class也代表只有类能遵守这个协议
var stu: Any = 10
stu = "Jack"

// 创建1个能存放任意类型的数组
var data1 = Array<Any>()
var dataAC = [Any]()

dataAC.append(1)
dataAC.append(3.14)
dataAC.append(stu)
dataAC.append("Jack")
dataAC.append({ 10 })
print(dataAC)





// is、as?、as!、as
// is用来判断是否为某种类型, as用类做强制类型转换
protocol RunnableE {
    func run()
}
class personAA {}

class StudentAA: personAA, RunnableE {
    func run() {
        print("Student run")
    }
    func study() {
        print("Student study")
    }
}

var stuAny: Any = 10
print(stuAny is Int)

stuAny = "Jack"
print(stuAny is String)

stuAny = StudentAA()

print(stuAny is personAA)
print(stuAny is StudentAA)
print(stuAny is RunnableE)




var stuBB: Any = 10
// 不是任意类型都可以进行强转——可能成功
(stuBB as? StudentAA)?.study()

stuBB = StudentAA()
(stuBB as? StudentAA)?.study()
(stuBB as! StudentAA).study()
// 注意类型的转换和方法的调用
(stuBB as? RunnableE)?.run()

// as 100%转换
var data = [Any]()
data.append(Int("123") as Any)

var d = 10 as Double
print(d)




// X.self、X.Type、AnyClass
// X.self是一个元类型(Metadata)的指针,metadata存放着类型相关信息
// X.self属于X.Type类型
class PersonBB{}
class StudentBB: PersonBB{}
var perType: PersonBB.Type = PersonBB.self
var stuType: StudentBB.Type = StudentBB.self


var anyType: AnyObject.Type = PersonBB.self
anyType = StudentBB.self

public typealias AnyClass = AnyObject.Type
var anyType2: AnyClass = PersonBB.self
anyType2 = StudentBB.self

var perBB = PersonBB()
var perTypeBB = type(of: perBB)
print(PersonBB.self == type(of: perBB))






// 元类型的应用
class AnimalCC { required init() {} }
class CatCC: AnimalCC {}
class DogCC: AnimalCC {}
class PigCC: AnimalCC {}

// 用类创建对象
func create(_ clses: [AnimalCC.Type]) -> [AnimalCC] {
    var arr = [AnimalCC]()
    for cls in clses {
        arr.append(cls.init())
    }
    return arr
}
print(create([CatCC.self, DogCC.self, PigCC.self]))





// 元类型的应用
class PersonDD {
    var age: Int = 0
}

class StudentDD: PersonDD {
    var no: Int = 0
}

print(class_getInstanceSize(StudentDD.self))
print(class_getSuperclass(StudentDD.self))
print(class_getSuperclass(PersonDD.self))
// 从结果可以看得出来，Swift还有个隐藏的基类：Optional(Swift._SwiftObject)
// 可以参考Swift源码: https://github.com/apple/swift/blob/master/stdlib/public/runtime/SwiftObject.h






// Self
// Self代表当前类型
class PersonEEF {
    var age = 1
    static var count = 2
    // 注意类方法的Self和对象方法的self的区别
    func run() {
        print(self.age)
        print(Self.count)
    }
}

// Self一般用作返回值类型，限定返回值跟方法调用者必须是同一类型(也可以作为参数类型)
protocol RunnableFF {
    func test() -> Self
}

class PersonFF: RunnableFF {
    required init() {}
    func test() -> Self {
        type(of: self).init()
    }
}
class StudentFF: PersonFF {}

var pFF = PersonFF()
print(pFF.test)
// (Function)

var stuFF = StudentFF()
print(stuFF.test())







//: [Next](@next)
