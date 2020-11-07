//: [Previous](@previous)

import Foundation
// 结构体
// 在Swift标准库中，绝大多数的公开类型都是结构体，而枚举和类只占很小一部分
// 比如Bool、 Int、 Double、 String、 Array、 Dictionary等常见类型都是结构体
struct Date {
    var year: Int
    var month: Int
    var day: Int
}
// 会有自动提示
var date = Date(year: 2020, month: 7, day: 7)
// 所有的结构体都有一个编译器自动生成的初始化器(initializer, 初始化方法、构造器、 构造方法)
// 在调用时，可以传入所有成员值，用以初始化所有成员(存储属性，Stored Property)

// 结构体的初始化器
// 编译器会根据情况，可能会为结构体生成多个初始化器，宗旨是：    保证所有成员都有初始化值
struct PointA {
    var x: Int
    var y: Int
}
var p1 = PointA(x: 10, y: 20)
// var p2 = PointA(x: 10)
// var p3 = PointA(y: 20)
// var p4 = PointA()
// 总结：此三种情况无法保证结构体的初始化出来都有值


// 可以通过编译的第一种方法
struct PointB {
    var x: Int = 0
    var y: Int = 0
}
var pb1 = PointB(x: 10, y: 20)
var pb2 = PointB(x: 10)
var pb3 = PointB(y: 20)
var pb4 = PointB()


// 可以通过编译的第二种方法
// 可选项都有个默认值nil
// 因此可以编译通过
struct PointC {
    var x: Int?
    var y: Int?
}
var pbc1 = PointC(x: 10, y: 20)
var pbc2 = PointC(x: 10)
var pbc3 = PointC(y: 20)
var pbc4 = PointC()



// 一旦在定义结构体时自定义了初始化器，   编译器就不会再帮它自动生成其他初始化器
struct PointD {
    var x: Int = 0
    var y: Int = 0
    // 定义初始化器
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
var pd1 = PointC(x: 10, y: 20)
// 只能用你生成的，别的就会报错
// var pd2 = PointC(x: 10)
// var pd3 = PointC(y: 20)
// var pd4 = PointC()




// 窥探初始化器的本质
// 以下2段代码完全等效
struct PointE {
    var x: Int = 0
    var y: Int = 0
}
var pe1 = PointE()

struct PointF {
    var x: Int
    var y: Int
    init() {
        x = 0
        y = 0
    }
}
var pf1 = PointF()




// 结构体内存结构
struct pointH {
    var x: Int = 0
    var y: Int = 0
    var origin: Bool = false
}
print(MemoryLayout<pointH>.size)
print(MemoryLayout<pointH>.stride)
print(MemoryLayout<pointH>.alignment)





// 类
// 类和结构体的区别
// 类的定义和结构体类似, 但编译器并没有为类自动生成可以传入成员值的初始化器和构造方法

class PointI {
    // 初始化类的属性没有默认值就会报错
    var x: Int = 0
    var y: Int = 0
}
let pi1 = PointI()

// 初始化类的属性没有默认值就会报错
//class PointJ {
//    var x: Int
//    var y: Int
//}
//let pi12 = PointJ()


// 类的初始化器
// 如果类的所有成员都在定义的时候指定了初始值，编译器会为类生成无参的初始化器
// 成员的初始化是在这个初始化器中完成的
class PointK {
    var x: Int = 0
    var y: Int = 0
}
let pk1 = PointK()


class PointL {
    var x: Int
    var y: Int
    init() {
        x = 0
        y = 0
    }
}
let pl1 = PointL()
// 上面两段代码是完全等效的




// 结构体和类的本质区别
// 结构体是值类型(枚举也是值类型)，类是引用类型(指针类型)

// 引用类型(指针类型)
class Size {
    var width = 1
    var height = 2
}

// 值类型：深拷贝
// 一个地址变量在内存中占用8个字节
// 栈空间存地址、堆空间存对象
// 堆空间一个对象包含的内容: 1.指向类型信息 2.引用计数 3.size.width 4.size.height
// 现在主要真多的就是64为编译器

struct Point {
    var x = 3
    var y = 4
}

func test() {
//    var size = Size()
//    var point = Point()
}

// 结构体在内存中的位置，取决于创建的它的位置，全局变量：全局区数据段、还是函数内：栈空间，还是类中：跟随类对象堆空间，类方法定义结构体还是存在栈空间
// 函数是独立与类和结构体存在的，函数级别是一样的，只是作用域不一样，结构体存于函数的栈空间和堆空间

// 值类型
// 值类型赋值给var、let或者给函数传参，是直接将所有内容拷贝一份
// 类似于对文件进行copy、paste操作，产生了全新的文件副本。属于深拷贝(deep copy)
struct Point1 {
    var x: Int
    var y: Int
}

func test1() {
    let p1 = Point1(x: 10, y: 20)
    var p2 = p1
    p2.x = 11
    p2.y = 22
    // 值类型赋值操作属于深拷贝赋值对原来没有影响
    print(p1)
    print(p2)
}
test1()
// 值类型还包括String、Array、Dictionary、Set采取了Copy On Write的技术

// 在Swift标准库中，为了提升性能，String、 Array、 Dictionary、 Set采取了Copy on Write的技术
// 比如仅当有"写"操作时, 才会真正执行拷贝操作
// 对于标准库值类型的赋值操作，Swift能确保最佳性能，所以没必要为了保证最佳性能来避免赋值
// 建议：不需要修改的，尽量定义为let
// 自己定义的结构体没有性能优化，只有标准库里面才有


// 值类型的赋值操作
struct Point2 {
    var x: Int
    var y: Int
}
var p22 = Point2(x: 10, y: 20)
p22 = Point2(x: 11, y: 22)
// 同一变量的赋值：不同的数据：值类型的地址没有发生改变。——值改变，地址不变
print(p22)




// 引用类型
// 引用赋值给var、let或者给函数传参，是将内存地址拷贝一份
// 类似于制作一个文件的替身(快捷方式、链接)，指向的是同一个文件。属于浅拷贝(shallow copy)
class SizeAA {
    var width: Int
    var height: Int
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

// 引用类型浅拷贝，值发生改变时：本质发生改变，地址不变。全都指向同一内容
func testAA() {
    let s1 = SizeAA(width: 10, height: 20)
    let s2 = s1
    print("s1:  \(s1.width)")
    print("s2:  \(s2.width)")
    s2.width = 22
    s2.height = 11
    print("s1:  \(s1.width)")
    print("s2:  \(s2.width)")
}
testAA()




class SizeBB {
    var width: Int
    var height: Int
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

var s1 = SizeBB(width: 10, height: 20)
s1 = SizeBB(width: 11, height: 22)
// s1的栈空间发生改变：各自指向不同的栈地址
// SizeBB两个对象指向两个堆空间



// 值类型、引用类型的let
struct PointCC {
    var x: Int
    var y: Int
}

class SizeCC {
    var width: Int
    var height: Int
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

///

let pcc = PointCC(x: 10, y: 20)
//pcc = PointCC(x: 11, y: 22)
//pcc.x = 22
//pcc.y = 33

let str = "Jack"
//str.append("_Rose")

let arr = [1, 2, 3]
//arr[0] = 11
//arr.append(4)

/// 值类型在初始化之后，就不能在对其自身以及它的属性进行操作改变



let s = SizeCC(width: 100, height: 200)
//s = SizeCC(width: 200, height: 300)
s.width = 300
s.height = 500
print(s.width)
print(s.height)
// 引用类型: 除了不能对其本身进行操作，其他属性可以改变



// 嵌套类型——不知道想说明什么问题
/*
 在Swift中，创建类的实例对象，要向堆空间申请内存，大概流程如下
 在Mac、iOS中的malloc函数分配的内存大小总是16的倍数
 通过class_getInstanceSize可以得知: 类的对象至少需要占用多少内存
 */




// 枚举、结构体、类都可以定义方法
// 一般把定义在枚举、结构体、类内部的函数，叫做方法

// 类
class SizeDD {
    var width = 10
    var height = 10
    func show() {
        print("width=\(width), height=\(height)")
    }
}

let sdd = SizeDD()
sdd.show()

// 结构体
struct PointDD {
    var x = 10
    var y = 10
    func show() {
        print("x=\(x), y=\(y)")
    }
}
let pdd = PointDD()
pdd.show()


// 枚举
enum PokerFace: Character {
    case spades = "♠️", headrs = "♥️", diamonds = "♦️", clubs = "♣️"
    func show() {
        print("face is \(rawValue)")
    }
}
let pf = PokerFace.headrs
pf.show()
// 总结:  方法占用对象的内存嘛？
// 不占用
// 方法的本质就是函数
// 方法、函数都存在代码段





// 规律
// 内存地址格式为: 0x4bdc(%rip),一般是全局变量，全局区(数据段)
// 内存地址格式为: -0x78(%@rbp),一般是局部变量
// 内存地址格式为: 0x10(%rax),一般是堆空间





// 方法占用对象的内存么？
// 方法是不占用对象内存空间的
// 方法的本质是就是函数
// 方法、函数都存在代码段











//: [Next](@next)
