//: [Previous](@previous)

import Foundation

var str = "从OC 到 Swift"
// MARK: 类似于OC中的#pragma mark
// MARK: - 类似于OC中的#pragma mark -
// TODO: 用于标记未完成的任务
// FIXME: 用于标记待修复的问题


func test() {
    // TODO: 未完成
}

func test2() {
    var age = 10
    // FIXME: 有待修复
    age += 20
}

public class Person {
    // MARK: - 属性
    var age = 0
    var weight = 0
    var height = 0
    
    
    // MARK: - 私有方法
    // MARK: 跑步
    private func run1() {}
    private func run2() {}
    
    // MARK: 走路
    private func walk1() {}
    private func walk2() {}
    
    // MARK: 公共方法
    public func eat1() {}
    public func eat2() {}
    
}




// 条件编译
// 操作系统:macOC\iOS\tvOS\watchOC\Linux\Android\Windows\FreeBSD
#if os(macOS) || os(iOS)
// CPU架构: i386\x86_64\arm\arm64
#elseif arch(x86_64) || arch(arm64)
// swift版本
#elseif swift(<5) && swift(>=3)
// 是否模拟器
#elseif targetEnvironment(simulator)
// 可以导入某模块
#elseif canImport(Foundation)
#else
#endif



// debug模式 这是一个标记，Swift中没有宏的定义
#if DEBUG
// release模式
#else
#endif

#if TEST
print("test")
#endif

#if OTHER
print("other")
#endif



// 打印——打印是个什么东西？
// 打印出所在文件路径、行数、内容——外界谁调用打出谁的路径
func log<T>(_ msg: T,
            file: NSString = #file,
            line: Int = #line,
            fn: String = #function) {
    #if DEBUG
    let prefix = "\(file.lastPathComponent)_\(line)_\(fn):"
    print(prefix, msg)
    #endif
}



// 系统版本检测
if #available(iOS 10, macOS 10.12, *) {
    // 对于iOS平台，只在iOS10及以上版本执行
    // 对于macOC平台，只在macOS 10.12及以上版本执行
    // 最后的*表示在其他所有平台都执行
}




// API可用性说明
//@available(iOS 10, macOS 10.15, *)
//class Person {}
//
//struct Student {
//    替换方法名字
//    @available(*, unavailble, renamed: "study")
//    func study_() {}
//    func study() {}
//
//    @available(iOS, deprecated: 11)
//    @available(macOS, deprecated: 10.12)
//    func run() {}
//}


// iOS程序的入口
// 在AppDelegate上面默认有个@UIApplicationMain标记，这表示
// 编译器自动生成入口代码(main函数代码),自动设置AppDelegate为App代理

// 也可以删掉@UIApplicationMain,自定义入口代码: 新建一个main.swift文件






// Swift调用OC的代码 —@_silgen_name
// 如果c语言暴漏给Swift的函数名跟Swift中的其他函数名冲突了
// 可以在Swift中使用@_silgen_name修改C函数名
// c语言
//Int sum(Int a, Int b) {
//    return a + b
//}
//
//// Swift
//@_silgen_name("sum") func swift_sum(_ v1: Int32, _v2: Int32) -> Int32
//print(swift_sum(10, 20))
//print(sum(10, 20))


















// OC要调用Swift的使用方法和注意事项
// OC调用Swift-(targetName)-Swift.h
// Swift暴露给OC的类最终继承自NSObject
// 使用@objc修饰需要暴露给OC的成员
// 使用@objcMembers修饰类


// 代表默认所有成员都会暴露给OC(包括扩展中定义的成员)
// 最终是否成功暴露，还需要考虑成员自身的访问级别


// 可以通过@objc重命名Swift暴露给OC的符号名(类名、属性名、函数名等)
// Xcode会根据Swift代码生成对应的OC声明, 写入{targetName}-Swift












// A
// 选择器(Selector)
// Swift中依然可以使用选择器，使用#selector(name)定义一个选择器
// 必须是被@objcMembers或@objc修饰的方法才可以定义选择器——————使用条件
@objcMembers class PersonA: NSObject {
    func test1(v1: Int) { print("test1") }
    func test2(v1: Int, v2: Int) { print("test2(v1, v2)") }
    func test2(_ v1: Double, _ v2: Int) { print("test2(_:_:)") }
    func run() {
        perform(#selector(test1))
        perform(#selector(test1(v1:)))
        perform(#selector(test2(v1:v2:)))
        perform(#selector(test2(_:_:)))
    }
}










// B
// Swift的字符串类型String, 跟OC的NSString, 在API设计上还是有较大差异/目前可以自动乔接
// 空字符串
var emptyStr1B = ""
var emptyStr2B = String()

var strB = "123456"
print(strB.hasPrefix("123"))
print(strB.hasSuffix("456"))



var strB1: String = "1"
// 拼接，jack_rose
strB1.append("_2")
// 重载运算符 +
strB1 = strB1 + "_3"
// 重载运算符 +=
str += "_4"
// \()插值
strB1 = "\(str)_5"
print(strB1.count)



// String的插入和删除
var strB2 = "1_2"
// 1_2
// 增加
strB2.insert("_", at: strB2.endIndex)
print(strB2)
strB2.insert(contentsOf:"3_4", at: strB2.endIndex)
print(strB2)
strB2.insert(contentsOf:"666", at: strB2.index(after: strB2.startIndex))
print(strB2)
strB2.insert(contentsOf:"888", at: strB2.index(before: strB2.endIndex))
print(strB2)
strB2.insert(contentsOf:"hello", at: strB2.index(strB2.startIndex, offsetBy: 4))
print(strB2)

// 删除
strB2.remove(at: strB2.firstIndex(of: "1")!)
print(strB2)
// 删除所有的6
strB2.removeAll {$0 == "6"}
print(strB2)
var range = str.index(strB2.endIndex, offsetBy: -4)..<strB2.index(before: strB2.endIndex)
strB2.removeSubrange(range)
print(strB2)



// C
// Substring
// String可以通过下标、prefix、suffix等截取子串，子串类型不是String，而是Substring
var strC = "1_2_3_4_5"
var substr1 = strC.prefix(3)
print(substr1)
var substr2 = strC.suffix(3)
print(substr2)
var rangeC = strC.startIndex..<strC.index(strC.startIndex, offsetBy: 3)
var substr3 = strC[rangeC]

// 最初的string1_2_3_4_5
// 原来依赖的基础是什么
print(substr3.base)

// Substring -> String
var strC2 = String(substr3)
print(strC2)
// Substring和它的base，共享字符串数据
// Substring发生修改或者转为String时，会分配新的内存存储x字符串数据


// E
// string与Character
for c in "jack" {
    print(c)
}
var strE = "jack"
// c是Character类型
var c = strE[strE.startIndex]
print(c)




// String相关的协议
// 多行String
// 自行了解一下


// F
// String 与 NSString
// String 与 NSString 之间可以随时随地桥接转换
// 如果你觉得String的API过于复杂难用，可以考虑将String转为NSString
var strF1: String = "jack"
var strF2: NSString = "rose"

var strF3 = strF1 as NSString
var strF4 = strF2 as String

var strF5 = strF3.substring(with: NSRange(location: 0, length: 2))
print(strF5)
// 比较字符串内容是否等价
// String使用 == 运算符
// NSString使用isEqual方法,也可以使用 == 运算符(本质还是调用了isEqual方法)


// Swift和OC桥接转换表
/*
 String <-> NSString
 String <-  NSMutableString
 Array <->  NSArray
 Array <-   NSMyutableArray
 Dictionary <-> NSDictionary
 Dictionary <- NSMutableDictionary
 Set <-> NSSet
 Set <- NSMutableSet
 */




// G
// 只能被class继承的协议
protocol Runnable1: AnyObject {}
protocol Runnable2: class {}
@objc protocol Runnable3 {}
// 被@objc 修饰的协议，还可以暴露给OC去遵守实现



// H
// 可以通过@objc定义可选协议，这种协议只能被class遵守    是类嘛？
@objc protocol RunnableH {
    func run1()
    @objc optional func run2()
    func run3()
}

class DogH: RunnableH {
    func run3() { print("Dog run3") }
    func run1() { print("Dog run1") }
    func run2() { print("DogH run2....") }
}

var d = DogH()
d.run1()
d.run3()
d.run2()




// I
// dynamic
// 被@objc dynamic修饰的内容会具有动态性，比如调用方法会走runtime那一套流程
class DogI: NSObject {
    @objc dynamic func test1() {}
    func test2() {}
}
var dI = DogI()
dI.test1()
dI.test2()





// J
// KVC/KVO
// Swift支持KVC\KVO的条件
// 属性所在的类、监听器最终继承自NSObject
// 用@objc dynamic修饰对应的属性
class Observer: NSObject {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("obsetveValue", change?[.newKey] as Any)
    }
}
class PersonJ: NSObject {
    @objc dynamic var age: Int = 0
    var observer: Observer = Observer()
    override init() {
        super.init()
        self.addObserver(observer, forKeyPath: "age", options: .new, context: nil)
    }
    deinit {
        self.removeObserver(observer, forKeyPath: "age")
    }
}

var pI = PersonJ()
pI.age = 20
pI.setValue(25, forKey: "age")






// K
// block方式的KVO
class PersonK: NSObject {
    @objc dynamic var age: Int = 0
    var observation: NSKeyValueObservation?
    override init() {
        super.init()
        observation = observe(\PersonK.age, options: .new) {
            (person, change) in
            print(change.newValue as Any)
        }
    }
}
var p = PersonK()
p.age = 32
p.setValue(30, forKey: "age")





// L
// 关联对象(Associated Object)
// 在Swift中，class依然可以使用关联对象
// 默认情况，extension不可以增加存储属性
// 借助关联对象，可以实现类似extension为class增加存储属性的效果
class PersonL{}
extension PersonL {
    private static var AGE_KEY: Void?
    var age: Int {
        get {
            (objc_getAssociatedObject(self, &Self.AGE_KEY) as? Int) ?? 0
        }
        set {
            (objc_setAssociatedObject(self, &Self.AGE_KEY, newValue, .OBJC_ASSOCIATION_ASSIGN))
        }
    }
}

var personl = PersonL()
print(personl.age)
personl.age = 11
print(personl.age)





// 资源名管理————————————是个什么东东，有什么用处?











// 多线程开发——异步
// 换编译器了得



//: [Next](@next)
