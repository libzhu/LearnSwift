//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/*
 
 存储属性
 计算属性
 属性观察器
 全局变量和局部变量
 类型属性

 */

//属性将值跟特定的类、结构或枚举关联。存储属性存储常量或变量作为实例的一部分，而计算属性计算（不是存储）一个值。计算属性可以用于类、结构体和枚举，存储属性只能用于类和结构体。

//存储属性和计算属性通常与特定类型的实例关联。但是，属性也可以直接作用于类型本身，这种属性称为类型属性。

//另外，还可以定义属性观察器来监控属性值的变化，以此来触发一个自定义的操作。属性观察器可以添加到自己定义的存储属性上，也可以添加到从父类继承的属性上。

//1、存储属性
//一个存储属性就是存储在特定类 或 结构体实例里的一个常量或变量。存储属性可以是变量存储属性（用关键字 var 定义），也可以是常量存储属性（用关键字 let 定义）可以在定义存储属性的时候指定默认值，请参考默认构造器一节。也可以在构造过程中设置或修改存储属性的值，甚至修改常量存储属性的值，请参考构造过程中常量属性的修改一节。

//下面的例子定义了一个名为 FixedLengthRange 的结构体，该结构体用于描述整数的范围，且这个范围值在被创建后不能被修改.

struct FixedLengthRange {
    
    var firstValue : Int
    let length : Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue : 0, length : 3)//该区间表示整数0， 1， 2

rangeOfThreeItems.firstValue = 6
//该区间表示6， 7， 8
//解释：FixedLengthRange 的实例包含一个名为 firstValue 的变量存储属性和一个名为 length 的常量存储属性。在上面的例子中，length 在创建实例的时候被初始化，因为它是一个常量存储属性，所以之后无法修改它的值。

//2、常量结构体的存储属性
//如果创建了一个结构体的实例并将其赋值给一个常量， 则无法修改该实例的任何属性，即使有属性被声明为变量也不行
let ohterRangeOfFourItems = FixedLengthRange(firstValue : 0, length : 4)

//ohterRangeOfFourItems.firstValue = 9//语法报错。

//ohterRangeOfFourItems.firstValue = 6 // 尽管 firstValue 是个变量属性，这里还是会报错
/********************************************************************************/
//这种行为是由于结构体（struct）属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。

//属于引用类型的类（class）则不一样。把一个引用类型的实例赋给一个常量后，仍然可以修改该实例的变量属性。
/********************************************************************************/



//3、延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来表示延迟存储属性。

//注意必须将延迟存储属性声明成变量（使用 var 关键字），因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性。
//延迟是属性很有用， 当属性的值依赖于在实例的构造过程结束后才会知道影响值的外部因素，或者当获得属性的初始值需要复杂或大量计算时， 可以只在需要的时候计算它。
//下面的例子使用了延迟存储属性来避免复杂类中不必要的初始化。例子中定义了 DataImporter 和 DataManager 两个类，下面是部分代码：
class DataImporter {
    
    /*
     DataImporter 是一个负责将外部文件中的数据导入的类。
     这个类的初始化会消耗不少时间。
     */
    var fileName = "Data.txt"
    
}

class DataManager {
    
    lazy var importer = DataImporter()
    var data = [String]()
    //这里提供数据管理功能
}

let manager = DataManager()

manager.data.append("hello World")
manager.data.append("hello beijing")

// DataImporter 实例的 importer 属性还没有被创建
//由于使用了 lazy ，importer 属性只有在第一次被访问的时候才被创建。比如访问它的属性 fileName 时：
print(manager.importer.fileName)
// DataImporter 实例的 importer 属性现在被创建了
// 输出 "data.txt”

print(manager.data)

//注意:如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。

//计算属性
//除存储属性外，类、结构体和枚举可以定义计算属性。计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值。

/*
 
 这个例子定义了 3 个结构体来描述几何形状：
 
 Point 封装了一个 (x, y) 的坐标
 Size 封装了一个 width 和一个 height
 Rect 表示一个有原点和尺寸的矩形
 
 Rect也提供了一个名为center 的计算属性。一个矩形的中心点可以从原点（origin）和大小（size）算出，所以不需要将它以显式声明的 Point 来保存。Rect 的计算属性 center 提供了自定义的 getter 和 setter 来获取和设置矩形的中心点，就像它有一个存储属性一样。
 
 上述例子中创建了一个名为 square 的 Rect 实例，初始值原点是 (0, 0)，宽度高度都是 10。如下图中蓝色正方形所示。
 
 square 的 center 属性可以通过点运算符（square.center）来访问，这会调用该属性的 getter 来获取它的值。跟直接返回已经存在的值不同，getter 实际上通过计算然后返回一个新的 Point 来表示 square 的中心点。如代码所示，它正确返回了中心点 (5, 5)。
 
 center 属性之后被设置了一个新的值 (15, 15)，表示向右上方移动正方形到如下图橙色正方形所示的位置。设置属性center的值会调用它的 setter 来修改属性 origin 的 x 和 y 的值，从而实现移动正方形到新的位置。
 
 */
struct Point {
    
    var x = 0.0, y = 0.0
    
}

struct Size {
    
    var width = 0.0, height = 0.0
    
}

struct Rect {
    
    var origin = Point()
    var size = Size()
    var center : Point {
        
        get {
            
            let centerX = origin.x + size.width / 2
            let centerY = origin.y + size.height / 2
            
            return Point(x : centerX, y : centerY)
    
        }
        
        set(newCenter) {
            
            origin.x = newCenter.x - size.width / 2
            origin.y = newCenter.y - size.height / 2
        }
        
    }

}

var square = Rect(origin : Point (x : 0.0, y : 0.0), size : Size(width : 10.0, height : 10.0))
let initialSquareCenter = square.center

print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
print("new square.origin is at (\(square.center.x), \(square.center.y))")

square.center = Point(x : 15.0, y : 15.0)

print("new square.origin is at (\(square.origin.x), \(square.origin.y))")
print("new square.origin is at (\(square.center.x), \(square.center.y))")

//简化 setter 声明

//如果计算属性的 setter 没有定义表示新值的参数名，则可以使用默认名称 newValue。下面是使用了简化 setter 声明的 Rect 结构体代码：
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//只读计算属性
//只有getter 没有 setter的计算属性就是只读属性。只读属性总是返回一个值，可以通过点运算符访问，但是不能设置新值
//注意:必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明常量属性，表示初始化后再也无法修改的值。
//只读计算属性的声明可以去掉 get 关键字 和 花括号
struct Cuboid {
    
    var width = 0.0, height = 0.0, depth = 0.0
    var volume : Double {
        
        return width * height * depth
    }
    
    
}

let fourFiveByTwo = Cuboid(width : 5.0, height : 4.0, depth : 2.0)

print("体积：\(fourFiveByTwo.volume)")

//属性观察器
//属性观察器监控和相应属性值的变化， 每次属性比设置值额时候都会调用属性观察器，即使新值和当前值相同的时候也不例外。
//可以为去了延迟存储属性之外的其他存储属性添加属性观察器，也可以通过重写属性的方式位继承的属性（包括存储属性和计算属性）添加属性观察器。不必为非重写的计算属性添加属性观察器，以为可以通过他的 setter 方法直接监控和相应值的变化。
//可以为属性添加如下的一个或全部观察器：·willSet 在新的值被设置之前调用  · didSet 在新的值设置之后立即调用；
//willSet 观察器会将新的属性值作为常量参数传入，在 willSet 的实现代码中可以为这个参数指定一个名称，如果不指定则参数仍然可用，这时使用默认名称 newValue 表示。

//同样，didSet 观察器会将旧的属性值作为参数传入，可以为该参数命名或者使用默认参数名 oldValue。如果在 didSet 方法中再次对该属性赋值，那么新值会覆盖旧的值。
//下面是一个 willSet 和 didSet 实际运用的例子，其中定义了一个名为 StepCounter 的类，用来统计一个人步行时的总步数。这个类可以跟计步器或其他日常锻炼的统计装置的输入数据配合使用。
class StepCounter {
    
    var totalSteps : Int = 0 {
        
        willSet(newTotalSteps){
            
            print("新的步数：\(newTotalSteps)")
        }
        
        didSet {
            
            if totalSteps > oldValue {
                print("增加了：\(totalSteps - oldValue) 步")
            }
        }
    }
    
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200

stepCounter.totalSteps = 300

stepCounter.totalSteps = 200

/*
 
 StepCounter 类定义了一个 Int 类型的属性 totalSteps，它是一个存储属性，包含 willSet 和 didSet 观察器。
 
 当 totalSteps 被设置新值的时候，它的 willSet 和 didSet 观察器都会被调用，即使新值和当前值完全相同时也会被调用。
 
 例子中的 willSet 观察器将表示新值的参数自定义为 newTotalSteps，这个观察器只是简单的将新的值输出。
 
 didSet 观察器在 totalSteps 的值改变后被调用，它把新值和旧值进行对比，如果总步数增加了，就输出一个消息表示增加了多少步。didSet 没有为旧值提供自定义名称，所以默认值 oldValue 表示旧值的参数名。
 
 */

//全局变量 和 局部变量
//计算属性和属性观察器所描述的功能也可以用于全局变量和局部变量。全局变量是在函数、方法和闭包或任何类型之外定义的变量，局部变量实在函数、方法或闭包内部定义的变量。

//类型属性
//实例属性属于一个特定的类型实例， 没创建一个实例， 实例都拥有属于自己的一套属性值，实例之间的额属性相互独立。
//也可以为类型本身定义属性，无论创建了多少该类型的实例，这些属性都只有唯一一份 这种属性就是 类型属性

//类型属性用于定义某个类型所有实例共享的数据，比如所有实例都能够用的一个常量 或者 所有实例都能够访问的一个变量。
//存储类型属性可以变量或常量，计算型类型属性跟实例的计算属性一样只能定成员变量属性。
//类型属性语法
//在 c  或 Objective-C 中 与某个关联的静态常量 和 静态变量，是作为全局 global 静态变量定义的。但是在Swift 中 ，类型属性是作为类型定义的一部分写在类型最外层的或括号中，因此它的作用范围也就是类型支持的范围内
//使用 关键字 static 来定义类型属性。在为类定义计算属性的时候，可以使用关键字 class 来支持子类对父类的实现进行重写，

struct SomeStructMethod {
    
    static var storedTypeProperty = "some value"
    static var computedTypeProperty : Int {
        
        return 1
    }
}

enum SomeEnumeration {
    
    static var storedTypeProperty = "Some Value"
    static var computedTypeProperty : Int {
        
        return 6
    }
}

class SomeClass {
    
    static var storedTypeProperty = "some value"
    static var computedTypeProperty : Int {
        
        return 27
    }
    
    class var overrideableComputedTypeProperty: Int {
        
        return 107
    }
}


//获取和设置类型属性的值
//跟实例属性一样， 类型属性也是通过点运算符来访问。但是，类型属性是通过类型本身来访问的， 而不是通过实例；
print(SomeStructMethod.storedTypeProperty);

SomeStructMethod.storedTypeProperty = "Another value"

print(SomeStructMethod.storedTypeProperty)

print(SomeEnumeration.computedTypeProperty)
print(SomeClass.computedTypeProperty)

//下面的例子定义了 一个结构体，使用两个存储类型属性来表示两个声道的音量，每个声道具有0 到10之间的证书音量。
//下图展示了如何把两个声道结合来模拟立体声的音量。当声道的音量是 0，没有一个灯会亮；当声道的音量是 10，所有灯点亮。本图中，左声道的音量是 9，右声道的音量是 7：


struct AudioChannel {
    
    static let thresholdLevel = 10
    static var maxInputLeverForAllChannels = 0
    var currentLevel : Int = 0 {
        
        didSet {
            
            if currentLevel > AudioChannel.thresholdLevel {
                //将当前音量限制在阈值之内
                currentLevel = AudioChannel.thresholdLevel
            }
            
            if currentLevel > AudioChannel.maxInputLeverForAllChannels {
                AudioChannel.maxInputLeverForAllChannels = currentLevel
            }
            
        }
        
    }
    
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)

print(AudioChannel.maxInputLeverForAllChannels)

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
print(AudioChannel.maxInputLeverForAllChannels)

















