//: Playground - noun: a place where people can play

import UIKit

var str = "自动引用计数"

/*
 
 自动引用计数的工作机制
 自动引用计数实践
 类实例之间的循环强引用
 解决实例之间的循环强引用
 闭包引起的循环强引用
 解决闭包引起的循环强引用

 */

/*
 
 自动引用计数的工作机制
 
 当你每次创建一个类的新的实例的时候，ARC 会分配一块内存来储存该实例信息。内存中会包含实例的类型信息，以及这个实例所有相关的存储型属性的值。
 
 此外，当实例不再被使用时，ARC 释放实例所占用的内存，并让释放的内存能挪作他用。这确保了不再被使用的实例，不会一直占用内存空间。
 
 然而，当 ARC 收回和释放了正在被使用中的实例，该实例的属性和方法将不能再被访问和调用。实际上，如果你试图访问这个实例，你的应用程序很可能会崩溃。
 
 为了确保使用中的实例不会被销毁，ARC 会跟踪和计算每一个实例正在被多少属性，常量和变量所引用。哪怕实例的引用数为1，ARC都不会销毁这个实例。
 
 为了使上述成为可能，无论你将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。之所以称之为“强”引用，是因为它会将实例牢牢地保持住，只要强引用还在，实例是不允许被销毁的。
 
 */

//自动引用计数实践
//例子
class Person {
    
    let name : String
    init(name : String) {
        self.name = name
        print("\(self.name) is being initialized")
    }
    
    deinit {
        print("\(self.name) is being  deinitalized")
    }
}

//Person 类有一个构造函数， 此构造函数为实例的 name 属性赋值， 并打印一条消息标明初始化过程生效。 Person 类也拥有一个析构器，这个析构函数会在实例被销毁是打印一条消息
//接下来的代码片段定义了三个类型为person？ 的变量， 为新的Person实例建立多个引用。由于这些变量是被定义为可选类型Person？ 而不是Person 它们的值会自动被初始化为nil 目前还不会被引用到Person 类的实例。

var reference1 : Person?
var reference2 : Person?
var reference3 : Person?

//创建 Person 类的新实例， 并且将它赋值给三个变量中的一个
reference1 = Person(name : "Joh APPleseed")//当调用Person类的构造函数的时候，Joh APPleseed is being initialized 被打印出来， 由此可以确定构造函数被执行。

//由于 Person 类的新实例被复制给 reference1 变量， 所以reference1到Person类型的新实例之间建立了一个强引用。正是这个强引用， ARC会保证Person 实例保持在内存中不被销户。
//如果将同一个 Person 实例也赋值给其他两个变量， 该实例又会多出两个强引用：
reference2 = reference1
reference3 = reference1

//现在这个 Person 实例已经有三个强引用了。如果通过给其中两个变量赋值nil的方式来断开连个强引用（包含最先的那个请引用），只留下一个强引用， Person实例不会被销毁。
reference1 = nil
reference2 = nil
//reference3 = nil
//再清楚标明不在使用这个Person 实例时， 即第三个也是最后一个强引用被断开时， ARC会销毁它
reference3 = nil

//2、类实例之间的循环强引用
//如果两个类实例都相互持有对方的强引用， 因而每个实例都让对方一直存在， 这种情况就是所谓的循环强引用。
//可以通过定义类之间的关系为弱引用或为无主引用， 以代替强引用， 从而解决循环引用的问题。

//例子：展示一个不经意间产生强循环引用的例子， 例子建立两个类： NewPerson 和 Apartmet， 用来建模公寓和其中的居民
class NewPerson {
    
    let name : String
    init(name : String) {
        self.name = name
    }
    var apartment : Apartment?
    
    deinit {
        print("\(name) 正在被销毁。。。")
    }
    
}

class Apartment {
    
    let unit : String
    init(unit : String) {
        self.unit = unit
    }
    
    var tenat : NewPerson?
    
    deinit {
        print("\(unit)正在被销毁。。。");
    }
    
}

//解释：每tenant 个NewPerson 实例都有一个类型为String 名字为name的属性， 并且一个可选的初始化为nil的apartment属性， apartment 属性是可选的，因为一个人并不是总是拥有公寓。每个Apartment 实例都有一个叫 unit 类型为String 的属性， 并且有一个可选的初始化为nil tenant 属性。 tenant 属性是可选的， 一栋公寓并不是总是有居民。
//这两个类都定义了析构函数， 用以在类实例被析构的时候输出信息。 让你能够知晓 NewPerson， Apartment 的实例是否像预期的哪像被销毁。
//接下来的代码片段定义了两个可选类型的变量john和unit4A，并分别被设定为下面的Apartment和Person的实例。这两个变量都被初始化为nil，这正是可选类型的优点：
var john : NewPerson?
var unit4A : Apartment?

//现在创建特定的NewPerson 和 Apartment 实例并将其赋值给John 和Unit4A变量
john = NewPerson(name : "MaYun")
print(john!.name, john!.apartment)
unit4A = Apartment(unit : "4A")
print(unit4A!.unit, unit4A!.tenat)

//现在将这个连个实例关联在一起， 这样人就能有公寓， 公寓里也有人了
john!.apartment = unit4A
unit4A!.tenat = john
print(john!.name, john!.apartment)
print(unit4A!.unit, unit4A!.tenat)


//不幸的是，这两个实例关联后会产生一个循环强引用。Person实例现在有了一个指向Apartment实例的强引用，而Apartment实例也有了一个指向Person实例的强引用。因此，当你断开john和unit4A变量所持有的强引用时，引用计数并不会降为0，实例也不会被 ARC 销毁：
john = nil
unit4A = nil

//****注意****，当你把这两个变量设为nil时，没有任何一个析构函数被调用。循环强引用会一直阻止Person和Apartment类实例的销毁，这就在你的应用程序中造成了内存泄漏。
//Person和Apartment实例之间的强引用关系保留了下来并且不会被断开。


//解决实例之间的循环强引用
//Swift提供了两种办法来解决你在使用类的属性时所遇到的循环强引用问题：弱引用（weak reference） 和 （unowned  reference）

//弱引用和无主循环引用允许循环引用中的一个实例引用另外一个实例而 不保持强引用。这样实例能能够相互引用而不产生循环强引用。
//当其他的实例有更短的生命周期时，使用弱引用，也就是说，当其他实例析构在先时。在上面公寓的例子中，很显然一个公寓在它的生命周期内会在某个时间段没有它的主人，所以一个弱引用就加在公寓类里面，避免循环引用。相比之下，当其他实例有相同的或者更长生命周期时，请使用无主引用。

//弱引用
//弱引用不会对其引用的实例保持请引用， 因而不会阻止ARC 销毁被引用的实例。这个特性阻止类引用变为循环强引用。 声明属性或者变量时， 在前面加上weak关键字表明这是一个弱引用。因为弱引用不会保持所引用的额实例， 即使引用存在，实例也有可能被销毁。因此，ARC 会在引用的实例被销毁后自动将其赋值为nil。并且因为弱引用可以允许它们的值在运行时被赋值为nil，所以它们会被定义为可选类型变量，而不是常量。

class AnotherPerson {
    
    let name : String
    init(name : String) {
        self.name = name
    }
    
    var apartment : AnotherApartment?
    
    deinit {
        print("\(name) 正在被销毁。。。")
    }
    
    
}


class AnotherApartment {
    
    let unit : String
    init(unit : String) {
        self.unit = unit
    }
    
    weak var tenant : AnotherPerson?
    
    deinit {
        print("公寓\(unit) 正在被销毁。。。")
    }
    
}

var hanMei : AnotherPerson?
var unitLianTou : AnotherApartment?

hanMei = AnotherPerson(name : "HanMei")
unitLianTou = AnotherApartment(unit : "LianTou")

hanMei!.apartment = unitLianTou
unitLianTou!.tenant = hanMei

//AnotherPerson 实例依然保持对 AnotherApartment实例的强引用， 但是 AnotherApartment 实例 只是持有对 AnotherPerson 实例的弱引用， 这意味着当你断开 HanMei 变量保持的强引用时，再也没有指向 AnotherPerson 的强引用了。
hanMei = nil
//由于没有指向AnotherPerson实例的强引用 该实例会被销毁。
//唯一剩下的指向AnotherApartment 实例的强引用来自变量unitLianTou，如果断开这个强引用 就再也没有指向AnotherApartment 实例的强引用了，这个实例也会被销毁释放内存
unitLianTou = nil

//无主引用
//和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用在其他实例有相同或者更长的生命周期时使用。你可以在声明属性或者变量时，在前面加上关键字unowned表示这是一个无主引用。
//无主引用通常都被期望拥有值。不过ARC无法在实例被销毁后将无主引用设置nil，  因为非可选类型的变量不允许不赋值为 nil
//重要
//使用无主引用，你必须确保引用始终指向一个未销毁的实例。
//如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。
//下面的例子定义了两个类：Customer 和 CreditCard 模拟了银行客户和客户的信用卡。这俩个类中， 每一个都将另外一个类的实例作为资深的属性。 这种关系可能会造成循环强引用。
//这个模型中， 一个客户可能有或者没有信用卡， 但是一张信用卡总是关联着一个客户，为了标明这种关系， Customer 类有一个可选的类型card 属性， 但是 CarditCard 类有一个非可选类型的 customer 属性。

class Customer {
    
    let name : String
    var card : CreditCard?
    init(name :String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 正在被销毁。。。")
    }
    
    
}

class CreditCard {
    
    let number :  UInt64
    
    unowned let customer : Customer
    
    init(number : UInt64, customer : Customer) {
        
        self.number = number
        self.customer = customer
    }
    
    deinit {
        print("Card#\(number)正在被销毁")
    }
    
}

//注意 CreditCard类的number属性被定义为UInt64类型而不是Int类型，以确保number属性的存储量在 32 位和 64 位系统上都能足够容纳 16 位的卡号。


var xiaoMing : Customer?//创建一个叫 xiaoMing 的可选类型Customer变量用来保存某个特定用户引用。 由于是可选类型， 所以变量被初始化为nil
xiaoMing = Customer(name : "xiaoMing")
xiaoMing!.card = CreditCard(number : 1234_5678_9012_3456, customer : xiaoMing!)

//Customer 实例持有对 CreditCard 实例的强引用 而 CreditCard 持有对 Customer 实例的无主引用。
//当你断开 xiaoMing 变量持有的强引用时， 就再也没有指向 Customer 实例的强引用了。Customer 实例销毁。Customer销毁后 也不会在持有对 CreditCard实例的强引用，也就没有指向 CreditCard 实例的强引用， 该实例也随之被销毁；
xiaoMing = nil
//xiaoMing 正在被销毁。。。
//Card#1234567890123456正在被销毁


//8.无主引用及隐式解析可选属性
//上面弱引用和无主引用的例子涵盖类两种常见的需要打破循环强引用的场景。
//Person 和 Apartment 的例子展示了两个属性的值都允许为nil， 并且潜在的产生循环强引用。这种场景最适合用弱引用来解决。
//Customer 和 CreditCard 的例子展示了一个属性值的允许为nil， 而另一个属性值不允许为nil 这可能产生循环引用， 这种场景最适合通过无主引用来解决。

//然而存在第三种场景， 在这种场景中， 两个属性值都必须有值， 并且初始化完成后永远不许为nil。这种场景中 需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。
//这两个属性在初始化完成后能被直接访问（不需要可选展开）， 同时避免了循环引用， 
//下面例子定义了两个类， Country 和 City 每个类将另外一个类的实例保存为属性。在这个模型中， 每个国家必须都有首都， 每个城市必须属于一个国家。为了实现这种关系， Country类拥有一个 CapitalCity 属性， 而City类 有一个Country属性
class Country {
    
    let name : String
    var capital : City!
    init(name : String, capitalName : String) {
        
        self.name = name;
        self.capital = City(name : capitalName, country : self)
    }
    
}

class City {
    
    let name : String
    unowned let country : Country
    init(name : String , country : Country) {
        self.name = name
        self.country = country
    }
    
}

//为了建立连个类的依赖关系， City的构造函数接受一个 Country实例作为参数并且将实例保存在country属性中。
//Country 的构造器调用类City的构造函数， 然而， 只有Country的实例完全初始化后， Country的构造函数才能把self 传给City的构造函数。
//为了满足这总需求， 通过在类型的结尾处加上感叹号（City！）方式， 将Country的capital 属性声明为隐式解析可选类型的属性， 这意味着向其他可选类型一样， capital 实行默认为nil， 但是不需要展开他的值就能访问它。

//由于capital 默认值为nil， 一旦Country的实例在构造函数中给name属性赋值后，整个初始化过程就完成了。这意味着 一旦name属性被赋值后， Country的构造函数就能引用并且传递隐式的self。Country的构造器在赋值capital时， 就能将self 作为参数传递给City的构造器。
//以上的意义在于可以通过一条语句同时创建Country 和 City 的实例， 而不产生循环强引用， 并且capital 的属性能不直接访问， 而不需要通过感叹符号来展开它的可选值

var country = Country(name : "中国", capitalName : "北京")
print("\(country.name)的首都是:\(country.capital.name)")

//在上面的例子中，使用隐式解析可选值意味着满足了类的构造函数的两个构造阶段的要求。capitalCity属性在初始化完成后，能像非可选值一样使用和存取，同时还避免了循环强引用。

//9、闭包引起的循环强引用。
//前面循环强引用都是在两个类实例属性相互保持对方的强引用产生的，而且还知道如何用弱引用和无主引用来打破这些循环强引用。
//循环强引用还会发生在将一个闭包赋值给类实例的某个属性，并且这个闭包体中有使用了这个类实例时。这个闭包体中可能访问了实例中的某个属性， 例如self.someProperty 或者闭包中调用了实例的某个方法， 例如self.method().这两种情况导致了闭包 捕获 self 从而产生了循环强引用。
//循环强引用的产生，因为闭包和类类似， 都是引用类型。当你把一个闭包赋值给某个属性时， 是将这个闭包的引用赋值给了属性。实质上，这跟之前的问题是一样的 -- 两个强引用彼此一直有效。但是和两个类实例不同， 这次是一个类实例 和 闭包。
//Swift 提供了一种优雅的方法来解决这个问题， 称之为 ： 闭包捕获列表 。 同样的， 在学习如何用闭包捕获列表打破循环强引用之前，先来了解这里的循环强引用是怎么产生。
//下面例子为你展示当一个闭包引用了 self后是如何产生一个循环强引用的。例子中定义了一个叫 HTMLElement 的类，用这种简单的模型表示HTML文档中的单独的元素

class HTMLElement {
    
    let name : String
    let text : String?//text可能为nil 这里默认初始化为nil
    
    lazy var asHTML : (Void) -> String = {
        
        if let text = self.text {
            
            return "<\(self.name)>\(text)</\(self.name)>"
            
        }else{
            
            return "<\(self.name) />"
        }
    }
    
    init(name : String, text : String? = nil) {
        self.name = name
        self.text = text
    }
    
    
    deinit {
        print("\(name) 正在销毁中。。。")
    }
    
}

//HTMLElement类定义了一个name属性来表示这个元素的名称，例如代表头部元素的"h1"，代表段落的“p”，或者代表换行的“br”。HTMLElement还定义了一个可选属性text，用来设置 HTML 元素呈现的文本。
//HTML 还定义了一个 lazy 属性 asHTML 这个属性引用了一个将 name 和 text 组合成HTML字符串片段的闭包， 该属性是 Void -> String 类型， 或者可以理解为在：一个没有参数返回值String 类型的函数。
//默认情况下，闭包赋值给了 asHTML 属性， 这个闭包返回一个代表HTML标签的字符串。 如果 text 值存在， 该标签就包含可选值 text ；如果 text 不存在， 该标签就不包含文本，例如段落元素， 根据text是“some text”还是nil，闭包会返回"<p>some text</p>"或者"<p />"。
//可以向实例方法那样去命名、使用asHTML属性， 然而，由于asHTML 是闭包而不是 实例方法， 如果你想改变特定HTML元素的处理方式的话， 可以用自定义的闭包来取代默认值。
//例如，可以将一个闭包赋值给asHTML属性，这个闭包能在text属性是nil时使用默认文本，这是为了避免返回一个空的 HTML 标签：

let heading = HTMLElement(name : "h1")
let defaultText = "some default text"

heading.asHTML = {
    
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}

print(heading.asHTML())

//注意:asHTML声明为lazy属性，因为只有当元素确实需要被处理为 HTML 输出的字符串时，才需要使用asHTML。也就是说，在默认的闭包中可以使用self，因为只有当初始化完成以及self确实存在后，才能访问lazy属性。

var paragraph : HTMLElement? = HTMLElement(name : "p", text : "hello world")

print(paragraph!.asHTML())
//注意:上面的paragraph变量定义为可选类型的HTMLElement，因此我们可以赋值nil给它来演示循环强引用。
//不幸的是，上面写的HTMLElement类产生了类实例和作为asHTML默认值的闭包之间的循环强引用。循环强引用如下图所示：
//https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Art/closureReferenceCycle01_2x.png

//实例的asHTML 属性持有闭包的强引用。闭包在闭包体内使用了self（引用self.name, self.text）因此闭包捕获了 self 这意味着闭包持有了 HTMLElement 实例的强引用。这样就产生了循环强引用
//注意：虽然闭包多次使用了self， 但它只捕获HTMLElement 实例的一个强引用。
//如果设置 paragraph 变量为nil， 打破它持有的HTMLElement 实例的强引用， HTMLElement 实例和他的闭包不会被销毁， 也是因为循环强引用：
paragraph = nil
//HTMLElement 的析构函数中的消息没有被打印， 证明HTMLElement 实例并没有被销毁。

//9.2、解决闭包引起的循环强引用
//在定义闭包的同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。捕获列表定义了闭包体内捕获一个或多个引用类型的规则。声明每个捕获的引用为弱引用或是无主引用，而不是强引用。应当根据代码关系来确定是弱引用还是无主引用。
//注意：Swift 有如下要求：只要在闭包中使用self的成员， 就要用self.someProperty或者self.someMethod() 这提醒你可能会一不小心就捕获了self

//9.3定义捕获列表
//捕获列表中的每一项都由一对元素组成，一个元素是weak或unowned 关键字， 另一个元素是类实例的引用（例如self）或初始化过的变量（delegate = self.delegate!）这些项在方括号总用逗号隔开。
//如果闭包有参数和返回类型， 把捕获列表放在他们前面
/*
 
 lazy var someClosure : (Int, String) -> String = {
 
 [unowned self, weak delegate = self.delegate!](index : Int, stringToProcess : String) -> String in
 
 //这里是函数体部分
 
 }
 
 //如果闭包没有指明参数列表或返回类型， 即会通过上下文推断， Name可以把捕获列表和关键字 in放在闭包最开始的地方
 lazy var someClosure : Void -> String = {
 
 [unowned self, weak delegate = self.delegate!] in
 
 }
 
 
 
 */

//闭包的弱引用和无主引用
//在闭包和捕获的实例总是相互引用总是同时销毁时，将闭包内的捕获定义为 无主应用；相反的，在捕获的引用可能会变为nil时， 将闭包内的捕获定义为 弱引用。弱引用总是可选类型， 并且当引用的实例被销毁后， 弱引用的值自动置为nil。这是我们在闭包体内检查他们是否存在。
//如果捕获的引用绝对不是nil 应该使用无主引用，而不是弱引用。

class NewHTMLElement {
    
    let name : String
    let text : String?//text可能为nil 这里默认初始化为nil
    
    lazy var asHTML : (Void) -> String = {
        
        [unowned self] in //将self捕获成无主引用， 防止发生循环引用。
        
        if let text = self.text {
            
            return "<\(self.name)>\(text)</\(self.name)>"
            
        }else{
            
            return "<\(self.name) />"
        }
    }
    
    init(name : String, text : String? = nil) {
        self.name = name
        self.text = text
    }
    
    
    deinit {
        print("\(name) 正在销毁中。。。")
    }
    
}

//上面的HTMLElement实现和之前的实现一致，除了在asHTML闭包中多了一个捕获列表。这里，捕获列表是[unowned self]，表示“将self捕获为无主引用而不是强引用”。
var newParagraph : NewHTMLElement? = NewHTMLElement(name : "p", text : "北京天安门")
print(newParagraph!.asHTML())

//这一次，闭包以无主引用的形式捕获self，并不会持有NewHTMLElement实例的强引用。如果将paragraph赋值为nil，HTMLElement实例将会被销毁，并能看到它的析构函数打印出的消息：
//https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Art/closureReferenceCycle02_2x.png

newParagraph = nil
//会打印 p 正在销毁。。。

