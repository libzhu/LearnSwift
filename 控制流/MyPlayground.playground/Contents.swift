//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/*
 
 
 For-In 循环
 While 循环
 条件语句
 控制转移语句（Control Transfer Statements）
 提前退出
 检测 API 可用性

 */

//1、For-In 循环
//可以使用for- in 循环来遍历集合中的所有元素， 例如数字范围， 数组中的所有元素或者字符串中的字符

for index in 1...5 {
    print(index)
}

var hello = "hello"
for characterItem in hello.characters {
    
    print(characterItem)
}

//如果不需要区间序列内的每一项值，可以使用（_）替代 变量名来忽略这个值
let base = 3
let power = 10
var answer = 1

for _ in 1...power {
    
    answer *= base
    print(answer)
}

let names = ["张三", "李四", "王五", "赵六"]

for name in names {
    
    print("姓名是：\(name)")
}

let nuberOfLegs = ["spider" : 8, "ant" : 4, "cat" : 4]

for (animalName, number) in nuberOfLegs {
    
    print("动物：\(animalName) 的数量 ：\(number)")
}

//2、While 循环 会一直运行一段语句直到条件变成 FALSE。这类循环适合在第一次迭代以前，迭代次数未知的情况下。
//while 循环， 每次在循环开始时计算条件是否符合
//repeat - while 循环 每次在循环结束时计算条件是否符合

//while 循环从开始计算第一个条件开始。如皋条件为TRUE， 会重复运行一段语句，知道条件变成 FALSE

//let finalSquare = 25
//
//var board = [Int](repeating: 0, count: finalSquare + 1)
//
//board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
//board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
//
//var square = 0
//var diceRoll = 0
//while square < finalSquare {
//    // 掷骰子
//    diceRoll += 1
//    if diceRoll == 7 { diceRoll = 1 }
//    // 根据点数移动
//    square += diceRoll
//    if square < board.count {
//        // 如果玩家还在棋盘上，顺着梯子爬上去或者顺着蛇滑下去
//        square += board[square]
//    }
//}
//print("Game over!")




//let finalSquare = 25
//var board = [Int](repeating: 0, count: finalSquare + 1)
//board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
//board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
//var square = 0
//var diceRoll = 0
//
//
//repeat {
//    // 顺着梯子爬上去或者顺着蛇滑下去
//    square += board[square]
//    // 掷骰子
//    diceRoll += 1
//    if diceRoll == 7 { diceRoll = 1 }
//    // 根据点数移动
//    square += diceRoll
//} while square < finalSquare
//print("Game over!")
//
//3、条件语句
/*
 条件语句
 
 根据特定的条件执行特定的代码通常是十分有用的。当错误发生时，你可能想运行额外的代码；或者，当值太大或太小时，向用户显示一条消息。要实现这些功能，你就需要使用条件语句。
 
 Swift 提供两种类型的条件语句：if语句和switch语句。通常，当条件较为简单且可能的情况很少时，使用if语句。而switch语句更适用于条件较复杂、有更多排列组合的时候。并且switch在需要用到模式匹配（pattern-matching）的情况下会更有用。
 */

var temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}


temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}

/*
 switch语句会尝试把某个值与若干个模式（pattern）进行匹配。根据第一个匹配成功的模式，switch语句会执行对应的代码。当有可能的情况较多时，通常用switch语句替换if语句。
 */

let someCharacter : Character = "H"

switch someCharacter {
case "x":
    print("x")
case "y":
    print("x")
case "H":
    print("H")
default:
    print("什么都没有")
}

//每一个case 分支 至少必须包含一条语句，

//let anotherCharacter = "b"
//switch anotherCharacter {
//case "b"://无效这个分支下面没有语句
//case "B":
//    print("B")
//default:
//    print("默认")
//}

let anotherCharacter = "B"
switch anotherCharacter {
case "b"://无效这个分支下面没有语句
    break
case "B":
    print("B")
default:
    print("默认")
}

let anotherOneCharacter = "A"
switch anotherOneCharacter {
case "a", "A":
    print("含有A或是a")
default:
    print("没有A或是a")
}

//case 分支的模式 可以是一个值的区间 

let approximateCount : Int = 62
let countedThings = "moons orbiting Saturn"
var naturalCount : String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")


//可以使用元祖 在同一Swift 中测试多个值， 元祖中的值可以值， 也可以是区间
let somePoint = (1, 0)

switch somePoint {
case (0, 0):
    print("在原点上")
case (_, 0):
    print("在x轴上")
case (0, _):
    print("在y轴上")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) 在这个区间盒子中")
default:
    print("(\(somePoint.0), \(somePoint.1)) 在盒子外面")
}

//绑定值  case 分支 允许将匹配的值绑定到一个临时的常量 或 变量 并且在case 分支内使用。这种行为被称为 值绑定 因为匹配的值在case分支体内，与临时的常量或变量绑定
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("在x轴上且x的值为：\(x)")
case (0, let y):
    print("在y轴上且x的值为：\(y)")
case (let x, let y):
    print("既不在x轴，也不在y轴，在：(\(x), \(y))")
}

//case 分支的模式可以使用 where 语句来判断额外的条件
let yesAnohterPoint = (1, -1)
switch yesAnohterPoint {
case let (x, y) where x == y:
    print("(\(x),\(y))在x == y 这条线上")
case let (x, y) where x == -y:
    print("(\(x), \(y)在x == y) 这条线上")
case let (x, y) :
    print("(\(x), \(y))既不在x == y 也不再 x == -y")
    
}

//复合匹配 当多个条件可以使用同一种方法来处理时，可以将这几种可能放在同一个 case 后面， 并且用逗号隔开。当 case 后面的任意一种模式匹配时，这条分支就会被匹配。并且如果匹配列表过长，还可以分行书写
let someOneCharacter = "a"
switch someOneCharacter {
case "a", "e", "i", "o", "u":
    print("\(someOneCharacter) 是声母")
case  "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
    "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
     print("\(someCharacter) is not a vowel or a consonant")
}


let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}

//4、控制转移语句
/*
 控制转移语句改变代码的执行顺序， 通过它可以实现代码的跳转
 Swift有
 continue、break、fallthrough、return、throw；
 */
//continue 告诉一个循环体立即停止本次循环，重新开始下次循环。就好像说 本次循环我已经执行了，但是并不会离开整个循环体。

let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for character in puzzleInput.characters {
    
    switch character {
    case "a", "o", "e", "i", "u", " ":
        continue
    default:
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)

//Break 语句会立即结束 整个控制流的执行，当你想要更早的结束一个 switch 代码块 或者 一个 循环体时，可以使用 break 语句

//循环语句中的break 会立即终端 该循环体，然后跳转到表示循环体结束的}后的第一行代码。不会再有本次循环的代码被执行，也不会再有下一次的循环产生

//switch 语句中的 break 会立即中断 该switch 代码块的执行，并且跳转到表示 switch 代码块结束的大括号 } 后的第一句代码行.这种特性可以用来匹配或者忽略多个分支。有时为了是你的意图更加明显，需要特意匹配或者忽略某个分支。那么当你想忽略某个分支时，可以再该分支内写上 break 语句。当该分支被匹配到时，分支内的 break 语句立即结束 switch 代码块

let numberSymbol : Character = "三"// 简体中文的 数字 3

var possibleIntegerValue : Int?
switch numberSymbol {
case "1", "/", "-", "@":
    possibleIntegerValue = 1
case "2", "/", "二", "@":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
    
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
    
default:
    break
}

if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}


//贯穿
/*
 Swift 中的switch不会从上一个 case 分支落入到下一个 case 分支中。相反，只要第一个匹配到的 case 分支完成了它需要执行的语句，整个switch代码块完成了它的执行。相比之下，C 语言要求你显式地插入break语句到每个 case 分支的末尾来阻止自动落入到下一个 case 分支中。Swift 的这种避免默认落入到下一个分支中的特性意味着它的switch 功能要比 C 语言的更加清晰和可预测，可以避免无意识地执行多个 case 分支从而引发的错误。
 
 如果你确实需要 C 风格的贯穿的特性，你可以在每个需要该特性的 case 分支中使用fallthrough关键字。下面的例子使用fallthrough来创建一个数字的描述语句。
 */
let integerToDescribe = 5
var description = "the  number \(integerToDescribe) is"

switch integerToDescribe {
case 2, 3, 4, 5, 6, 7,8 ,9:
    
    description += " a prime number, and so"
    
    fallthrough//Swift 中的贯穿， 写了之后才可执行到下一条语句。否则要是匹配执行完 分支语句之后， 结束switch 代码块
    
default:
    description += " an integer"
}

print(description)

/*
 
 带标签的语句
 
 在 Swift 中，你可以在循环体和条件语句中嵌套循环体和条件语句来创造复杂的控制流结构。并且，循环体和条件语句都可以使用break语句来提前结束整个代码块。因此，显式地指明break语句想要终止的是哪个循环体或者条件语句，会很有用。类似地，如果你有许多嵌套的循环体，显式指明continue语句想要影响哪一个循环体也会非常有用。
 
 为了实现这个目的，你可以使用标签（statement label）来标记一个循环体或者条件语句，对于一个条件语句，你可以使用break加标签的方式，来结束这个被标记的语句。对于一个循环语句，你可以使用break或者continue加标签，来结束或者继续这条被标记语句的执行。
 
 声明一个带标签的语句是通过在该语句的关键词的同一行前面放置一个标签，作为这个语句的前导关键字(introducor keyword)，并且该标签后面跟随一个冒号。下面是一个针对while循环体的标签语法，同样的规则适用于所有的循环体和条件语句。
 
 label name: while condition { statements }
 
 下面的例子是前面章节中蛇和梯子的适配版本，在此版本中，我们将使用一个带有标签的while循环体中调用break和continue语句。这次，游戏增加了一条额外的规则：
 
 为了获胜，你必须刚好落在第 25 个方块中。
 
 如果某次掷骰子使你的移动超出第 25 个方块，你必须重新掷骰子，直到你掷出的骰子数刚好使你能落在第 25 个方块中。
 
 游戏的棋盘和之前一样：
 
 */
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0

//这个版本的游戏使用while循环和switch语句来实现游戏的逻辑。while循环有一个标签名gameLoop，来表明它是游戏的主循环。该while循环体的条件判断语句是while square !=finalSquare，这表明你必须刚好落在方格25中。
gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        // 骰子数刚好使玩家移动到最终的方格里，游戏结束。
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // 骰子数将会使玩家的移动超出最后的方格，那么这种移动是不合法的，玩家需要重新掷骰子
        continue gameLoop//continue 在这里只在while 循环体中 可以不写 gameLoop 中止循环
    default:
        // 合法移动，做正常的处理
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")

//注意：如果上述的break语句没有使用gameLoop标签，那么它将会中断switch语句而不是while循环。使用gameLoop标签清晰的表明了break想要中断的是哪个代码块。 同时请注意，当调用continue gameLoop去跳转到下一次循环迭代时，这里使用gameLoop标签并不是严格必须的。因为在这个游戏中，只有一个循环体，所以continue语句会影响到哪个循环体是没有歧义的。然而，continue语句使用gameLoop标签也是没有危害的。这样做符合标签的使用规则，同时参照旁边的break gameLoop，能够使游戏的逻辑更加清晰和易于理解。


/*
 
 提前退出
 
 像if语句一样，guard的执行取决于一个表达式的布尔值。我们可以使用guard语句来要求条件必须为真时，以执行guard语句后的代码。不同于if语句，一个guard语句总是有一个else从句，如果条件不为真则执行else从句中的代码。
 
 */

func greet(person:[String:String]){
    
    guard let name = person["name"] else {
        
        return
    }
    print("Hello \(name)")
    
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
    
}

greet(person: ["name" : "zhu"])//函数的调用

greet(person: ["name" : "xu", "location" : "wuhan"])//函数的调用

/*
 如果guard语句的条件被满足，则继续执行guard语句大括号 } 后的代码。将变量或者常量的可选绑定作为guard语句的条件，都可以保护guard语句后面的代码。
 
 如果条件不被满足，在else分支上的代码就会被执行。这个分支必须转移控制以退出guard语句出现的代码段。它可以用控制转移语句如return,break,continue或者throw做这件事，或者调用一个不返回的方法或函数，例如fatalError()。
 
 相比于可以实现同样功能的if语句，按需使用guard语句会提升我们代码的可读性。它可以使你的代码连贯的被执行而不需要将它包在else块中，它可以使你在紧邻条件判断的地方，处理违规的情况。
 */

//6、检测 API 可用性
/*
 检测 API 可用性
 
 Swift内置支持检查 API 可用性，这可以确保我们不会在当前部署机器上，不小心地使用了不可用的API。
 
 编译器使用 SDK 中的可用信息来验证我们的代码中使用的所有 API 在项目指定的部署目标上是否可用。如果我们尝试使用一个不可用的 API，Swift 会在编译时报错。
 
 我们在if或guard语句中使用可用性条件（availability condition)去有条件的执行一段代码，来在运行时判断调用的API是否可用。编译器使用从可用性条件语句中获取的信息去验证，在这个代码块中调用的 API 是否可用。
 
 if #available(iOS 10, macOS 10.12, *) {
 // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
 } else {
 // 使用先前版本的 iOS 和 macOS 的 API
}
 
 以上可用性条件指定，在iOS中，if语句的代码块仅仅在 iOS 10 及更高的系统下运行；在 macOS中，仅在 macOS 10.12 及更高才会运行。最后一个参数，*，是必须的，用于指定在所有其它平台中，如果版本号高于你的设备指定的最低版本，if语句的代码块将会运行。
 
 在它一般的形式中，可用性条件使用了一个平台名字和版本的列表。平台名字可以是iOS，macOS，watchOS和tvOS——请访问声明属性来获取完整列表。除了指定像 iOS 8的主板本号，我们可以指定像iOS 8.3 以及 macOS 10.10.3的子版本号。

 */

