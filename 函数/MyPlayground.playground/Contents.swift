//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
 · 函数的定义与调用
 · 函数参数与返回值
 · 函数参数标签和参数名称
 · 函数类型
 · 嵌套函数
 */
//函数是一段完成特定任务的独立代码。可以通过函数命名来标识某个函数的功能，真个名字可以被用来在需要的时候“调用”这个函数来完成她的任务

//Swift 统一的函数语法非常的灵活，可以用来表示任何函数，包括简单的没有参数名字的 c 风格函数，到复杂的带局部和外部参数名的 Objective-C风格函数。

//1、函数的定义 与 调用
/*
 下面例子中的函数的名字是greet(person:)，之所以叫这个名字,是因为这个函数用一个人的名字当做输入，并返回向这个人问候的语句。为了完成这个任务，你需要定义一个输入参数——一个叫做 person 的 String 值，和一个包含给这个人问候语的 String 类型的返回值：
 */

func greet(person : String, dataList : [String]) ->(String , [String]){
    
    let greering = "hello" + person + "!"
    
    let dataListArr = dataList
    
    
    
    return (greering, dataListArr)
}


greet(person: "xiaoming", dataList: ["hello", "world"])

print(greet(person: "xiaoming", dataList: ["hello", "world"]))

//2、函数参数与返回值
//2.1、无参数函数

func sayHelloWorld() -> String{
    
    return "hello world"
}
print(sayHelloWorld())

//2.2、多参数函数
//函数可以有多种输入参数， 这些参数被包含在函数的参数中，以逗号隔开

func otherGreet(person : String , alreadyGreeted : Bool) -> String{
    
    if alreadyGreeted {
        return "\(person)已经被打过招呼！"
    }else{
        
        return "hello \(person) !"
    }
    
}

print(otherGreet(person: "xiaoran", alreadyGreeted: true))
print(otherGreet(person: "xiaoqiang", alreadyGreeted: false))

//2.3、无返回值函数
//函数可以没有返回值 
func otherTwoGreet(person : String){
    
    print("hello \(person) !")
}

otherTwoGreet(person: "niming")

//被调用时一个函数的返回值可以被忽略
func otherPrintAndCount(str : String) -> Int{
    
    print(str)
    return str.characters.count
    
}

func printWithOutCounting(str : String){
    
    let _ = otherPrintAndCount(str: str)
    
}

otherPrintAndCount(str: "hello world")

printWithOutCounting(str: "hello world")

//无参无返回值额函数
func otherOneGreet(){
    
    print("hello!");
}


otherOneGreet()

//多重返回值函数
//可以使用 元祖 类型让多个值作为一个复合值 从函数中返回
func minmax(arr : [Int]) -> (min : Int, max : Int){
    
    var currentMin = arr[0]
    var currentMax = arr[0]
    var num = 0
    
    
    for value in arr[0..<arr.count] {
        value
        num += 1
        if value < currentMin {
            
            currentMin = value
            
        }else if value > currentMax{
            
            currentMax = value
        }
    }
    
    return(currentMin, currentMax)
}

let bounds = minmax(arr: [1000, -6, 2, 100, 71])

print("min:\(bounds.min), max:\(bounds.max)")

//可选元祖返回类型
//如果函数返回的元祖类型可能整个元祖都没有值， 可以使用可选的 optional 元祖返回的类型反映整个元祖可以是 nil 的事实。可以通过元祖类型的右括号后放置一个问号来定义一个可选元祖 例如（Int, Int）? 或 （String， Int ， Bool）？
//前面的 minmax(arr:) 函数返回一个包含两个 Int 值的元祖，但是函数不对对传入的数组执行任何安全检查， 如果 arr 参数是一个空数组，如上定义 minmax（arr：）在试图访问arr[0] 时会触发一个运行时错误。为了安全的处理这个空数组的问题 将 minmax（arr：）函数改写为使用可选元组返回类型， 并且但数组为空时返回 nil
func otherMinMax(arr : [Int]) ->(min : Int, max : Int)? {
    
    if arr.isEmpty {
        return nil
    }
    
    var currentMin = arr[0]
    var currentMax = arr[0]
    for value in arr[1..<arr.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = otherMinMax(arr: [99, -100, 200, 400, 100]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
    
}else{
    
    print("返回的为：nil")
}



var testNum : Int? = 1
testNum = nil  //nil不能用于非可选的常量 或变量， 如果代码中有需要处理常量或变量的值的确实情况，请把期声明为可选


func testFunc(){
    
    guard let otherBounds = otherMinMax(arr: []) else {
        print("没有值：nil")
        let a = minmax(arr: [1,2,3,4])
        print(a)
        return
        
    }
    
    print(otherBounds)
}

testFunc()

//3、函数参数标签和参数名称
//每个函数参数都有一个 函数标签（argument Label）以及参数名称 （parameter Name）。参数标签在调用函数的时候使用；调用的时候需要将函数的参数标签写在对应的参数前面。参数名称在函数的实现中使用。默认情况下，函数使用参数名称来作为他们的参数标签
func someFouction(firstParameterName : Int, secondParameter : Int){
    
    
}

someFouction(firstParameterName: 1, secondParameter: 2)
//所有的参数必须有一个独一无二的名字。虽然多个标签拥有同样的参数是可能的。但是一个唯一的函数标签能够是你的代码更具可读性

//3.1、指定 函数标签
//可以在函数名称之前指定它的参数标签，中间以空格分隔
func ohterSomeFunction(argumentLabel parameterName : Int){
    
    // 在函数体内，parameterName 代表参数值
}

func meetGreet(person : String, from homeTown : String){
    
    print("\(person)的家乡是\(homeTown)")
    
}

print(meetGreet(person: "小明", from: "天门"))

//3.2 忽略参数标签
//如果不希望某个参数添加标签，可以使用 下划线_ 来替代一个明确的参数标签
func createSomeFunc(_ animal : String, name : String){
    
    print("\(animal)的名字是\(name)")
}

createSomeFunc("蟋蟀", name: "小强")

//3.3 默认参数
//可以再函数体中通过给参数赋值来为任意参数定义默认值（defaultValue）默认值被定义后，调用这个函数可以忽略这个参数
func testSomeDefaultValueFunc(name: String, food : String  = "rice"){//什么的食物是大米
    // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
    
    print("\(name)的食物是：\(food)")
}

testSomeDefaultValueFunc(name: "dog")//不传第二个参数 就会说那个默认值
testSomeDefaultValueFunc(name: "mokey", food: "banana")//传了第二个参数的值，就是用传的值

//3.4、可变参数
//一个可变参数（variadic parameter）可以接受零个 或 多个值。函数调用时 可以用可变参数来制定函数可以被传入不确定的输入值。通过在变量类型名后面加入（...）的方式来定义可变参数
//可变参数的传入值在函数体中变为此类型到的一个数组。例如，一个叫做 numbers 的 Double... 型可变参数，在函数体内可以当做一个叫 numbers 的 [Double] 型的数组常量。
func arithmeticMean(_ numbers : Double..., _ other : String = "test") -> Double{
    
    var total : Double = 0
    
    for number in numbers {
        
        total += number
    }
    
    return total / Double(numbers.count)
    
}

/*
 一个函数最多只有一个可变参数；
 */

print(arithmeticMean(1, 2, 3, 4, 5))
print(arithmeticMean(2, 4, 5, 7, 10))

//3.5、输入输出参数(能够对函数体外产生影响)
/*
 函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误(compile-time error)。这意味着你不能错误地更改参数值。如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）。
 
 定义一个输入输出参数时，在参数定义前加 inout 关键字。一个输入输出参数有传入函数的值，这个值被函数修改，然后被传出函数，替换原来的值。想获取更多的关于输入输出参数的细节和相关的编译器优化，请查看输入输出参数一节。
 
 你只能传递变量给输入输出参数。你不能传入常量或者字面量，因为这些量是不能被修改的。当传入的参数作为输入输出参数时，需要在参数名前加 & 符，表示这个值可以被函数修改。
 
 注意 输入输出参数不能有默认值，而且可变参数不能用 inout 标记。
 
 下例中，swapTwoInts(_:_:) 函数有两个分别叫做 a 和 b 的输入输出参数：
 
 swapTwoInts(_:_:) 函数简单地交换 a 与 b 的值。该函数先将 a 的值存到一个临时常量 temporaryA 中，然后将 b 的值赋给 a，最后将 temporaryA 赋值给 b。
 
 你可以用两个 Int 型的变量来调用 swapTwoInts(_:_:)。需要注意的是，someInt 和 anotherInt 在传入 swapTwoInts(_:_:) 函数前，都加了 & 的前缀：
 
 从上面这个例子中，我们可以看到 someInt 和 anotherInt 的原始值在 swapTwoInts(_:_:) 函数中被修改，尽管它们的定义在函数体外。
 
 注意：
 输入输出参数和返回值是不一样的。上面的 swapTwoInts 函数并没有定义任何返回值，但仍然修改了 someInt 和 anotherInt 的值。输入输出参数是函数对函数体外产生影响的另一种方式。

 
 */

func switchValue(_ a : inout Int, _ b : inout Int ){
    
    let tem = a
    a = b
    b = tem
}

//只能传 变量 给输入输出参数的函数  否则会编译错误
var someInt = 2
var anotherInt = 9
switchValue(&someInt, &anotherInt)
print(someInt, anotherInt)//两数交换了

//4、函数类型
//每个函数都有种特定的 函数类型，函数的类型有函数的参数类型和返回类型组成。
func addTwoInts(_ a : Int, _ b : Int) -> Int{
    
    return a + b;
}

func multiplyTwoInts(_ a : Int, _ b : Int) -> Int{
    
    return a * b
}

//没有参数 没有返回值的函数：
func printHelloWorld(){
    
    print("helloWorld！")
}


//在Swift中， 使用函数类型就像使用其他类型一样，例如：可以定义一个类型为函数的常量 或 变量，并将适当的函数赋值给他
var mathFunction : (Int, Int) -> Int = addTwoInts //代码解读：定义一个 mathFunction 的变量， 类型是‘一个有两个 int 型的参数并返回一个 Int 型值的函数’，并让这个新的变量 指向 addTwoInts 函数
//addTwoInts mathFunction 有同样的类型，所以这个赋值过程在 Swift 类型检查中是允许的
print("result:\(mathFunction(2, 3))")

//有相同匹配类型的不同函数可以被赋值给同一个变量， 就像非函数变量一样：
mathFunction = multiplyTwoInts

print("result:\(mathFunction(2, 3))")

//向其他类型一样， 当赋值一个函数给常量或变量时，可以让Swift 来推断其函数的类型

let anotherMathFunction = addTwoInts
//anotherMathFunction 被推断为 （Int， Int）-> Int 类型
anotherMathFunction(4, 5)

//4.1、函数类型作为参数类型
//可以使用 （Int， Int） —> Int 这样的函数 类型作为另一个函数的参数类型。这样你可以将函数的一部分实现留给函数的调用者来使用。
func printMathResult(_ kAnotherMathFunction : (Int, Int) -> Int, _ a : Int, _ b : Int){
    
    print(kAnotherMathFunction(a, b))
}

printMathResult(anotherMathFunction, 6, 9)//解释：这个例子定义了一个 printMathResult（_,_,_）函数， 他有三个参数，第一个参数名 kAnotherMathFunction 标签忽略， 类型是 （Int， Int）-> Int 类型，你可以传入任何这种类型的函数最为参数；第二个和第三个参数a和b, 他们的类型的都是Int 这两个值最为已给出的函数的输入值；当 printMathResult(_:_:_:) 被调用时，它被传入 addTwoInts 函数和整数 6 和 9。它用传入 6 和 9 调用 addTwoInts，并输出结果：8。

//printMathResult(_:_:_:) 函数的作用就是输出另一个适当类型的数学函数的调用结果。它不关心传入函数是如何实现的，只关心传入的函数是不是一个正确的类型。这使得 printMathResult(_:_:_:) 能以一种类型安全（type-safe）的方式将一部分功能转给调用者实现。

//4.2、函数类型作为返回值
//可以用函数类型作为另一个函数的返回值。你需要做的是在返回箭头 -> 写一个完整的函数函数类型
//下面的这个例子中定义了两个简单函数，分别是 stepForward(_:) 和 stepBackward(_:)。stepForward(_:)函数返回一个比输入值大 1 的值。stepBackward(_:) 函数返回一个比输入值小 1 的值。这两个函数的类型都是 (Int) -> Int：
func stepForward(_ input : Int) -> Int{
    
    return input + 1
}

func stepBackward(_ input : Int) -> Int{
    return input - 1
}

//如下名为 chooseStepFunction(backward:) 的函数，它的返回类型是 (Int) -> Int 类型的函数。chooseStepFunction(backward:) 根据布尔值 backwards 来返回 stepForward(_:) 函数或 stepBackward(_:) 函数：
func chooseStepFunction(_ backward : Bool) -> (Int) -> Int{

    return backward ? stepBackward : stepForward
}

var currentValue = -13

let moveNearerToZeroValue = chooseStepFunction(currentValue > 0)

while currentValue != 0 {
    
    print(currentValue)
    currentValue = moveNearerToZeroValue(currentValue)
}

print("zero")

//5、嵌套函数
//到目前为止本章中你所见到的所有函数都叫全局函数（global functions），它们定义在全局域中。你也可以把函数定义在别的函数体中，称作 嵌套函数（nested functions）。
//默认情况下，嵌套函数是对外界不可见的，但是可以被他的 外围函数 （enclosing function）调用， 一个外为函数可以返回他的某个嵌套函数， 使得这个函数可以在其他作用域中使用

func chooseAnotherStepFunction(backWard : Bool) -> (Int) -> Int{
    
    func otherStepForward(input : Int) -> Int { return input + 1 }
    func otherStepBackward(input : Int) -> Int { return input - 1 }
    
    return backWard ? otherStepBackward : otherStepForward
    
}

currentValue = -5
let anotherMoveToZeroFunction = chooseAnotherStepFunction(backWard: currentValue > 0)

while currentValue != 0 {
    
    print("\(currentValue)")
    currentValue = anotherMoveToZeroFunction(currentValue)
}
print("zero")


