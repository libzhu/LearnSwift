//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/*
 本页内容包含：
 
 枚举语法
 使用 Switch 语句匹配枚举值
 关联值
 原始值
 递归枚举

 */

//枚举为一组相关的值定义了一个共同的类型，是你可以在代码中一类型安全的方式来使用这些值；
//枚举会为一组整型值分配相关的名称。Swift 中的枚举更加灵活，不必给每一个成员提供一个值。如果给枚举成员提供一个值（称为原始值），则该值的类型可以是字符串，字符，或是整形值或浮点数
//此外， 枚举成员可以指定任意类型的关联值存储到枚举成员中，就像其他语言中的联合体，（unions）和 变体（variants）你可以在一个枚举中定义一组相关的枚举成员，每个枚举成员都可以有适当类型的关联值。
//在 Swift 中，枚举类型是一组（first-class）类型。它们采用了很多在传统上只被类（class）所支持的特性，例如计算属性（computed properties），用于提供枚举值的附加信息，实例方法（instance methods），用于提供和枚举值相关联的功能。枚举也可以定义构造函数（initializers）来提供一个初始值；可以在原始实现的基础上扩展它们的功能；还可以遵循协议（protocols）来提供标准的功能。

//1、枚举语法
//1:使用 enum 关键词来创建枚举并且把它们的整个定义放在一对带括号中

enum SomeEnumeration{
    
    //枚举定义放在这里
    
}

//下面用枚举表示指南针的四个方向
enum CompassPoint {
    
    case north
    case south
    case west
    case east
}

//枚举中定义的值（如：north south west east）是这个枚举的成员值。你可以用 case 关键字来定义一个新的枚举成员
//特别注意：与C 和 OC 不同 Swift 的枚举成员在创建时不会被赋予一个默认的整型值，在上面的CompassPoint 例子中，north south east west 不会被隐式的赋值为0， 1， 2， 和 3. 相反，这些枚举成员本省就是完备的值，这些类型的值是已经完全定义好的 CompassPoint 类型
//多个成员值 可以出现在同一行上，用逗号隔开
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//每个枚举定义了一个全新的类型。 像 swift 中其他类型一样，他的名字（例如CompassPoint， Planet）应该以一个大写字母开头。给枚举起一个单名字而不是复数名字，以便读起来更加容易理解；

var directionToHead = CompassPoint.north//directionToHead 的类型可以被他的CompassPoint 的某个初始化值推断出来。一旦directionToHead 被声明为CompassPoint 类型，你可以使用 更简单的语法将其设置为另一个 CompassPoint 的值：
directionToHead = .south  //当directionToHead 的类型已知时，再次为其赋值可以省略枚举类型名。在使用显示类型的枚举值时， 这种写法让代码更具有可读性。

//2.使用switch 语句匹配枚举值
// 可以使用switch 语句 匹配单个枚举值
directionToHead = .west

switch directionToHead {
case .north:
    print("指向是->北")
case .south:
    print("指向是->南")
case .west:
    print("指向是->西")
default:
    print("指向是->东")
}

let somePlanet = Planet.earth

switch somePlanet {
    
case .earth:
    print("地球")
default:
    print("其他星球")
}

//3、关联值 
//上一小节的例子演示了如何定义和分类枚举的成员。你可以为Planet.earth设置一个常量或者变量，并在赋值之后查看这个值。然而，有时候能够把其他类型的关联值和成员值一起存储起来会很有用。这能让你连同成员值一起存储额外的自定义信息，并且你每次在代码中使用该枚举成员时，还可以修改这个关联值。

//你可以定义 Swift 枚举来存储任意类型的关联值，如果需要的话，每个枚举成员的关联值类型可以各不相同。枚举的这种特性跟其他语言中的可识别联合（discriminated unions），标签联合（tagged unions），或者变体（variants）相似。

//例如，假设一个库存跟踪系统需要利用两种不同类型的条形码来跟踪商品。有些商品上标有使用0到9的数字的 UPC 格式的一维条形码。每一个条形码都有一个代表“数字系统”的数字，该数字后接五位代表“厂商代码”的数字，接下来是五位代表“产品代码”的数字。最后一个数字是“检查”位，用来验证代码是否被正确扫描：
//其他商品上标有 QR 码格式的二维码，它可以使用任何 ISO 8859-1 字符，并且可以编码一个最多拥有 2,953 个字符的字符串：
enum BarCode {
    
    case upc(Int, Int, Int, Int)
    case qrCode(String)
    
}
//解释 :定义一个名为 BarCode 的枚举类型、它的成员值具有（int， int， int， int）类型关联的 UPC 另一个成员具有 String 类型关联的qrCode

var productBarcode = BarCode.upc(9, 85909, 51226, 3)//关联的元祖值为(9, 85909, 51226, 3)

//同一个商品 可以被分配一个不同类型的条形码， 例如
//productBarcode = .qrCode("akfjladfjlajflk")

switch productBarcode {
case .upc(let nuberSystem, let manufacturer, let product, let check):
    
    print("条形码：\(nuberSystem) \(manufacturer) \(product) \(check)")
    
case .qrCode(let productCode):

    print("二维码：\(productCode)")
}

//如果一个枚举成员的所有关联值被提取为常量， 或是都被提取为变量变量，为了简洁，可以在成员名称前标注一个 let  或 var
productBarcode = .qrCode("helloworld")
switch productBarcode {
case let .upc(numbersSystem, manufacturer, product, check):
    print("条形码：\(numbersSystem) \(manufacturer) \(product) \(check)")
case let .qrCode(productCode):
    
    print("二维码：\(productCode)")
    
}

//3、原始值
/*
 在关联值小节的条形码例子中，演示了如何声明存储不同类型关联值的枚举成员。作为关联值的替代选择，枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同。
 
 这是一个使用 ASCII 码作为原始值的枚举：
 */

enum ASCIIControlCharacter : Character {
    
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
//解释：枚举类型：ASCIIControlCharacter 的原始值类型被定义为 Character 并设置了一些比较常见的 ASCLL 控制符。
//原始值可以是字符串， 字符， 或者任意整型或浮点值型。每个原始值 在枚举声明中必须是唯一的
//注意；原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值可以变化

//3.1 原始值的隐式赋值
//在使用原始值作为整型或者字符串类型的枚举时，不需要显示的为每一个枚举成员 设置原始值，Swift 会自动为你赋值；
//例如；当你使用整型作为原始值时，隐式赋值的值依次递增 1， 如果第一个枚举成员没有设置原始值，其原始值将为0
enum Planets : Int {
    
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus
}

let originValue = Planets.mercury.rawValue
print(originValue)

//当使用字符串为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称；

enum NewCompassPoint : String {
    
    case north, south, west, east
}

//NewCompassPoint.soutn 拥有隐式的原始值 south 依次类推

//原始值：rawValue 属性 可以访问给枚举成员的原始值
let earthOrder = Planets.earth.rawValue

let southDirection = NewCompassPoint.south.rawValue

//3.2、使用原始值初始化枚举实例
//如果在定义了枚举类型的时候使用了原始值， 那么将会自动获得一个初始化方法， 这个方法接受一个rawValue 的参数， 参数类型即为原始值类型，返回值则是枚举成员 或 nil 你可以使用这个方法来创建一个新的枚举实例。

let possiblePlanet = Planets(rawValue: 5)//possiblePlanet 类型为 Planets？ 值为 Planets.jupiter
//然而 并非所有的int 值都可以匹配到行星。因此，原始值构造器总是返回一个可选的枚举成员。在上面的例子中 possiblePlanet 是 Planets? 类型，或者说是可选的 Planets 

//MARK:注意:原始值构造器是一个可失败构造器，因为并不是每一个原始值都有与之对应的枚举成员。

//如果视图寻找位置为 11 的行星， 通过原始值构造返回的可能是nil
let positionToFind = 1
if let somePlant = Planets(rawValue : positionToFind) {
    
    switch somePlant {
    case .earth:
        print("地球");
    default:
        print("不是地球！")
    }
}else{
    
    print("所选的：\(positionToFind)位没有星球")
}


//4、递归枚举
//递归枚举是一种枚举类型，它有一个或多个枚举 成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。可以在枚举成员前加上indirect 来表示该成员可以递归
enum ArithmenticExpression {
    
    case number(Int)
    indirect case addition(ArithmenticExpression, ArithmenticExpression)//成员变量是可以递归的
    indirect case multiplication(ArithmenticExpression, ArithmenticExpression) ////成员变量是可以递归的
}

//可以在枚举成员开头加上 indirect 关键字来表明 这个枚举是可以递归的
indirect enum AnotherArithmenticExpression {
    
    case number(Int)
    case addition(AnotherArithmenticExpression, AnotherArithmenticExpression)
    case multiplication(AnotherArithmenticExpression, AnotherArithmenticExpression)
}

let five = AnotherArithmenticExpression.number(5)
let four = AnotherArithmenticExpression.number(4)
let sum = AnotherArithmenticExpression.addition(four, five)
let product = AnotherArithmenticExpression.multiplication(sum, four)

func evaluate(_ expression : AnotherArithmenticExpression) -> Int {
    
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
        
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(sum))
print(evaluate(product))







