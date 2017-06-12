//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var a = 1
a = 2;

let b = 2

let c = 3.14

var d = 0.618

var welcome : String = "hello world"

var red, green, blue: Double

red = 2.0
green = 2.11
blue = 14

//类型标注(给常量添加类型标注String)
let welcomestr : String

welcomestr = "hello baby"

/*————————————————————————————常量和变量的命名——————————————————*/
let π = 3.14159
let 你好 = "你好世界"
let 🐶 = "🐶"


print(🐶)
print(你好)
print(π)

/*————————————————————————————整数范围————————————————————————*/
let minValue = UInt8.min
let maxValue = UInt8.max
print("最大值",maxValue, "最小值", minValue)

//浮点数
//Double :表示64位浮点数。当你需要存储很大或者精度很高的浮点数时请用此类型
//float: 表示32位浮点数。精度要求不高的话可以使用此类型

//数值类字面量可以包括额外的格式来增强可读性。整数和浮点数都可以添加额外的零并且包含下划线，并不会影响字面量：
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

let three = 3
let pointOneFourOneFiveNine : Float = 0.14159
let pi = Float(3) + pointOneFourOneFiveNine

//布尔值
//Swift 有一个基本的布尔（Boolean）类型，叫做Bool。布尔值指逻辑上的值，因为它们只能是真或者假。swift的bool值只有ture 和 false：

let trueBoolValue = true
let falseBoolValue = false
print(trueBoolValue, falseBoolValue)

if trueBoolValue {
    print("正确")
}else{
    print("错误")
}

//如果你在需要使用 Bool 类型的地方使用了非布尔值，Swift 的类型安全机制会报错。下面的例子会报告一个编译时错误：
let i = 1
//
//if i {
//    
//    print("此处会报错，不能通过编译")
//}

if i == 1 {
    print("正确，通过编译")
}

//元祖
/*元祖（tuples）：把多个值组合成一个复合值。元祖内的值可以是不同类型的值*/

let http404Error = (404, "notFound")
//(404, "Not Found") 元组把一个 Int 值和一个 String 值组合起来表示 HTTP 状态码的两个部分：一个数字和一个人类可读的描述。这个元组可以被描述为“一个类型为 (Int, String) 的元组”。
//你可以把任意顺序的类型组合成一个元组，这个元组可以包含所有类型。只要你想，你可以创建一个类型为 (Int, Int, Int) 或者 (String, Bool) 或者其他任何你想要的组合的元组。


//1.元祖的分解. 你可以将一个元组的内容分解（decompose）成单独的常量和变量，然后你就可以正常使用它们了
let (stautCode, statusMessage) = http404Error

print("错误码： \(stautCode)")
print("错误信息：\(statusMessage)")

//2.如果只需要元祖的一部分， 分解的时候可以用（_）忽略不需要的部分
let (_, wantStatusMessage) = http404Error
print("错误信息:\(wantStatusMessage)")

//3.通过下标来访问元祖信息
let oneStatusCode = http404Error.0
let twoStatusMessage = http404Error.1

//创建元祖的时候可以给元祖中的单个元素命名
let http200Status = (code:200, msg:"返回成功！")

print(http200Status)

print(http200Status.code, http200Status.msg)



//可选类型:使用可选值类型（optionals）来处理可能缺失的情况。可选类型表示：·有值，等于x 或者 · 没有值

let possibleNumber = "123"
let convertedNumer = Int(possibleNumber)//let convertedNumer: Int?//返回的是一个可选值类型的Int？而不是Int （问号包含的值是可选类型，也就是说可能包含Int值， 也可能不包含值。不能包含其他任何值比如 Bool 值或者 String 值。只能是 Int 或者什么都没有。）

//nil  可以给可变变量赋值为nil 来表示它没有值：
var serverResponseCode : Int? = 404;// serverResponseCode 包含一个可选的 Int 值 404

serverResponseCode = nil // serverResponseCode 现在不包含值


//var testValue : Int = 404
//
//testValue = nil

//注意：nil不能用于非可选的常量和变量。如果你的代码中有常量或者变量需要处理值缺失的情况，请把它们声明成对应的可选类型。
//Swift 的 nil 和 Objective-C 中的 nil 并不一样。在 Objective-C 中，nil 是一个指向不存在对象的指针。在 Swift 中，nil 不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选状态都可以被设置为 nil，不只是对象类型。

var surveyAnswer : String?

let otherAnswer : String?

var surveyohterAnswer : String?

otherAnswer = "hello world"

surveyAnswer = "a"

surveyAnswer = "b"


//if 语句以及强制解析

if convertedNumer != nil {
    
    print("convertedNumer contains some integer value \(convertedNumer)")
}

//当你确定这个可选类型确实包含值之后，你可以在可选测名字后面加一个感叹号（ ！）来获取这个值。这个感叹号表示“我知道这个可选值有值，请使用它。”这被称为可选值的强制解析
if convertedNumer != nil {
    
    print("这个可选值的值：\(convertedNumer!)")
}

//注意：使用 ! 来获取一个不存在的可选值会导致运行时错误。使用 ! 来强制解析值之前，一定要确定可选包含一个非 nil 的值。
//if serverResponseCode == nil {
//    print("serverResponseCode 的值：\(serverResponseCode!)")
//}

//可选绑定
//使用可选绑定（optional binding） 来判断可选类型是否包含值， 入股包含就把值赋给一个临时常量或变量。可选绑定可以用在if 和 while 的语句中 这条语句不仅可以用来判断可选类型中是否有值，同时可以将可选类型中的值赋给一个常量或变量。if 和 while 语句
if let actualNumber = Int(possibleNumber){//这段代码可以被理解为：“如果 Int(possibleNumber) 返回的可选 Int 包含一个值，创建一个叫做 actualNumber 的新常量并将可选包含的值赋给它。”如果转换成功，actualNumber 常量可以在 if 语句的第一个分支中使用。它已经被可选类型 包含的 值初始化过，所以不需要再使用 ! 后缀来获取它的值。在这个例子中，actualNumber 只被用来输出转换结果你可以在可选绑定中使用常量和变量。如果你想在if语句的第一个分支中操作 actualNumber 的值，你可以改成 if var actualNumber，这样可选类型包含的值就会被赋给一个变量而非常量。
    
    print("\'\(possibleNumber)\' 中有一个integer 的值是\(actualNumber)")
}else{
    
    print("\'\(possibleNumber)\' 中没有一个integer的值");
}

/*隐式解析可选类型
 
 如上所述，可选类型暗示了常量或者变量可以“没有值”。可选可以通过 if 语句来判断是否有值，如果有值的话可以通过可选绑定来解析值。
 
 有时候在程序架构中，第一次被赋值之后，可以确定一个可选类型总会有值。在这种情况下，每次都要判断和解析可选值是非常低效的，因为可以确定它总会有值。
 
 这种类型的可选状态被定义为隐式解析可选类型（implicitly unwrapped optionals）。把想要用作可选的类型的后面的问号（String?）改成感叹号（String!）来声明一个隐式解析可选类型。
 
 当可选类型被第一次赋值之后就可以确定之后一直有值的时候，隐式解析可选类型非常有用。隐式解析可选类型主要被用在 Swift 中类的构造过程中
 */
//一个隐式解析可选类型其实就是一个普通的可选类型，但是可以被当做非可选类型来使用，并不需要每次都使用解析来获取可选值。下面的例子展示了可选类型 String 和隐式解析可选类型 String 之间的区别：
let possibleString : String? = "hello world"//正常的可选类型
let possibleStringValueStr = possibleString! //非隐式可选类型需要感叹号 来取值

let otherPossibleString : String! = "hello beijin" //隐式解析可选类型
let otherPossibleStringValueStr = otherPossibleString  //隐式可选类型 可直接赋值  不用感叹号

/*---------------------正常的可选类型赋值及可选绑定--------------------------------*/
if possibleString != nil {
    print("\(possibleString!)")
}

if let optionStr  = possibleString {
    
    print(optionStr)
}else{
    
    print("possibleString 中没有 String 值")
}


/*-----------------隐式解析可选类型赋值及可选绑定------------*/
if otherPossibleString != nil {
    
    print(otherPossibleString)
}

if let getStr = otherPossibleString {
    
    print(getStr)
}

//注意：如果一个变量之后可能变成nil的话请不要使用隐式解析可选类型。如果你需要在变量的生命周期中判断是否是nil的话，请使用普通可选类型。


/*
 使用断言进行调试
 
 断言会在运行时判断一个逻辑条件是否为 true。从字面意思来说，断言“断言”一个条件是否为真。你可以使用断言来保证在运行其他代码之前，某些重要的条件已经被满足。如果条件判断为 true，代码运行会继续进行；如果条件判断为 false，代码执行结束，你的应用被终止。
 */
let age = -5
assert(age >= 0, "年龄不能小于0")
// 因为 age < 0，所以断言会触发
//在这个例子中，只有 age >= 0 为 true 的时候，即 age 的值非负的时候，代码才会继续执行。如果 age 的值是负数，就像代码中那样，age >= 0 为 false，断言被触发，终止应用。


		
