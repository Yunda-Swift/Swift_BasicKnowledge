//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

// 泛型(Generics)
// 泛型可以将类型参数化，提高代码复用率，减少代码量
// 前后的变量要保持一致
func swapValue<T>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}
var i1 = 10
var i2 = 20
swapValue(&i1, &i2)
print(i1)
print(i2)

var d1 = 10.0
var d2 = 20.0
swapValue(&d1, &d2)

struct Date {
    var year = 0, month = 0, day = 0
}
var dd1 = Date(year: 2011, month: 9, day: 10)
var dd2 = Date(year: 2012, month: 10, day: 11)
swapValue(&dd1, &dd2)
print(dd1)
print(dd2)




// 泛型函数赋值给变量
func test<T1, T2>(_ t1: T1, _ t2: T2) {}
var fn:(Int, Double) ->() = test



// 泛型
class Stack<E> {
    var elements = [E]()
    func push(_ element: E) { elements.append(element) }
    func pop() -> E { elements.removeLast() }
    func top() -> E { elements.last! }
    func size() -> Int { elements.count }
}

class SubStack<E>: Stack<E> {}

struct StackStruct<E> {
    var elements = [E]()
    mutating func push(_ element: E) { elements.append(element) }
    mutating func pop() -> E { elements.removeLast() }
    func top() -> E { elements.last! }
    func size() -> Int {elements.count}
}

var stack = Stack<Int>()
stack.push(11)
stack.push(22)
stack.push(33)
print(stack.top())
print(stack.pop())
print(stack.pop())
print(stack.pop())
print(stack.size())


enum Score<T> {
    case point(T)
    case grade(String)
}
let score0 = Score<Int>.point(100)
let score1 = Score.point(99)
let score2 = Score.point(99.6)
let score3 = Score<Int>.grade("A")




// 关联类型(Associated Type)
// 关联类型的作用: 给协议中用到的类型定义一个站位名称
// 协议中可以拥有多个关联类型
protocol Stackable2 {
    // 关联类型
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element
    func top() -> Element
    func size() -> Int
}

class StackClass<E>: Stackable2 {
    var elements = [E]()
    func push(_ element: E) {
        elements.append(element)
    }
    func pop() -> E { elements.removeLast() }
    func top() -> E { elements.last! }
    func size() -> Int { elements.count }
}

class StringStack: Stackable2 {
    // 给关联类型设定真实类型
    // typealias Element = String
    var elements = [String]()
    func push(_ element: String) { elements.append(element) }
    func pop() -> String { elements.removeLast() }
    func top() -> String { elements.last! }
    func size() -> Int { elements.count }
}
var ss = StringStack()

print(ss.push("Jack"))
print(ss.push("Rose"))
print(ss.elements.count)
print(ss.elements)
print(ss.pop())
print(ss.top())






// 类型约束
protocol Runnable {}

class Person { }

func swapValuesAA<T: Person & Runnable>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}

protocol StackableAA {
    associatedtype Element: Equatable
}

class StackAA<E: Equatable>: StackableAA {
    typealias Element = E
}

// func equal<S1: StackableAA, S2: StackableAA>(_ s1: S1, _ s2: S2) -> Bool where S1.Element == S2.Element, S1.Element : Hashable { return false }
//
// var stackAA1 = StackAA<Int>()
// var stackAA2 = StackAA<String>()
// equal(stackAA1, stackAA2)
// error: global function 'equal' requires the types 'Int' and 'String' be equivalent



// 协议类型的注意点









// 不透明类型(Opaque Type)
// 解决方案2: 使用some关键字声明一个不透明类型
//func get(_type: Int) -> some Runnable { Car() }
//var r1 = get(0)
//var r2 = get(1)

// some限制只能返回一种类型
//func get(_ type: Int) -> some Runnable {
//    if type == 0 {
//        return Person()
//    }
//    return Car()
//}



// some
// some除了用在返回值类型上, 一般还可以用在属性类型上
protocol RunnableAAC { associatedtype Speed }
class Dog: RunnableAAC {
    typealias Speed = Double
}

class PersonAAC {
    var pet: some RunnableAAC {
        return Dog()
    }
}







// 可选项的本质
// 可选项的本质是enum类型











//: [Next](@next)
