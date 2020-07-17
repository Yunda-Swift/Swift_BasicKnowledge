//: [Previous](@previous)

import Foundation

// 函数的定义
// 函数名+() 加—> 以及返回值
func pi() -> Double {
    return 3.14
}

print(pi())

// 如果整个函数体是一个单一表达式，那么函数会隐式返回这个表达式
/// 求和【概述】
///
/// 将2个整数相加【更详细的描述】
///
/// - Parameter v1: 第一个整数
/// - Parameter v2：第二个整数
/// - Returns: 2个整数的和
///
/// -Note:传入2个整数即可【批注】
///
func sum(v1: Int, v2: Int) -> Int {
    return v1 + v2
}
// v1 和 v2不能省略
print(sum(v1: 10, v2: 45))
// 形参是不可变的
// 形参默认是let，也只能是let


// 无返回值：函数的几种写法
func sayHello1() -> Void {
    print("Hello1")
}

func sayHello2() -> () {
    print("Hello2")
}

func sayHello3() {
    print("Hello3")
}


// 隐式返回(Implicit Return)
// 如果整个函数是一个单一表达式, 那么函数会隐式返回表达式，返回结果为表达式且没有return

//  函数的文档注释怎么写⚠️
/// 求和【概述】
///
/// 将两个整数相加【更详细的描述】
///
/// - Parameter v1: 第一个整数
/// - Parameter v2: 第二个整数
/// - Return: 2个整数的和
///
/// -Note：传入2个整数即可【批注】
func sumABC(v1: Int, v2: Int) -> Int {
    v1 + v2 // 隐式返回
}
print(sumABC(v1: 10, v2: 20))


// 返回元组： 实现多返回值
// 元组更加的轻量级
func calculate(v1: Int, v2: Int) -> (sum: Int, difference:Int, average: Int) {
    let sum = v1 + v2
    return (sum, v1 - v2, sum >> 1)
}
let result = calculate(v1: 20, v2: 10)
// 求和
print(result.sum)
// 差
print(result.difference)
// 平均数
print(result.average)




// 参数标签(Argument Label)
// 可以修改参数标签
// 便于人们更容易的理解
// at
func gotoWork(at time: String) {
    // time内部使用
    print("this time is \(time)")
}
// at外面调用
gotoWork(at: "08:00")

// 可以使用下划线_省略参数标签——但是不推荐这么使用
func sum(_ v1: Int, _ v2: Int) -> Int {
    return v1 + v2
}
sum(10, 20)


// 默认参数值(Default Parameter Value)
func check(name: String = "nobody", age: Int, job: String = "iOS") {
    print("name = \(name), age=\(age), job=\(job)")
}
check(name: "KSJ1", age: 29, job: "Swift")
check(name: "KSJ2", age: 30)
check(age: 31, job: "Flutter")
check(age: 35)
// ⚠️C++的默认参数值有个限制，必须从右往左。由于Swift拥有参数标签，因此并没有此类限制
// 但是在省略参数标签时，需要特别注意，避免出错


// 这里的middle不可以省略标签 —— 报错：Missing argument for parameter #2 in call
// 带默认参数的函数，函数中未带默认值的标签 —— 不能省略标签
// 为什么在这里必须不能省略参数标签——因为传入参数易混淆分不清参数到底赋值给谁
func test (_ first: Int = 0, middle: Int, _ last: Int = 30) {
    print(middle)
}
test(middle: 20)

// 什么是可变参数？
// 可变参数(Variadic Parameter)——暂时认定这个numbers为一个数组
func sumMutable (_ numbers: Int...) -> Int {
    var total = 0
    for number in numbers {
        total += number
    }
    return total;
}
print(sumMutable(10, 20, 30, 40))

// 一个函数最多只能有1个可变参数
// 紧跟在可变参数后面的参数     是不能省略标签参数的——如果连续是Int类型容易产生歧义和混淆，所以不能省略
func test(_ numbers:Int..., string: String, _ other: String) {
    print("\(numbers), \(string), \(other)")
}
test(10, 20, 30, string: "Jack", "Rose")

// Swift自带的print函数
// print函数的间隔：1.内容  2.用什么分割 3.该函数跟下一行换行
// 内部默认参数展示情况
print(1, 2, 3, 4, 5, separator: " ", terminator: "\n")

print(1, 2, 3, 4, 5)
print(1, 2, 3, 4, 5, separator: "_")
print("My name is Jake", terminator: "")
print("My age is 18")


// 输入输出参数(In-Out Parameter)
// 可以用inout定义一个\\\输入输出参数⚠️\\\：可以在函数内部修改外部实参的值
//

func swapValues(_ v1: inout Int, _ v2: inout Int) {
    let tmp = v1
    v1 = v2
    v2 = tmp
}
var num1 = 10
var num2 = 20
// 此处的参数传入的是参数的地址
swapValues(&num1, &num2)
print("\(num1)-----\(num2)")

// 通过元组包装参数进行地址的的转换
// 元祖元素的一一对换
func swapValuesYuanZu(_ v1: inout Int, _ v2: inout Int) {
    // 交换地址
    (v1, v2) = (v2, v1)
}
swapValuesYuanZu(&num1, &num2)
print("\(num1)-----\(num2)")
// 输入输出参数的⚠️事项
/*
 可变参数不能标记为inout
 inout参数不能有默认值
 inout参数只能传入可以被多次赋值的，也就是var 不能是let
 inout参数的本质是地址传递(引用传递)
 */



// 函数重载(Function Overload)
/*
 规则：
    函数名相同
    参数个数不同  /   参数类型不同  /   参数标签不同
 */
func sumOverload(v1: Int, v2: Int) -> Int {
    v1 + v2
    // return 都可以省略
}
// 重载：参数个数不同
func sumOverload(v1: Int, v2: Int, v3: Int) -> Int {
    v1 + v2 + v3
}

// 重载：参数类型不同
func sumOverload(v1: Int, v2: Double) -> Double {
    Double(v1) + v2
}
func sumOverload(v1: Double, v2: Int) -> Double {
    v1 + Double(v2)
}

// 重载：参数标签不同
func sumOverload(_ v1: Int, _ v2: Int) -> Int {
    v1 + v2
}
func sumOverload(a: Int, b: Int) ->Int {
    a + b
}


// 函数重载注意点1
// 返回值类型与函数重载无关——这就不构成函数的重载
func sumOverloadTest(v1: Int, v2: Int) -> Int {
    v1 + v2
}

func sumOverloadTest(v1: Int, v2: Int) {}

// Ambiguous use of 'sumOverloadTest(v1:v2:)'——无法选择具体的方法
// sumOverloadTest(v1: 10, v2: 20)
// 上面这个两个方法不能调用


// 默认参数值和函数重载一起使用产生二义性时，编译器并不会报错:(C++中会报错)
func sumOverloadCome(v1: Int, v2: Int) -> Int {
    v1 + v2
}

func sumOverloadCome(v1: Int, v2: Int, v3:Int = 10) -> Int {
    v1 + v2 + v3
}

// 会调用sumOverloadCome的方法
// 带默认可选参数的函数被调用的优先级低于初始的函数
print(sumOverloadCome(v1: 10, v2: 20))


// 函数重载注意点2
// 可变参数、省略参数标签、函数重载一起使用产生二义性时，"编译器"可能会报错
func sumB(v1: Int, v2: Int) -> Int {
    v1 + v2
}

func sumB(_ v1: Int, _ v2: Int) -> Int {
    v1 + v2
}

func sumB(_ numbers: Int...) -> Int {
   var total = 0
   for number in numbers {
       total += number
   }
   return total;
}
// Ambiguous use of 'sumB'
// sumB(10, 20)——也是不能用




// 内联函数(Inline Function)
// 如果开启了编译器优化（Release模式默认会开启优化)，编译器会自动将某些函数变成内联函数
// 将函数调用展开成函数体——>进行直接的调用不再开辟新的函数的空间节约性能和内存

// 举例说明
// func test() {
//     print("test")
// }
// test()
// 替换成print("test")
// 函数展开成函数体的前提是短小，节约内存。但不会破坏编译增加编译负担。该走内存走内存，该编译才编译。

// 哪些函数不会被内联：1.函数体比较长的时候   2.包含递归调用    3.包含动态派发，运行时调用谁





// 函数类型(Function Type)
func test() {}
// () -> Void 或者 ()->()
func sumFunctionType(a: Int, b: Int) -> Int {
    a + b
}
// 定义函数变量:  把函数作为参数进行传递
// (Int, Int) -> Int 这就是一个类型: 类似于Int、Double等
var fn:(Int, Int) -> Int = sumFunctionType
fn(2, 3)
print(fn(2, 30))



// 函数类型作为函数参数来进行传递
func sumPragram(v1: Int, v2: Int) -> Int {
    v1 + v2
}

func difference(v1: Int, v2: Int) -> Int {
    v1 - v2
}

func printResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result:   \(mathFunction(a, b))")
}

printResult(sumPragram, 10, 5)
printResult(difference, 10, 5)



// 函数类型作为函数的返回值
// 返回值是函数类型的函数，叫做高阶函数(Higher-Order Function)
func next(_ input: Int) -> Int {
    input + 1
}

func previous(_ input: Int) -> Int {
    input - 1
}

// 返回函数类型——也称为高阶函数
func forword(_ forword: Bool) -> (Int) -> Int {
    forword ? next : previous
}

print(forword(true)(5))
print(forword(false)(5))







// typealias
// typealias用来给类型起别名
typealias Byte = Int8
typealias Short = Int16
typealias Long = Int64
// 元祖
typealias Date = (year: Int, month: Int, day: Int)
func testDate(_ date: Date) {
    print(date.year)
    print(date.1)
    print(date.2)
}
// 传入一个元祖：提示性不是很好
testDate((2022, 9, 10))


// 函数类型的别名类型
typealias IntFn = (Int, Int) -> Int

func differenceIntFn(v1: Int, v2: Int) -> Int {
    v1 - v2
}

// 函数作为类型传递
let fnBieMing: IntFn = differenceIntFn
print(fnBieMing(50, 33))

// 函数作为参数传递
func setFn(_ fn: IntFn) {
    print(fn(111, 100))
}
setFn(fnBieMing)

// 函数作为返回值传递
func getFn() -> IntFn{
    differenceIntFn
}
// 返回函数进行执行
print(getFn()(100, 33))



// 嵌套函数(Nested Function)
// 将函数定义在函数内部
func forwardNestedFunction(_ forward: Bool) -> (Int) -> Int {
    func next(_ input: Int) -> Int {
        input + 1
    }
    
    func previous(_ input: Int) -> Int {
        input - 1
    }
    // 单一返回值可以省略return/下面这种不可以省略
    return forward ? next : previous
}
// 执行函数——返回一个函数——再执行这个返回的函数
print(forwardNestedFunction(true)(10))
print(forwardNestedFunction(false)(10))



// 按照Swift标准库的定义，Void就是空元组()
public typealias Void = ()
// 等价空元组



//: [Next](@next)

