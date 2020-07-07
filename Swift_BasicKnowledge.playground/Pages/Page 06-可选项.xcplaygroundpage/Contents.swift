//: [Previous](@previous)

import Foundation


// 可选项(Optional)
// 可选项，一般也叫可选类型，他允许将值设置为nil
// 在类型名称后面加个问号❓来定义一个可选项
var name: String? = "Jack"
print(name ?? 0)
name = nil

var age: Int?
age = 10
print(age!)
age = nil
// 输出带Optional的结果
// Optional("Jack")
// Optional(10)

var array = [1, 15, 40, 29]
func get(_ index: Int) -> Int? {
    if index < 0 || index > array.count - 1 {
        return nil
    }
    return array[index]
}
print(get(1) ?? 0)
print(get(-1) ?? 0)
print(get(4) ?? 0)



// 强制解包(Forced Unwrapping)
// 可选项是对其他类型的一层包装，可以将他理解为一个盒子
// 如果为nil，那么它是个空盒子
// 如果不为nil，那么盒子里装的是：被包装类型的数据

// 强制解包的前提是你能保证可选项不为nil，否则可选项将会报错

// 如果要从可选项中取出被包裹的数据(将盒子里装的东西取出来)，需要使用感叹号！进行强制解包
var ageA: Int? = 10
var ageInt: Int = ageA!
ageInt += 10
print(ageInt)

// 如果对值为nil的可选项(空盒子)进行强制解包，将会产生运行时错误:
// Fatal error: Unexpectedly found nil while unwrapping an Optional value: file Page 07-可选项.xcplaygroundpage, line 49
// var ageB: Int?
// ageB!


// 判断可选项是否包含值
// 这里需要手动解包⚠️
let number = Int("123")
if number != nil  {
    print("字符串转换整数成功:\(number!)")
} else {
    print("字符串转换整数失败")
}


// 可选项绑定(Optional Binding)
// 可以使用可选项绑定来判断可选项是否包含值
// 如果包含就自动解包，把值赋给一个临时的常量(let)或者变量(var),并且返回true，否则返回false
// 自动解包⚠️:  包含自动解包就不需要再强制解包了
if let numberA = Int("123")  {
    print("字符串转换整数成功:\(numberA)")
} else {
    print("字符串转换整数失败")
}

enum Season: Int {
    case spring = 1, summer, autumn, winter
}

if let season = Season(rawValue: 6) {
    switch season {
    case .spring:
        print("the season is spring")
    default:
        print("the season is other")
    }
} else {
    print("no such season")
}


// 经典等价写法："逗号   ,"分割
if let first = Int("4") {
    if let second = Int("42") {
        if first < second && second < 100 {
            print("\(first) < \(second) < 100")
        }
    }
}

// 这里的判断是嵌套关系
if let first = Int("4"),
    let second = Int("42"),
    first < second && second < 100 {
    print("\(first) < \(second) < 100")
}


// while循环中使用可选项绑定
// 遍历数组，将遇到的整数都加起来，如果遇到负数或者非数字，停止遍历
var strs = ["10", "20", "abc", "-20", "30"]
var index = 0
var sum = 0
// 此处就显示出了逐步判断的逻辑情况
while let num = Int(strs[index]), num > 0 {
    sum += num
    index += 1
}
// 执行前2项，后面的都不满足了
print(sum)


// 空合并运算符 ?? (Nil-Coalescing Operator)
// 可选项需要手动解包
// public func ?? <T>(Optional: T?, defaultValue: @autoclosure () throws -> T?) rethrows ->T?
// 非可选项会自动解包
// public func ?? <T>(Optional: T?, defaultValue: @autoclosure () throws -> T) rethrows ->T?

// a ?? b
// a 是可选项
// b 是可选项 或者 不是可选项
// b 跟 a的存储类型必须相同
// 如果a 不为 nil, 就返回a
// 如果a 为nil, 就返回b
// 如果b 不是可选项, 返回a时会自动解包
// 如果b 不是可选项, 返回b时也会自动解包


// 空合并运算符 ?? (Nil-Coalescing Operator)
let a: Int? = 1
let b: Int? = 2
let c = a ?? b
print(c!)

let a1: Int? = nil
let b1: Int? = 2
let c1 = a1 ?? b1
print(c1!)

let a2: Int? = nil
let b2: Int? = nil
let c2 = a2 ?? b2
print(c2 ?? 0)

let a3: Int? = 1
let b3: Int = 2
let c3 = a3 ?? b3
print(c3)

let a4: Int? = nil
let b4: Int = 2
let c4 = a4 ?? b4
print(c4)


// 多个 ?? 一起使用
let a5: Int? = 1
let b5: Int? = 2
let c5 = a5 ?? b5 ?? 3
print(c5)

let a6: Int? = nil
let b6: Int? = 2
let c6 = a6 ?? b6 ?? 3
print(c6)

let a7: Int? = nil
let b7: Int? = nil
let c7 = a7 ?? b7 ?? 3
print(c7)


// ??跟if let配合使用
let a8: Int? = nil
let b8: Int? = 2
if let c8 = a8 ?? b8 {
    print(c8)
}
// 类似于if a8！= nil || b8 != nil

if let c8 = a8, let d8 = b8 {
    print(c8)
    print(d8)
}
// 类似于if a!= nil && b!= nil



// if语句实现登录
func login(_ info: [String: String]) {
    let username: String
    if let tmpA = info["username"] {
        username = tmpA
    } else {
        print("请输入用户名")
        return
    }
    
    let password: String
    if let tmpB = info["password"] {
        password = tmpB
    } else {
        print("请输入密码")
        return
    }
    print("用户名\(username)", "密码\(password)", "登录ing")
}

login(["username": "jack", "password" : "123456"])
login(["username": "jack"])
login(["password" : "123456"])




// guard语句
// 当guard语句的条件为false时，就会执行大括号里面的代码
// 当guard语句的条件为true时，就会跳过guard语句
// guard语句特别适合用来 "提前退出"
// guard处理特殊情况，正常的就放过去了
func loginA(_ info: [String: String]) {
    
    guard let username = info["username"] else {
        print("guard: 请输入用户名")
        return
    }
    guard let password = info["password"] else {
        print("guard: 请输入密码")
               return
    }
    print("guard: 用户名\(username)", "密码\(password)", "登录ing")
}

loginA(["username": "jack", "password" : "123456"])
loginA(["username": "jack"])
loginA(["password" : "123456"])


// 隐式解包(Implicity Unwrapped Optional)
// 在某些情况下，可选项一旦被设定值之后，就会一直拥有值
// 在这种情况下，可以去掉检查，也不必每次访问的时候都进行拆包，因为它能确定每次访问的时候都有值
// 可以在类型后面加个感叹号！定义一个隐式解包的可选项
// 隐式解包值不能为nil会报错
let num1: Int! = 10
let num2: Int = num1
if num1 != nil {
    print(num1 + 6)
}

if let num3 = num1 {
    print(num3)
}




// 可选项在字符串插值或者直接打印时，编译器会发出警告
// Int有面的问号要紧跟着，这是一个运算符
var ageC: Int? = 10
//print("My ageC is\(ageC)")

// 至少3种方法消除警告
// 手动强制解包
print("My ageC is\(ageC!)")

// 描述解包
print("My ageC is\(String(describing: ageC))")

// 合并解包
print("My ageC is\(age ?? 0)")



// 多重可选项的学习和理解

















//: [Next](@next)
