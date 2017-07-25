//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/*
 
 
 定义一个基类
 子类生成
 重写
 防止重写

 
 */

//一个类可以 继承 另一个类的方法， 属性和其他特征。当一个类继承其他类时，继承类叫做子类，被继承类叫做超类（或 父类） 在Swift 中 继承是区分 【类】与 其他类型的一个基本特征。
//在Swift 中， 类可以调用和访问超类的方法， 属性，下标，并且可以重写这些方法，属性和下标来优化或修改他们的行为。Swift 会检查你的重写定义在超类中是否有匹配的定义，以确保你的重写行为是正确的。
//可以为类中继承的属性添加属性观察器，这样一来，当属性值改变时，类就会被通知到， 可以为任何属性添加属性观察器，无论它被定义为存储属性或是计算属性

//1.定义一个基类
//注意 Swift中的类并不是从一个通用的基类继承而来， 如果你不为你定义的类指定一个超类，这个类就会自动成为基类。
//下面的例子：定义了一个叫Vehicle 的基类。这个基类声明了一个明为 currentSpeed， 默认值是0.0的存储属性（属性类型推断为 Double）。currentSpeed 属性的值被一个 String 类型的只读属性计算属性 description 使用， 用来创建车辆的描述。 定义一个名为 makeNoise 的方法，这个方法 补位 Vehicle 实例做任何事情， 但之后会被 vehicle 的子类定制：

class Vehicle {
    
    var currentSpeed = 0.0
    var description : String {
        
        return "\(currentSpeed)km/s "
    }
    
    func makeNoise() {
        
        // 什么也不做-因为车辆不一定会有噪音
    }
    
}

//可以使用初始化语句创建一个 vehicle 的新实例， 

let someVehicle = Vehicle()

print("当前噪音：\(someVehicle.description)")

//2.子类生成
//子类生成：实在一个已有的基础上创建一个新的类。子类继承超类的特性，并且可以进一步完善。可以为子类 添加新的特性。
class Bicyle : Vehicle {
    
    var hasBasket = false
    
}
//形的Bicycle 类自动获得 Vehicle 类的所有特性， 比如 currentSpeed 和 description 属性，还有它的 makeNoise（）方法。
//除了它所继承的特性，Bicycle类还定义了一个默认为 FALSE的存储型属性 hasBasket 

let bicycle = Bicyle()

bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bcycle:\(bicycle.description)")

//子类可以继续被其他类继承：

class Tandem : Bicyle {
    
    var currentNumberOfPassenger = 0
    
}

//Tandem 从 Bicycle 继承了 所有的属性与方法， 这又使他同时集成了 Vehicle 的所有属性与方法。同时增加一个新的叫做currentNumberOfPassengers 的存储属性 默认值为：0

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassenger = 2
tandem.currentSpeed = 2.0

print("Tandem:\(tandem.description)")

//2.重写
//子类可以为继承来的实例方法， 类方法， 实例属性， 或下标提供自己定制的实现。我们 把这种行为称为重写；
//如果重写某个特性， 你需要在重写定义的前面 加上 override 关键字。这么做， 你就表明了你想提供一个重写版本。 而非错误的提供了一个相同的定义。意外的重写行为可能会导致不可预知的错误。 任何缺少 override 关键字的重写都会在编译时被诊断为错误。
//override 关键字会提醒Swift编译器去检查该类型的父类是否匹配重写版本的声明。这个检查可以确保你的重写定义是正确的。

//2.1 重写方法
//在子类中， 你可以重写继承的实例方法或类方法，提供一个定制或替代的方法实现。
//例子：定义了 Vehicle 的一个新的子类， 叫 Train 它重写了 Vehicle 类继承来的 makeNoise（） 方法：
class Train  : Vehicle {
    
    override func makeNoise() {
        print("Choo Choo");
    }
}

let train = Train()
train.makeNoise()

//2.2 重写属性
//在子类中， 可以重写继承来的实例属性或类型属性，提供自己定制的 getter 和 setter 或添加属性观察器是重写的属性可以观察属性值什么时候发生变化。
//重写属性的 Getters 和 setters 
//可以提供定制的 getter 或 setter 来重写任意继承来的属性，无论继承来的属性是存储属性还是计算属性。子类并不知道属性是存储还是计算型的，，它质知道继承来的属性会有一个名字和类型。在重写属性时。必须将它的名字和类型都写出来。这样才能使编译器去检查你重写的属性是与超类中同名同类型的属性相匹配。
//可以将一个继承的只读属性重写为读写属性，只需要在重写的版本的属性里提供getter 和 setter即可。但是不可以将一个继承的读写属性重写为只读属性。注意
//注意：如果你在重写属性中提供了 setter，那么你也一定要提供 getter。如果你不想在重写版本中的 getter 里修改继承来的属性值，你可以直接通过super.someProperty来返回继承来的值，其中someProperty是你要重写的属性的名字。

//例子：定义了一个新类：Car 它是 Vehicle 的子类。这个类引入了一个新的存储属性叫做 gear 默认值为整数：1 Car类重写了 继承自 Vehicle 的 description 属性， 

class Car : Vehicle {
    
    var gear = 1
    override var description: String {
        
        return super.description + "in gear \(gear)"
    }
    
}

//重写的 description 属性首先要调用 super.description 返回 Vehicle 类的 description 属性，之后 Car 类版本的 description 在末尾增加了一些额外的文本提供当前档位的信息。
//如果你创建了 Car 的实例并且设置了它的 gear 和 currentSpeed 属性， 可以看到他的 description 返回了 Car中的自定义描述

let car = Car()
car.currentSpeed = 25.0
car.gear = 3

print("Car : \(car.description)")

//重写属性观察器
//可以通过重写属性为一个集成来的属性添加属性观察器。当继承来的属性只发生变化改变时。就会被通知到无论那个属性原本是如何实现的。
//注意:不可以为继承来的常量存储属性或继承来的只读计算属性添加属性观察器。这些属性的值是不可以被设置的，所以，为他们提供 willSet 和 didSet 实现是不恰当的。不可同时提供重写的setter 和重写的属性观察器。如果你想观察属性值的变化。并且已经为那个属性提供定制的setter， 那么你在setter 中可以观察到任何值的变化了。
//例子：下面的例子定义了一个新类叫 AutomaticCar 他是Car 类 的子类。 AutomaticCar 表示自动挡汽车，可以根据当前的速度自动选择合适的档位。

class AutomaticCar : Car {
    
    override var currentSpeed: Double {
        
        didSet {
            
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

//当你设置 AutomaticCar 的CurrentSpeed 属性时，属性的 didSet 观察器会自动的设置 gear 属性，为新的速度选择一个合适的档位。具体来就是说。属性观察器将新的速度值 除以10 然后向下去的最接近的整数值，+ 1来得到 档位 gear 的值


let automatic = AutomaticCar()

automatic.currentSpeed = 35.0

print("AutomaticCar : \(automatic.description)")


//防止重写
//可以通过把方法、属性或下标标记为 final 来防止他们被重写， 只需要在声明关键字前面加上 final 修饰符即可（例如：final var, final func, final class func 以及 final subscript）。
//如果你重写了带有 final 标记的方法，属性或下标， 在编译时会报错。在类扩展中的方法，属性或下标也可以在扩展的定义里标记为final 的
//可以 通过关键字 在 class 前添加 final 修饰符 final class 来将整个类标记为 final 这样的类是不可被继承的 试图继承这样的类 会导致编译报错。














