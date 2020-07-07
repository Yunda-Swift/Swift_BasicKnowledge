//: [Previous](@previous)

import UIKit
import PlaygroundSupport

// if - else: if后面的条件类型只能是bool类型，Swift中没有非0即正
let ageNumber = 4
if ageNumber >= 22 {
    print("Get married")
} else if ageNumber >= 18 {
    print("Being a adult")
} else if ageNumber >= 7 {
    print("Go to school")
} else {
    print("Just a child")
}


// while
var num1 = 5
while num1 > 0 {
    print("num is \(num1)")
    num1 -= 1
}

var num2 = -1
repeat {
    print("num is \(num2)")
} while num2 > 0
/*
 repeat_while相当于C语言中的do_while
 这里不用num--，是因为从Swift3开始，去除了自增（++）、自减（--）运算符
 **/

// for
// 区间运算起步3个点呦

var age = 10

// 闭区间运算符
let range = 1...3

for i in 0...3 {
    print(i)
}

for _ in 0...3 {
    print("用不到i时避免警告用_替代i")
}

// i默认是常量let不可变，要改变就下面这样改
for var i in 1...3 {
    i += 5
    print(i)
}

// 半开区间运算符：a..<b
for i in 0..<5 {
    print(i)
}

// 单侧区间： 让区间朝一个方向尽可能地远
// 单侧区间——用中括号扩起来
let names = ["Anna", "Alex", "Brian", "Jack"]

for name in names[0...3] {
    print(name)
}

for i in names[2...] {
    print(i)
}

for i in names[...2] {
    print(i)
}

for i in names[..<2] {
    print(i)
}

// 单侧区间的范围的条件判断
let rangeNumber = ...5
// return falseA
rangeNumber.contains(7)
print(range.contains(7))
// return true
rangeNumber.contains(4)
print(range.contains(4))
// return false
rangeNumber.contains(-3)
// 此处不包括负数
print(range.contains(-3))


// 区间类型
// 封闭区间
let range1: ClosedRange<Int> = 1...3
// 半开半闭区间
let range2: Range<Int> = 1..<3
// 单侧区间
let range3: PartialRangeThrough<Int> = ...5


// 字符、字符串也能使用区间运算符，但默认不能用在for-in中
let stringRange1 = "cc"..."ff"
stringRange1.contains("dd")
stringRange1.contains("dz")
stringRange1.contains("fg")

let stringRange2 = "a"..."f"
stringRange2.contains("a")
stringRange2.contains("d")
stringRange2.contains("h")

// \0到～囊括了所有可能要用到的ASCII字符
let characterRange:ClosedRange<Character> = "\0"..."~"
characterRange.contains("G")
// return true


// 字符、字符串也能使用区间运算符，但默认不能用在for-in中——截图page04——但是可以用在range中
// 可以展示图片
let imageView = UIImageView(image: UIImage(named: "page04"))
PlaygroundPage.current.liveView = imageView

// Character的展示——
let str:Character = "b"
let a:Character = "a"
let z:Character = "z"
let rangeCharacter = a...z
print("rangeCharacter")
rangeCharacter.contains(str)


// 带间隔的区间值
let hour = 10
let hourInterval = 2
// tickMark的取值：从4开始，累加间隔2，不超过10
// 半开半闭区间，包括4不包括10 —— 4..<10
for tickMark in stride(from: 4, to: hour, by: hourInterval) {
    print(tickMark)
    // 4   6   8   10
}

// switch————case、default后面是不能写大括号{}
let number = 1
switch number {
case 1:
    print("1")
    break
    // break默认可以不写，并不会贯穿到后面的条件——相当于默认有break
case 2:
    print("2")
    break
    // fallthroughy可以实现条件判断的贯穿，即使满足条件后面还可以继续执行——直到遇见下一个break
default:
    // 必须得有defalut也就是else的情况，必须加否则不安全就会报错——Switch must be exhaustive
    print("3")
    // 如果不想做任何事情，可以仅添加break这一行代码就够了
    break
    // 安全性比较高的代码
}

// 特殊情况：如果能保证已处理所有情况，也可以不必使用default


// 复合条件
// switch也支持Character、String类型
// Invalid redeclaration of 'age' —— “age”的重新声明无效/重复定义
switch age {
case 0:
    fallthrough
case 1:
    print("1 2")
default:
    print("other")
}

// 如果能保证已处理的所有情况，也可以不必使用default
// 由于已确定answer是Answer类型，因此可以省略Answer
enum Answer {case right, wrong}
let answer = Answer.right
switch answer {
// case Answer.right:
case .right:
    print("right")
case .wrong:
    print("wrong")
}

// 11
let string = "Jack"
switch string {
case "RoseJack":
    print("Right person1")
case "Jack":
    fallthrough
    // 仔细体会这个关键字的使用
case "Rose":
    print("Right person1")
default:
    break
}

// 11和22的写法是等价的

// 22
switch string {
case "Jack", "Rose":
    print("Right person2")
default:
    break
}


// 区间匹配、元祖匹配

// 区间匹配的显示
let count = 62
switch count {
case 0:
    print("none")
case 1..<5:
    print("a few")
case 5..<12:
    print("several")
case 12..<100:
    print("dozens of")
case 100..<1000:
    print("hundreds of")
default:
    print("many")
}

// 元祖匹配——坐标轴的判断问题
let point = (1, 1)
switch point {
case (0, 0):
    print("the origin")
case (_, 0):
    print("on the x-axis")
case (0, _):
    print("on the y-axis")
case (-2...2, -2...2):
    print("inside the box")
default:
    print("outside of the box")
}

// 值绑定 ——必要时let可以换成var
let pointA = (2, 0)
switch pointA {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case (let x, let y):
    print("somewhere else at (\(x) ,\(y))")
//default:
//    break
}

// where ——(X, y)元祖作为数组显示
let pointB = (1, -1)
switch pointB {
case let (x, y) where x == y:
    print("on the line x == y")
case let (x, y) where x == -y:
    print("on the line x == -y")
case (let x, let y):
    print("(\(x) ,\(y)) is just some arbitrary point")
}

// where的作用就是条件过滤
// 将所有正数加起来
var numbers = [10, 20, -10, -20, 30, -30]
var sum = 0
for num in numbers where num > 0 {
    sum += num
}

// 标签语句
outer: for i in 1...4 {
    for k in 1...4 {
        if k == 3 {
            continue outer
        }
        if i == 3 {
            break outer
        }
        print("i==\(i), k==\(k)")
    }
}

//: [Next](@next)
