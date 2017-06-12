//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//1、初始化空字符串
var emptyString = ""
var anothrEmptyString = String()
// 两个字符串均为空 并等价

//可以通过检查其 bool 类型的 isEmpty 属性 类判断该字符串是否为空字符串

if emptyString.isEmpty {
    print("字符串为空字符串");
}

//2、字符串的可变性
//可以通过讲一个特定字符串分配给一个变量来对其进行修改，或则分配给一个常量来保证其不被修改
var variableString = "Hourse"
variableString = "hello world"

let constantString = "beijing"
//constantString += "i"

let testStr : String
var testOtherStr : String

//3、Swift 的String类型是值类型。 如果您创建了一个新的字符串，那么当其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝。 任何情况下，都会对已有字符串值创建新副本，并对该新副本进行传递或赋值操作。 值类型在 结构体和枚举是值类型 中进行了详细描述。Swift 默认字符串拷贝的方式保证了在函数/方法中传递的是字符串的值。 很明显无论该值来自于哪里，都是您独自拥有的。 您可以确信传递的字符串不会被修改，除非你自己去修改它。在实际编译时，Swift 编译器会优化字符串的使用，使实际的复制只发生在绝对必要的情况下，这意味着您将字符串作为值类型的同时可以获得极高的性能。


//4、使用字符
//您可通过for-in循环来遍历字符串中的characters属性来获取每一个字符的值：

for character in "hello world".characters {
    
    print(character)
}

//另外，通过标明一个 character 类型并用字符类型进行赋值，可以建立一个独立的字符常量或变量

let characterMark : Character = "a"
print(characterMark)

//字符串可以通过传递一个值类型为 character 的数组作为变量类初始化

let catCharacters : [Character] = ["c", "a", "t", "🐈"]

let catString = String(catCharacters)
print(catString)


//5、连接字符串 和 字符
//字符串可以通过加法运算符（+）相加在一起（或程“连接”）创建一个新的字符串：

let string1 = "hello"
let string2 = "world"
let string3 = string1 + string2
print(string3)

//也可以通过加法赋值运算符（+=）讲一个字符串添加到一个已经存在的字符串变量上

var instruction = "look all"
instruction += string2
print(instruction)

//也可通过 append（）方法将一个字符添加到一个字符串变量的尾部

let exclamationMark : Character = "!"
instruction.append(exclamationMark)


//6、字符串插值是一种构建新字符串的方式，可以在其中包含常量， 变量， 字面量和表达式，你插入的字符串字面量的每一项都在以反斜杠未前缀的圆括号中
let multiplier = 3
let message = "\(multiplier) 乘以 2.5 等于 \(Double(multiplier) * 2.5)"
print(message)

//7、Unicode是一个国际标准，用于文本的编码和表示。可以使用标准格式来表示来自任意语言几乎所有的字符，并能够对文本文件或网页这样的外部资源中的字符进行读写操作。Swift 中的 String 和 character 类型完全兼容Unicode标准
//Unicode 标量 swift 的 Sting 类型是基于Unicode标量建立的。

//8、字符串字面量的特殊字符
//字符串字面量可以包含以下特殊字符：·转义字符\0 （空字符）、 \\(反斜杠)、\t(水平制表符)、\n(换行符)、\r(回车符)、\"(双引号)、\'(单引号)
//Unicode 标量：写成\u{n} u为小写， 其中 n 为任意一到八为16进制数且可用的Unicode编码

let wiseWords = "\"北京欢迎您\""
print(wiseWords)

let dollalSign = "\u{24}"  //$,Unicode 标量 U + 0024

let blackHeart = "\u{2665}" //❤，
let sparklingHeart = "\u{1F496}"      // 💖, Unicode 标量 U+1F496

//9、可扩展的字形群集
//每一个Swift 的 character 类型代表一个可扩展的字形群。一个可扩展的字形群是一个或多个可生成人类可读的字符串Unicode标量的有序排列
let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e 后面加上  ́
// eAcute 是 é, combinedEAcute 是 é

//10、计算字符数量
//如果要想获得一个字符串中 Character 值的数量， 就可以使用characters 属性中的 count 属性

let unusulMenagerie = "我爱北京天安门，天安门上城楼壮观美丽"
print("unusulMenagerie中字符的数量是\(unusulMenagerie.characters.count)个")

for character in unusulMenagerie.characters {
    print(character)
}
//注意：在Swift中 使用可拓展的字符群集作为 Character 值 来连接或改变字符串时，并不一定会改变字符串中字符的数量。

var word = "case"
print("\(word)中字符的数量：\(word.characters.count)")
word += "\u{301}"
print("\(word)中字符的数量：\(word.characters.count)")






