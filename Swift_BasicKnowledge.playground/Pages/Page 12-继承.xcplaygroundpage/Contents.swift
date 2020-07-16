//: [Previous](@previous)

import Foundation
import UIKit

var str = "继承"

// 继承
// 值类型(枚举、结构体)不支持继承，只有类支持继承
// 没有父类的类，称为：基类
// Swift并没有像OC、Java、那样的规定：任何类最终都要继承自某个基类
// 子类可以重写父类的下标、方法、属性，重写必须加上override关键字


// 内存结构
class Animal {
    var age = 0
}

class Dog: Animal {
    var weight = 0
}

class Erha: Dog {
    var iq = 0
}

let a = Animal()
a.age = 10


let d = Dog()
d.age = 10
d.weight = 20


let e = Erha()
e.age = 10
e.weight = 20
e.iq = 30


// 重写实例方法、下标
class AnimalA {
    func speak() {
        print("AnimalA speak A")
    }
    subscript(index: Int) -> Int {
        return index
    }
}

var animal: AnimalA
animal = AnimalA()
animal.speak()
print(animal[6])



class Cat: AnimalA {
    override func speak() {
        super.speak()
        print("Cat speakC")
    }
    
    override subscript(index: Int) -> Int {
        return super[index] + 1
    }
}
animal = Cat()
animal.speak()
print(animal[6])
// 可以通过设置不同的下标执行不同的事情


// 重写类型方法、下标——  哪些可以被重写，哪些不可以被重写
// 被class修饰的类型方法、下标，允许 被子类重写
// 被static修饰的类型方法、下标，不允许 被子类重写
class AnimalB {
    class func speak() {
        print("Animal speak")
    }
    
    class subscript(index: Int) -> Int {
        return index
    }
}

AnimalB.speak()
print(AnimalB[6])


class CatB: AnimalB {
    override class func speak() {
        super.speak()
        print("Cat speak")
    }
    
    override class subscript(index: Int) -> Int {
        return super[index] + 1
    }
}
CatB.speak()
print(CatB[6])



// 重写属性： 要求
// 子类可以将父类的属性(存储、计算)重写为计算属性
// 子类不可以将父类属性重写为存储属性
// 只能重写var属性，不能重写let属性
// 重写时，属性名、类型要一致


// 子类重写后的属性权限 不能小于 父类属性的权限 ——> 只能扩不能缩
// 1. 如果父类属性是只读的，那么子类重写后的属性可以是只读的、也可以是可读写的
// 2. 如果父类属性是可读写的，那么子类重写后的属性也必须是可读写的



// 重写实例属性
class Circle {
    var radius: Int = 0
    var diameter: Int {
        set {
            print("Circle setDiameter")
            radius = newValue / 2
        }
        get {
            print("Circle getDiameter")
            return radius * 2
        }
    }
}

var ciecle: Circle
ciecle = Circle()
ciecle.radius = 6
print(ciecle.diameter)

ciecle.diameter = 22
print(ciecle.radius)
print(ciecle.diameter)
print("分割线..............")

// 重写实例属性
class SubCircle: Circle {
    // 存储属性可以变成计算属性
    override var radius: Int {
        set {
            print("SubCircle setRadius")
            super.radius = newValue > 0 ?  newValue : 0
        }
        get {
            print("SubCircle getRadius")
            return super.radius
        }
    }
    
    override var diameter: Int {
        set {
            print("SubCircle setDiameter")
            super.diameter = newValue > 0 ?  newValue : 0
        }
        get {
            print("SubCircle getDiameter")
            return super.diameter
        }
    }
}
var circleSub = SubCircle()
circleSub.radius = 6
print(circleSub.diameter)
print(circleSub.radius)

circleSub.diameter = 20
print(circleSub.diameter)
print(circleSub.radius)


// 重写类型属性
// 被class修饰的计算类型属性，可以被子类重写
// 被static修饰的类型属性(存储、 计算), 不可以被子类重写
class CircleC {
    static var radius: Int = 0
    class var diameter: Int {
        set {
            print("CircleC setDiameter")
            radius = newValue / 2
        }
        get {
            print("CircleC getDiameter")
            return radius * 2
        }
    }
}

class SubCircleC: CircleC {
    override class var diameter: Int {
        set {
            print("SubCircleC setDiameter")
            super.diameter = newValue > 0 ? newValue : 0
        }
        get {
            print("SubCircleC getDiameter")
            return super.diameter
        }
    }
}
CircleC.radius = 6
print(CircleC.radius)
print(CircleC.diameter)

CircleC.diameter = 20
print(CircleC.radius)
print(CircleC.diameter)


SubCircleC.radius = 11
print(SubCircleC.radius)


SubCircleC.diameter = 20
print(SubCircleC.diameter)
print(SubCircleC.radius)



// 属性观察器
// 可以在子类中为父类属性(除了只读计算属性、 let属性)增加属性观察器
class CircleD {
    var radius: Int = 1
}

class SubCircleD: CircleD {
    override var radius: Int {
        willSet {
            print("SubCircleC willSetRadius", newValue)
        }
        didSet {
            print("SubCircleC didSetRadius", oldValue, radius)
        }
    }
}
var circleD = SubCircleD()
circleD.radius = 10


// 属性观察器2
// 对象属性观察器
class CircleE {
    var radius: Int = 1 {
        willSet {
            print("CircleE willSetRadius", newValue)
        }
        didSet {
            print("CircleE didSetRadius", oldValue, radius)
        }
    }
}

class SubCircleE: CircleE {
    override var radius: Int {
        willSet {
            print("SubCircleE willSetSubCircleE", newValue)
        }
        didSet {
            print("SubCircleE didSetSubCircleE", oldValue, radius)
        }
    }
}
print("这个执行过程..........................循环滚动执行结束2")
var circleE = SubCircleE()
circleE.radius = 10;



// 属性观察器3
// 对象属性
class CircleF {
    var radius: Int {
        set {
            print("CircleF setRadius", newValue)
        }
        get {
            print("CircleF getRadius")
            return 20
        }
    }
}

class SubCircleF: CircleF {
    override var radius: Int {
        willSet {
            print("SubCircleF willSetSubCircleF", newValue)
        }
        didSet {
            print("SubCircleF didSetSubCircleF", oldValue, radius)
        }
    }
}
print("这个执行过程..........................循环滚动执行结束3")
var circleF = SubCircleF()
circleF.radius = 10



// 属性观察器4
// class类属性
class CircleG {
    class var radius: Int {
        set {
            print("CircleG setRadius", newValue)
        }
        get {
            print("CirCle getRadius")
            return 20
        }
    }
}

class SubCircleG: CircleG {
    override class var radius: Int {
        willSet {
            print("SubCircleG willSetSubCircleG", newValue)
        }
        didSet {
            print("SubCircleG didSetSubCircleG", oldValue, radius)
        }
    }
}
print("这个执行过程..........................循环滚动执行结束4")
SubCircleG.radius = 10




// final 最终的不能修改的
// 被final修饰的    方法、下标、属性、   禁止被重写
// 被final修饰的    类，  禁止被继承







//: [Next](@next)
