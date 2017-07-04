//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
 
 类和结构体对比
 结构体和枚举是值类型
 类是引用类型
 类和结构体的选择
 字符串、数组、和字典类型的赋值与复制行为

 */

//类和结构体是人们构造代码所用的一种通用且灵活的构造体。我们可以使用完全相同的语法规则来为类和结构体定义属性（常量、变量） 和 添加方法，从而扩展类和结构体的功能。
//与其他编程语言所不同的是：Swift并不要求你为自定义类和结构去创建独立的接口和实现文件。你所要做的是在一个单一文件中定义一个类或结构体，从而扩展类和结构体的功能

//FIXME:通常一个类的实例被称为对象。然而在 Swift 中，类和结构体的关系要比在其他语言中更加的密切，本章中所讨论的大部分功能都可以用在类和结构体上。因此，我们会主要使用实例。
//1、类和结构体对比
//1、Swift 中类和结构体有很多共同点。1）定义属性用于存储值， 2）定义方法用于提供功能，3）定义下标操作使得可以通过下标语法来访问实例所包含的值 4）定义构造器用于生成初始化值 5）通过扩展以增加默认的功能 6）实现协议已提供某种标准功能
//与结构体相比， 类还有如下的附加功能：1）继承允许一个类继承另一个类型的特征 2）类型转换允许在运行时检查和解释一个类型实例的类型 3）析构器允许一个类实例释放任何其所被分配的资源 4）引用计数允许对一个类的多次应用
//2、定义语法
//2.1、类和结构体都有着类似的定义方式。我们通过关键字 class 和 struct 来分别表示类 和 结构体，并在一对大括号中定义他们的具体内容：

class SomeClass {
    
    //在这里定义类
    
}

struct SomeStruct {
    //在这里定义结构体
}

//FIXME:在每次定义一个新类 或 结构体的时候，实际上定义类一个新的Swift类型。因此请使用 UpperCamelCase 这种方式来命名，以便复合标准的Swift类型的大写命名风格 （String ， Int Bool）相反的请使用lowerCamelCase这种类型方式为属性和方法命名（framerare 和 incrementCount），以便和类型名区分
//以下是定义结构体 和 定义类型实例
struct Resolution {
    
    var width = 0
    var height = 0

}

class ViedoMoel {
    
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name : String?
}
//解释：定义雷一个名为 Resolution 的结构体，用来描述显示器的分辨率， 这个结构体包含了两个名为 Width 和 height 的存储属性。当这两个属性被初始化整数 0 的时候 会被自动推断为 Int 类型。 VideoMode类，用来描述一个视频显示器的特定模式。这个类包含了四个变量储存属性，第一个 分辨率 他被初始化为一个新的Resolution 结构体的实例， 属性被推断为 Resolution 。 新的 VideoMode 实例 同时还会初始化其他是三个属性， 他们分别是 初始值为FALSE 的interlaced 初始值为0.0 frameRate 以及值为可选String的 name ，name会自动被赋值一个默认的nil 意为“没有name”值，因为他是一个可选类型。

//3、类和结构体实例
//3.1、Resolution 结构体 和 VideoMode 类的定义仅描述了什么事 Resolution 和 VideoMode 他们并没用描述一个给定的分辨率 或者视频模式（video Mode）味蕾描述一个特定的分辨率 或则视频模式。我们需要生成一个他们的实例
//生成结构体和类实例的语法非常相似

let someResolution = Resolution()
let someVidoMode = ViedoMoel()

//结构体和类使用构造器语法来生成新的实例。构造器语法的最简单的形式就是在结构体中或者类的类型名称后跟随一对空括号，如 Resolution（） 和 VideoMode（）通过这种方式所创建的类或结构体实例，其属性会被初始化为默认值。
//4：属性访问
//4.1 通过使用点语法， 你可以访问实例的属性。其语法规则是，实例名后面紧跟属性名，两者通过点号链接
print("屏幕的分辨率 宽度：\(someResolution.width)")

print("视频分辨率 宽度：\(someVidoMode.resolution.width)")

//可以使用点语法为变量属性赋值
someVidoMode.resolution.width = 1800
print("现在视频的分辨率 宽度：\(someVidoMode.resolution.width)")

//5 结构体类型的成员逐一构造器
//所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性。新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中

let vga = Resolution(width : 640, height : 480)
print("分辨率宽度和高度：\(vga.width) \(vga.height)")

//与结构体不同， 类实例没有么默认的成员逐一构造器；***

//6.结构体和枚举都是值类型
//6.1、值类型被赋予给变量、常量 或者被传递给一个函数的时候，其值会被拷贝。
//在之前的章节中，我们已经大量使用了 值类型。实际上。所有的基本类型：整数（integer） 浮点数（float）布尔值（bool），字符串（String）数组（array）字典（dictionary）都是值类型，并且在底层都是以结构体的形式所实现。
//在Swift 中所有的结构体类型 和 枚举类型 都是 值类型。意味着他们的实例， 及实例中包含的任何值类型属性，在代码中传递的时候都会被复制；
let hd = Resolution(width : 1920 , height : 1080)
var cinema = hd
//解释：声明一个名为 hd  的常量， 其值为一个初始化为全高清视频分辨率 1920 X 1080 的 Resolution 实例 然后有声名了一个变量为 cinema 的值其实是 hd 的拷贝副本， 而不是hd本身，尽管hd 和 cinema 有着相同的高度，宽度，但是在幕后他们完全不是两个相同的实例
cinema.width = 2000
print("cinema is now \(cinema.width) 像素宽")

print("hd is still \(hd.width) 像素宽")

//在将hd赋予给cinema的时候，实际上是将hd中所存储的值进行拷贝，然后将拷贝的数据存储到新的cinema实例中。结果就是两个完全独立的实例碰巧包含有相同的数值。由于两者相互独立，因此将cinema的width修改为2048并不会影响hd中的width的值。
//枚举也遵循相同的行为准则
enum CompassPoint {
    
    case North, South, East, West
}

var currentDirection = CompassPoint.West

let rememberedDirection = currentDirection

currentDirection = .East

if rememberedDirection == .West {
    print("The remember direction is  still .West")
}

//上例中rememberedDirection被赋予了currentDirection的值，实际上它被赋予的是值的一个拷贝。赋值过程结束后再修改currentDirection的值并不影响rememberedDirection所储存的原始值的拷贝。

//7.类是引用类型
//与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，引用的是已经存在的实例本身而不是其拷贝

let tenEighty = ViedoMoel()

tenEighty.resolution = hd

tenEighty.interlaced = true

tenEighty.name = "100086"

tenEighty.frameRate = 25.0

//解释：声明了一个tenEighty 的常量，其引用了一个 videoMode 类的新实例， 在这之前的实例中 这个视频模式（video Mode）被赋予了 HD 分辨率为 （1920 * 1080）的一个拷贝hd 。同时设置为interlaced 命名“10086”，最后帧率25.0 帧 每秒；
// 然后 将 tenEighty 赋予给 alsoTenEighty 的新常量。同时对 alsoTenEighty 的帧率修改
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

//因为是类 是引用类型， 所以tenEighty 和 alsoTenEighty 实际上引用的是相同的VideoMode实例 他们是同一个实例的两种叫法
//通过查看 tenEighty 的 frameRate 属性，我们会发现他会正确的显示了引用的 videoMode 实例的新帧率其值：30.0
print("The frameeRate property of tenEighty is now \(tenEighty.frameRate)")
//MARK:需要注意的是tenEighty和alsoTenEighty被声明为常量而不是变量。然而你依然可以改变tenEighty.frameRate和alsoTenEighty.frameRate，因为tenEighty和alsoTenEighty这两个常量的值并未改变。它们并不“存储”这个VideoMode实例，而仅仅是对VideoMode实例的引用。所以，改变的是被引用的VideoMode的frameRate属性，而不是引用VideoMode的常量的值。

//8.恒等运算符。
//1、因为类 是引用类型，有可能有多个常量和变量在幕后引用同一个类实例，（对于结构体和枚举来说，这并不成立。因为它们作为值类型，在被赋予到常量、变量或者传递到函数时，其值总是会被拷贝。）

//如果能够判断两个常量 或变量是否引用了同一个类实例将会很有帮组，为了达到这个目的 Swift 建立了两个恒等运算符：
//：·等价于（===） ·不等价于（!==）

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
}
//请注意，“等价于”（用三个等号表示，===）与“等于”（用两个等号表示，==）的不同：

//“等价于”表示两个类类型（class type）的常量或者变量引用同一个类实例。
//“等于”表示两个实例的值“相等”或“相同”，判定时要遵照设计者定义的评判标准，因此相对于“相等”来说，这是一种更加合适的叫法。

//9.指针
//如果你有 C，C++ 或者 Objective-C 语言的经验，那么你也许会知道这些语言使用指针来引用内存中的地址。一个引用某个引用类型实例的 Swift 常量或者变量，与 C 语言中的指针类似，但是并不直接指向某个内存地址，也不要求你使用星号（*）来表明你在创建一个引用。Swift 中的这些引用与其它的常量或变量的定义方式相同。
//10.类和结构体的选择\
/*
 
 类和结构体的选择
 
 在你的代码中，你可以使用类和结构体来定义你的自定义数据类型。
 
 然而，结构体实例总是通过值传递，类实例总是通过引用传递。这意味两者适用不同的任务。当你在考虑一个工程项目的数据结构和功能的时候，你需要决定每个数据结构是定义成类还是结构体。
 
 按照通用的准则，当符合一条或多条以下条件时，请考虑构建结构体：
 
 该数据结构的主要目的是用来封装少量相关简单数据值。
 有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。
 该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
 该数据结构不需要去继承另一个既有类型的属性或者行为。
 
 举例来说，以下情境中适合使用结构体：
 
 几何形状的大小，封装一个width属性和height属性，两者均为Double类型。
 一定范围内的路径，封装一个start属性和length属性，两者均为Int类型。
 三维坐标系内一点，封装x，y和z属性，三者均为Double类型。
 
 在所有其它案例中，定义一个类，生成一个它的实例，并通过引用来管理和传递。实际中，这意味着绝大部分的自定义数据构造都应该是类，而非结构体。
 
 */

//11、字符串、数组、字典类型的赋值与复制行为
/*
 字符串、数组、和字典类型的赋值与复制行为
 
 Swift 中，许多基本类型，诸如String，Array和Dictionary类型均以结构体的形式实现。这意味着被赋值给新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝。
 
 Objective-C 中NSString，NSArray和NSDictionary类型均以类的形式实现，而并非结构体。它们在被赋值或者被传入函数或方法时，不会发生值拷贝，而是传递现有实例的引用。
 
 注意
 以上是对字符串、数组、字典的“拷贝”行为的描述。在你的代码中，拷贝行为看起来似乎总会发生。然而，Swift 在幕后只在绝对必要时才执行实际的拷贝。Swift 管理所有的值拷贝以确保性能最优化，所以你没必要去回避赋值来保证性能最优化。
*/
