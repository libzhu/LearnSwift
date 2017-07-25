//: Playground - noun: a place where people can play

import UIKit

var str = "扩展"

/*
 · 扩展语法
 · 计算型属性
 · 构造器
 · 方法
 · 下标
 · 嵌套类型
 
 */
//扩展 就是为了一个已有的类、结构体、枚举类型或者协议类型添加新功能。这包括在没有权限获取到源代码的情况下扩展类型的能力（即逆向建模）。扩展和Objective-C中的分类类似。
//Swift中的扩展可以：
/*
 
 · 添加计算性属性和计算型类型属性
 · 定义实例方法和类型方法
 · 提供新的构造器
 · 定义下标
 · 定义和使用新的嵌套类型
 · 使一个已有类型符合某个协议
 
 */

//在swift中 甚至可以对协议进行扩展，提供协议要求的实现。或者添加额外的功能， 从而可以让符合协议的类型拥有这些功能。
//注意可以为一个类型添加新的功能， 但是不能重写已有的功能。

//1、扩展语法
//使用关键字 extension 来声明扩展
//extension SomeType {
//    
//    //为someType 添加新的功能
//}

//可以通过扩展一个已有的类型，使其采纳一个或多个协议。这种情况下，无论是类 结构体， 协议名字的书写方式完全一样
//extension SomeType : SomeProtocol, AnohterProtocol {
//    
//    //协议的实现写在这里。
//}

//计算性属性
//扩展可以为已有类型添加实例属性和计算类型属性，下面的例子中Swift 的内建 Double 类型添加了五个计算属性实例， 从而提供与距离单位协作的基本支持：
extension Double {
    
    var km : Double { return self * 1_000.0 }
    var m  : Double { return self }
    var cm : Double { return self / 100.0 }
    var mm : Double { return self / 1_000.0 }
    var ft : Double { return self / 3.28084 }
    

}

let oneInch = 25.4.mm
print("one Inch is \(oneInch) meters")

let threeFeet = 3.ft
print("three feet is \(threeFeet) meters")

let fiveM = 5.m
print("five mi \(fiveM)")

//这些计算属性表达式的含义是把 一个 Double 值看作是某个单位下的长度值。即使把他们实现为计算型属性，但这些属性的名字人可以紧接着一个浮点型字面值， 从而通过点语法来使用， 并以此实现距离转换。
//上述例子中， Double 值 1.0 用来表示1米， 这就是为什么计算属性m 返回的self， 及表达式1.m 被认为计算Double值 1.0；
//其他单位则需要一些换算， 一千米等于1000米， 所以计算属性km 要把值乘以1_000.0来实现千米到米的单位换算， 类似的，一米有3.28024英尺， 所以计算型属性 ft 要把对应的 Double值除以 3.28024来实现英尺对米的单位换算。
//这些属性是只读的计算属性，为了更简洁， 省略了 get 关键字。 他们的返回值 是 Double 而且可以用于所有接受Double 值的数学计算中

let aMarathon = 42.km + 195.ft
print("A marathon is \(aMarathon) meters long")

//注意：扩展可以添加新的计算型属性， 但是不可以添加存储型属性， 也不可以为已有的属性添加属性观察器。

//构造器
//扩展可以为已有类型添加新的构造器。这可以让你扩展其他类型， 将你自己定制的类型作为其构造器构造器参数， 或者提供该类型的原始实现中未提供的额外的初始化选项。
//扩展能为类添加新的便利构造器 但是他们不能为类添加新的指定构造器或析构器， 指定构造器和析构器必须总是由原始的类实现来提供的。
//注意：如果你使用扩展为值类型添加构造器，同时该值类型的原始实现中未定义任何定制的构造器切所有的存储属性提供了默认值， 那么我们可以在扩展中的构造器里调用默认构造器和逐一成员构造器。正如在 值类型的构造器代理中描述的， 如果你把定制的构造器写在值类型的原始实现中 上述规则将不再实用。

//下面的例子：定义了一个描述几何矩形的结构体 Rect 这个例子同时定义了连个辅助结构体Size 和 Point 它们都把 0.0 作为所有属性的默认值 

struct Size {
    
    var width = 0.0, height = 0.0
    
}

struct Point {
    
    var x = 0.0, y = 0.0
    
}

struct Rect {
    
    var size = Size()
    var origin = Point()
    
}

//以为结构体Rect 未提供 定制的构造器， 因此它会获得一个逐一成员构造器，应为它又对所有存储属性都提供了默认值， 他又会获得一个默认值构造器，

let defaultRect = Rect()//默认构造器

let memberwiseRect  = Rect(size : Size(width : 5.0, height : 5.0), origin : Point(x : 2.0 , y : 2.0))

//可以提供一个额外的接受指定中心点和大小的构造器来扩展 Rect 结构体

extension Rect {
    
    init(center : Point, size : Size) {
        
        let originX = center.x - size.width / 2
        let originY = center.y - size.height / 2
        self.init(size : size, origin : Point(x : originX, y : originY))
    }
}

//这个新的构造器首先根据提供的 center 和 size 的值计算一个合适的原点。 然后调用结构体的主意成员构造器 init（origin： size：）该原点将新的原点和大小的值保存在相应的属性中

let centerRect = Rect(center : Point(x : 4.0, y : 4.0), size : Size(width : 3.0, height : 3.0))
print(centerRect.origin, centerRect.size)


//方法：
//扩展可以为已有类型的添加新的实例方法和类型方法。下面的例子为Int 类型添加了一个名为repetitions 的实例方法。
extension Int {
    
    func repetitions(task : () -> Void) {
        
        for _ in 0..<self {
            
            task()
        }
    }
}

//这个 repetition（task ： ）方法接受一个 （）—> Void 类型的单参数， 表示没有参数没有返回值的函数。定义该扩展之后， 你就可以对任意整数调用repetition(task:)方法， 将闭包中的任务执行整数对应的次数。
7.repetitions {
    print("good")
}
3.repetitions { 
    print("hello")
}

//可变实例方法
//通过扩展添加的实例方法也可以修改该实例本事。结构体和枚举类型中修改self 或其属性的方法必须将该实例方法 标注为 mutating （变化、可变）正如来自原始实现的可变方法一样。
//下面的例子：Int 类型添加了一个名为square 的可变方法，用于计算原始值的平方
extension Int{
    
    mutating func square(){
        
        self = self * self
    }
    
}

var someInt = 3
someInt.square()
print(someInt)

//下标
//扩展可以为已有类型添加新下标。
//例子：为Int类型添加了一个整型下标。该下标【n】返回十进制数字从右向左的第n个数字。
// 123456789[0] 返回 9  123456789[1] 返回8

extension Int {
    
    subscript(digitIndex : Int) -> Int {
    
    
        var decimalBase = 1
        
        for _ in 0..<digitIndex {
            
            decimalBase *= 10
        }
        
        return (self / decimalBase) % 10
        
    }
}

7438[0]

124252353523[9]

//如果该 Int 值没有足够的位数，即下标越界，那么上述下标实现会返回 0，犹如在数字左边自动补 0：
746381295[9]
// 返回 0，即等同于：
0746381295[9]

//嵌套类型
//扩展可以为已有的类、结构体和枚举调添加新的嵌套类型
extension Int {
    
    enum Kind {
        case Negative, Zero, Positive
    }
    
    var kind : Kind {
        
        switch self {
            
        case 0:
            return .Zero
            
        case let x where x > 0:
            
            return .Positive
            
        default:
            
            return .Negative
        }
    }
    
}
//为Int 添加了嵌套枚举。 这个Kind 的枚举表示特定整数的类型。具体说就是表示整数 负数 和 零。还为Int 添加了一个计算型实例属性， 即kind 用来根据整型返回适当的Kind 成员

func printIntegerKinds(_ numbers : [Int]) {
    
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ", terminator: "")
        case .Positive:
            print("+ ", terminator: "")
        case .Zero:
            print("0 ", terminator: "")
        }
    }
    print("")
}

printIntegerKinds([3,4,-17, 44, 0, 5, -21, -9, 0])

//函数 printIntegerKinds(_:) 接受一个 Int 数组，然后对该数组进行迭代。在每次迭代过程中，对当前整数的计算型属性 kind 的值进行评估，并打印出适当的描述。

//注意
//由于已知 number.kind 是 Int.Kind 类型，因此在 switch 语句中，Int.Kind 中的所有成员值都可以使用简写形式，例如使用 . Negative 而不是 Int.Kind.Negative。





