//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//包含类容：
/*
 
 存储属性的初始赋值
 自定义构造过程
 默认构造器
 值类型的构造器代理
 类的继承和构造过程
 可失败构造器
 必要构造器
 通过闭包或函数设置属性的默认值

 */

//构造过程是使用类、结构体或枚举的实例之前的准备过程。在新实例可用前必须执行这个过程，具体操作包括设置实例中每个存储属性的初始值和执行其他必须设置或初始化工作。
//通过定义构造器来实现构造过程，这些构造器可以是用来创建特定类型新实例的特殊方法，与Objective-C 的构造器不同， Swift 的构造器无需返回值，他们的主要任务是保证新实例第一次使用前就正确的初始化。
//类的实例也可以通过定义析构器 在实例释放之前执行特定的清除工作。

//1.存储属性的初始赋值
//类和结构体在创建实例时，必须为所有存储属性设置合适的初始值。存储属性的值不能处于一个未知的状态。
//可以在构造器中为存储型属性赋初值，也可以在定义属性时为其设置默认值。
//注意：当你为存储属性设置默认值或者在构造其中为其赋值时，他们的值是直接被设置的。不会被触发任何属性观察者。

//2，构造器：在创建某个特定类型的新实例时被调用，它的最简形式类似于一个不带任何参数的实例方法， 以关键字 init 命名：
//init() {
//    
//    //在此处执行构造过程。
//}
//下面的例子定义类一个保存华氏温度的结构体 Fahrenheit 它拥有一个 Double 类型的纯属属性 temperature

struct Fahrenheit {
    
    var temperature : Double
    
    init() {
        temperature = 30.5
    }
    
}

var f = Fahrenheit()
print("默认的华氏温度是：\(f.temperature)")
//这个结构体定义了一个不带参数的 构造器 init 并在里面 将存储属性 temperature 的初始值 初始化为30.5；

//3、默认属性值
//可以在构造器中为存储属性是指初始值。同样，你也可以在属性声明的时候为其设置默认值。
//注意：如果一个属性总是使用相同的初始值，那么为其设置一个默认值比每次都在构造器中赋值要好。两种方法的效果是一样的。只不过使用默认值让属性的初始化和声明结合的更加紧密。使用默认值能够是你的构造器跟简洁、更清晰，且能通过默认值自动推断属性的类型；同时，也能让你充分利用默认构造器、构造器继承等特性，
struct NewFahrenheit {
    
    var temperature = 32.0
    
}

//3.自定义构造过程。
//可以通过输入参数和可选类型的属性来自定义构造过程，也可以在构造过程中修改常量属性。
//3.1、构造参数：
//自定义构造过程时。可以在定义中提供构造参数，指定所需要的类型和名字。构造参数的功能和语法跟函数的和方法的参数相同
struct Celsiu {
    
    var temperatureInClesius : Double
    init(fromFahreheit fahrenheit : Double) {
        
        temperatureInClesius = (fahrenheit - 32.0) / 1.8
    }

    
    init(fromKelvin kelvin : Double) {
        
        temperatureInClesius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsiu(fromFahreheit : 212.0)
boilingPointOfWater.temperatureInClesius

let freezingPointOfWater = Celsiu(fromKelvin : 273.15)
freezingPointOfWater.temperatureInClesius
//解释：第一个构造器拥有一个构造参数，其外部名字为 fromFahrenheit， 内部名字为 Fahrenheit； 第二个构造器也拥有一个构造参数，其外部名字为 fromKelvin 内部名字为 Kevin。这两个构造器都将唯一的参数值 转换成摄氏温度值 并保存在属性 temperatureInCelsius 中。
//3.2：参数的内部名称和外部名称
//跟函数和方法参数相同， 构造参数也拥有一个在构造器内部使用的参数名字和一个在调用构造器时使用的外部名字。
//构造器并不像函数和方法那样在括号前有一个可辨别的名字。因此在调用构造器时，主要通过构造器中的参数名和类型来确定被调用的的构造器。正因为参数如此重要，如果你在定义构造器时没有提供参数的外部名字， Swift会为构造器的每个参数自动生成跟内部名字相同的外部名。
//例子：定义一个结构体 Color 包含三个常量 red green blue 这些属性可以存储 0.0 到 1.0 之间的值，用来指示颜色中 红 绿 蓝 成分的含量。
//Color 提供了一个构造器，其中包含三个 double 类型的构造参数。 Color 也可以提供第二个构造器，它只包含 white 的 Double 类型参数 ，他被用于给三个构造参数赋予同样的值
struct Color {
    
    let red, green, blue : Double
    init(red : Double, green : Double , blue : Double) {
        
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white : Double) {
        
        red = white
        green = white
        blue = white
    }
    
}

//两种构造器都能用于创建一个新的 Color 实例 需要为构造器每个外部参数传值。
let mageta = Color(red : 1.0, green : 0.0, blue : 1.0)
mageta.red
mageta.green
mageta.blue


let halfGray = Color(white : 0.5)
halfGray.red
halfGray.green
halfGray.blue

let anotherColor = Color(red : 1.8, green : 0.0, blue : 1.0)//赋值构造


//注意： 如果不通过外部参数名字传值， 你是没法调用这个构造器的。只要构造器调用了某个外部名字， 你就必须使用它，否则他将导致编译错误！

//let veryGreen = Color(0.0, 0.0, 1.0)//编译时错误，需要外部名称！

//3.3、不带外部名的构造器参数
//如果不希望为构造器的某个参数提供外部名字，可以使用下划线（_）来显示的描述它的外部名，
//例子：之前 Celsius 例子的扩展，跟之前相比 添加了一个带有 Double 类型参数的构造器 其外部名字用 _ 代替
struct NewCelsiu {
    
    var temperatureInCelsius : Double
    
    init(fromFahrenheit fahrenheit : Double) {
        
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin : Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius : Double) {
        
        temperatureInCelsius = celsius
    }
    
}

let bodyTemperature = NewCelsiu(37.0)
bodyTemperature.temperatureInCelsius

//调用 NewCelsius（37.0）意图明确， 不需要外部参数名称。因此适合使用 init(_ celsius : Double) 这样的构造器，从而可以提供 Double 类型的参数调用 构造器， 而不需要加上外部名。

//4、可选属性类型。
//如果定制的类型包含一个逻辑上允许取值为空的存储属性--无论因为他无法再初始化时赋值，还应为它在之后某个时间点可以赋值为空--你都需要将他定义为可选类型，可选类型的属性将自动初始化为你了 表示这个属性是有意在初始化时设置为空的。
//下面例子定义了类 SurveyQuestion 它包含一个可选字符串属性 response ：
class SurveyQuestion {
    
    var text : String
    var response : String?
    
    init(text : String) {
        self.text = text
    }

    func ask(){
        
        print(text)
    }
    
}

let cheseseQuesetion = SurveyQuestion(text : "hellor world")
cheseseQuesetion.ask()

cheseseQuesetion.response = "Yes, I do like cheese"
//解释：调查问题的答案在回答钱是无法确定的，因此我们 降属性 response 声明为 String？ 类型， 或者 可选值字符串类型。 当 SurveyQuestion 实例化时，自动将赋值为 nil 笔名此字符串暂时还没有值；

//5、构造过程中常量属性的修改
//在构造过程中的任意时间点给常量属性指定一个值，只要在构造过程结束时是一个确定的值。一旦常量属性被赋值，它将永远不可被修改。
//注意：对于类的实例来说，它的常量属性只能定义它的类的构造过程中修改；不能在子类中修改
//可以 修改上面 SurveyQusetion 示例，用常量属性替代变量属性text， 表示内容 text 在 SurveyQuestion 的实例被创建之后不会再被修改。尽管 text 属性现在是常量， 我们仍让可以在累的构造器中设置他的值。
class NewSurveyQuestion  {
    
    let text : String
    var response : String?
    init(text : String) {
        self.text = text
//        self.text = "bei jing"
    }
    
    func ask() {
        print(text)
    }
    
}

let beetSQuestion = NewSurveyQuestion(text : "How  about beets?")
beetSQuestion.ask()

//5、默认构造器
//如果结构体 或 类的所有属性都有默认值，同时没有自定义的构造器，那么Swift 会结合这些结构体或类提供一个默认构造器（default initalizers）这个默认构造器将简单的创建一个所有属性值都设置为默认的实例。
//例子：创建一个类 ShoppingListItem， 他封装了购物清单的某一物品的属性：名字（name）、数量（quantity）和购买状态：purchase statte：
class ShoppingListItem {
    
    var name : String?
    var qunatity = 1
    var purchased = false
    
}

var item = ShoppingListItem()
//由于 ShoppingListItem 类中的所有属性都有默认值， 并且是没有父类的基类，它将自动获得一个可以为所有属性设置默认值的默认构造器（尽管代码中没有显示的为 name 属性设置默认值），但是name是可选字符串类型， 它将默认设置为nil 上面例子中使用默认构造器创建了 一个shoppingListItem 类的实例 使用 shoppingListItem（）形式的构造器语法， 并将其赋值给变量 Item。

//5.2、结构体的逐一成员构造器
//除了上面提到的默认构造器， 如果结构体没有提供自定义的构造器， 它们将自动获得一个逐一成员构造器，即使结构体的存储属性没有默认值。
//逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法，我们在调用逐一成员构造器时，通过与成员名属性名相同的参数名进行传值来完成对成员属性的初始赋值。
//例子：定义结构体 Size 它包含两个属性 Width 和 height 。swif 可以根据这两个属性的初始赋值0.0， 自动推导出它们的类型为 Double。
//结构体 Size 自动获得了一个逐一成员构造器 init（Width：height）可以用它来为 size 创建新的实例：
struct Size {
    
    var width : Double, height : Double
    
}

let twoByTwo = Size(width : 2.0, height : 2.0)

//6、值类型的构造器代理
//构造器可以通过调用其他构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能减少多个构造器间的代码重复。
//构造器代理的实现规则和形式在值类型和类类型中所有不同。值类型（结构体和枚举类型）不支持继承，所以构造器代理的过程相对简单， 因为他们只能代理给自己的其他构造器。类则不同，它可以继承自其他类，这意味着类有责任保证其所有继承的存储属性在构造时也能正确的初始化。
//对于值类型， 可以使用 self.init 在自定义的构造器中引用相同类型的其它构造器，并且你只能在构造器内部使用self.init
//如果为某个值类型定义了一个自定义的构造器， 将无法访问默认构造器（如果是结构体，将无法访问逐一成员构造器）。这种限制可以防止你为值类型增加了一个额外的切十分复杂的构造器之后，任然有人错误的使用自动生成的构造器
//注意：假如希望默认构造器， 逐一成员构造器以及你自己定义构造器都能用来创建实例，你可以将自定义的构造器写到扩展中 extension  而不是写在值类型的原始定义中。
//例子：定义一个结构体 Rect 用来代表几何矩形。这例子需要两个辅助的结构体 Size 和 Point 他们默认的为其属性提供了默认初始值：0.0

struct NewPoint {
    
    var x  = 0.0, y = 0.0
    
}

struct NewSize {
    
    var width = 0.0, height = 0.0
    
}

//可以通过以下三种方式为Rect 创建实例 -- 使用被初始化为默认值 的origin 和 size 属性来完成初始化；提供指定的origin 和 size 实例来初始化；指定的center 和 size 来初始化。在下面Rect 结构体 定义中， 我们为这三种方式提供了自定义的构造器：
struct Rect {
    
    var origin = NewPoint()
    var size = NewSize()
    init() {
        
    }
    
    init(origin : NewPoint, size : NewSize) {
        self.origin = origin
        self.size = size
    }
    
    init(center : NewPoint, size : NewSize) {
        let originX = center.x - size.width / 2
        let originY = center.y - size.height / 2
        self.init(origin : NewPoint(x : originX, y : originY), size : size)
        
        
    }
    
}

//解释：第一个 Rect 构造器 init（）在功能上跟没有自定义构造器时自动获取的默认构造器是一样的。这个构造器是一个空函数。使用一对大括号{}来表示， 他没有执行任何构造过程。调用这个构造器将返回一个 Rect 实例，它的origin 和 size属性都是用自定义的默认值 NewPoint（x:0.0, y:0.0）和 NewSize（Width： 0.0， height: 0.0）
let basicRect = Rect()
print(basicRect.origin, basicRect.size)

//第二个构造器init（origin： size：），在功能上跟结构体在没有自定义构造器时获得的逐一构造器是一样的。这个构造器知识简单的将 origin 和 size 的参数赋值个对应的存储属性：

let originRect = Rect(origin : NewPoint(x : 2.0, y : 2.0), size : NewSize(width : 5.0, height : 5.0))
print(originRect.origin, originRect.size)

//第三个 Rect 构造器 init（center： size）稍微复杂一点。它先通过center 和 size的值计算出 origin 的坐标 然后在调用 或者 说是代理 init（origin： size：）构造器来将新的origin 和 size 值赋值到对应属性中：

let centerRect = Rect(center : NewPoint(x : 4.0, y : 4.0), size : NewSize(width : 3.0, height : 3.0))
print(centerRect.origin, centerRect.size)

//解释：构造器init（center： size :）可以直接将 origin 和 size的新值赋值到对应的属性中。然而， 利用恰好提供了相关功能的现有构造器会更加方便，构造器init（center： size：）的意图更加清晰。
//注意：如果你想用另外一种不需要自己定义init（）和 init(origin:size:)的方式来实现这个例子，，参考扩展



//7、类的集成和构造过程
//类里面所有存储属性 -- 包括所有继承自父类的属性 -- 都必须在构造过程中设置初始值， Swift 为类类型提供了两种构造器来确保实例中所有的存储属性都能够获得初始值，他们分别是指：指定构造器和遍历构造器
//7.1、指定构造器和便利构造器
//指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并根据父类链接往上调用父类的构造器来实现父类的初始化。每一个类必须拥有至少一个指定构造器。在某些情况下，许多类通过继承了父类中的指定构造器而满足了这个条件。 
//便利构造器是类中比较次要的、辅助性的构造器。可以定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值，也可以定义一个便利构造器来创建一个特殊用途或特定输入的实例。
//应当在必要的时候为类提供便利构造器，比方说某种情况下通过便利构造器来快捷调用某个指定构造器，能够节省开发时间并且让类的构成过程更加清晰明了。

//7.1、指定构造器和便利构造器的语法。
/*
 类的指定构造器的写法跟值类型简单构造器一样
 init(parameters){
 
    statements
 }
 
 */
//便利构造器也采用相同样式的写法，但是在init关键字前 放置 convenience 关键字， 并且使用空格将他们分开。
/*
 convenience init (){
 
 
 }
 */
//7.2 类的构造器代理规则
//为了简化指定构造器和便利构造器之间的调用关系，Swift采用 一下三条规则来限制构造器之间的代理调用：
//规则1：指定构造器必须调用其直接父类的指定构造器;规则2：便利构造器必须调用同类中定义的其它构造器。规则3：便利构造器必须最终导致一个指定构造器被调用。
//方便记忆：指定构造器必须总是向上代理、便利构造器必须总是横向代理

//7.3 类的两段式构造过程
//Swift中类的构造过程包含两个阶段。第一个阶段，每个存储属性被引入他们的类指定一个初始值。当每个存储属性的初始值被确定后，第二个阶段开始，它给每个类一次机会，在新实例准备使用之前进一步确定他们的存储属性。
//两段式构造过程的使用让构造过程更加安全，同时在整个类层级结构中给于每个类完全的灵活性。两段式过早过程可以防止属性在初始化之前被访问，也可以防止属性被另外一个构造器意外的赋予不同的值。
//注意：Swift 的两段式构造过程跟Objective-C中的构造过程类似。最主要的区别在于阶段1，Objective-C给每个属性赋值0或空值。Swift的构造流程更加灵活，它允许你设置定制的初始值，并自如对应某些属性不能以0或nil作为合法默认的情况。
//安全检查1：指定构造器必须保证它所在类引入的所有属性都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器。一个对象的内存只有在其所有存储属性确定以后才能完全初始化。为了满足这一规则，指定构造器必须能保证所在类引入的属性在它网上代理之前完成初始化。
//安全检查2：指定构造器必须先向上代理调用父类构造器，然后在为继承的属性设置新值。如果没这么做，指定构造器赋予的新值将被父类中的构造器所覆盖。
//安全检查3：便利构造器必须先代理调用统一类中的其他构造器，然后在为任意属性赋新值。如果没有这没做，便利构造器赋予的新值将被同一类中其它指定构造器所覆盖。
//安全检查4:构造器在第一阶段完成之前，不能调用任何实例方法，不能读取任何实例属性的值，不能应用self 作为一个值。类实例在第一阶段结束以前并不是完全有效的。只有第一阶段完成以后，该实例才会成为有效实例， 才能访问属性和调用方法。
//一下是两段式构造过程中基于上述安全检查的流程展示：
/**
 
 阶段一：
 · 某个指定构造器或便利构造器被调用。
 · 完成新实例内存的分配，但此时内存还没有被初始化
 · 指定构造器确保其所在类引入的所有存储属性都已赋初值。存储型属性的内存完成初始化。
 · 指定构造器将调用父类的构造器，完成父类属性的初始化。
 · 这个调用父类构造器的过程沿着构造器链一直往上执行，直到达到构造器链的最顶部。
 · 当达到了构造器链最顶部，且以确保所有实例包含的存储属性都已经赋值，这个实例的内存被认为已经完全初始化，此时阶段1完成。
 
 阶段2
 · 从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问self、修改他的属性并调用实例方法等等。
 · 最终，任意构造器中的便利构造器可以有机会定制实例和使用self
 
 
 */

//8、构造器的继承和重写
//跟 Objective-C 中的子类不同， Swift中的子类默认情况下不会继承父类的构造器。Swift的这种机制可以防止一个父类的简单构造器被一个更精细的子类继承，并被错误的创建子类的实例。
//注意：父类的构造器仅会在安全和适当的情况下被继承。
//自定义的子类中能提供一个或多个跟父类相同的构造器，可以在子类中提供这些构造器的自定义实现。编写一个和父类中指定构造器相匹配的子类构造器时，你实际上是在重写父类的这个指定构造器。因此，必须在定义子类构造器式带上 override（重写）修饰符。即使重写的是系统自动提供的默认构造器，也要带上 override 修饰符，
//注意：重写一个父类的指定构造器时，总是需要写 override 修饰符，即使子类将父类的指定构造器重写成了便利构造器。
//编写一个和父类便利构造器相匹配的子类构造器，由于子类不能直接调用父类的便利构造器因此子类并未对一个父类构造器提供重写。最后的结果就是，在子类中重写一个父类便利构造器时，不需要加上override 前缀
//例子：定义一个 Vehicle 的基类。基类中声明 一个存储属性numberOfWheels 它的值为 0 的int类型的存储属性、 numberOfWheels 属性用于创建名为 description 的String 类型的计算属性：

class Vehicle {
    
    var nunberOfWheels = 0
    var description : String {
        
        return "\(nunberOfWheels)辆车"
    }
    
}

//解释：Vehicle 类只为存储属性提供默认值，而不自定义构造器。因此会自动获得一个默认构造器，自动获得的默认构造器总会是类中的指定的构造器，他可以用于创建numberOfWheels 为 0 的Vehicle实例
let vehicle = Vehicle()
print("vehicle:\(vehicle.description)")

//下面定义了一个 Vehicle 的子类 Bicycle：
class Bicycle : Vehicle {
    
    override init(){
        
        super.init()
        nunberOfWheels = 2
    }
}
//解释：子类 Bicycle 定义了一个自定义的指定构造器init（） 这个指定构造器和父类的指定构造器相匹配，所以 Bicycle 中的指定构造器需要加上 override 修饰符。Bicycle 的构造器init（）调用 super.init() 方法开始，这个方法的作用是调用 Bicycle的父类 Vehicle 的默认构造器。这样可以确保 Bicycle在修改属性之前，它所继承的属性 numberOfWheels 能被 Vehicle 类初始化。在调用super.init()之后，numberOfWheels 的原值被新值 2 替换。
//如果你创建一个 Bicycle 实例， 你可以调用继承的 description 计算型属性去查看 属性 numberOfWheels 是否有变化；

let bicycle = Bicycle()
print("bicycle:\(bicycle.nunberOfWheels)")

//注意：子类可以在初始化时修改继承来的变量属性， 但是不能修改继承来的常量属性。

//8.1、构造器的自动继承
//子类默认情况下不会继承父类的构造器，但是如果满足特定条件，父类构造器是可以被自动继承的。在实践中，这意味着许多常见场景不必重写父类的构造器，并且可以在安全的情况下以最小的代价继承父类的构造器。
//假设：子类中引入的所有新属性都提供了默认值，以下2个规则适用：
//1.如果子类没有定义任何指定构造器，他将自动继承父类所有的指定构造器。2.如果子类提供了所有父类指定构造器的实现 -- 无论是通过规则1继承过来的，还是提供了自定义的实现 -- 它将自动继承所有父类的便利构造器。
//注意：子类可以将父类的指定构造器实现为便利构造器。

//8.2.指定构造器和便利构造器的实践
//例子将展示实践中 指定构造器、便利构造器以及 构造器的自动继承。这个例子定义了三个类 Food RecipeIngredient 以及 NewShoppingListItem的层级结构， 并将演示他们的构造器是如何相互作用的。
//类 层次中的基类 是Food 它是一个简单的用来封装食物名字的类。Food 类引入了一个叫做name 的String类型的属性，并且提供了两个个构造器来创建Food 实例


class Food {
    
    var name : String
    
    //指定构造器
    init(name : String) {
        self.name = name
    }
    
    //便利构造器
    convenience init() {
        
        self.init(name : "[Unnamed]")//便利构造器都是指向同一类型的指定构造器。
    }
}
//解释：类类型没有默认的逐一成员构造器，所以Food 类 提供了一个接受单一参数 name 的指定构造器 init（name：）这个构造器可以使用特定的名字来创建新的 Food实例：
let  nameMeat = Food(name : "bacon")
print(nameMeat.name)
//Food 类中的构造器init（name：String）被定义为一个指定构造器，因为他能够确保Food 实例的所有存储属性都被初始化，Food 类没有父类， 所以init（name： String）构造器不需要调用 super.init()来完成构造器过程。
//Foot 类同样提供了一个没有参数的便利构造器init（）， 这个init（）构造器为新食物提供了一个默认的站位名字，通过横向代理到指定构造器init（name： String）并给参数name传值【Unnamed】来实现：
let mysteryMeat = Food()
print(mysteryMeat.name)
//类层级中的第二个类是Food 的子类 RecipeIngredient。RecipeIngredient 类用来表示食物普中的一项原料，它将引入 Int 类型的属性 quantity （以及重 Food及继承过来的 name属性）并且定义了连个构造器来创建 RecipeIngredient 实例
class RecipeIngredient : Food {
    
    var quantity : Int
    init(name : String, qunatitys : Int) {
        self.quantity = qunatitys
        super.init(name: name)//向上代理
    }
    
    override convenience init(name : String) {//重写父类的指定构造器为便利构造器
        
        self.init(name : name, qunatitys : 1)//横向代理
    }
    
}

//解释：RecipeIngredient 类拥有一个指定构造器 Init（Name：String，  quantity：Int）它可以用来填充RecipeIngredient实例的所有属性值，这个构造器一开始将传入的qunatitys 参数赋值给 quantity属性，这个属性也是唯一在 RecipeIngredient 中新引入的属性，随后，构造器向上代理到父类Food 的init（Name：String）。这个过程满足两段式构造过程中的安全检查1
//RecipeIngredient 还定义了一个便利构造器 init（Name： String）它只通过name 来创建RecipeIngredient 实例。这个便利构造器假设任意RecipeIngredient实例的quantity为1，所以不需要显示指明数量即可创建实例。这个便利构造器的定义可以快捷方便的创建实例，并且避免了创建多个quantity为 1 的 RecipeIngredient 实例时的重复代码，这个便利构造器知识简单的横向代理到类中的指定构造器，并且为quantity传递参数为1.RecipeIngredient的便利构造器init（Name： String）使用了跟Food中指定构造器init（name ： String）相同的参数。由于这个便利构造器重写了 父类的指定构造器init（name ： String）， 因此必须在前面使用关键字 override 修饰。尽管 RecipeIngredient 将父类的指定构造器重写为了便利构造器，它一样提供了父类所有指定构造器的实现，它依然提供了父类的所有指定构造器的实现。因此， RecipeIngredient 会自动继承父类的所有便利构造器。
//在这个例子中 RecipeIngredient 的父类是Food Food 拥有一个便利构造器init（）。这个便利构造器会被RecipeIngredient继承。这个继承版本的init（）在功能上跟Food 提供的版本是一样的，它只会代理到RecipeIngredient 版本的init（Name： String）而不是Food提供的版本

let oneMysteryItem = RecipeIngredient()//继承父类的便利构造器实例，init（），这个继承版本的init（）在功能上跟Food 提供的版本是一样的，它只会代理到RecipeIngredient 版本的init（Name： String）而不是Food提供的版本
oneMysteryItem.name
oneMysteryItem.quantity

let oneBacon = RecipeIngredient(name : "Bacon")
print(oneBacon.name, oneBacon.quantity)

let sixEggs = RecipeIngredient(name : "eggs", qunatitys : 6)
print(sixEggs.name, sixEggs.quantity)

//类的层级中第三个也是最后一个类是RecipeIngredient子类， 叫做 NewShoppingListItem 这个类构建了购物单中出现的某种食物的原料
//购物单中的每一项总是重围购买状态开始的，为了呈现这一事实， NewShoppingListItem 引入了一个Bool类型属性 purchased 他的默认值为FALSE NewShoppingListItem还添加了一个计算属性description 他提供了关于NewShoppingListItem 实例的一些文字描述：
class NewShoppingListItem : RecipeIngredient {
    
    var purchased = false
    var description : String {
        
        var outPut = "\(quantity) x \(name)"
        outPut += purchased ? "✅ 已购买" : "❌ 未购买"
        
        return outPut
    }
    
    
}

//由于NewShoppingListItem自己引入的属性都提供了默认值，并且自己没有定义任何构造器，NewShoppingListItem 将自动继承所有父类中定义的指定构造器和遍历构造器。
//可以使用全部三个继承来的构造器来创建 NewShoppingListItem 的新实例：

var breakFastList = [NewShoppingListItem(), NewShoppingListItem(name : "bacon"), NewShoppingListItem(name : "eggs", qunatitys : 6)]
breakFastList[0].name = "Orange juice"
breakFastList[0].purchased = true

breakFastList[1].purchased = true
breakFastList[1].name = "Meat"


for item in breakFastList {
    print(item.description)
}

//上面例子通过字面量创建了一个 数组 breakFastList 它 包含三个 NewShoppingListItem 实例，因此数组的类型也能不自动推到为 [NewShoppingListItem] 在数组创建完之后，数组中第一个 NewShoppingListItem 实例的名字【Unnamed】更改为 Orange Juice 并标记为已购买。


struct Water {
    
    var wendu : String, shendu : String
    
    init(status : String) {
        self.wendu = status
        self.shendu = status
    }
    
}
//let water = Water(wendu : "20", shendu : "30")

let otherWater = Water(status : "30")





//9、可失败构造器
//如果一个类、结构体或枚举类型的的对象，在构造过程总可能失败，则定义为可失败构造器。这里的失败：是指构造器传入无效的参数值，或缺少某种需要的外部资源，或不满足某种必要的条件。为了妥善处理这种构造过程中可能失败的情况。可以在一个类。结构体或是枚举类型的定义中，添加一个或多个可失败构造器。其语法在 init关键字后面添加（init ？）
//注意：可失败构造器的参数名和参数类型，不能与其他非可失败构造器的参数名，及参数类型相同。。
//可失败构造器创建一个类型为自身类型的可选的对象，通过return nil 语句表明可失败构造器在任何情况下应该失败
//注意：严格来说，构造器都不支持返回值。因为构造器本省的作用，只是为了确保对象能正确构造，因此只是用return nil 表明可失败构造器失败，而不用关键字return 来表明构造成功。
//下面例子，定义了一个名为 Animal的结构体，其中有一个名为species的String类型的常量属性。同时该结构体还定义了一个接受一个名为species的String类型参数的可失败构造器。这个可失败构造器 检查传入的参数是否为一个空字符串。如果为空字符串，则构造失败。否则 species属性被赋值，构造成功！

struct Animal {
    
    let species : String
    init ? (species : String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
    
}

//通过可失败构造器来创建一个Animal实例， 并检查构造过程是否成功

let someCreature = Animal(species : "hello")
if let giraffe = someCreature {
    
    print("一个Animal 实例 特征为：\(giraffe.species)")
}

//如果给该可失败构造器传入一个空字符串作为参数，则会导致构造失败
let annoymousCreature = Animal(species : "")
if annoymousCreature == nil {
    print("可失败构造器，构造失败！")
}

//9.1、枚举类型的可失败构造器
//可以通过一个带一个或者多个参数的可失败构造器来获取枚举类型中特定的枚举成员。如果提供的参数无法匹配任何枚举成员，则构造失败。
//例子：定义一个名为 TemperatureUnit 的枚举类型。其中包含三个可能的枚举成员Kelvin Celsius Fahrenheit 以及一个根据 Character 值查找出所对应的枚举成员的可失败构造器：
enum TemperatureUnit {
    
    case Kelvin, Celsius, Fahrenheit
    init ? (symbol : Character) {
        
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

let  fahrenheitUnit = TemperatureUnit(symbol : "F")

if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

//9.2带原始值的枚举类型的可选失败构造器
//带原始值的枚举类型会自动带一个可选失败构造器init？（rawValue），该失败构造器有一个名为rawValue 的参数，其类型和枚举类型的原始值类型一致，如果该参数的值能够和某个枚举成员的原始值匹配，则该构造器会构造相应的枚举成员否则构造失败。
enum NewTemperatureUnit : Character {
    
    case Kelvin = "K", Celsius = "C",Fahrenheit = "F"
    
}

let newFahrenheitUnit = NewTemperatureUnit(rawValue : "F")

if newFahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unKwonUnit = NewTemperatureUnit(rawValue : "X")
if unKwonUnit == nil {
    
    print("This is not a defined temperature unit, so initialization failed.")
}

//9.3构造失败的传递
//类，结构体，枚举的可选失败构造器可以横向代理到类中的其他可选失败构造器。类似的，子类的可选失败构造器也能向上代理到父类的可选失败构造器。
//无论是向上代理还是横向代理，如果你代理到的其他可失败构造器触发构造失败，整个构造过程立即终止，接下来的任何构造代码不会再被执行。
//注意：可失败构造器也可以代理到其他非可失败构造器，通过这种方式，可以增加一个可能的失败状态到现有的构造中。
//下面的例子，定义了一个名为 CarItem 的Product 的子类。这个子类建立了在线购物车中的物品的模型，他有一个名为 quantity 的常量存储属性，并确保该属性的值至少为：1
class Product {
    
    let name : String
    init ? (name : String) {
        if name.isEmpty {
            
            return nil
        }else{
            
            self.name = name
        }
    }
    
}

class CarItem : Product {
    
    let quantity : Int
    
    init ? (name : String, quantity : Int) {
        
        if quantity < 1 {
            return nil
        }
        
        self.quantity = quantity
        super.init(name: name)
    }
    
}

//解释：CarItem 可失败构造器首先验证接受的 quantity 值是否大于等于1.倘若 quantity 值无效， 则立即种子整个构造过程，返回失败结果，且不执行余下代码。同样的，Product 的可失败构造器首先检查 Name 值 假如 name 值为空字符串， 则构造器立即执行失败。
//如果你传入一个非空字符串name 以及一个值大于等于 1 的quantity 来创建一个 CarItem 实例，那么构造器能够成功被执行：

if let twoSocks = CarItem(name : "socks", quantity : 2) {
    print("item:\(twoSocks.name), quantity:\(twoSocks.quantity)")
}

//如果以一个值为 0  的quantity 来创建 一个 CarItem 实例， 那么将导致 CarItem 构造失败：

if let zeroShirts = CarItem(name : "shirts", quantity : 0) {
    
    print("item : \(zeroShirts.name), quantity : \(zeroShirts.quantity)")
}else{
    
    print("初始化失败！")
}

//同样的，如果你尝试传入一个值为空字符串的 name 来创建一个 CarItem 实例， 那么将导致父类 Product 的构造过程失败：

if let oneUnnamed = CarItem(name : "", quantity : 1) {
    print("Item:\(oneUnnamed.name) quantity : \(oneUnnamed.quantity)")
}else{
    
    print("Product 初始化失败！")
}

//9.4、重写一个可失败构造器
//如同其他的构造器，你可以在子类中重写父类的的可失败构造器，或者也可以用子类的非可失败构造器重写一个父类的可失败构造器。这使可以定义一个不会构造失败的子类， 即使父类的构造器允许构造失败。
//注意：当用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包。
//注意：可以用非可失败构造器重写可失败构造器，但反过来却不行。

//例子:定义了一个名为 Document 的 类， name属性的值必须为一个非空字符串或为nil 但不能是一个空字符串
class Document {
    
    var name : String?
    //该构造器创建了一个 name 属性的值为 nil 的 document 实例
    init() {}
    //该构造器创建了一个 name 属性的值为非空字符串的 document 实例
    init?(name : String){
        self.name = name
        if name.isEmpty {
            return nil
        }
    }
}
//下面定义一个Document 类的子类 AutomaticallyNamedDocument 这个子类重写 父类的两个指定构造器，确保无论是init（）构造器 还是 init（name：）构造器并为参数传递空字符串，生成实例中的name 属性总有初始值：[Untitled]

class AutomaticallyNamedDocument : Document {
    
    override init() {
        
        super.init()
        self.name = "[Untitled]"
    }
    
    override init(name : String) {
        
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        }else{
            
            self.name = name
        }
    }
}
//解释：AutomaticallyNamedDocument 用一个非可失败构造器 init（name：）重写了父类的可失败构造器init？（name：）。因为子类用另一种方式处理了空字符串的情况，所以不再需要一个可失败构造器，因此子类用一个非可失败构造器代替了父类的可失败构造器。
//可以在子类的非可失败构造器中强制解包来调用父类的可失败构造器。比如下面 UntitledDocument 子类的 name 属性总是【Untitled】 它在构造过程中调用了父类的可失败构造器 init?(name:)
class UntitledDocument : Document {
    
    override init(name : String) {
        
        super.init(name: name)!
    }
}
let untitleDocument = UntitledDocument(name: "8")
untitleDocument.name

//在这个例子中，如果在调用父类的可失败构造器init?(name:)时传入的是空字符串，那么强制解包操作会引发运行时错误。不过，因为这里是通过非空的字符串常量来调用它，所以并不会发生运行时错误。

//9.5、可失败构造器init！
//通常来说可以通过在 init关键字 后添加问号的方式（init？）来定义一个可失败构造器， 当也可以通过在init后面添加惊叹号的方式来定义一个可失败构造器（init！），该失败构造器将会构建一个对应类型的隐式解包可选类型的对象。
//可以在 init？ 中代理到 init！ 反之亦然。也可以用 init？ 重写init！反之亦然。还可以用init代理到init！，不过 一旦init！ 构造失败， 则会触发一个断言。


//10、必要构造器
//在类的构造器前添加 required 修饰符表明所有该类的子类必须都实现该构造器

class  SomeClass {
    
    var name : String
    
    required init(){
        
        //构造器实现代码
        self.name = "[Undo]"//没有定义的
    }
}

//在子类重写父类的必要构造器时，必须在子类的构造器前也添加required 修饰。表明 该构造器要求也应用于继承链后面的子类。在重写父类中必要的指定构造器时，不需要添加 override 关键字修饰。

class SomeClassSub : SomeClass {
    
    required init() {
        //构造器代码的实现
        super.init()
        self.name = "hello"
        
    }
}


let someSubClass = SomeClassSub()
someSubClass.name


//11.通过闭包或函数设置属性的默认值
//如果某个存储属性的默认值需要一些定制或设置，可以使用闭包或全局函数为其提供定制的默认值。每当某个属性所在的类型的新实例被创建时。对应的闭包或函数会被调用，而且他们的返回值会当做默认值赋值给这个属性。这种类型的闭包或函数通常会创建一个跟属性类型相同的临时变量，然后修改他们的值以满足预期的初始状态，最后返回这个临时变量，作为属性的more值。

//下面介绍如何使用闭包为属性提供默认值
/*
 
 class NewSomeClsss {
 
 let someProperty : SomeType = {
 
 return  someValue
 }()
 
 }
 
 注意：闭包结尾的大括号后面接了一对小括号。这用来告诉Swift 立即执行次闭包。如果你忽略了这对括号， 相当于将闭包本身作为赋值给了属性， 而不是将闭包的返回值赋值给属性。
 
 如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的self属性，或者调用任何实例方法
 
 */

//下面例子中定义了一个结构体 CheckerBoard 它构建了一个西洋跳棋游戏的棋盘 西洋跳棋游戏在一副黑白格交替的10x10的棋盘中进行。为了呈现这副游戏棋盘，Checkerboard结构体定义了一个属性boardColors，它是一个包含100个Bool值的数组。在数组中，值为true的元素表示一个黑格，值为false的元素表示一个白格。数组中第一个元素代表棋盘上左上角的格子，最后一个元素代表棋盘上右下角的格子。

struct CheckerBoard {
    
    let boardColors : [Bool] = {
       
        var temporayBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            
            for j in 1...8 {
                
                temporayBoard.append(isBlack)
                isBlack = !isBlack
            }
            
            isBlack = !isBlack
            
            
        }
        
        return temporayBoard
        
    }()
    
    func squareBlackAtRow(row : Int, column : Int) -> Bool {
        
        return boardColors[row * 8 + column]
    }
    
}

//每当一个新的CheckBoard实例被创建时， 赋值闭包会被自动执行， boardColors 的默认值会被计算出来并返回。上面例子中描述的闭包将计算出棋盘中每个格子对应的颜色，并将这些值保存在一个临时数组中 最后在构建完成时将此数组作为闭包返回值返回。这个返回的数组会保存在 boardColors中，并可以通过函数工具来查询：
let board  = CheckerBoard()
print(board.squareBlackAtRow(row: 0, column: 1))

print(board.squareBlackAtRow(row: 7, column: 7))

print(board.squareBlackAtRow(row: 1, column: 1))











