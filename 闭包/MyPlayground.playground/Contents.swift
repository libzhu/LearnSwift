//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//（1）创建两个类型相同的函数，一个函数返回两个整数的差值 一个返回整数的乘积
func diff (number1 : Int, number2 : Int) -> Int{
    
    return number1 - number2
    
}

func mul (number1 : Int, number2 : Int) -> Int{
    
    return number1 * number2
}

//（2）定义一个枚举来枚举每种函数的类型，
enum CountType : Int{
    
    case DiffCount = 0
    case MulCount
}

//（3）定义一个函数 把 （1）和 （2）定义的东西组合起来
func choiseCountType (countType : CountType) -> (Int, Int) -> Int{
    
    var myFuncType : (Int, Int) -> Int
    
    switch countType {
    case .DiffCount:
        myFuncType = diff
    case .MulCount:
        myFuncType = mul
    }
    return myFuncType
}
    
var myFouncType : (Int, Int) -> Int
    
myFouncType = choiseCountType(countType: CountType.DiffCount)
myFouncType(20, 30)
    
myFouncType = choiseCountType(countType: CountType.MulCount)
myFouncType(30, 20)
    
    



/*
 本页包含内容：
 
 闭包表达式
 尾随闭包
 值捕获
 闭包是引用类型
 逃逸闭包
 自动闭包

 */
//闭包 是自包含的函数代码 块， 可以在代码中被传递和使用。Swift 中的闭包 与 c 和 objective-c中的 代码块（blocks）比较相似；
//闭包可以捕获 和 存储其上下文中任意的常量 和 变量的引用。被称为包裹常量和变量。
//Swift 会为你管理在捕获过程中涉及到的所有内存操作
//全局和嵌套函数实际上也是特殊的闭包， 
/*
 · 全局函数是一个有名字但不会捕获任何值的闭包
 · 嵌套函数是一个有名字并且可以捕获其封闭函数内值的闭包
 · 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文变量或常量值的匿名闭包
 
 */

//Swift 的闭包表达式拥有简介的风格，并鼓励在常见的场景中进行语法优化，如下
/*
 · 利用上下文推断参数和返回值类型
 · 隐式返回但表达式闭包， 即但表达式闭包可以省略 return 关键字
 · 参数名称缩写
 · 尾随闭包语法
 */
//1-1、Closure 就是匿名 函数，我们可以定义一个闭包变量，而这个闭包类型的变量就是我们上面介绍的函数类型、定义一个闭包变量就是定义一个特殊函数类型的的变量、凡是如下；因为closure变量没有赋初始值、所以我们把其声明成可选的变量

var myCloure0 : ((Int , Int) -> Int)?
//另一种常用的声明闭包变量的方式。使用关键字 typealias定义定义一个特定函数类型，我们可以用这个类型声明一个 Closure 变量
typealias myCloureType = (Int, Int) -> Int
var myCloure : myCloureType?



//给闭包变量赋值，的函数体中含有参数列表 ，参数列表和真正的函数体之间 使用关键字in来分割。闭包可选变量的调用和普通函数没有什么区别，唯一不同是这个函数需要使用 ！ 来强制解包。
myCloure0 = {(num1 : Int,num2 : Int) -> Int in
    
    return num1 + num2
    
}

myCloure0!(10, 20)

//数组中常用的闭包函数 Swift 中 自带一些比较好用的闭包函数；例如 map sorted filter reduce 

//Map 映射 map闭包函数的功能就是对数组中的每一项进行遍历，然后通过映射规则对数组中的每一项进行处理，最终的返回结果是处理后的数组（以一个新的数组形式出现）。当然，原来数组中的元素值是保持不变的，这就是map闭包函数的用法与功能。

let  family = [1, 2, 3, 4, 5]

var falmilMap = family.map { (item : Int) -> String in
    
    return "我是老\(item)"
}

family
print(falmilMap)

//2.Filter 过滤器
//Filter的用法还是比较好理解的，Filter就是一个漏勺，就是用来过滤符合条件的数据的

let heightOfPerson = [170, 180, 173, 175, 190, 168]

let heightOfPersonFilter = heightOfPerson.filter { (height : Int) -> Bool in
    return height >= 173
}

heightOfPerson
print(heightOfPersonFilter)

//Reduce Swift 中使用Reduce 闭包来合并items 并且是和并后的value 

let salary = [1000, 2000, 3000, 4000, 9000]

let sumSalary = salary.reduce(0) { (sumSalaryTemp : Int, salaryItems : Int) -> Int in
    
    return sumSalaryTemp + salaryItems
}




//1、闭包表达式
//嵌套函数 是一个在较复杂函数中方便进行命名和定义闭包函数代码块的方块。嵌套函数是一个在较复杂函数中方便进行命名和定义自包含代码模块的方式。当然，有时候编写小巧的没有完整定义和命名的类函数结构也是很有用处的，尤其是在你处理一些函数并需要将另外一些函数作为该函数的参数时。

//闭包表达式是一种利用简洁语法构建内联闭包的方式。闭包表达式提供了一些语法优化，使得撰写闭包变得简单明了。下面闭包表达式的例子通过使用几次迭代展示了 sorted(by:) 方法定义和语法优化的方式。每一次迭代都用更简洁的方式描述了相同的功能。

//1.1、sorted 方法
//Swift 标准库提供了 名为 sorted（by:）的方法，会根据你提供的用于排序的闭包函数将已知类型函数数组中的值进行排序。一旦完成，sorted（by：）方法会返回一个与原数组大小相同，包含同类型元素且元素正确排序的新数组。原数组不会被 sorted（by：）方法修改
//下面的闭包表达式使用 sorted（by：）方法对一个 String 类型的数组进行字母逆序排列。一下是初始数组：

let names = ["xiaoming", "zhansan", "lisi", "wangwu", "zhaoliu"]

//sorted（by：）方法接受一个闭包， 该闭包函数需要传入与数组元素类型相同的两个值， 并返回一个布尔类型值来表明当排序结束后传入的第一个参数排在第二个参数的前面还是后面。如果第一个参数值出现在第二个参数值前面，排序闭包函数返回TRUE 反之 返回FALSE
//该例子对一个 String 类型的数组进行排序，因此排序闭包函数类型需为 (String, String) -> Bool。
let sortedNames = names.sorted { (str1 : String, str2 : String) -> Bool in
    
    return str1 > str2
}



func backward(_ s1 : String, _ s2 : String) -> Bool{
    
    return s1 > s2
}

var reveredNames = names.sorted(by: backward)

//2.闭包表达式的语法
//2.1、闭包表达式语法有如下的一般形式
/*
 
 { (parameters) -> returnType in
        statements
 }
 
 */

//闭包表达式参数可以是 in-out 参数， 但不能设定默认值。也可以使用局名的可变参数 元组也可以作为参数和返回值
names.sorted { (s1, s2) -> Bool in
    return s1 > s2
}
reveredNames = names.sorted(by: { (s1 : String, s2 : String) -> Bool in
    
    return s1 > s2
})

///需要注意的是内联闭包参数和返回值类型声明与 backward(_:_:) 函数类型声明相同。在这两种方式中，都写成了 (s1: String, s2: String) -> Bool。然而在内联闭包表达式中，函数和返回值类型都写在大括号内，而不是大括号外。闭包的函数体部分由关键字in引入。该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始。

//由于这个闭包的函数体部分如此短，以至于可以将其改写成一行代码：

reveredNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
print(reveredNames)

//该例中 sorted(by:) 方法的整体调用保持不变，一对圆括号仍然包裹住了方法的整个参数。然而，参数现在变成了内联闭包。

//2、根据上下文推断类型
//因为排序闭包函数是作为 sorted(by:) 方法的参数传入的，Swift 可以推断其参数和返回值的类型。sorted(by:) 方法被一个字符串数组调用，因此其参数必须是 (String, String) -> Bool 类型的函数。这意味着 (String, String) 和 Bool 类型并不需要作为闭包表达式定义的一部分。因为所有的类型都可以被正确推断，返回箭头（->）和围绕在参数周围的括号也可以被省略：

reveredNames = names.sorted(by: { s1, s2 in return s1 > s2 } )

//实际上，通过内联闭包表达式构造的闭包作为参数传递给函数或方法时，总是能够推断出闭包的参数和返回值类型。这意味着闭包作为函数或者方法的参数时，你几乎不需要利用完整格式构造内联闭包。

//尽管如此，你仍然可以明确写出有着完整格式的闭包。如果完整格式的闭包能够提高代码的可读性，则我们更鼓励采用完整格式的闭包。而在 sorted(by:) 方法这个例子里，显然闭包的目的就是排序。由于这个闭包是为了处理字符串数组的排序，因此读者能够推测出这个闭包是用于字符串处理的。

//3、单表达式闭包隐式返回
//单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果，如上版本的例子可以改写为：

reveredNames = names.sorted(by: { s1, s2 in s1 > s2 } )

//在这个例子中，sorted(by:) 方法的参数类型明确了闭包必须返回一个 Bool 类型值。因为闭包函数体只包含了一个单一表达式（s1 > s2），该表达式返回 Bool 类型值，因此这里没有歧义，return 关键字可以省略。

//4、参数名称缩写

//Swift 自动为内联闭包提供了参数名称缩写功能，你可以直接通过 $0，$1，$2 来顺序调用闭包的参数，以此类推。

//如果你在闭包表达式中使用参数名称缩写，你可以在闭包定义中省略参数列表，并且对应参数名称缩写的类型会通过函数类型进行推断。in关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成：

reveredNames = names.sorted(by: { $0 > $1 } )

//在这个例子中，$0和$1表示闭包中第一个和第二个 String 类型的参数。

//5、运算符方法
//实际上还有一种更简短的方式来编写上面例子中的闭包表达式。Swift 的 String 类型定义了关于大于号（>）的字符串实现，其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。而这正好与 sorted(by:) 方法的参数需要的函数类型相符合。因此，你可以简单地传递一个大于号，Swift 可以自动推断出你想使用大于号的字符串函数实现：

reveredNames = names.sorted(by: >)

//更多关于运算符方法的内容请查看运算符方法。


//6、尾随闭包
let digitNameS = [0 : "zero", 1 : "one", 2 : "two", 3 : "three", 4 : "four", 5 : "five", 6 : "six", 7 : "seven", 8 : "eight", 9 : "nine"]
let numbers = [123, 24, 250]

let srings = numbers.map { (num) -> String in
    
    var outPut = ""
    var number = num
    
    repeat {
        print(number)
        
        outPut = digitNameS[number % 10]! + outPut
        number /= 10
        
        
    } while number > 0
    
    return outPut
}

print(srings)

//值捕获
//闭包可以在其被定义的上下文中 捕获常量 和 变量。即使定义这些常量的作用域已经不存在，闭包任然可以在闭包函数体内应用和修改这些值
//Swift 中 可以捕获值的闭包的最简单的形式即使嵌套函数， 也就是定义在其他函数的函数体内的函数。嵌套函数可以捕获其外部函数的所有参数，及定义的常量 和 变量

func makeIncrementer(forIncrement amount : Int) -> () -> Int{//返回的是一个闭包
    
    
    var runningTotal = 0
    
    func increment() -> Int{
        
        runningTotal += amount
        return runningTotal
        
    }
    
    return increment
    

}

//解释 ：incrementer() 函数并没有任何参数，但是在函数体内访问了 runningTotal 和 amount 变量。这是因为它从外围函数捕获了 runningTotal 和 amount 变量的引用。捕获引用保证了 runningTotal 和 amount 变量在调用完 makeIncrementer 后不会消失，并且保证了在下一次执行 incrementer 函数时，runningTotal 依旧存在。

let incrementByTen = makeIncrementer(forIncrement: 10)//定义了一个 incrementByTen 的常量， 该常量指向一个每次调用会将其 runningTotal 变量增加 10 的 Incrementer 函数
incrementByTen()
incrementByTen()

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
incrementBySeven()

incrementByTen()

//闭包是引用类型
//上面的例子中，incrementBySeven 和 incrementByTen 都是常量，但是这些常量指向的闭包仍然可以增加其捕获的变量的值。这是因为函数和闭包都是引用类型。无论你将函数或闭包赋值给一个常量还是变量，你实际上都是将常量或变量的值设置为对应函数或闭包的引用。上面的例子中，指向闭包的引用 incrementByTen 是一个常量，而并非闭包内容本身。
//这也意味着如果你将闭包赋值给了两个不同的常量或变量，两个值都会指向同一个闭包：

let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()

//8、逃逸闭包
//当闭包作为一个参数传到一个函数中，但是这个闭包在函数返回之后才会不执行，我们称为该闭包从函数中逃逸。当你定义接受闭包作为参数的函数时，你可以在 参数名称之前 标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的

//一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中。举个例子，很多启动异步操作的函数接受一个闭包参数作为 completion handler。这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。在这种情况下，闭包需要“逃逸”出函数，因为闭包需要在函数返回之后被调用。例如：
var completionHandlers : [() -> Void] = []
func someFuctionWithEscapingClosure(completionHander : @escaping () -> Void){
    
    completionHandlers.append(completionHander)
}
//解释：someFuctionWithEscapingClosure（_:）函数接受一个闭包作为参数， 该闭包被添加到一个函数外定义的数组中，如果你不将这个参数标记为 @escaping 就会得到一个编译错误。将一个闭包 标记为 @escaping 意味着你必须在闭包中 显示的应用 self。比如说，在下面的代码中，传递到 someFunctionWithEscapingClosure(_:) 中的闭包是一个逃逸闭包，这意味着它需要显式地引用 self。相对的，传递到 someFunctionWithNonescapingClosure(_:) 中的闭包是一个非逃逸闭包，这意味着它可以隐式引用 self。

func someFunctionWithNoneEsapingClosure(closure : () -> Void){
    
    closure()
}

class someClass{
    
    var x = 10
    
    func dosomething() -> Void {
        
        someFuctionWithEscapingClosure {
            self.x = 100
        }
        
        someFunctionWithNoneEsapingClosure {
            x = 200
        }
    }
    
}

let instance = someClass()

instance.dosomething()
print(instance.x)

completionHandlers.first?()

print(instance.x)

//10、自动闭包 
//自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当他被调用的时候，会返回包装在其中的表达式的值。这个便利语法让你能能够省略闭包的或括号，用普通的表达式来替代显示的表达式
//我们经常会调用采用自动闭包的函数，但是很少去实现这样的函数。举个例子来说，assert(condition:message:file:line:) 函数接受自动闭包作为它的 condition 参数和 message 参数；它的 condition 参数仅会在 debug 模式下被求值，它的 message 参数仅当 condition 参数为 false 时被计算求值。

//自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。延迟求值对于那些有副作用（Side Effect）和高计算成本的代码来说是很有益处的，因为它使得你能控制代码的执行时机。下面的代码展示了闭包如何延时求值。

var customerInLine = ["Chris", "Alex", "ewa", "Barry", "Daniela"]

let deleteItem = customerInLine.remove(at: 0)


print(customerInLine.count)

let custmerProvider = {customerInLine.remove(at: 0)}
print(customerInLine.count)

print("删除的：：\(custmerProvider())!")

print(customerInLine.count)









