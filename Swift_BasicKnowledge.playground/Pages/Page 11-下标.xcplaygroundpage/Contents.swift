//: [Previous](@previous)

import Foundation


// 下标(subscript)
// 使用subscript可以给任意类型(枚举、结构体、类)增加下标功能，有些地方翻译为：下标脚本
// subacript的语法类似于实例方法、计算属性，本质就是方法(函数)
class Point {
    var x = 0.0, y = 0.0
    subscript(index: Int) -> Double {
        set {
            if index == 0 {
                x = newValue
            } else if index == 1 {
                y = newValue
            }
        }
        
        get {
            if index == 0 {
                return x
            } else if index == 1 {
                return y
            }
            return 0
        }
    }
}
var p = Point()
p[0] = 11.1
p[1] = 22.2
print(p.x)
print(p.y)
print(p[0])
print(p[1])
// subscript中定义的返回值类型决定了
// get方法的返回值类型
// set方法中newValue的类型
// subscript可以接受多个参数，并且类型任意








// 下标的细节
// subscript可以没有set方法，但必须要有get方法
class PointA {
    var x = 0.0, y = 0.0
    subscript(index: Int) -> Double {
        get {
            if index == 0 {
                return x
            } else if index == 1 {
                return y
            }
            return 0
        }
    }
}

// 如果只有get方法，可以省略get
class PointC {
    var x = 0.0, y = 0.0
    subscript(index: Int) -> Double {
        if index == 0 {
            return x
        } else if index == 1 {
            return y
        }
        return 0
    }
}


// 可以设置参数标签
class PointD {
    var x = 0.0, y = 0.0
    subscript(index i: Int) -> Double {
        if i == 0 {
            return x
        } else if i == 1 {
            return y
        }
        return 0
    }
}
// 反向取值方法
var pd = PointD()
pd.y = 22.2
print(pd[index: 1])



// 下标可以是类型方法
class Sum {
    static subscript(v1: Int, v2: Int) -> Int {
        return v1 + v2
    }
}
print(Sum[10, 22])





// 结构体、类作为返回值对比
class PointE {
    var x = 0, y = 0
}

class PointManagerE {
    var point = PointE()
    subscript(index: Int) -> PointE {
        get {point}
    }
}

struct PointF {
    var x = 0, y = 0
}
class PointManagerF {
    var point = PointF()
    subscript(index: Int) -> PointF {
        set { point = newValue }
        get { point }
    }
}

var pm = PointManagerE()
pm[0].x = 11
pm[0].y = 22
print(pm[0])
print(pm.point)


var pma = PointManagerF()
pma[0].x = 11
pma[0].y = 22
print(pma[0])
print(pma.point)

// __lldb_expr_2.PointE
// __lldb_expr_2.PointE
// PointF(x: 11, y: 22)
// PointF(x: 11, y: 22)
// 也不知道说明了个啥，学习学习吧





// 接收多个参数的下标
class Grid {
    var data = [
        [2, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
    ]
    subscript(row: Int, column: Int) -> Int {
        set {
            guard row >= 0 && row < 3 && column >= 0 && column < 3 else {
                return
            }
            data[row][column] = newValue
        }
        get {
            guard row >= 0 && row < 3 && column >= 0 && column < 3 else {
                return 0
            }
            return data[row][column]
        }
    }
}

var grid = Grid()
grid[0, 0] = 77
grid[1, 1] = 88
grid[2, 2] = 99
print(grid.data)








//: [Next](@next)
