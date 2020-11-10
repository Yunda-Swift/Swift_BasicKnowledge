//: [Previous](@previous)

import Foundation

var str = "内存管理"
/*
 跟OC一样，Swift也是采取基于引用计数的ARC内存管理方案(针对堆空间)
 
 Swift 的ARC中有3种引用
 
 强引用 (Strong reference): 默认情况下，引用都是强引用
 
 弱引用 (weak reference): 通过weak定义弱引用
 ·必须是可选类型的var,因为实例销毁后，ARC会自动将弱引用设置为nil
 ·ARC自动给弱引用设置nil时，不会出发属性观察器
 
 无主引用(unowned reference): 通过unowned定义无主引用
 ·不会产生强引用，实例销毁后仍然存储着实例的内存地址(类似于OC中的unsafe_unretained)
 ·试图在实例销毁后访问无主引用，会产生运行时错误(野指针)
 Fatal error: Attemted to read an unowned reference but object  0x0 was already deallocated
 */



// weak、 unowned的使用限制
// weak、unowned只能用在类实例上面
protocol Livable: AnyObject{}
class Person {}

weak var p0: Person?
weak var p1: AnyObject?
weak var p2: Livable?

unowned var p3: Person?
unowned var p4: AnyObject?
unowned var p5: Livable?






// Autoreleasepool
//public func autoreleasepool<Result>(invoking body: () throws -> Result) rethrows -> Result
//autoreleasepool {
//    let p = MJPerson(age: 20, name: "Jack")
//    p.run()
//}



// 循环引用(Reference Cycle)
// weak、unowned都能解决循环引用的问题,unowned要比weak少一些性能消耗
// 在生命周期中可能会变为nil的使用weak
// 初始化赋值后再也不会变为nil的使用unowned





// 闭包的循环引用
// 闭包表达式默认会对外层对象产生额外的强引用(对外层对象进行了retain操作)
// 下面代码会产生循环引用，导致Person对象无法释放(看不到Person的deinit被调用)
class PersonAA {
    var fn: (() -> ())?
    func run() {
        print("run")
    }
    deinit {
        print("deinit")
    }
}
func test() {
    let p = PersonAA()
    p.fn = { p.run() }
    p.run()
}
test()



// 在闭包表达式的捕获列表声明weak或unowned引用，解决循环引用问题
//p.fn = {
//    [weak p] in
//    p?.run()
//}
//p.fn = {
//    [unowned p] in
//    p.run()
//}
//p.fn = {
//    [weak wp = p, unowned up = p, a = 10 + 20] in
//    wp?.run()
//}




// 如果想在定义闭包属性的同时引用self，这个闭包必须是lazy的(因为在实例初始化完毕之后才能引用self)
class PersonBB {
    lazy var fn: (() -> ()) = {// 左边的闭包fn内部如果用到了实例成员(属性、方法))
        [weak self] in         // 编译器会强制要求明确写出self
        self?.run()
    }
    func run() {
        print("run")
    }
    deinit {
        print("deinit")
    }
}

// 如果lazy属性是闭包调用的结果，那么不用考虑循环引用的问题(因为闭包调用后，闭包的生命周期就结束了)
class PersonCC {
    var age: Int = 0
    lazy var getAge: Int = {
        self.age
    }()
    deinit {
        print("deinit")
    }
}









// @escaping
// 非逃逸闭包、逃逸闭包，一般都是当做参数传递给函数
// 非逃逸闭包：闭包调用发生在函数结束前，闭包调用在函数作用域内
// 逃逸闭包: 闭包有可能在函数接受后调用，闭包调用逃离了函数作用域，需要通过@escaping声明
import Dispatch
typealias Fn = () -> ()

// fn是非逃逸闭包
func test1(_ fn: Fn) { fn() }

// fn是逃逸闭包
var gFn: Fn?
func test2(_ fn: @escaping Fn) { gFn = fn }

// fn是逃逸闭包
func test3(_ fn: @escaping Fn) {
    DispatchQueue.global().async {
        fn()
    }
}

class PersonDD {
    var fn: Fn
    // fn是逃逸闭包
    init(fn: @escaping Fn) {
        self.fn = fn
    }
    func run() {
        // DispatchQueue.global().async也是一个逃逸闭包
        // 它用到了实例成员(属性、方法)，编译器会强制要求明确写出self
        DispatchQueue.global().async {
            self.fn()
        }
    }
}





// 逃逸闭包的注意点
// 逃逸闭包不可以捕获(使用)inout参数、






// 内存访问冲突(Conflicting Access to Memory)
// 内存访问冲突会在两个访问满足下列条件时发生：
// 至少一个是写入操作
// 它们访问的是同一块内存
// 它们的访问时间重叠（比如在同一个函数内）

// 不存在内存访问冲突
func plus(_ num: inout Int) -> Int { num  + 1 }
var number = 1
number = plus(&number)

// 存在内存访问冲突
var step = 1
func increment(_ num: inout Int) { num += step }
//increment(&step)
// 报错信息
// Simultaneous accesses to 0x128808c88, but modification requires exclusive access.
// Previous access (a modification) started at  (0x1323c6cb9).
// Current access (a read) started at:
// 0    libswiftCore.dylib                 0x0000000109e92590 swift_beginAccess + 568
// 3    Swift_BasicKnowledge               0x0000000109b0b560 main + 0
// 4    CoreFoundation                     0x000000010b0dc290 __CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__ + 12
// 5    CoreFoundation                     0x000000010b0db8d0 __CFRunLoopDoBlocks + 312
// 6    CoreFoundation                     0x000000010b0d6390 __CFRunLoopRun + 1284
// 7    CoreFoundation                     0x000000010b0d5eb0 CFRunLoopRunSpecific + 438
// 8    GraphicsServices                   0x000000010f4fab6f GSEventRunModal + 65
// 9    UIKitCore                          0x00000001101326f8 UIApplicationMain + 1621
// 10   Swift_BasicKnowledge               0x0000000109b0b560 main + 205
// 11   libdyld.dylib                      0x000000010ca2ac24 start + 1
// Fatal access conflict detected.
// Playground execution failed:
//
// error: Execution was interrupted, reason: signal SIGABRT.
// The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.



// 解决内存访问冲突
// 避免对统一内存进行操作
var copyOfStep = step
increment(&copyOfStep)
step = copyOfStep




// 内存访问冲突2
func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

var num1 = 42
var num2 = 30
balance(&num1, &num2)
//balance(&num1, &num1)






// 指针
// Swift中也有专门的指针类型,这些都被定性为"Unsafe"(不安全的)，常见的有以下4种类型
// UnsafePointer<Pointee>类似于const Pointee *
// UnsafeMutablePointer<Pointee>类似于Pointtee *
// UnsafeRawPointer 类似于 const void *
// UnsafeMutableRawPointer类似于 void*
var age = 10
func testAAA(_ ptr: UnsafeMutablePointer<Int>) {
    ptr.pointee += 10
}

func test2AAA(_ ptr: UnsafePointer<Int>) {
    print(ptr.pointee)
}

testAAA(&age)
test2AAA(&age)
print(age)



var ageBB = 10
func test3B(_ ptr: UnsafeMutableRawPointer) {
    ptr.storeBytes(of: 20, as: Int.self)
}

func test4B(_ ptr: UnsafeRawPointer) {
    print(ptr.load(as: Int.self))
}
test3B(&ageBB)
test4B(&ageBB)
print(ageBB)




// 指针的应用示例
var arr = NSArray(objects: 11, 22, 33, 44)
arr.enumerateObjects { (obj, idx, stop) in
    print(idx, obj)
    if idx == 2 { // 下标为2就停止遍历
        stop.pointee = true
    }
}

for (idx, obj) in arr.enumerated() {
    print(idx, obj)
    if idx == 2 {
        break
    }
}




// 获取指向某个变量的指针
var ageC = 11
var ptr1C = withUnsafeMutablePointer(to: &ageC){ $0 }
var ptr2C = withUnsafePointer(to: &age){ $0 }

ptr1C.pointee = 22
print(ptr2C.pointee)
print(ageC)


var ptr3C = withUnsafeMutablePointer(to: &ageC) { UnsafeMutableRawPointer($0) }
var ptr4C = withUnsafePointer(to: &ageC) { UnsafeRawPointer($0) }
ptr3C.storeBytes(of: 33, as: Int.self)
print(ptr4C.load(as: Int.self))
print(ageC)






// 获取指向堆空间实例的指针
class PersonCCC {}
var personcc = PersonCCC()
var ptrCC = withUnsafeMutablePointer(to: &personcc) { UnsafeRawPointer($0) }
var heapPtr = UnsafeRawPointer(bitPattern: ptrCC.load(as: UInt.self))
print(heapPtr!)






// 创建指针
//var ptrAAA = UnsafeRawPointer(bitPattern: 0x100001234)
// 创建
var ptrAAA = malloc(16)

// 存
ptrAAA?.storeBytes(of: 11, as: Int.self)
ptrAAA?.storeBytes(of: 22, toByteOffset: 8, as: Int.self)

// 取
print((ptrAAA?.load(as: Int.self))!)
print((ptrAAA?.load(fromByteOffset: 8, as: Int.self))!)
free(ptrAAA)







// 创建指针 指针之间的转换










// swift中do可以单独使用，变成局部的作用域
// 不用必须跟catch搭配使用
do {
    do {
        
    }
    
    do {
        
    }
}

do {
    
}









//: [Next](@next)
