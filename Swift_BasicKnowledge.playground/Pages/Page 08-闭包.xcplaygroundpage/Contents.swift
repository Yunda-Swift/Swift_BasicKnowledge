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














//: [Next](@next)
