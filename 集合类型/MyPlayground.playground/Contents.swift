//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
 
 Swift 语言提供Arrays、Sets和Dictionaries三种基本的集合类型用来存储集合数据。数组（Arrays）是有序数据的集。集合（Sets）是无序无重复数据的集。字典（Dictionaries）是无序的键值对的集。
 
 */

/*
 如果创建一个Arrays、Sets或Dictionaries并且把它分配成一个变量，这个集合将会是可变的。这意味着我们可以在创建之后添加更多或移除已存在的数据项，或者改变集合中的数据项。如果我们把Arrays、Sets或Dictionaries分配成常量，那么它就是不可变的，它的大小和内容都不能被改变。
 */

//1、数组（Arrays）
//写 Swift 数组应该遵循像Array<Element>这样的形式，其中Element是这个数组中唯一允许存在的数据类型。我们也可以使用像[Element]这样的简单语法。尽管两种形式在功能上是一样的，但是推荐较短的那种，而且在本文中都会使用这种形式来使用数组。
//数组使用有序列表存储同一类型的多个值。相同的值可以多次出现在一个数组的不同位置中。
//1.1 创建一个空数组
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")
// 打印 "someInts is of type [Int] with 0 items."
someInts.append(3)// someInts 现在包含一个 Int 值
someInts = []// someInts 现在是空数组，但是仍然是 [Int] 类型的。

var otherSomeInts = [1, 2, 3, 4]


//1.2 创建一个带有默认值的数组
//swift中的 Array 类型还提供一个可以创建特定大小并且所有数据都被默认的构造方法。我们可以把准备加入新数组的数据项数量 （count） 和 适当类型的初始值 （repeating） 传入构造函数

var threeDoubles = Array(repeatElement(0.0, count: 3))

//1.3 通过两个数组相加创建一个数组
//我们可以使用加法操作符 （+）来组合两种已经存在的相同类型的数组、新数组中的类型会被两个数组的数据类型中推出了

var anohterThreeDoubles = Array(repeatElement(2.5, count: 3))

var sixDoubles = threeDoubles + anohterThreeDoubles

//1.4用数组字面量构造数组
//我们可以使用数组字面量来进行数组构造，这是一种用一个或多个数值构造数组的简单方法。数组字面量是由一系列有逗号分割并由方括号包含的数值

var shoppingList : [String] = ["eggs", "milk"]
print(shoppingList)

//shoppingList 变量声明为“字符串值类型的数组” 记做【String】 因为这个数组被规定只有 String 一种数据结构，所以只有 String 类型可以在其中被存储。shoppingList数组被声明为变量（var关键字创建）而不是常量（let创建）是因为以后可能会有更多的数据项被插入其中。
//由于 Swift 的类型推断机制，当我们用字面量构造只拥有相同类型值数组时，我们不必把数组的类型定义清除，可以简写：
var otherShoppingList = ["eggs", "milk"]
print(otherShoppingList)

//2、访问和修改数组
//通过数组的方法和属性来访问和修改数组， 或者使用下标语法
//可以使用数组的只读属性 count 来获取数组中的数据项数量
print("The shopping list contains \(otherShoppingList.count) items")

//使用布尔属性 isEmpty 作为缩写形式去检查 count 属性是否为0：

if shoppingList.isEmpty {
    print("购物清单为空")
}else{
    
    print("购物清单不是空")
}

//可以使用 append（）方法在数组后面添加新的数据项
shoppingList.append("Flour")
print(shoppingList)

//可以使用加法赋值运算符 += 可以直接在数组后面添加一个 或多个拥有相同类型数据项
shoppingList += ["water"]
print(shoppingList)

shoppingList += ["fruit", "meet", "coca", "coffee"]
print(shoppingList)

//可以直接使用下标语法来获取数组中的数据项，把我们需要的数据项的索引值直接放在数组名称的方括号中
var firstItem = shoppingList[0]
print(firstItem)

//可以使用下标改变某个已有索引值对应的数据值：
shoppingList[0] = "rice"
print(shoppingList)

//可以利用下标来一次改变一系列数据值，即使新数据和原有数据的数量是不一样的
shoppingList[4...6] = ["apple", "orange"]
print(shoppingList)

//可以调用 insert（_at:）方法来在某个具体索引值之前添加数据项
shoppingList.insert("banana", at: 0)
shoppingList.insert("putao", at: shoppingList.count)
print(shoppingList)

//可以使用 remove（at：）方法来移除数组中的某一项，这个方法把数组在特定索引值中存储的数据项移除并且返回这个被移除的数据项（我们不需要的时候就可以无视它）
shoppingList.remove(at: 0)
print(shoppingList)
firstItem = shoppingList[0]
print(firstItem)

//可以使用 removeLast（）方法移除数组的最后一项数组
shoppingList.removeLast()
print(shoppingList)

//删除后几项数据
shoppingList.removeLast(3)
print(shoppingList)


//删除全部数据项
shoppingList.removeAll(keepingCapacity: true)
print(shoppingList)

//
shoppingList += ["fruit", "meet", "coca", "coffee"]
shoppingList += ["fruit", "meet", "coca", "coffee"]
print(shoppingList)
//删除第一项数据
shoppingList.removeFirst()
print(shoppingList)


//删除前几项数据
shoppingList.removeFirst(3)
print(shoppingList)

//1.5 数组的遍历
//我们可以使用for - in 循环来遍历数组中所有的数据项

for itemStr in shoppingList {
    print(itemStr)
}

//如果我们同事需要每个数据项的值 和 索引值，可以使用 enumerated() 方法来进行数组遍历。enumerated（）返回由每一个数据项索引值和数据值组成的元祖数据。我们可以办这个元祖分解成临时的常量或者变量来遍历

for (index, value) in shoppingList.enumerated() {
    
    print("数据的下标：\(index) 值：\(value)")
}

// NSArray 型数组

let nsArr1:NSMutableArray = ["nan", "jing", "huan", "ying", "nin", "bei", "jing", "ni", "hao"]

// 删除指定下标的元素
nsArr1.removeObject(at: 2)

// 删除指定元素，删除所有指定元素
nsArr1.remove("ying")

// 删除指定元素
nsArr1.removeObject(identicalTo: "nan")

// 删除最后一个元素
nsArr1.removeLastObject()

// 删除指定范围的元素
nsArr1.removeObjects(in: NSMakeRange(2, 1))

// 删除所有元素
nsArr1.removeAllObjects()



//2.集合（Sets）
//集合（Set）用来存储相同类型并且没有确定顺序的值， 当集合元素不重要时 或 希望确保每个元素只出现一次时可以使用集合元素而不是数组

/*
 注意:Swift的 set 类型被桥接到 Foundation 中的NSSet 类。
 */

//集合类型的哈希值
//一个类型为了存储在集合中，该类型必须是 可哈希化的 -- 也就是说，该类型必须提供一个方法来计算他的哈希值。一个哈希值 是 Int 类型的， 相等的对象值必须相同，若果 a == b 那么a.hashValue == b.hashValue

//Swift 的所有基本类型（比如 Sring， Int， Double 和 Bool ）默认都是可以哈希化的 可以作为集合的值的类型或者字典的键的类型。没有关联值的枚举成员值(在枚举有讲述)默认也是可哈希化的。

//集合类型语法
//Swift 中的 Set 类型被写为 Set<element>,这里的 Element 表示 Set 中允许存储的类型 和 数组不同 集合中么有等价的简化形式
//2.1、创建一个一个空的集合

var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count)")//通过构造器 这里的letters 被推断为Set<Character>

letters.insert("a")
print(letters)

//此外，如果上下文提供了类型信息，比如作为函数的参数或者已知类型的变量或常量，我们可以通过一个空的数组字面量创建一个空的Set：
letters = []
print(letters)

//2.2、用数组字面量来构造集合 并且 可以使用简化形式写一个或者多个值作为集合的元素
//集合中有重复的元素和自动过滤掉
var favoriteGenres : Set<String> = ["rock", "classical", "hip hop", "rock", "hip hop", "rock"]
print(favoriteGenres)

//一个Set类型不能从数组字面量中被单独推断出来，因此Set类型必须显式声明。然而，由于 Swift 的类型推断功能，如果你想使用一个数组字面量构造一个Set并且该数组字面量中的所有元素类型相同，那么你无须写出Set的具体类型。favoriteGenres的构造形式可以采用简化的方式代替：
var ohterFavorateGenres : Set = ["rock", "classical", "hip hop"] //数组里面元素类型相同， Swift的推出机制 会推断出 ohterFavorateGenres 为 Set<String>
//2.3、访问和修改一个集合
//可以通过 Set 的属性和方法来访问和修改一个 Set。
//找出 Set 中元素的数量 
print("otherFavorateGenres 中元素的数量：\(ohterFavorateGenres.count)")

//使用布尔属性 isEmpty 作为缩写形式去检查 count 属性是否为 0

if ohterFavorateGenres.isEmpty {
    
    print("没有元素")
}else{
    
    print("有元素")
}

//可以通过你调用 Set 的 insert（_:）方法添加一个新的元素
favoriteGenres.insert("Jazz")

//可以通过调用 Set 的 remove（_:）方法删去一个元素， 如果该值是 该 Set 的一个元素则删除该元素并且返回被删除元素的值，否则如果该 Set 不包含该值，则返回 nil 。 删除 Set 中所有的元素 可以使用 removeAll() 方法

if let removedGenre = ohterFavorateGenres.remove("rock") {
    
    print("\(removedGenre) 是我喜欢的，被我删除了")
    print(ohterFavorateGenres)
}else{
    
    print("没有找到要删除的元素！")
}

 let nsSet1:NSSet = [2, 4, 6, 8]

print(nsSet1)



ohterFavorateGenres = ["rock", "classical", "hip hop"]

print(ohterFavorateGenres)

print(ohterFavorateGenres.endIndex)

ohterFavorateGenres.removeFirst()
print(ohterFavorateGenres)

//可以使用 contains（_:）方法来检查 Set 中 是否包含一个特定的值

if favoriteGenres.contains("rock") {
    print("包含这个特定的值")
    
}else{
    print("不包含这个特定的值")
    
}

print(favoriteGenres)

//2.4、遍历集合

//可以在 for - in 循环中 遍历一个 set 中的所有值

for gener in favoriteGenres {
    
    print("集合中的值：\(gener)")
}

//Swift 的Set类型没有确定的顺序，为了按照特定顺序来遍历一个Set中的值可以使用sorted()方法，它将返回一个有序数组，这个数组的元素排列顺序由操作符'<'对元素进行比较的结果来确定.

for gener in favoriteGenres.sorted() {
    
    print(gener)
}

for (index, value) in favoriteGenres.sorted().enumerated() {
    
    print(index, value )
}

//2.5 集合基本操作
/*
 
 使用intersection(_:)方法根据两个集合中都包含的值创建的一个新的集合。
 使用symmetricDifference(_:)方法根据在一个集合中但不在两个集合中的值创建一个新的集合。
 使用union(_:)方法根据两个集合的值创建一个新的集合。
 使用subtracting(_:)方法根据不在该集合中的值创建一个新的集合。

 
 */

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

let new1 = oddDigits.union(evenDigits)

let new2 = oddDigits.intersection(evenDigits)

let new3 = oddDigits.subtracting(singleDigitPrimeNumbers)

let new4 = oddDigits.symmetricDifference(singleDigitPrimeNumbers)

/*
 
 使用“是否相等”运算符(==)来判断两个集合是否包含全部相同的值。
 使用isSubset(of:)方法来判断一个集合中的值是否也被包含在另外一个集合中。
 使用isSuperset(of:)方法来判断一个集合中包含另一个集合中所有的值。
 使用isStrictSubset(of:)或者isStrictSuperset(of:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
 使用isDisjoint(with:)方法来判断两个集合是否不含有相同的值(是否没有交集)。

 
 */
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals)
farmAnimals.isSuperset(of: houseAnimals)
farmAnimals.isDisjoint(with: cityAnimals)


//3.字典
/*
 字典是一种存储多个相同类型的值的容器。每个值（value）都关联唯一的键（key），键作为字典中的这个值数据的标识符。和数组中的数据项不同，字典中的数据项并没有具体顺序。我们在需要通过标识符（键）访问数据的时候使用字典，这种方法很大程度上和我们在现实世界中使用字典查字义的方法一样。
 
 */

//3.1 创建一个空字典 
//我们可以像数组一样使用构造语法创建一个拥有确定类型的空字典：

var nameOfIntegers = [Int : String]()
// namesOfIntegers 是一个空的 [Int: String] 字典, 来存储整数的英文命名。它的键是 Int 类型 值 String 类型。
//如果上下文已经提供了类型信息，我们可以使用空字典字面量来创建一个空字典，记作[:]（中括号中放一个冒号）：
nameOfIntegers[16] = "sixteen"
print(nameOfIntegers)
nameOfIntegers = [:]//又变成类空字典
print(nameOfIntegers)

//我们可以使用字典字面量来构造字典，这和我们刚才介绍过的数组字面量拥有相似语法。字典字面量是一种将一个或多个键值对写作Dictionary集合的快捷途径。

//一个键值对是一个key和一个value的结合体。在字典字面量中，每一个键值对的键和值都由冒号分割。这些键值对构成一个列表，其中这些键值对由方括号包含、由逗号分割：
//下面的例子创建了一个存储国际机场名称的字典。在这个字典中键是三个字母的国际航空运输相关代码，值是机场名称：

var airports : [String : String] = ["YYZ" : "Toronto Pearson", "DUB" : "Dublin"]

//简写
var otherAirports = ["YYZ" : "Toronto Pearson", "DUB" : "Dublin"]


print(airports, otherAirports)

//3.2访问 或 修改字典

print("otherAirports 字典中的项目数量：\(otherAirports.count)")

//3.3 可以说使用 isEmpty 作为一个缩写 去检查 count 属性是否为 0

if otherAirports.isEmpty {
    
    print("字典中元素项目为零")
}else{
    
    print("字典中元素项目不为零")
}

//3.3 可以使用字典的语法 来添加新的数据项
airports["CSN"] = "China"
print(airports)

//3.4 可以根据 key 值 修改 value 值
airports["YYZ"] = "CBD"
print(airports)

//可以 根据 updateValue（_:forKey:）方法修改对应的值 updateValue(_:forKey:)方法会返回对应值的类型的可选值。举例来说：对于存储String值的字典，这个函数会返回一个String?或者“可选 String”类型的值。如果有值存在于更新前，则这个可选值包含了旧值，否则它将会是nil。
airports.updateValue("Pearson", forKey: "YYZ")
print(airports)

if let old = airports.updateValue("Toronto Pearson", forKey: "YYZ") {

    print(old)
}

print(airports)

//我们也可以使用下标语法来在字典中检索特定键对应的值。因为有可能请求的键没有对应的值存在，字典的下标访问会返回对应值的类型的可选值。如果这个字典包含请求键所对应的值，下标会返回一个包含这个存在值的可选值，否则将返回nil：

if let airportName = airports["DUBH"] {
    
    print("机场的名字：\(airportName)")
    
    
}else{
    
    print("机场的名字不存在")
}

if let airportName = airports["DUB"] {
    
    print("机场的名字：\(airportName)")
    
    
}else{
    
    print("机场的名字不存在")
}

//我们还可以使用下标语法来通过给某个键的对应值赋值为nil来从字典里移除一个键值对：
airports["APL"] = "Apple Internation"
print(airports)

airports["APL"] = nil//可以移除键值对
print(airports)

//也可以使用 removeValue（forKey：）方法来移除字典中的键值对。当移除的键值 存在时会移除并返回这个移除的 key 值所对应的 value 值，键值不存在返回nil

if let removeValue = airports.removeValue(forKey: "YYZ") {
    
    print("移除内容：\(removeValue)")
}else{
    
    print("字典中没有对应的 key 键值")
}

//3.5 字典的遍历
//我们可以使用for-in循环来遍历某个字典中的键值对。每一个字典中的数据项都以(key, value)元组形式返回，并且我们可以使用临时常量或者变量来分解这些元组：

for (key, value) in airports {
    print("key:\(key), value:\(value)")
}

//3.5.1 只遍历 字典的key 值 或是  value 值；

for airportCode in airports.keys {
    print(airportCode)
}

for airportKey in airports.values {
    print(airportKey)
}

//如果我们只是需要使用某个字典的键集合或者值集合来作为某个接受Array实例的 API 的参数，可以直接使用keys或者values属性构造一个新数组：
let airportCode = [String](airports.keys)
print(airportCode)

let airportName = [String](airports.values)
print(airportName)

//或者使用另一种方法
let code = airports.keys.sorted()
let name = airports.values.sorted()

var dic : [String : Any] = ["a" : "1", "b" : 2]



