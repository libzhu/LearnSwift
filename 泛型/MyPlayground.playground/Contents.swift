//: Playground - noun: a place where people can play

import UIKit

var str = "泛型"
/*
 
 
 泛型所解决的问题
 泛型函数
 类型参数
 命名类型参数
 泛型类型
 扩展一个泛型类型
 类型约束
 关联类型
 泛型 Where 语句

 
 */
//泛型代码 让你根据自定义的需求， 编写出任意适用于任意类型、灵活可重用的函数及类型， 它能让你避免代码的重复， 用一种清晰和 抽象的方式来表达代码的意图。
//泛型是Swift 最强大的特性之一， 许多Swift 标准库是通过泛型代码沟构建的。 事实上， 泛型的使用贯穿了正本语言手册， 例如 Swift 的 Array He Dictionary 都是泛型集合， 创建 一个 Int 数组， 也可以闯将一个 String 数组， 甚至可以是任意其他Swift 类型的数组。同样的。可以创建存储任意指定的字典。
//1.泛型所解决的问题
//下面 是一个标准的非泛型函数 swapTwoInts（_:_:）用来交换连个int值
func swapTwoInts(_ a :inout Int, _ b : inout Int) {
    
    let temporaryA = a
    a = b
    b = temporaryA
    
}
//这个函数使用输入输出参数inout 来交换a 和 b  的值，输入输出参数传入的参数必须是变量 ，不能是常量或字面量。调用时 在参数前面加上 & 符 表示参数是可以修改的

var someInt = 3
var anotherInt = 108
swap(&someInt, &anotherInt)
print(someInt, anotherInt)

//诚然swap(&<#T##a: T##T#>, &<#T##b: T##T#>) 函数挺有用， 但是他只是交换了 Int 值， 如果你想交换两个 String 或者 Double 值， 就不得不写更多的函数， 例如swapTwoStrings(_:_:) 和 swapTwoDoubles(_:_:)，如下所示：func swapTwoStrings(_ a: inout String, _ b: inout String) {
func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//注意到：swapTwoInts(_:_:)、swapTwoStrings(_:_:) 和 swapTwoDoubles(_:_:) 的函数功能都是相同的，唯一不同之处就在于传入的变量类型不同，分别是 Int、String 和 Double。

//在实际应用中， 通常需要一个更实用更灵活的函数体来交换任意类型的值幸运的是，泛型代码帮你解决了这种问题。（这些函数的泛型版本已经在下面定义好了
//注意
//在上面三个函数中，a  和 b 类型相同。如果 a 和 b 类型不同，那它们俩就不能互换值。Swift 是类型安全的语言，所以它不允许一个 String 类型的变量和一个 Double 类型的变量互换值。试图这样做将导致编译错误。

//泛型函数
//泛型函数可以适用于任何类型， 下面的 swapTwoValues（_:_:）函数是上面三个函数的泛型版本
func  swapTwoValues<T>(_ a : inout T, _ b : inout T){
    
    let temporaryA = a
    a = b
    b = temporaryA
    
}

//swapTwoValues(_:_:) 的函数主体和 swapTwoInts(_:_:) 函数是一样的，它们只在第一行有点不同，如下所示：
/*
 func swapTwoInts(_ a: inout Int, _ b: inout Int)
 func swapTwoValues<T>(_ a: inout T, _ b: inout T)
 */
//这个函数的泛型版本使用了占位类型名（这里用字面T来表示）来代替实际类型名如Int ， String， 或 Double 占位类型名没有指明 t 必须是什么类型， 但是他指明了 a 和 并 必须是同一类型 T 无论 T 代表什么类型，只有 swapTwoValue（_:_:）函数在调用时， 才能根据所传入的实际类型决定 T 所代表的类型。
//另外 一个不同之处在于 这个泛型函数名 swapTwoValues(_:_:) 后面跟着占位类型名（T）并用尖括号括起来<T>.这个尖括号告诉 Swift 那个 T 是swapTwoValues(_:_:)函数定义内的一个占位类型名， 因此Swift 不会去查找名为T 的实际类型
//swapTwoValues(_:_:) 函数 现在可以像 swapTwoInts(_:_:)那样调用， 不同的是它能够接受两个任意类型的值， 条件是这两个值有着相同的类型。swapTwoValues(_:_:)函数被调用时，T 所代表的类型都会由传入的值的类型推断出来
//下面的例子中 ， T 分别代表Int  和 String 类型
var testSomeInt  = 3
var testAnotherInt = 107

swapTwoValues(&testSomeInt, &testAnotherInt)
print(testSomeInt, testAnotherInt)

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
print(someString, anotherString)

swap(&someString, &anotherString)
print(someString, anotherString)
//注意
//上面定义的 swapTwoValues(_:_:) 函数是受 swap(_:_:) 函数启发而实现的。后者存在于 Swift 标准库，你可以在你的应用程序中使用它。如果你在代码中需要类似 swapTwoValues(_:_:) 函数的功能，你可以使用已存在的 swap(_:_:) 函数。

//类型参数
//上面的例子：swapTwoValues(_:_:)中 占位类型 T 是类型参数的一个例子。类型参数指定并命名一个占位类型。并且紧跟随在 函数数名后面， 使用一对尖括号 括起来例如<T>
//一旦一个 类型参数被指定，可以用它来定义一个函数参数的类型（例如：swapTwoValues(_:_:) 函数中的参数a 和 b）或者作为函数的返回类型， 还可以作为函数主体中的注释类型。 在这种情况下， 类型参数会在函数调用时被实际类型替换。（swapTwoValues(_:_:)例子中，当函数被第一次调用时 T被替换成 Int 类型，  第二次调用时被替换 String 类型）
//可提供多个类型参数， 将他们都写在尖括号中， 用逗号隔开

//命名类型参数
//在大多数情况下， 类型参数具有一个描述性名字例如 Dictionary<key, value> 中的key 和 value , 以及Array<Element> 中的 element ， 这可以告诉阅读代码的人，这些类型参数含泛型函数之间的关系。当它们之间没有有意义的关系时，通常使用单个字母来命名，例如 T、U、V，正如上面演示的 swapTwoValues(_:_:) 函数中的 T 一样。
//注意:请始终使用大写字母开头的驼峰命名法（例如 T 和 MyTypeParameter）来为类型参数命名，以表明它们是占位类型，而不是一个值。

//泛型类型
//除了泛型函数，Swift 还允许你定义泛型类型， 这些自定义类 结构体和枚举适用于任何类型 类似于Arrary Dictionary 。
//这部分内容将向你展示如何编写一个 名为 Stack （栈）的泛型集合类型。 栈是一系列值的有序集合， 和 array 类似， 但他比swif 的array 类型有更多的操作限制， 数组允许在数组的任意位置插入新元素或是删除其中任意位置的元素。 而栈只允许在集合的末端添加新的元素（称之为入栈），栈也只能从末端移除元素 称之为 出栈
//注意 栈的概念 已经被UINavigationController 类用来构造视图控制器的导航结构。通过调用UINavigationController的 pushViewControl（_ : animated:_）方法来添加新的视图控制器到导航栈，通过调用PopViewController（_:）方法从导航栈中移除视图控制器，每当你需要一个严格的“后进先出”方式管理集合， 栈都是最实用的模型。
//下面例子展示如何编写一个非泛型版本的栈， 以Int 型的栈为例
struct IntStack {
    
    var items = [Int]()
    mutating func push (_ item : Int){
        
        items.append(item)
    }
    
    mutating func pop() -> Int {
        
        return items.removeLast()//移除的最后一个元素
    }
    
}

//这个结构体在栈中使用一个名为 Items 的Array 属性来存储值， IntStack 提供了两个方法 push（_:） pop() 用来向栈中压入值和从栈中移除值。 这些方法被标记为 mutating因为它们需要修改结构体的Items 数组。
struct Stack<Element> {
    
    var items = [Element]()
    mutating func push(_ item : Element){
        
        items.append(item)
    }
    
    mutating func pop() -> Element {
        
        return items.removeLast()
    }
    
}

//上面的Stack 和 IntStack 形同， 只是使用了占位类型参数 Element 替代了实际的 Int 类型， 这个类型参数包裹在紧随结构体名的一对尖括号中<Element>
//Element 为待提供的类型定义了一个占位名，这总待提供的类型可以在结构体定义中通过 Element 来引用 在这个例子中Element 在如下三个地方呗用作占位符。
//· 创建 Items 属性， 使用 Element 类型的空数组对其进行初始化。 ·指定push（_:）方法的唯一参数 Item 的类型必须是 Element 类型。· 指定 pop（）方法的返回值类型必须是 Element 类型。
//由于：Stack 是泛型类型， 因此可以用来创建Swift中任意的有效类型的栈， 就像Array和Dictionary 那样
//可以通过在尖括号中写出栈需要的存储的数据类型来创建并初始化一个 Stack实例。例如，要创建一个String类型的栈， 可以写成Stack<String>()

var stackOfString = Stack<String>()

stackOfString.push("Hello")
stackOfString.push("world")
stackOfString.push("BeiJing")
stackOfString.push("天安门")
print(stackOfString.items)

stackOfString.pop()
print(stackOfString.items)

stackOfString.pop()
print(stackOfString.items)


//扩展一个泛型类型
//当扩展一个泛型类型的时候， 并不需要在扩展的定义中提供类型参数的列表。 原始类型定义中申明的参数列表可以在扩展中直接使用，并且这些来自原始类型中的参数名会被原始定义中类型参数的引用
extension Stack {
    
    var topItme : Element? {
        
        return items.isEmpty ? nil : items[items.count - 1]
    }
    
}
//topItem 属性会返回一个 Element 类型的可选值， 当栈为空时， topItem 会返回nil 当栈不为空时，topItem 会返回数组元素中最后一个元素。
//这个扩展并没有定义一个 类型参数列表， 相反的 Stack 类型已有的 类型参数名Element被用在扩展中来表示计算型属性topItem 的可选类型。

if let topItem = stackOfString.topItme {
    
    print(topItem)
}

//类型约束
//swapTwoValues(_:_:)函数 和 Stack 类型可以作用于任何类型， 不过有时候如果能将使用在泛型函数和泛型类型中的类型添加一个特定的类型约束， 将会是非常有用的。类型约束可以指定一个参数类型必须继承自自定类， 或者符合一个特定的协议或协议组合。
//例如：Swift 的Dictionary 类型对字典的键的类型做了一些限制， 在字典的描述中， 字典的键的类型必须是 可哈希的 hashable的， 也就是说 必须有一种方法能够唯一的表示它， Dictionary的键之所欲要是可哈希的，是为了便于检查字典是否已经包含某个特定的键的值， 若它没有这个要求，Dictionary将无法判断是否可以插入或者替换某个指定键的值， 也不能查找到已经存储在字典中的指定值。
//为了显现这个要求， 一个类型约束被强制加到Dictionary 的 键类型上， 要求其键类型必须符合hashable 协议，这是 Swift 标准库中定义的一个特定协议， 所有额Swift 基本类型（例如 String Int, Double, Bool）默认都是可哈希的
//当你自己创建自定义泛型类型时， 可以定义自己的类型约束， 这些约束将提供更为强大的泛型编程能力， 抽象概念， 例如可哈希的， 描述的是类型在概念上的特征， 而不是他们显示类型。
//类型约束语法。
//可以在一个类型参数名后面放置一个类名或者协议名， 并且用冒号进行分割，来定义类型约束， 他们将成为类型参数列表的一部分。对泛型函数添加约束的基本语法如下所示

class SomeClass {
    
}

protocol SomeProtocol {
    
    
}


func someFuction<T : SomeClass, U : SomeProtocol>(someT : T, someU : U){
    
    //这里是泛型函数体的部分
}

//上面函数有两个类型参数， 第一个类型参数T 有一个要求T 必须是SomeClass子类的类型约束， 第二个类型参数U 有一个要求 U 必须符合 someProtocol协议的类型约束

//类型约束实践。
//这里有一个 名为 findIndex（ofString： in:）的非泛型函数， 该函数的功能是在一个String数组中查找给定 String 值的索引， 若查找到匹配的字符串， findIndex（ofString： in）函数放回该字符串在数组中的索引值， 否则返回nil
func findIndex(ofString valueToFind : String, in array : [String]) -> Int? {
    
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            
            return index
        }
        
    }
    
    return nil
}

let strings = ["cat", "dong", "llama", "parakeet", "pig"]

findIndex(ofString: "cat", in: strings)

if let foundeIndex = findIndex(ofString: "pig", in: strings) {
    print("查找到pig 的索引值：\(foundeIndex)")
}

//如果只能查找字符串在数组中的索引， 用处不是很大 不过可以使用占位类型 T 替换 String类型来写出具有同样功能的泛型函数 findIndex（_:_:）

//findIndex（_:_:）函数的泛型版本 这个函数的返回值类型依然是Int？ 类型， 这是因为我们需要的是函数的可选的索引数， 而不是数组中的一个值。
//func findNewIndex<T>(of valueToFind : T, in array : [T]) -> Int?{
//    
//    for (index, value) in array.enumerated() {
//        
//        if value == valueToFind {
//            return index
//        }
//    }
//    
//    return nil
//}

//上面缩写的函数无法通过编译，问题出在相等性检查上， 即if value == valueToFind，，并不是所有的Swift 类型都可以用等式符号 == 进行比较， 比如说。如果你创建一个自定义的类或结构体来表示一个复杂的数据模型，那么Swift 无法猜到对于这个类或结构体而言相等意味着什么。正因为如此， 这部分代码无法保证适用于每个可能的 T 类型， 当你试图编译这部分代码时会出现相应的错误。
//不过，所有的这些并不会让我们无从下手， Swift 标准库中定义了一个 equatable 协议，该协议要求任何遵循该协议的类型必须符合等式 == 不等式 != 从而能构对该类新的任意两个值进行比较。所有的Swift标准类型自动支持 equatable协议

//任何 Equatable 类型都可以安全地使用在 findIndex(of:in:) 函数中，因为其保证支持等式操作符。为了说明这个事实，当你定义一个函数时，你可以定义一个 Equatable 类型约束作为类型参数定义的一部分：

func findNewIndex<T : Equatable >(of valueToFind : T, in array : [T]) -> Int?{
    
    for (index, value) in array.enumerated() {
        
        if value == valueToFind {
            return index
        }
    }
    
    return nil
}

//findNewIndex(of:in:)唯一的类型参数写作T：Equatable 也就意味着 任何符合Equatable 协议的类型T

//findNewIndex(of:in:) 函数现在可以成功编译了，并且可以作用于任何符合 Equatable 的类型，如 Double 或 String：

let doubleIndex = [5.0, 4.0, 1.22]

findNewIndex(of: 9.3, in: doubleIndex)

let stringIndex = findNewIndex(of: "北京", in: ["上海", "北京", "武汉", "广州", "重庆"])


//关联类型
//定义一个协议时，有时候声明一个或多个关联类型作为协议定义的一部分将非常有用。关联类型为协议中的某个类型提供了一个占位名（或者说书别名）， 其代表的实际类型在协议被采纳时才会被指定， 可以通过 associatedType 关键字来制定关联类型
//关联类型实践
protocol Container {
    
    associatedtype ItemType
    mutating func append(_ item : ItemType)
    var count : Int { get }
    
    subscript(i : Int) -> ItemType { get }
}

//Container 协议定义了三个任何遵循该协议的类型必须提供的功能：
//· 必须通过 append（_:）方法添加一个新元素到容器里   ·必须通过count  属性获取容器中元素的数量， 并返回一个 Int 值。必须通过索引值类型为 int 的下标检索容器中的每一个元素。
//这个协议没有指定容器中元素如何存储， 以及元素必须是何种类型，这个协议只指定了三个任何遵从 container 协议的类型必须提供的功能。遵从协议的类型在满足这三个条件的情况下可以提供其他额外的功能。
//任何遵循container 协议的类型必须能够指定其存储的元素的类型，必须保证只有正确的元素可以加进容器中， 必须明确通过其下标返回元素的类型
//为了定义这三个条件， container 协议需要在不知道容器中元素的具体类型的情况下应用这种类型， container 协议需要指定任何通过 append(_:)方法添加到容器中的元素和容器中的元素是相同的类型。并且通过下标返回的元素类型也是这种类型。
//为了达到这个目的：container 协议声明以一个关联类型 ItemType， 写作associatedType ItemType 这个协议无法定义itemType 是什么类型的别名， 这个信息留给遵循协议的类型来提供， 尽管如此， ItemType 别名提供了一种方式来引用Container 中的元素类型，并将之用于append（_:）方法和下标， 从而保证任何 container 行为都能够被正确的执行

struct NewIntStack : Container {
    
    var items = [Int]()
    mutating func push(_ item : Int) {
        
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    //Container 协议的实现部分
    
    typealias ItemType = Int//指定 ItemType 类型
    
    mutating func append(_ item: Int) {
        self.push(item)
    }
    
    var count: Int {
        
        return items.count
    }
    

    subscript(i : Int) -> Int {
        
        return items[i]
    }
}

//NewIntStack 结构体 实现了 Container 协议的三个要求， 其原有的功能也不会和这些要求相冲突。此外 NewInStack 在实现 Container 要求时， 指定 ItemType 为 Int 类型。即 typealias ItemType = Int 从而将 Container 协议中抽象的 ItemType 类型转换为具体的 Int 类型。
//由于 Swift 的类型推断，你实际上不用在 IntStack 的定义中声明 ItemType 为 Int。因为 IntStack 符合 Container 协议的所有要求，Swift 只需通过 append(_:) 方法的 item 参数类型和下标返回值的类型，就可以推断出 ItemType 的具体类型。事实上，如果你在上面的代码中删除了 typealias ItemType = Int 这一行，一切仍旧可以正常工作，因为 Swift 清楚地知道 ItemType 应该是哪种类型。


//也可以让泛型 NewStack 结构体 遵循Container 协议
struct NewStack<Element> : Container {
    
    // Stack<Element> 的原始实现部分
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    //Container 协议的实现部分
    mutating func append(_ item: Element) {
        
        self.push(item)
    }
    
    var count: Int {
        
        return items.count
    }
    
    subscript(i : Int) -> Element {
        
        return items[i]
    }
}

//这一次，占位类型参数 Element 被用作 append(_:) 方法的 item 参数和下标的返回类型。Swift 可以据此推断出 Element 的类型即是 ItemType 的类型。


//通过扩展一个存在的类型来指定关联类型

//通过扩展添加协议一致性中描述了如何利用扩展让一个已存在的类型符合一个协议，这包括使用了关联类型的协议。

//Swift 的 Array 类型已经提供 append(_:) 方法，一个 count 属性，以及一个接受 Int 类型索引值的下标用以检索其元素。这三个功能都符合 Container 协议的要求，也就意味着你只需简单地声明 Array 采纳该协议就可以扩展 Array，使其遵从 Container 协议。你可以通过一个空扩展来实现这点，正如通过扩展采纳协议中的描述：

extension Array: Container {}

//如同上面的泛型 Stack 结构体一样，Array 的 append(_:) 方法和下标确保了 Swift 可以推断出 ItemType 的类型。定义了这个扩展后，你可以将任意 Array 当作 Container 来使用。

//泛型 Where 语句
//类型约束能够让你为泛型函数或泛型类型的类型参数定义一些强制的要求。
//为了关联类型定义约束也是非常有用的。当你在参数列表中通过where子句为关联类型定义约束。你能通过where子句要求一个关联类型遵从某个特定的协议， 以及某个特定的类型参数和关联类型必须类型相同。你可以通过将 where 关键字紧跟在类型参数列表后面来定义 where 子句，where 子句后跟一个或者多个针对关联类型的约束，以及一个或多个类型参数和关联类型间的相等关系。你可以在函数体或者类型的大括号之前添加 where 子句。

//例子定义一个名为 allItemmatch 的泛型函数， 用来检查 两个 Container 实例是否包含相同顺序的元素。如果所有的元素都能匹配， 那么返回true 否则返回false

//被检测的两个 Cont 可以不是相同的容器， 但是他们必须拥有相同的元素， 这个要求通过一个类型约束 以及一个 where子句来表示


//func allItemsMatch<C1: Container, C2: Container>
//    (_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
//        
//        // 检查两个容器含有相同数量的元素
//        if someContainer.count != anotherContainer.count {
//            return false
//        }
//        
//        // 检查每一对元素是否相等
//        for i in 0..<someContainer.count {
//            if someContainer[i] != anotherContainer[i] {
//                return false
//            }
//        }
//        
//        // 所有元素都匹配，返回 true
//        return true
//}

func allItemsMatch<C1 : Container, C2 : Container>(_ someContainer : C1, _ anotherContainer : C2) -> Bool where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
    
    //检查两个容器含有相同的数量的元素
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    //检查每一对元素是否相等
    for i in 0..<someContainer.count {
        
        if someContainer[i] != anotherContainer[i] {
            
            return false
        }
    }
    
    
    return true
}

//这个函数接受 someContainer 和 anotherContainer 两个参数。参数 someContainer 的类型为 C1，参数 anotherContainer 的类型为 C2。C1 和 C2 是容器的两个占位类型参数，函数被调用时才能确定它们的具体类型。

//这个函数的类型参数列表还定义了对两个类型参数的要求：
//
//C1 必须符合 Container 协议（写作 C1: Container）。
//C2 必须符合 Container 协议（写作 C2: Container）。
//C1 的 ItemType 必须和 C2 的 ItemType类型相同（写作 C1.ItemType == C2.ItemType）。
//C1 的 ItemType 必须符合 Equatable 协议（写作 C1.ItemType: Equatable）。
//
//第三个和第四个要求被定义为一个 where 子句，写在关键字 where 后面，它们也是泛型函数类型参数列表的一部分。
//
//这些要求意味着：
//
//someContainer 是一个 C1 类型的容器。
//anotherContainer 是一个 C2 类型的容器。
//someContainer 和 anotherContainer 包含相同类型的元素。
//someContainer 中的元素可以通过不等于操作符（!=）来检查它们是否彼此不同。
//
//第三个和第四个要求结合起来意味着 anotherContainer 中的元素也可以通过 != 操作符来比较，因为它们和 someContainer 中的元素类型相同。
//
//这些要求让 allItemsMatch(_:_:) 函数能够比较两个容器，即使它们的容器类型不同。
//
//allItemsMatch(_:_:) 函数首先检查两个容器是否拥有相同数量的元素，如果它们的元素数量不同，那么一定不匹配，函数就会返回 false。
//
//进行这项检查之后，通过 for-in 循环和半闭区间操作符（..<）来迭代每个元素，检查 someContainer 中的元素是否不等于 anotherContainer 中的对应元素。如果两个元素不相等，那么两个容器不匹配，函数返回 false。
//
//如果循环体结束后未发现任何不匹配的情况，表明两个容器匹配，函数返回 true。
//
//下面演示了 allItemsMatch(_:_:) 函数的使用：

var stackOfNewStrings = NewStack<String>()
stackOfNewStrings.push("hello")
stackOfNewStrings.push("world")
stackOfNewStrings.push("!")

var arrayOfStrings = ["hello", "world", "!"]

if allItemsMatch(stackOfNewStrings, arrayOfStrings) {
    
    print("所有的元素都匹配")
    
}else{
    
    print("不是所有的元素都匹配")
}

//上面的例子创建了一个 Stack 实例来存储一些 String 值，然后将三个字符串压入栈中。这个例子还通过数组字面量创建了一个 Array 实例，数组中包含同栈中一样的三个字符串。即使栈和数组是不同的类型，但它们都遵从 Container 协议，而且它们都包含相同类型的值。因此你可以用这两个容器作为参数来调用 allItemsMatch(_:_:) 函数。在上面的例子中，allItemsMatch(_:_:) 函数正确地显示了这两个容器中的所有元素都是相互匹配的。








