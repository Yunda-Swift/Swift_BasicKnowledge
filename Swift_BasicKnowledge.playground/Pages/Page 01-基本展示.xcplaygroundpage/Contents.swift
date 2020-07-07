import UIKit

// 变量类型的使用

// 只能赋值1次
// 保证只赋值一次， 初次指定类型可以不赋值 ：也可以直接赋值不指定类型自行推导
let age: Int
age = 10

// 它的值不要求在编译时期确定，但使用之前必须赋值1次

// Swift相对于OC而言更加的安全，例如：常量、变量在初始化之前，都不能使用，使用就会报错——OC中则没有



var str = "Hello, playground"
let a = 10
let b = 20
var c = a + b
c += 10
c += 20

import UIKit
import PlaygroundSupport

// 可以展示单一的view
let view = UIView()
view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
view.backgroundColor = UIColor.red
PlaygroundPage.current.liveView = view

// 可以展示图片
let imageView = UIImageView(image: UIImage(named: ""))
PlaygroundPage.current.liveView = imageView

// 可以展示控制器
let vc = UITableViewController()
vc.view.backgroundColor = UIColor.lightGray
PlaygroundPage.current.liveView = vc


//: [下一页](@next)
