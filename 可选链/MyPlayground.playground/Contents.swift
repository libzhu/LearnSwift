//: Playground - noun: a place where people can play

import UIKit

var str = "可选链式调用"

/*
 
 · 使用可选链式调用代替强制展开
 · 为可选链式调用定义模型类
 · 通过可选链式调用访问属性
 · 通过可选链式调用调用方法
 · 通过可选链式调用访问下标
 · 链接多层可选链式调用
 · 在方法的可选返回值上进行可选链式调用
 
 */

//可选链式调用是一种可以在当前值可能为nil的可选值上请求和调用属性、方法及下标的方法。如果可选值有值，那么会调用成功，如果可选值为nil， 那么调用将返回nil。多个调用可以连在一起形成一个调用链， 如果任何一个节点为nil， 整个调用都会失败 及返回值为 nil
//Swift的可选链式调用和Objective-C中向nil发送消息有些相像。但是Swift 的可选链式调用应用于任意类型， 并且能检查调用是否成功。
//1、使用可选链式调用代替强制展开
//童工在想调用的属性、方法、下标的可选值后面放一个问号（ ？）可以定义一个可选链。这一点很像在可选值后面放一个叹号（！） 来强制展开他的值。它们的主要区别在于可选值为空时可选链式调用只会调用失败， 然而强制张开会触发运行时错误。
//为了反映可选链式调用可以在空值nil 上调用的事实， 不能这个调用的属性、方法及下标返回的值是不是可选值， 它的返回结果都是一个可选值。你可以利用这个返回值来判断你的可选链式调用是否调用成功，如果调用有返回值则说明调用成功， 返回为nil 这说明调用失败。
//特别的：可选链式调用的返回结果与原本的返回结果具有相同的类型， 但是被包装成了一个可选的值。例如， 使用可选链式调用访问属性，当可选链式调用成功时，如果属性原本的返回结果是 Int 类型， 则会变成  Int？ 类型。
//下面几段代码将解释可选链式调用和强制展开的不同。
//首先定义两个类 Person 和 Residence

class Person {
    
    var residence : Residence?
    
}

class Residence {
    
    var numberOfRooms  = 1
    
}

//Residence 有一个 Int 类型的属性numberOfRooms, 其默认值为  1， Person 具有一个可选的residence 属性， 请类型为Residence？
//创建一个新的Person 实例， 它的residence 属性由于是可选类型而将初始化为nil， 在下面的代码中， John有一个值为nil residence 属性：
let john = Person()
//john.residence = Residence()
//print(john.residence!)
//如果使用感叹号！强制展开获得这个 John的residence属性中的numberOfRooms值， 会触发运行时错误，因为这个residence 没有展开的值：
//let roomCount = john.residence!.numberOfRooms//会引发运行时错误。

//john.residence为非nil值的时候， 上面的调用会成功， 并且把roomCount 设置为 int类型的房间数，正如上面提到的， 当 residence 为 nil的时候 上述代码会触发运行时错误。
//可选链式调用提供另一种访问 numberOfRooms 的方式， 使用问号（？）来替代原来的叹号 （！）

if let roomCount = john.residence?.numberOfRooms {
    
    print("John's residence has \(roomCount) rooms")
    
}else{
    
    print("Unable to retrieve the nunber of rooms.")
}

//residence 后面添加问号之后， Swift 就会在 residence 不为 nil 的情况下访问 numberOfRooms。访问numberOfRooms 有可能失败， 可选链式调用会返回int？类型， 或称为可选的 int  如上所示，当residence为nil 的时候，可选的Int将会为nil， 标明无法访问numberOfRooms。访问成功时 可选的Int值会通过可选绑定展开， 并赋值给非可选类型的roomCount 常量。注意的是：即使numberOfRooms 是非可选的 Int 时，这一点也成立。只要使用可选链式调用就意味着numberOfRooms会返回一个Int而不是 Int

//将一个 Residence 的实例赋值给John.residence, 这样他就不是nil 了

john.residence = Residence()

//john.residence 现在包含一个实际的 Residence 实例， 而不是nil 如果你试图使用先前可选链式调用 numberOfRooms 它将返回值为 1 的Int？ 类型的值。
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// 打印 “John's residence has 1 room(s).”


//2、为可选链式调用定义模型类
// 通过使用可选链式调用可以调用多层属性、方法和下标。这样可以在复杂的模型中向下访问各种子属性， 并且判断能否访问子属性的属性、方法或下标。
//例子：定义四个模型类，这些例子包含多层可选链式调用。为了方便说明 在NewPerson和NewResidence 的基础上增加Room类 和 Address 类，以及相关的属性，方法及下标。

class NewPerson {
    
    var residence : NewResidence?
    
}

//NewResidence 类型比之前复杂些， 增加一个名为rooms 的变量属性， 该属性被初始化为[Room]类型的空数组
class NewResidence {
    
    var rooms = [Room]()
    var numberOfRooms : Int {
        
        return rooms.count
    }
    
    subscript (i : Int) -> Room {
        
        get {
            
            return rooms[i]
        }
        
        set {
            
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        
        print("房间的数量：\(numberOfRooms)")
    }
    
    
    var address : Address?
    
    
    
}

//解释：现在NewResidence 有了一个存储 Room实例是的数组， numberOfRooms 被实现为计算属性， 而不是存储属性，numberOfRooms 简单的返回rooms 数组的count属性值。NewResidence还提供了 访问rooms数组的快捷方式， 既提供可读写的下标来访问rooms 数组中指定位置的元素。还提供 printNumberOfRooms 方法， 这个方法的作用是打印numberOfRooms 的值。最后提供了一个可选属性address 其类型Address？


//Room类是一个简单类， 其实例被存储在rooms 数组中， 该类只包含一个属性name 以及用于将该属性设置为适当房间名的初始化函数
class Room {
    
    let name : String
    init(name : String) {
        self.name = name
    }
    
}
//含有三个String？ 类型的可选属性， buildingName以及buildingNumber属性分别表示某个大厦的名称和号码，  第三个属性 street 表示大厦所在街道的名称：此外，还提供了 buildingIdentifier（）方法， 返回值为Stirng? 如果buildingName又返回值 buildingName 如果buildingNumber和Street 均有值则返回buildingNumber。否则返回 nil。
class Address {
    
    var buildingName : String?
    var buildingNumber : String?
    var street : String?
    
    func buildingIdentifier() -> String? {
        
        if buildingName != nil {
            return buildingName
        }else if buildingNumber != nil && street != nil {
            
            return "\(buildingNumber)\(street)"
        }else{
            
            return nil
        }
    }
    
}

//通过可选链式调用访问属性
//可以通过可选链式调用在一个可选值上访问它的属性，并且判断访问是否成功。
//创建一个NewPerson 实例，然后像之前 访问numberOfRooms 属性
let liLei = NewPerson()
if let roomCount = liLei.residence?.numberOfRooms {
    
    print("LiLei 的住宅有 \(roomCount)个房间")
}else{
    
    print("Unable to retrieve the number of rooms")
}

//因为john.residence 为nil 所以这个可选链式依旧会像先前一样失败。

//还可以通过可选连式调用来设置属性值：
let somdAddress = Address()
somdAddress.buildingNumber = "29"
somdAddress.street = "关山大道"

liLei.residence?.address = somdAddress//jonh.residence 来设定属性也会失败， 因为liLei.residence 当前为nil

//上述代码的赋值过程是可选链式调用的一部分， 意味着可选链式调用失败时， 等号右侧的的代码不会被执行。对于上面的代码来说很难验证这一点， 因为像这样赋值一个常量没有任何副作用，下面的代码完成了同样的事情，但是它使用一个函数创建Address 实例，然后将该实例用于赋值。 该函数会在返回前打印 【Founction  was  called】者是你能验证等号右侧的代码是否被执行。
func createAddresss() -> Address {
    
    print("Function was  called")
    
    let  someAddress = Address()
    somdAddress.buildingNumber = "701"
    somdAddress.street = "关山大道"
    
    return someAddress
    
}

liLei.residence?.address = createAddresss()//没有任何消息打印， 可以看出 createAddress（）函数并未被执行，，说明 可选链式构调用失败 = 右边的代码是不会执行的。

//通过可选链式调用调用方法。
//可以通过可选链式调用来调用方法， 并且判断是否调用成功， 即使这个方法没又返回值。
//NewRecidence 类中的 printNumberOfRoom是（）方法打印当前的numberOfRooms 值
//这个方法没雨返回值， 没与返回值的方法具有隐式的返回类型 Void ， 这意味着没有返回值的的方法也会返回（）或者说是空的元祖。
//如果在可选值上通过可选链式调用来调用这个方法， 该方法的返回类型会是 Void？ 而不是Void 以为通过可选链式调用得到的返回值都是可选的。这样我们就可以用if语句判断能否成功调用printNumberOfRooms（）方法， 即使方法本身没有定义返回值。通过判断返回值是否为nil 可以判断调用是否成功。
//liLei.residence = NewResidence()


print(liLei.residence?.printNumberOfRooms() ?? "hello world")
if liLei.residence?.printNumberOfRooms() != nil {//可选链式调用无返回值类型的函数隐式的返回Void？
    
    print("It was  possible to print the number of rooms")
}else{
    
    print("it was not possible to print the number of rooms")
}

//同样的， 可以判断通过可选链式调用为属性赋值是否成功， 我们尝试给liLei.residence中的address属性赋值，即使residence为nil。通过可选链式调用给属性赋值会返回Void?，通过判断返回值是否为nil就可以知道赋值是否成功：

if (liLei.residence?.address = somdAddress) != nil {
    
    print("it was possible to set the address")
}else{
    
    print("it was not possible to set the address")
}

//通过可选链式调用访问下标
//通过可选链式调用， 我们可以在一个可选值上访问下标， 并未判断是否访问成功。
//注意：通过可选链式调用访问可选值的下标时，应该将问号放在方括号的前面而不是后面。可选链式调用的问号一般直接跟在可选表达式的后面。
//下面这个例子用下标 liLei.residence 属性存储的Residence 实例的rooms 数组中的第一个房间的名称， 

let johnsHouse = NewResidence()

johnsHouse.rooms.append(Room(name : "Living Room"))
johnsHouse.rooms.append(Room(name : "Love Room"))

liLei.residence = johnsHouse


if let firstRoom  = liLei.residence?[0].name {
    
     print("The first room name is \(firstRoom).")
}else{
    
     print("Unable to retrieve the first room name.")
}

//访问可选类型的下标
//如果下标返回可选类型值， 比如Swift 中 dictionary 类型的键的下标， 可以在下标的结尾括号后面放一个问号来在其可选返回值上进行可选链式调用：
var testScores = ["Dave" : [84, 83, 85], "Bev" : [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0]

print(testScores["Dave"]!, testScores["Bev"]!)

//上面的例子中定义了一个testScores字典，包含了两个键值对，把String类型的键映射到一个Int值的数组。这个例子用可选链式调用把"Dave"数组中第一个元素设为91，把"Bev"数组的第一个元素+1，然后尝试把"Brian"数组中的第一个元素设为72。前两个调用成功，因为testScores字典中包含"Dave"和"Bev"这两个键。但是testScores字典中没有"Brian"这个键，所以第三个调用失败。

//链接多层可选链式调用
//可以通过连接多个可选链式调用在更深的模型层中访问属性、方法以及下标。然而，多层可选链式调用不会增加返回值的可选层级。也就是说：1、如果你访问的值不是可选的，可选链式调用将会返回可选值。2、如果你返回的值是可选的，可选链式调用不会让可选返回值变得更可选。因此：1.通过可选链式访问一个int 值， 将返回一个 int？ 无论使用了多少层可选链式调用。2、类似的、通过可选链式访问int？值，依旧会返回一个 int？值， 并不会返回int？？
//下面的例子尝试访问 john中的 residence属性中的address属性中的street 属性， 这里使用了两层可选链式调用， residence和address都是可选值类型。

if let liLeiStreet = liLei.residence?.address?.street {
    
    print("lilei's street name is \(liLeiStreet)")
}else{
    
    print("Unable to retrieve the address.")
}

//liLei.residence 现在包含一个有效的NewResidence实例， 然而 liLei.residence.address 的值当前为nil。 因此调用liLei。residence?.address?.street 会失败。
let liLeiAddress = Address()
liLeiAddress.street = "天门街"
liLeiAddress.buildingName = "摩天大厦"
liLei.residence?.address = liLeiAddress

if let liLeiStreet = liLei.residence?.address?.street {
    print("lilei's street name is \(liLeiStreet)")
}else{
    
    print("Unable to retrieve the address.")
}

//在方法的可选返回值上进行可选链式调用
//上面的例子展示了如何在一个可选值上通过可选链式调用来获取它的属性值。我们还可以在一个可选值上通过可选链式调用来调用方法，并且可以根据需要继续在方法的可选返回值上进行可选链式调用。
//下面的例子中， 通过可选链式调用Address 的buildingIdentifier（）方法，这个方法返回String？类型的值。可以通过可选链式调用来调用该方法， 最终的返回值依旧是String？类型

if let buildingIdentifier = liLei.residence?.address?.buildingIdentifier() {
    
    print("LiLei's building identifier is \(buildingIdentifier)")
}

//如果还要在该方法返回值上进行链式调用，在该方法的圆括号后面加上问号？即可

if let beginWithThe = liLei.residence?.address?.buildingIdentifier()?.hasPrefix("摩") {
    if beginWithThe {
        print("LiLei's building identifier begins with \"摩\"")
    }else{
        
         print("John's building identifier does not begin with \"摩\".")
    }
}

//注意：上面的例子中， 在方法的圆括号后面加上问号是因为你要在buildingIdentifier（） 方法的可选值上进行可选链式调用， 而不是方法本身。




