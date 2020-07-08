//: [Previous](@previous)

import Foundation
// 闭包表达式
// 在Swift中，可以通过func定义一个函数，也可以通过闭包表达式定义一个函数
func sum(_ v1: Int, _ v2: Int) -> Int {v1 + v2}

// 定义函数的两种方式:   通过func定义一个函数、  通过闭包定义一个函数
// 闭包1
var fn = {
    (v1: Int, v2: Int) -> Int in
    return v1 + v2
}
// 闭包
fn(10, 20)
print(fn(10, 20))


// 闭包2: 不能从头单独开始, 必须包含在函数或者方法内部使用————无名闭包的使用
// 如下：
print({(v3: Int, v4: Int) -> Int in return v3 + v4}(20, 50))


// 闭包的意形
//{(参数表达式) -> 返回值类型 in 函数表达式 }





// 闭包表达式的简写
func exec(v1: Int, v2: Int, fn:(Int, Int) -> Int) {
    print(fn(v1, v2))
}

// 函数调用传入闭包1
exec(v1: 15, v2: 21, fn: {
    (v1: Int, v2: Int) -> Int in
    return v1 + v2
})

// 函数调用传入闭包2
exec(v1: 13, v2: 22, fn: { v1, v2 -> Int in
    return v1 + v2
})

// 函数调用传入闭包3
exec(v1: 12, v2: 23, fn:{ v1, v2 -> Int in
    v1 + v2
})

// 函数调用传入闭包4
exec(v1: 11, v2: 22, fn: { v1, v2 in
    v1 + v2
})


// 函数调用传入闭包5——系统提示推荐的写法
exec(v1: 11, v2: 33) { (v1, v2) -> Int in
    v1 + v2
}

// 越来越简写
exec(v1: 10, v2: 22) { v1, v2 in
    v1 + v2
}



// 尾随闭包
// 如果将一个很长的闭包表达式作为函数的 最后一个实参，使用尾随闭包可以增强函数的可读性
// 尾随闭包是一个被书写在函数调用括号外面(后面)的闭包表达式
func execA(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
    print(fn(v1, v2))
}
execA(v1: 11, v2: 25) { (v1, v2) -> Int in
    v1 + v2
}



// 如果闭包表达式是函数的唯一实参，而且使用了尾随闭包的语法，那就不需要在函数名后边写圆括号
// 特殊记忆吧
func execB(fn: (Int, Int) -> Int) {
    print(fn(1, 2))
}
execB (fn: { $0 + $1 })
execB() { $0 + $1 }
execB { $0 + $1 }




// 示例 - 数组的排序
// func sort(by areInIncreasingOrder: (Element, Element) -> Bool)
// 返回true：i1排在i2前面
// 返回false： i1排在i2后面

// 定义函数规则+闭包规则
func cmpA(i1: Int, i2: Int) -> Bool {
    return i1 > i2
}

func cmpB(i1: Int, i2: Int) -> Bool {
    return i1 < i2
}

// 排序方法
var numsA = [11, 2, 18, 22, 33, 44, 5]
numsA.sort(by: cmpA)
print(numsA)

var numsB = [11, 2, 18, 22, 33, 44, 5]
numsB.sort(by: cmpB)
print(numsB)

// Swift中实现排序的方法—— n种 尾随闭包 调用简写方法
numsB.sort(by: { (a: Int, b: Int) -> Bool in
    return a > b
})
print(numsB)


numsB.sort(by: { (a, b) -> Bool in
    return a < b
})
print(numsB)


numsB.sort(by: { (a, b) in return a > b})
print(numsB)


numsB.sort(by: { a, b in return a < b})
print(numsB)


numsB.sort(by: {a, b in a > b})
print(numsB)


numsB.sort { (a, b) -> Bool in
    return a < b
}
print(numsB)


numsB.sort { a, b in return a > b}
print(numsB)


numsB.sort { a, b in a < b}
print(numsB)


numsB.sort(by: {$0 > $1 })
print(numsB)


numsB.sort(by: <)
print(numsB)


numsB.sort(by: { $0 > $1 })
print(numsB)


numsB.sort{ $0 < $1 }
print(numsB)




// 忽略参数
func execC(fn: (Int, Int) -> Int) {
    print(fn(1, 2))
}

// 不管你传什么参数我返回的都是10
// 写法1
execC { (_, _) -> Int in
    10
}
// 写法2
execC { _, _ -> Int in
    10
}
// 以上写法的演练 —— 目的1：告诉你有不断简写的方法 目的2:看到别人不同的写法不要感觉到懵逼





// 闭包(Closure)
// 网上有各种关于闭包的定义，个人觉得比较严谨的定义是：
// 一个函数和它所捕获的变量、常量环境组合起来，称为闭包
    // 一般指定义在函数内部的函数
    // 一般它捕获的是外层函数的局部变量、常量


//  此处深入理解需要看资料⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
print("分割线202行...................函数 闭包元组")
typealias Fn = (Int) -> Int
func getFn() -> Fn {
    var num = 0
    func plus(_ i: Int) -> Int {
        num += i
        return num
    }
    return plus
}
var fn1 = getFn()
var fn2 = getFn()
print(fn1(1))
print(fn1(2))
print(fn1(3))
print(fn2(4))
print(fn2(5))
print(fn2(6))
// 此处的值会不断的累加


print("分割线223行...................类对象 闭包元组")
class ClosureA {
    var num = 0
    func plus(_ i: Int) -> Int {
        num += i
        return num
    }
}
var vs1 = ClosureA()
var vs2 = ClosureA()

// num作为类的属性，同一类对象不销毁，属性的值不断增加不销毁
// 此处的值会不断的累加
print(vs1.plus(1))
print(vs1.plus(2))
print(vs1.plus(3))
print(vs2.plus(4))
print(vs2.plus(5))
print(vs2.plus(6))




print("分割线246行...................函数 闭包元组")
typealias FnA = (Int) -> (Int, Int)
func getFnA() -> (FnA, FnA) {
    var num1 = 0
    var num2 = 0
    func plus(_ i: Int) -> (Int, Int) {
        num1 += i
        num2 += i << 1
        return (num1, num2)
    }
    
    func minus(_ i: Int) -> (Int, Int) {
        num1 -= i
        num2 -= i << 1
        return (num1, num2)
    }
    return (plus, minus)
}
let (p, m) = getFnA()
print(p(5))
print(p(4))
print(m(3))
print(m(2))

print("分割线270行...................类对象 闭包元组")

class ClosureB {
    var num1 = 0
    var num2 = 0
    func plus(_ i: Int) -> (Int, Int) {
        num1 += i
        num2 += i << 1
        return (num1, num2)
    }
       
    func minus(_ i: Int) -> (Int, Int) {
        num1 -= i
        num2 -= i << 1
        return (num1, num2)
    }
}
var csB = ClosureB()
print(csB.plus(5))
print(csB.plus(4))
print(csB.minus(3))
print(csB.minus(2))



print("分割线295行...................数组 闭包元素 的使用")
// 数组闭包元素的使用
var functions: [() -> Int] = []
for i in 1...3 {
    functions.append { i }
}
for f in functions {
    print(f())
}


print("分割线306行...................数组 对象类元素 的使用")
class ClosureC {
    var i: Int
    init(_ i: Int) {
        self.i = i
    }
    func get() -> Int {
        return i
    }
}
var clses: [ClosureC] = []
for i in 1...3 {
    clses.append(ClosureC(i))
}
for cls in clses {
    print(cls.get())
}



print("分割线326行...................如果返回值是函数类型, 那么参数的修饰要保持统一")
// 如果返回值是函数类型，那么参数的修饰要保持统一
func add(_ num: Int) -> (inout Int) -> Void {
    func plus(v: inout Int) {
        v += num
    }
    return plus
}
var num = 5
add(20)(&num)
print(num)
// 20 + 5 = 25



// 自动闭包
// 如果第1个数大于0，返回第一个数，否则返回第2个数
print("分割线343行...................自动闭包")
func getFirstPositive(_ v1: Int, _ v2: Int) -> Int {
    return v1 > 0 ? v1 : v2
}
print(getFirstPositive(10, 20))
print(getFirstPositive(-10, 21))
print(getFirstPositive(-10, 2))



// 改成函数类型的参数，可以让v2延迟加载
func getFirstpositiveA(_ v1: Int, _ v2: () -> Int) -> Int {
    return v1 > 0 ? v1 : v2()
}
var numberB = getFirstpositiveA(-4) { () -> Int in
    20
}
var numberC = getFirstpositiveA(-4) { 20 }

print(numberB)
print(numberC)


func getFirstPositiveC(_ v1: Int, _ v2: @autoclosure () -> Int) -> Int? {
    return v1 > 0 ? v1 : v2()
}
// 你传进来的是个21, 但是会被  自动封装成一个闭包
var numberD = getFirstPositiveC(-4, 21)
print(numberD)

// @autoclosure 会自动将20 封装成闭包 { 20 }
// @autoclosure 只支持() -> T格式的参数
// @autoclosure 并非只支持最后一个参数
// 空合并运算符 ?? 使用了@autoclosure技术
// 有@autoclosure、无@autoclosure，构成了函数重载



// ⚠️⚠️⚠️⚠️⚠️⚠️
// 为了避免与期望冲突，使用了@autoclosure的地方最好明确注释清楚：这个值会被推迟执行






















//: [Next](@next)
