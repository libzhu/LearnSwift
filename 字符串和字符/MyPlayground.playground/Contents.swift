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

var otherWord = "hello"
otherWord += "\u{200}"
print("\(otherWord)中的字符数量：\(otherWord.characters.count)")


//11、访问或修改字符串
//可以通过字符串的属性和方法来访问和修改它， 亦可以通过其下标语法完成。
//11.1、字符串索引
//每个 String 值都有一个关联的索引（index）， String.Index,它对应着字符串中的每一个 Character 的位子
/*
 前面提到，不同的字符可能会占用不同数量的内存空间，所以要知道Character的确定位置，就必须从String开头遍历每一个 Unicode 标量直到结尾。因此，Swift 的字符串不能用整数(integer)做索引。
 
 使用startIndex属性可以获取一个String的第一个Character的索引。使用endIndex属性可以获取最后一个Character的后一个位置的索引。因此，endIndex属性不能作为一个字符串的有效下标。如果String是空串，startIndex和endIndex是相等的。
 
 通过调用 String 的 index(before:) 或 index(after:) 方法，可以立即得到前面或后面的一个索引。您还可以通过调用 index(_:offsetBy:) 方法来获取对应偏移量的索引，这种方式可以避免多次调用 index(before:) 或 index(after:) 方法。
 
 你可以使用下标语法来访问 String 特定索引的 Character。
 */

let greeting = "Guten Tag!"
greeting.startIndex
greeting[greeting.startIndex]//G

greeting.endIndex

var endIndex : String.Index = greeting.endIndex

greeting[greeting.index(before: greeting.endIndex)]

greeting.index(before: greeting.endIndex)

greeting[greeting.index(after: greeting.startIndex)]

let index = greeting.index(greeting.startIndex, offsetBy: 7)
let index8 = greeting.index(greeting.startIndex, offsetBy: 8)

greeting[index]
greeting[index8]

//试图获取越界索引对应的 Character 会发生错误
//greeting[greeting.endIndex]
//greeting.index(after: greeting.endIndex)

//12、字符串的插入或删除
//调用 insert（_:at:）方法可以在一个字符串的指定索引插入 一个 字符，使用insert（contentsOf：at：）可以在一个字符串的指定索引插入 一段 字符串

//插入一个字符
var welcome : String = "welcome"
welcome.insert("!", at: welcome.endIndex)
print(welcome)

welcome.insert(contentsOf: " to China".characters, at: welcome.endIndex)
print(welcome)

//调用 remove（at:）方法可以在一个字符串的指定索引删除一个字符， 
welcome.remove(at: welcome.index(welcome.startIndex, offsetBy: 7))
print(welcome)
print("welcome:\(welcome)中的字节数：\(welcome.characters.count)")

//调用removeSubrange（_:）可以在一个字符串的指定索引删除一个子字符串

let range = welcome.index(welcome.endIndex, offsetBy: -9)..<welcome.endIndex
print(range)
welcome.removeSubrange(range)
// welcome 现在等于 "welcome"
/*
 注意： 您可以使用 insert(_:at:)、insert(contentsOf:at:)、remove(at:) 和 removeSubrange(_:) 方法在任意一个确认的并遵循 RangeReplaceableCollection 协议的类型里面，如上文所示是使用在 String 中，您也可以使用在 Array、Dictionary 和 Set 中。
 */

//13、字符串相等
//字符串/字符可以用等于操作符(==)和不等于操作符(!=)
let qutotation = "We're a lot alike, you and I"
let someQutotation = "We're a lot alike, you and I"
if qutotation == someQutotation {
    print("这两个字符串相等")
}

/*
 如果两个字符串（或者两个字符）的可扩展的字形群集是标准相等的，那就认为它们是相等的。在这个情况下，即使可扩展的字形群集是有不同的 Unicode 标量构成的，只要它们有同样的语言意义和外观，就认为它们标准相等。
 
 例如，LATIN SMALL LETTER E WITH ACUTE(U+00E9)就是标准相等于LATIN SMALL LETTER E(U+0065)后面加上COMBINING ACUTE ACCENT(U+0301)。这两个字符群集都是表示字符é的有效方式，所以它们被认为是标准相等的：
 */

// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}
// 打印输出 "These two strings are considered equal"

//13.1 字符串前缀和后缀相等
/*
 通过调用字符串的hasPrefix(_:)/hasSuffix(_:)方法来检查字符串是否拥有特定前缀/后缀，两个方法均接收一个String类型的参数，并返回一个布尔值。
 
 下面的例子以一个字符串数组表示莎士比亚话剧《罗密欧与朱丽叶》中前两场的场景位置：
 */

let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1ScreenCount = 0
for acts in romeoAndJuliet {
    
    if acts.hasPrefix("Act 1") {
        act1ScreenCount += 1
    }
}

print("有\(act1ScreenCount)个数据在数据中")

var mansionCoutnt = 0
var cellCount = 0
for scene in romeoAndJuliet {
    
    if scene.hasSuffix("mansion") {
        
        mansionCoutnt += 1
    }else if scene.hasSuffix("cell"){
        
        cellCount += 1
    }
}










