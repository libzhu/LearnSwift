//: Playground - noun: a place where people can play

import UIKit

var str = "类型转换"

/*
 
· 定义一个类层次作为例子
· 检查类型
· 向下转型
· Any 和 AnyObject 的类型转换
 
 */

//类型转换可以判断实例的类型，也可以将实例看做是其父类或子类的实例。
//类型转换在Swift 中使用 is 和 as 操作符实现。这两个操作符提供了一种简单的方式去检查值的类型或者转换它的类型。

//定义一个类层次作为例子
//可以将类型转换用在类和子类的层次结构上，检查特定类实例的类型并且转化这个类型实例的类型成为这个层次结构中的其他类型。下面的三个代码定义了一个类层次和一个包含了这些类实例的数组，作为类型转换的例子。
//第一个代码段定义了一个新的基类MediaItem 。这个类为任何现在数字媒体库的媒体项提供基础功能。特别的 它声明一个 String 类型的name 属性， 和一个init(name:)构造器

class MediaName {
    
    var name : String
    init(name : String) {
        self.name = name
    }
    
}

//下一个代码定义了 MediaName 两个子类。第一个子类Movie 封装了与电影相关的额外信息，在父类的基础上增加了一个 director 属性， 和相应的初始化器。 第二个子类 Song 在父类的基础上增加了一个 artist 属性 和相应的初始化器。

class Movie : MediaName {
    
    var director : String
    init(name : String, director : String) {
        self.director = director
        super.init(name: name)
    }
    
}

class Song : MediaName {
    
    var artist : String
    init(name : String, artist : String) {
        self.artist = artist
        super.init(name: name)
    }
    
}


//最后一个一个代码创建了一个数组常量 library 包含两个Movie 实例和三个Song实例。 library的类型是在它被初始化时根据数组中所包含的内容推断来的。Swift的类型检测器能够推断出 Movie 和 Song有共同的父类 MediaItem， 所以它推断出 【MediaItem】类作为 library 的类型

let library = [Movie(name : "中国合伙人", director : "老毛"), Movie(name : "色戒", director : "李安"), Song(name : "中国人", artist : "刘德华"), Song(name : "龙的传人", artist : "刘德华")]
// 数组 library 的类型被推断为 [MediaItem]
//在幕后 library 里存储的媒体项依然是 Movie 和 Song 类型， 但是，若你 迭代它， 依次取出的实例会是 MediaItem 类型的。  而不是Movie 和 Song 类型。为了 让它们作为原本的类型工作， 需要检查它们的类型或是向下转换它们到其他类型， 

//检查类型
//用类型检查符 is 来检查一个实例是否属于特定子类。如实例属于那个子类型， 类型检查操作符返回 true 否则返回 false
//下面的例子定义了两个变量， movieCount 和 songCount 用来计算数组 library 中 Movie 和 Song类型的实例数量。

var movieCount = 0
var songCount = 0

for item in library {
    
    if item is Movie {
        
        movieCount += 1
        
    }else if item is Song {
        
        songCount += 1
    }
}

print("Media 类型数组library中\(movieCount) movies and \(songCount) songs")

//向下转型
//某类型的一个常量或变量可能在某后实际上属于个子类。当确定这种情况时， 可以尝试向下转到它的子类型， 用类型转换操作符（as？ 或 as!）因为向下转型可能会失败， 类型转换操作符带有两种不同形式。条件形式as？返回一个试图向下转成的类型的可选值。 强制形式 as! 把视图向下转型和强制解包（转换结果结合为一个操作）。
//当你不确定向下转型可以成功时， 用类型转换的条件形式 as?  条件形式的类型转换总是返回一个可选值，并且若下转是不能能的，可选值将是nil 这使你你能够检查向下转型是否成功。
//当你确定向下转型一定会成功时， 才使用强制形式 as! 当你试图向下转型为一个不正确的类型时， 强制形式 的类型转换会触发一个运行时错误。
//下面例子，迭代了 library 里的每一 MediaItem 并打印出适当的描述。 要这样做， Item 需要真正作为Movie 或 Song 的类型来使用， 而不是作为MediaItem。 为了能够在描述在使用 Movie 和 Song 的direct 或 artist 属性 这是必要的。
//这个示例中 数组中的每一个 Item 可能是 Movie 或 Song  ，事前你不知道每个Item的真实类型，所以这里使用条件形式的类型转换 as? 去检查循环里的每次下转

for item in library {
    if let movie = item as? Movie {
        
        print("Move:\(movie.name) dir : \(movie.director)")
        
    }else if let song  = item as? Song {
        
        print("Song :\(song.name) art :\(song.artist)")
    }
}

//示例首先试图将 item 下转为 Movie。因为 item 是一个 MediaItem 类型的实例，它可能是一个 Movie；同样，它也可能是一个 Song，或者仅仅是基类 MediaItem。因为不确定，as? 形式在试图下转时将返回一个可选值。item as? Movie 的返回值是 Movie? 或者说“可选 Movie”。

//当向下转型为 Movie 应用在两个 Song 实例时将会失败。为了处理这种情况，上面的例子使用了可选绑定（optional binding）来检查可选 Movie 真的包含一个值（这个是为了判断下转是否成功。）可选绑定是这样写的“if let movie = item as? Movie”，可以这样解读：

//“尝试将 item 转为 Movie 类型。若成功，设置一个新的临时常量 movie 来存储返回的可选 Movie 中的值”

//若向下转型成功，然后 movie 的属性将用于打印一个 Movie 实例的描述，包括它的导演的名字 director。相似的原理被用来检测 Song 实例，当 Song 被找到时则打印它的描述（包含 artist 的名字）。

//注意
//转换没有真的改变实例或它的值。根本的实例保持不变；只是简单地把它作为它被转换成的类型来使用。

//Any 和 AnyObject 的类型转换
//Swift 为不确定类型提供两种特殊的类型别名：
//· Any 可以表示任何类型 包括函数类型   · AnyObject 可以表示任何类型的实例。
//只有当你确定需要他们的行为和功能时才使用 Any 和 AnyObject 。在你的代码中使用你期望的明确类型总是最好的

//示例： 使用Any 类型 来 混合不同类型一起工作， 包括函数类型和非类类型，创建一个可以存储 Any 类型的数组 things

var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.141596253)
things.append(3.14)
things.append("hello")
things.append((3.0, 4.0, 5.0))
things.append(Movie(name : "鬼吹灯", director : "黄渤"))
things.append({(name : String) -> String in name})

//things 数组包含两个 Int 值，两个 Double 值，一个 String 值，一个元组 (Double, Double)，一个Movie实例“Ghostbusters”，以及一个接受 String 值并返回另一个 String 值的闭包表达式。
//可以在 switch 表达式的 case 中使用 is 和 as 操作符来找出只知道是 Any 或 AnyObject 类型的常量或变量的具体类型。下面的示例迭代 things 数组中的每一项，并用 switch 语句查找每一项的类型。有几个 switch 语句的 case 绑定它们匹配到的值到一个指定类型的常量，从而可以打印这些值：

for thing in things {
    
    print("--->\(thing)")
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a double")
    case let someInt as Int:
        print("an Integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double Value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string valhe of \"\(someString)\"")
    case let (x, y, z) as (Double, Double, Double):
        print("空间（x, y, z）点在 (\(x), \(y), \(z))")
    case let movie as Movie:
        print("a movie called :\(movie.name), 导演：\(movie.director)")
    case let stringConverter as (String) -> String:
        
        print(stringConverter("Michael"))
        
    default:
        print("something else")
    }
}

//注意：Any类型可以表示所有类型的值， 包括可选类型，Swift会在 Any类型表示一个可选值的时候给一个警告。 如果你确定想使用Any类型来承载可选值 可以使用 as 操作符显示转换为Any

let optionalNumber : Int? = 3

things.append(optionalNumber)

things.append(optionalNumber as Any)























