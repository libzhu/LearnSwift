//: Playground - noun: a place where people can play

import UIKit
import Foundation
var str = "错误处理"

/*
 
 · 表示并抛出错误
 · 错误处理
 · 指定清理操作
 
 */

//错误处理（error handling）是响应错误以及从错误中恢复的过程。Swift提供了在运行时对可恢复错误的抛出、捕获、传递和操作的功能。
//某些操作无法保证总是执行完所有代码或总是生成游泳的结果。可选类型可用来表示缺失，但是当某个操作失败时， 最好能的值失败的原因，从而做出相应的应对。
//举个例子，假如有一个磁盘
/**
 
 假如有个从磁盘上的某个文件读取数据并进行处理的任务，该任务会有多种可能失败的情况，包括指定路径下文件并不存在，文件不具有可读权限，或者文件编码格式不兼容。区分这些不同的失败情况可以让程序解决并处理某些错误，然后把它解决不了的错误报告给用户。
 
 注意
 Swift 中的错误处理涉及到错误处理模式，这会用到 Cocoa 和 Objective-C 中的NSError。关于这个类的更多信息请参见 Using Swift with Cocoa and Objective-C (Swift 3.0.1) 中的错误处理。

 
 */

//表示并抛出错误
//在Swift 中， 错误用符合 Error 协议的类型的只来表示。这个空协议表明该类型可以用于错误处理。
//Swift的枚举类型尤为适合构建一组相关的错误状态，枚举的关联值还可以提供错误状态的额外信息。例如，可以这样表示在一个游戏中操作自动贩卖机时可能出现的错误状态：
enum VendingMachineError : Error {
    
    case invalidSelection //选择无效
    case insufficentFunds(coinsNeeded : Int)//金额不足
    case outOfStock  //缺货
}

//抛出一个错误可以让你表明有意外情况发生， 导致正常的执行流程无法继续执行。抛出错误使用关键字 throw 例如，下面的代买抛出一个错误，提示贩卖机还需要5个硬币
// throw VendingMachineError.insufficentFunds(coinsNeeded: 5)

//处理错误。
//某个错误被抛出时，附近的某部分代码必须负责处理这个错误，例如纠正整个问题， 尝试另一种方式、或是向用户报告错误。
//Swift中有四种处理错误的方式，可以把函数抛出的错误传递给调用此函数的代码、用 do - catch 语句处理错误、将错误作为可选类型处理、或者断言此错误根本不会发生。 
//当一个函数抛出错误时，你的程序流程会发生改变，所以重要的是你能迅速识别代码中抛出错误的地方。为了标识这个地方， 在调用一个抛出错误函数、方法或者构造器之前， 加上太try关键字 或者try？或try！这种变体。注意
//Swift 中的错误处理和其他语言中用try，catch和throw进行异常处理很像。和其他语言中（包括 Objective-C ）的异常处理不同的是，Swift 中的错误处理并不涉及解除调用栈，这是一个计算代价高昂的过程。就此而言，throw语句的性能特性是可以和return语句相媲美的。

//throwing 函数传递错误
//为了表示一个函数、方法或构造器可以抛出错误， 在函数声明的参数列表之后加上关键字throws 一个标有 throw关键字的函数被称作 throwing 函数。如果这个函数指明了返回值类型，throws 关键词需要写在 -> 的前面。
func canThrowErrors() throws -> String {
    
    return "hh"
}

func canNotThrowErrors() -> String {
    
    return "hh"
}

//一个throwing 函数可以在其内部抛出错误， 并将错误传递到函数被调用是的作用域
//注意：只有throwing 函数可以传递错误。任何在某个非throwing函数内部抛出的错误只能在函数内部处理。

//下面的例子中：VendingMachine 类有一个 vend（itemNamed：）方法， 如果请求的物品不存在、缺货或投入金额小于物品价格， 该方法就会抛出一个相应的VendingMachineError：

struct Item  {
    
    var price : Int
    var count : Int
    
}

class VendingMachine {
    
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func dispenseSanck(snack : String) {
        
        print("Dispensing \(snack)")
    }
    
    func vend(itemNamed name : String) throws {
        
        guard let item = inventory[name] else {
            
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            
            throw VendingMachineError.insufficentFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        
        newItem.count -= 1
        
        inventory[name] = newItem
        
        print("Dispensing : \(name)")
        
        
    }
    
    
}

//在vend(itemNamed:)方法的实现中使用了 guard 语句来提前退出，确保在购买某个物品所需的条件中，有任一条件不满足时，能够提前退出方法并抛出相应的错误。由于throw 语句会立即退出方法， 所以物品只有在所有条件都满足的情况下才会被出售。
//vend(itemName:)会传递它抛出的错误， 在你的代码中调用此方法的地方， 必须要么直接处理这些错误--使用 do -- catch语句 try? 或try！；要么继续让这个错误传递下去。例如下面的这个例子中 buyFavoriteSnack（_ : vendingMachine:）同样是一个 throwing 函数， 任何vend（itemNamed：）方法抛出的错误会一直被传递到 buyFavoriteSnack(person:vendingMachine:)函数被调用的地方
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person : String, vendingMachine : VendingMachine) throws {
    
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    
    try vendingMachine.vend(itemNamed: snackName)
    
}

//上例中：buyFavoriteSnack(person: String, vendingMachine: VendingMachine)会查找某人最喜欢的零食， 并通过vend（itemNamed：）方法来尝试为他们购买。因为 vend（itemNamed：）方法能抛出错误, 所以在调用他时候 在他前面加上try 关键字。
//throwing 构造器能像throwing函数一样传递错误。例如下面的代码中 PurchaseSanck 构造器 在构造的过程中调用了 throwing 函数， 并且通过传递到它的调用者来处理这些错误。


struct PurchaseSnack {
    
    let name : String
    init(name : String, vendingMachine : VendingMachine) throws {
        
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
    
}

//使用 DO - Catch 处理错误
//可以使用一个do-catch 语句运行一段闭包代码来处理错误。如果在do字句中的代码抛出一个错误，这个错误会与catch字句做匹配， 从而决定那条子句能处理
/**
 do - catch 语句的一般形式
 
 do {
 try expression
 statements
 } catch pattern 1 {
 statements
 } catch pattern 2 where condition {
 statements
 }
 */
//在catch 后面写一个匹配模式来表明这个子句能处理什么样的错误。如果一条catch子句没有指定匹配模式， 那么这条子句可以匹配任何错误，并且报错误绑定到一个名字为Error的局部常量。
//catch 子句不必将do子句中的代码所抛出的每一个能错误都做处理，如果所有catch都未处理错误， 错误就会被传递到周围的作用域。然而。错误还是必须被某个周围的作用域处理 要么是一个外围的do - catch 错误处理语句， 要么是一个throwing函数的内部。
//例子 代码处理了VendingMachineError 枚举类型的全部枚举值，但是所有其他的错误就必须由周围的作用域处理：

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 40

do {
    
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    
}catch VendingMachineError.invalidSelection {
    
    print("invalid Selection")
    
}catch VendingMachineError.outOfStock {
    
    print("out of stock")
    
}catch VendingMachineError.insufficentFunds(let coinsNeeded){
    
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}


let errorDes = try?buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)



//将错误转成可选值
//可以使用try？通过将错误转成一个可选值来处理错误。如果在评估try？表达式时一个错误被抛出， 那么表达式的值是nil 。你如下面的代码中 x和y有着相同的数值和等价的含义。

func someThrowingFunction() throws -> Int {
    
    throw VendingMachineError.outOfStock
    return 1
}

let x = try? someThrowingFunction()

let y : Int?

do {
    try someThrowingFunction()
    
} catch  {
    y = nil
}

//如果someThrowingFuction()抛出一个错误  x和y的值是nil。 否则x 和 y 的值就是这个函数的返回值。 注意 someThrowingFunction()de返回值类型是什么类型 x和y都是这个类型的可选类型。 例子中 此函数返回一个整型，所以x和y 是可选整型。
//如果想对所有的错误采用相同的方式处理，用 try？就可以让你写出简洁的错误处理代码。例如下面的代码中用几种方式来获取数据。如果所方式都失败了 则返回nil
/*
 
 func fetchData() -> Data? {
 if let data = try? fetchDataFromDisk() { return data }
 if let data = try? fetchDataFromServer() { return data }
 return nil
 }
 
 */

//禁止错误传递
//有时知道某个 throwing 函数实际上在运行时 是不会抛出错误的。在这种情况下。你可以在表达式前面写 try！ 来禁用错误传递， 这会吧调用包装在一个不会有错误抛出的运行断言中。如果真的抛出错误，你会得到一个运行时错误。
//例如，下面的代码中使用了 loadImage（atPath:）函数，该函数从给定的路径加载图片资源，如果图片 无法加载则抛出一个错误。这种情况下， 因为图片和应用是绑定的， 运行时不会有错误抛出， 所以适合禁用错误传递：

//let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")


//指定清理
//可以使用 defer 语句在即将离开的当前代码块时执行一系列语句。该执行能够让你执行一些必要的清理工作，不管是以何种方法离开当前代码块的 -- 无论是由抛出错误而离开还是由于诸如 return 或者 break 的语句。 例如， 可以调用defer语句来确保文件描述符合得以关闭， 以及手动分配内存得以释放。
//defer 语句将代码的执行延迟到当前的作用域退出之前。该语句有defer关键字和要被延迟执行的语句组成。延迟执行的语句不能包含任何控制转移语句， 例如break或return语句。或是抛出一个错误。 延迟执行的操作会按照他们指定时的顺序的相反顺序执行 -- 也就是说第一条 defer 语句中的代码 会在defer 语句中的代码被执行之后才执行，以此类推。
/*
 
 func processFile(filename: String) throws {
 if exists(filename) {
 let file = open(filename)
 defer {
 close(file)
 }
 while let line = try file.readline() {
 // 处理文件。
 }
 // close(file) 会在这里被调用，即作用域的最后。
 }
 }
 
 */













