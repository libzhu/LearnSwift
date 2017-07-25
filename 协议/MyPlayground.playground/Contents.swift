//: Playground - noun: a place where people can play

import UIKit

var str = "协议"

/*
 内容：
 
 协议语法
 属性要求
 方法要求（Method Requirements）
 Mutating 方法要求
 构造器要求
 协议作为类型
 委托（代理）模式
 通过扩展添加协议一致性
 通过扩展遵循协议
 协议类型的集合
 协议的继承
 类类型专属协议
 协议合成
 检查协议一致性
 可选的协议要求
 协议扩展

 
 */
//协议定义乐一个蓝图， 规定了用来实现某一特定任务或者功能的方法、属性，以及其他需要的东西， 类、结构体或枚举都可以遵循协议， 并为协议定义的这些要求提供具体的实现，某个类型能够满足某个协议的要求， 可以说是该类型遵循这个协议。
//除了遵循协议的类型必须实现的要求外， 还可以对协议进行扩展， 通过扩展协议来实现一部分要求或者实现以一些附加功能， 这样遵循协议的类型就能够使用这些功能。

//协议语法
//协议的定义方式与类、结构体和枚举的定义非常相似

protocol SomeProtocol {
    
    //这里是协议的定义部分
}

protocol AnotherProtocol {
    
    //这是另一个协议的内容
}

//要让自定义类型遵循某个协议， 在定义类型时， 需要在类型名称后加上协议名称， 中间1️⃣冒号：分隔遵循多个协议时 个协议之间有逗号， 分隔。

struct  SomeStructture : SomeProtocol, AnotherProtocol {
    
    
}

//拥有父类的类遵循协议时， 应该将父类名放在协议名之前， 以逗号分隔开。
class SuperClass {
 
    
}

class SomeClass : SuperClass, SomeProtocol, AnotherProtocol {
    
    
}

//属性要求
//协议可以要求遵循协议的类型提供特定的名称和类型的实例属性或类型属性，协议不指定属性书存储属性还是计算属性。 它只指定属性的名称和类型。此外，协议还制定属性是可读还是可读可写的
//如果协议要求属性是可读可写的，那么属性就不能是常量属性或只读的计算属性，。如果协议只要求属性时可读的， 那么该属性不仅是可读的。如果代码需要的话， 还可以是可写的。
//协议总是用 var 关键字来声明变量属性， 在类型声明后加上{set get} 来表示属性是可读可写的。 可读属性用{get}来表示
protocol TestProtocol {
    
    var mustBeSettable : Int {get set}
    var doseNotNeedToBeSettable : Int  {get}
    
}
//协议中定义类型属性时， 总是使用 static 关键字作为前缀， 当类类型遵循协议时。除了static 关键字， 还可以使用 class 关键字来声明属性
protocol TestAnotherProtocol {
    
    static var someTypeProperty : Int {get set}
}

//一个只含有一个实例属性要求的协议
protocol FullyNamed {
    
    var fullName : String {get}
    
}
//FulllyNamed 协议除了要求遵循协议的类型提供fullName 属性外， 并没有其他特别的要求， 这个协议表示， 任何遵循 fullyNamed 的类型， 都必须有一个可读的 String  类型实例属性 fullName。
struct Person : FullyNamed {
    
    
    internal var fullName: String
    
    var fullNamed: String
    
}

let john = Person(fullName : "Bob Tip", fullNamed : "John Appleseed")

john.fullNamed
//这个例子定义了一个叫Person 的结构体， 用来表示一个具体名字的人， 它遵循了 FullyNamed 协议。
//Person 结构体的每一实例都要有一个 String 类型的存储属性 fullName。这正好满足了FullyNamed 协议的要求， 也就意味着 Person 结构体正确的符合了协议（如果这个协议未被完全满足 编译时会报错误）

class StarShips : FullyNamed {
    
    var prefix : String?
    var name : String
    
    init(name : String, prefix : String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        
        return (prefix != nil ? prefix! + " " : "") + name
    }
    

}

var ncc9527 = StarShips(name : "Enterprise", prefix : "USA")
print(ncc9527.fullName)


//StarShip 类 把 fullName属性实现为只读的计算属性。 每个 StarShips实例都有一个名为 name 的非可选属性和一个名为Prefix可选属性。当Prefix存在时，计算型属性 fullName 会将 prefix 插入到 name之前 从而为星际飞船构建一个全名


//方法要求
//协议可以要求遵循协议的类型实现某些指定的实例方法或类方法。这些方法作为协议的一部分， 像普通方法一样放在协议的定义中，但是不需要大括号和方法体。可以在协议中定义具体具有可变参数的方法， 和普通方法定义的方式相同， 但是，不支持为协议中的方法参数提供默认值。
//正如属性要求中所述，在协议中定义类方法的时候， 总是使用Static 关键字作为前缀。 当类类型遵循协议时， 除了 Static关键字， 还可以使用 class关键字 作为前缀。

protocol SomeTestProtocol {
    
    static func someTypeMethod()
}

//定义一个只含有一个实例方法的协议
protocol RandomNumberGenerator {
    
    func random() -> Double
    
}

//RandomNumberGenerator 协议要求遵循协议的类型必须拥有一个名为 random 返回值为Double 类型的实例方法， 尽管这里并未指明，但是我们假设返回值在【0.0， 1.0】区间内
//RandomNumberGenerator 洗衣并不关心每一个随机数是怎么产生的， 它只要求必须提供一个随机生成器。
//例子：下边一是一个遵循并符合 RandomNumberGenerator 协议的类， 该类实现了一个叫做 线性同余生成器 的伪随机算法。
class LinearCongruentialGenerator : RandomNumberGenerator {
    
    var lastRandom  = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 28473.0
    
    func random() -> Double {//对浮点数取余
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        
        return lastRandom / m
    }
    
}

let generator = LinearCongruentialGenerator()
generator.random()
generator.random()
generator.random()

//mutating 方法要求
//有时需要在方法中改变方法所属的实例，例如， 在值类型（即结构体和枚举）的实例方法中， 将mutating 关键字作为方法的前缀， 写在func 关键字前面， 表示可以在该方法中修改它所属的实例以及实例的任意属性值， 
//如果你在协议方法中定义了一个实例方法， 该方法会改变遵循协议的类型的实例，那么在定义协议时需要在需要在方法前面加上 mutating 关键字。 这使得结构体和枚举能够遵循此协议并满足此方法要求。
//实现协议中mutating 方法时， 如是类类型， 则不用写mutating关键字， 而对于对于结构体 和枚举 则必须写 mutating 关键字。
//例子： Togglable  协议只要求实现一个名为 toggle 的实例方法， 根据名称的暗示， toggle（）方法将改变实例属性，从而切换遵循该实例的实例状态。toggle（）方法在定义的时候， 使用 mutating 关键字标记， 这表明当它被调用时， 该方法会改变遵循协议的类型的实例。

protocol Togglable {
    
    mutating func toggle()
}

//当使用枚举或结构体来实现 Togglable 协议时， 需要提供带有mutating 前缀的 toggle（）方法。
//定义一个名为 OnOffSwitch 的枚举。 这个枚举在两种状态之间切换， 用成员On Off 表示， 枚举的toggle()方法 被标记为 mutating 以满足 Togglable 协议的要求
enum OnOffSwitch : Togglable {
    
    case on, off
    mutating func toggle() {
     
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        
            
        }
        
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
lightSwitch.toggle()


//构造器要求
//协议可以要求遵循协议的类型实现指定的构造器。可以像编写普通构造器那样， 在协议的定义里写下构造器的声明， 但不需要写花括号和构造器的实体。
protocol SomeInitProtocol {
    
    init(someParameter : Int)
}

//构造器要求在类中的实现
//可以在遵循协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器，都必须为构造器实现表上 required 修饰符
class SomeInitClass : SomeInitProtocol {
    
    required init(someParameter: Int) {
        //这里是实现构造器的部分
    }
}

//使用 required 修饰符可以确保所有子类必须也提供此构造器实现， 从而也能符合协议  

//如果一个子类重写了父类的自定构造器，并且该构造器满足了某个协议要求，那么该构造器的实现需要同时标注 required 和 override 修饰符
protocol SomeOneProtocol {
    
    init()
}

class SomeSuperClass {
    
    init() {
        
        //这里是构造器的实现部分
        
    }
}

class SomeSubTestClass : SomeSuperClass, SomeOneProtocol {
    
    //因为遵循协议， 需要加上 required
    // 因为继承自父类， 需要加上 override
    
   required override init() {
    
    
    }
}

//可失败构造器要求
//协议可以为遵循的类型定义可选失败构造器要求。遵循协议的类型可以通过可选失败构造器 （init？）或者非可选 失败构造器（init）来满足协议中定义的可失败构造器要求。 协议中定义的非可失败构造器要求可以通过非可失败构造器（init）或隐式解包可选失败构造器（init！来满足）

//协议作为类型
//尽管协议本身并未实现任何功能， 但是协议可以被当做一个成熟的类型来使用
//协议可以像其他普通类型一样使用， 使用场景如下：
//· 作为函数、方法或者构造器中的参数类型或者返回值类型 · 作为常量、变量或者属性的类型  ·作为数组、字典或者其他容器中的元素类型。
//注意：协议是一种类型，因此协议类型的名称应与其他类型（例如：Int Double String ）的写法相同，可以使用大写字母开头的驼峰式写法
//下面是协议作为类型使用的例子
class Dice {
    let sides : Int
    let generator : RandomNumberGenerator

    init(sides : Int, generator : RandomNumberGenerator) {
        
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        
        return Int(generator.random() * Double(sides)) + 1
    }
    
}

//定义了一个 Dice 类，用来代表桌游中拥有N个面的骰子。Dice 的实例含有 sides 和 generator 两个属性，前者是整型， 用来表示骰子有几个面， 后者为骰子提供一个随机数生成器，从而生成随机点数。
//generator 属性的类型为 RandomNumberGenerator，因此任何遵循了RandomNumberGenerator协议的类型的实例都可以赋值给 generator 
//Dice 类 还有一个 构造器，用来是指初始状态。 构造器有一个名为 generator， 类型为RandomNumberGenerator 的形参， 在调用构造器创建 Dice 实例时， 可以传入任何衣蛾遵循RandomNumberGenerator 协议的实例给 generator

//Dice 提供了一个名为 roll 的实例方法， 用来模拟骰子的面子，它先调用generator 的 random（）方法生成一个【0.0， 1.0】的随机数，然后使用这个随机数生成骰子的面子。 因为 generator 遵循了RandomNumberGenerator协议， 可以确保有一个 random（）方法可以调用
//下面的例子展示了如何使用 LinearCongruentialGenerator 的实例作为随机数生成器来创建一个六面骰子：

var d6 = Dice(sides : 6, generator : LinearCongruentialGenerator())
for _ in 1...5 {
    
    print("Random dice roll is \(d6.roll())")
}

//委托（代理）模式
//委托是一种设计模式， 它允许类或结构体将一些需要他们负责的功能委托给其他类型的实例。委托模式的实现很简单： 定义协议来封装那些需要被委托的功能， 这样就能确保遵循协议的类型能提供这些功能。 委托模式可以用来相应特定的动作，或者接受外部数据源提供的数据， 而不关心外部数据源的类型。
//下面的例子定义了两个基于骰子游戏的协议

protocol DiceGame {
    
    var dice : Dice {get}
    func play()
}

protocol DiceGameDelegate {
    
    func gameDidStart(_ game : DiceGame)
    func game(_ game : DiceGame, didStartNewTurnWithDiceRoll  diceRoll : Int )
    func gameDidEnd(_ game : DiceGame)
}


//DiceGame 协议可以被任意涉及骰子的游戏遵循。DiceGameDelegate 协议可以被任意类型遵循，用来追踪 DiceGame 的游戏过程。

//如下所示，SnakesAndLadders 是 控制流 章节引入的蛇梯棋游戏的新版本。新版本使用 Dice 实例作为骰子，并且实现了 DiceGame 和 DiceGameDelegate 协议，后者用来记录游戏的过程：

class SnakesAndLadders : DiceGame {
    
    let finalSquare = 25
    var dice = Dice(sides : 6, generator : LinearCongruentialGenerator())
    var square = 0
    var board : [Int]

    
    init() {
        
        board =  [Int](repeating: 0, count: finalSquare + 1)
    
    
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02;
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    
    }
    
    var delegate : DiceGameDelegate?
    
    func play() {
        
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)

        
    }
    
}

//这个版本的游戏封装到了 SnakesAndLadders 类中，该类遵循了 DiceGame 协议，并且提供了相应的可读的 dice 属性和 play() 方法。（ dice 属性在构造之后就不再改变，且协议只要求 dice 为可读的，因此将 dice 声明为常量属性。）

//游戏使用 SnakesAndLadders 类的 init() 构造器来初始化游戏。所有的游戏逻辑被转移到了协议中的 play() 方法，play() 方法使用协议要求的 dice 属性提供骰子摇出的值。

//注意，delegate 并不是游戏的必备条件，因此 delegate 被定义为 DiceGameDelegate 类型的可选属性。因为 delegate 是可选值，因此会被自动赋予初始值 nil。随后，可以在游戏中为 delegate 设置适当的值。

//DicegameDelegate 协议提供了三个方法用来追踪游戏过程。这三个方法被放置于游戏的逻辑中，即 play() 方法内。分别在游戏开始时，新一轮开始时，以及游戏结束时被调用。

//因为 delegate 是一个 DiceGameDelegate 类型的可选属性，因此在 play() 方法中通过可选链式调用来调用它的方法。若 delegate 属性为 nil，则调用方法会优雅地失败，并不会产生错误。若 delegate 不为 nil，则方法能够被调用，并传递 SnakesAndLadders 实例作为参数。

//如下示例定义了 DiceGameTracker 类，它遵循了 DiceGameDelegate 协议：

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

//DiceGameTracker 实现了 DiceGameDelegate 协议要求的三个方法，用来记录游戏已经进行的轮数。当游戏开始时，numberOfTurns 属性被赋值为 0，然后在每新一轮中递增，游戏结束后，打印游戏的总轮数。

//gameDidStart(_:) 方法从 game 参数获取游戏信息并打印。game 参数是 DiceGame 类型而不是 SnakeAndLadders 类型，所以在gameDidStart(_:) 方法中只能访问 DiceGame 协议中的内容。当然了，SnakeAndLadders 的方法也可以在类型转换之后调用。在上例代码中，通过 is 操作符检查 game 是否为 SnakesAndLadders 类型的实例，如果是，则打印出相应的消息。

//无论当前进行的是何种游戏，由于 game 符合 DiceGame 协议，可以确保 game 含有 dice 属性。因此在 gameDidStart(_:) 方法中可以通过传入的 game 参数来访问 dice 属性，进而打印出 dice 的 sides 属性的值。

//DiceGameTracker 的运行情况如下所示：

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()
// Started a new game of Snakes and Ladders
// The game is using a 6-sided dice
// Rolled a 3
// Rolled a 5
// Rolled a 4
// Rolled a 5
// The game lasted for 4 turns


//通过扩展添加协议的一致性
//即使无法修改源代码，依然可以通过扩展令已有类型遵循并符合协议。扩展可以为已有类型添加属性、方法、下标以及构造器。因此可以符合协议中的相应要求。
//注意： 通过扩展令已有的类型遵循并符合协议时。该类型的所有实例也会随之获得协议中的各项功能。

//例如下面这个 TextTepresenttale 协议 任何想通过文本表示一些内容的类型都可以实现该协议。这些想要表示的内容可以是实例本身的描述， 也可以是实例当前状态的文本描述
protocol TextRepresentable {
    
    var textualDecription : String {get}
    
}

//通过扩展指令， 令先前提到的 Dice 类遵循并符合TextRepresentable协议

extension Dice : TextRepresentable {
    
    var textualDecription: String {
        
        return "A \(sides)-sided dice"
    }
}

//通过扩展并遵循符合协议，和在原始定义中遵循并符合协议效果是完全一样的。协议名写在类型名之后，以冒号隔开， 然后在扩展的大括号内实现协议要求的内容
//现在所有的 Dice 的实例都可以看做是 TextRepresentable 类型：

let d12 = Dice(sides : 12, generator : LinearCongruentialGenerator())
print(d12.textualDecription)

//同样的 SnakesAndLadders 类也可以通过扩展遵循并符合 TextRepresentable 协议

extension SnakesAndLadders : TextRepresentable {
    
    var textualDecription: String {
        
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

print(game.textualDecription)


//通过扩展遵循协议
//当一个类型已经符合了某个协议中的所有要求， 却还没有声明遵循该协议时，可以通过空扩展体的扩展来遵循该协议：
struct Hamster {
    
    var name : String
    var textualDecription: String {
        
        return "A hamster named \(name)"
    }
    
}

extension Hamster : TextRepresentable {}


let simonTheHamster = Hamster(name : "Simon")
print(simonTheHamster.textualDecription)
let somethingTextRepresentable : TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDecription)

//注意:即使满足了协议的所有要求，类型也不会自动遵循协议，必须显式地遵循协议。

//协议类型的集合
//协议类型可以在数组和字典这样的集合中使用， 在协议类型 提到了这样的用法。 下面的例子创建一个原酸类型为 TextRepresentable 的数组

let things : [TextRepresentable] = [game, d12, simonTheHamster]

for thing in things {
    
    print(thing.textualDecription)
}

//thing 是 TextRepresentable 类型而不是 Dice，DiceGame，Hamster 等类型，即使实例在幕后确实是这些类型中的一种。由于 thing 是 TextRepresentable 类型，任何 TextRepresentable 的实例都有一个 textualDescription 属性，所以在每次循环中可以安全地访问 thing.textualDescription。

//协议的继承
//协议能够继承一个 或多个 其他协议 可以在继承的基础上增加新的要求。 协议的继承语法与类的继承相似， 对个继承的协议间用逗号分隔：
protocol NewInheritingProtocol : SomeOneProtocol, SomeProtocol, SomeInitProtocol {
    
    //这里是协议的定义部分
}

//例子： PrettyTextRepresentable 协议继承了 TextRepresentable 协议 

protocol PrettyTextRepresentable : TextRepresentable {
    
    var prettyTextualDescription : String {get}
    
}

//例子中定义了一个新的协议 PrettyTextRepresentable 它继承TextRepresentable协议 任何遵循 PrettyTextRepresentable协议的类型在满足该协议的要求时， 也必须满足 TextRepresentable 协议要求。 在这个例子中 PrettyTextRepresentable 协议额外要求遵循协议的类型提供了一个返回值为 String 类型的 prettyTextualDescription 属性。
//如下 扩展 NewSnakesAndLadders 使其遵循并符合 PrettyTextRepresentable协议
extension SnakesAndLadders : PrettyTextRepresentable {
    
    
    var prettyTextualDescription: String {
        
        var output = textualDecription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "⬆️ "
            case let snake where snake < 0:
                output += "⬇️ "
            default:
                output += "O "
            }
        }
        
        return output
        
    }
    
    
    
}

//上述扩展 令SnakesAndLadders 遵循了 PrettyTextRepresentable 协议并提供了协议要求的prettyTextualDescription属性。 每个PrettyTextRepresentable类型同时也是TextRepresentable类型 所以在 prettyTextualDescription 的实现中，可以访问 textualDescription 属性。然后，拼接上了冒号和换行符。接着，遍历数组中的元素，拼接一个几何图形来表示每个棋盘方格的内容：

//当从数组中取出的元素的值大于 0 时，用 ▲ 表示。
//当从数组中取出的元素的值小于 0 时，用 ▼ 表示。
//当从数组中取出的元素的值等于 0 时，用 ○ 表示。

//任意 SankesAndLadders 的实例都可以使用 prettyTextualDescription 属性来打印一个漂亮的文本描述：

print(game.prettyTextualDescription)


//类类型的专属协议
//可以在协议的继承列表中， 添加class 关键字类限制协议只能不类类型遵循，而结构体和枚举不能遵循该协议，class 关键字比逊第一个出现在协议的列表中在其他继承协议之前。
protocol SomeClassOnlyProtocol : class, SomeInitProtocol {
    
    //这里是类类型专属协议的定义部分
}

class TestClassOnly : SomeClassOnlyProtocol {
    
    internal required init(someParameter: Int) {
        
    }
  
}

//解释：SomeClassOnlyProtocol 只能被类类型遵循， 如果尝试让结构体或枚举类型遵循该协议， 则会导致编译错误。


//协议的合成
//有时候需要同时遵循多个协议， 可以将多个协议采用 SomeProtocol & AnotherProtocol 遮掩的格式进行组合， 称为协议合成 （protocol composition ）可以罗列任意多个你想遵循的协议，以与符号分隔

//下面的例子将 Named 和 Age的 两个协议按照上述语法组合成一个协议， 作为函数参数类型。
protocol Named {
    
    var name : String {get}
    
}

protocol Age {
    
    var age : Int {get}
    
}


struct NewPerson : Named , Age {
    
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator : Named & Age){
    
    print("Happy Birthday \(celebrator.name) you‘re \(celebrator.age)")
}

let birthDayPerson = NewPerson(name : "xiaoMing", age : 18)
wishHappyBirthday(to: birthDayPerson)//Happy Birthday xiaoMing you‘re 18

//Named 协议包含 String 类型的 name 属性， Aged 协议包含 Int 类型的age属性， NewPerson 结构体遵循了两个协议 

//wishHappyBirthday(to: )函数的参数 celebrator 的类型为Named & Aged 这意味着他并不关心参数的具体类型， 只要参数符合这两个类型即可

//上面的例子创建了一个名为 birthdayPerson 的 Person 的实例，作为参数传递给了 wishHappyBirthday(to:) 函数。因为 Person 同时符合这两个协议，所以这个参数合法，函数将打印生日问候语。

//检查协议的一致性
//可以使用类型转换中的 is as 操作符来检查协议的一致性， 即是否符合协议， 并且可以转换到指定的协议类型。 检查和转换的到某个协议类型在语法和类型的检查和转换是完全相同：
//1。is用来检查实例是否符合某个协议，如符合则返回true 否则返回false  2、as？ 返回一个可选值， 当实例符合某个协议时，返回类型是该协议类型的可选值， 否则放回nil  3.as！将协议强制向下转移到某个类型， 如果强转失败，会引发运行时错误。
//例子：定义了一个额 HasArea 协议 ， 该协议定义了一个Double 类型的可读属性 area
protocol HasArea {
    
    var area : Double {get}
    
}
class Circle : HasArea {
    
    let pi = 3.141592653
    var radius : Double
    
    var area: Double {
        
        return radius * radius * pi
    }
    
    init(radius : Double) {
        self.radius = radius
    }
    
}

class Country : HasArea {
    
    var area: Double
    init(area : Double) {
        
        self.area = area
    }
}

//Circle 类把 area 属性实现为基于存储属性 radius 的计算属性， Country 类则吧 area 属性实现为存储属性。 这俩个类都正确的符合了HasArea协议 。

//定义一个 Animal 类 不遵循HasArea 协议 
class  Animal {
    
    var legs : Int
    init(legs : Int) {
        self.legs = legs
    }
    
}

//Circle Country Animal  并没有一个共同的基类， 尽管如此 他们都是类型， 他们的实例都可以作为AnyObject 类型的值， 存储在一个数组中：

let objects : [AnyObject] = [Circle(radius : 2.0), Country(area : 243_610), Animal(legs : 4)]

//objects 数组使用字面量初始化，数组包含一个 radius 为 2 的Circle 的实例， 一个保存了国土面积的Country实例  和一个legs 为 4 的Animal 实例。

for obect in objects {
    
    if let objectWithArea = obect as? HasArea {
        
        print("Area is \(objectWithArea.area)")
    }else{
        
        print("Something that doesn't have an area")
    }
    

    
    
    if let objectWithArea = obect as? Circle {
        
        print("圆的面积：\(objectWithArea.area)")
        
    }else{
        
        print("没有找到类型为Circle")
    }
    
    
}

//当遍历出的元素符合HasArea协议时， 将 as? 操作符返回的可选值通过可选绑定，绑定到 objectWithArea 常量上。 ObjectWihtArea 是HasArea 协议类型的实例 因此area属性可以被访问和打印。
//objects 数组中的元素的类型并不会因为强转而丢失类型信息，它们仍然是 Circle，Country，Animal 类型。然而，当它们被赋值给 objectWithArea 常量时，只被视为 HasArea 类型，因此只有 area 属性能够被访问。

//可选的协议要求
//协议可以定义为可选要求， 遵循协议的类可以选择是否实现这些要求。 在协议中使用 optional 关键字作为前缀来定义可选要求。 可选要求用在你需要和Objective-C 打交道的代码中， 协议和可选要求必须带上@objec 属性， 标记为@object 特性的协议只能被继承自 Objective-C类的类或者 @object 类型遵循， 其他类结构体均、枚举均不能遵循这种协议。
//使用可选要求时（可选的方法或属性），他们的类自动变成可选的。 比如 一个类型为 （int）-> Sting 的方法变成（（int）-> String）? 需要注意的是整个函数的类型是可选的，而不是函数的返回值。
//协议中的可选要求可通过可选链式调用来使用， 因为遵循协议的类型可能没有实现这些可选要求。类似 someOptionalMethod？（someArgument）这样， 你可以在可选方法名称上名加上？来调用可选方法， 
//例子定义了一个 Counter 的用于整数计数的类， 他使用外部的数据源来提供每次的增量。 数据源由 CounterDataSource 协议定义， 包含两个可选要求
@objc protocol CounterDataSource {
    
   @objc optional func incrementForCount(count : Int) -> Int
   @objc optional var fixdeIncrement : Int { get }
}

//CounterDataSource 协议定义了一个可选方法 increment(forCount:) 和一个可选属性 fiexdIncrement，它们使用了不同的方法来从数据源中获取适当的增量值。
//注意严格来讲，CounterDataSource 协议中的方法和属性都是可选的，因此遵循协议的类可以不实现这些要求，尽管技术上允许这样做，不过最好不要这样写。

//Counter 类含有一个 CounterDataSource？ 类型的可选属性 dataSource 

class Counter {
    
    var count = 0
    
    var dataSource : CounterDataSource?
    
    func increment() {
        
        if let amount = dataSource?.incrementForCount?(count: count) {
            
            count += amount
            
        }else if let amount = dataSource?.fixdeIncrement {
            
            count += amount
        }
    }
    
    
}

//Counter 类 使用变量 count 来存储当前值， 该类定义了衣蛾 increment方法， 每次调用该方法的时候， 会增加count 的值。
//increment()方法视图使用incrementForCount（count： ）方法来得到每次的增量。 increment（）方法使用可选链式调用 incrementForCount（count：）并将当前的count 值作为参数传入。
//这里使用了两层可选链式调用， 首先 DataSource可能为nil， 因此在DataSource后面加上？ 因此表明只在dataSource 非空是去掉用incrementForCount（count ： ）方法。 即使DataSource 存在也无法保证其是否实现了 incrementForCount（Count：）方法， 以为这个方法是可选的， 因此incrementForCount（Count：）方法同样使用可选链式调用进行调用， 只有在该方法被实现的情况下才能调用它， 所以在incrementForCount（count ：）方法后面也加上？
//increForCount（Count： ）方法在上两种情形下都有可能失败， 所以返回值为Int？类型， 虽然， CountDataSource 协议中， incrementForCount（count：）的返回值类型是非可选int类型，
//在调用incrementForCount（Count： ）方法后，Int?型的返回值可以通过可选绑定解包并赋值给常量amount， 如果返回值确实含有一个值， 也就是说数据源和方法都存在， 数据源方法返回了一个有效值，之后将解包后的amount加到count上 增量操作完成。
//如果没有从IncrementForCount（count：）方法获取到值，可能由于DataSource为nil 或者并没有实现IncrementForCount（count：）方法， 那么 Increment（）方法视图从数据源fixIncrement 属性中获取增量值。 fixedIncrement 是一个可选的属性， 一次属性是一个int？ 值 即使该属性在CountDataSource 协议中个的类型时非可选的Int

//下面的例子 展示了 CountDataSource 的简单实现， ThreeSource类遵循了 CountDataSource 协议 它实现了 可选属性fixedIncrement 没戏返回 3

class ThreeSource : NSObject, CounterDataSource {
    
    var fixdeIncrement: Int = 3
}

//可以使用 ThreeCount实例作为Count二 实例的数据源

var counter = Counter()
counter.dataSource  = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

//下面是一个更为复杂的数据源 TowardZeroSource， 它将使最后的值变为0
@objc class TowardZeroDataSource : NSObject, CounterDataSource{
    
    func incrementForCount(count: Int) -> Int {
        
        if count == 0 {
            
            return 0
            
        }else if count < 0 {
            
            return 1
        }else {
            
            return -1
        }
    }
}

//TowardZeroSource 实现了 CountDataSource 协议中的 IncrementForCount（Ocount：）方， 以Count数据为依据计算出每次的增量， 如果count已经为0 此方法返回 0 以此表明之后不应在有增量操作。

counter.count = -4
counter.dataSource = TowardZeroDataSource()

for _ in 1...5 {
    
    counter.increment()
    print(counter.count)
}


//协议扩展
//协议通过扩展来为遵循协议的类型提供属性，方法和下标的实现。通过这个方式， 可以基于协议本身来实现这些功能， 而无需在每个遵循协议的类型中重复同样的实现， 也无需使用全局函数
//例如：可以扩展 RandomNumberGenerator 协议来提供 randomBool（）方法，方法通过使用协议中定义的random（）函数来返回一个随机的 Bool 值
extension RandomNumberGenerator {
    
    func randoumBool() -> Bool {
        
        return random() > 0.5
    }
}

//通过协议扩展， 所有遵循协议的类型， 都能自动获得这个扩展的实现方法， 无需任何额外修改
let testGenerator = LinearCongruentialGenerator()
print("Here's a random number:\(testGenerator.random())")
print("And Here's a random Boolean : \(testGenerator.randoumBool())")


//提供默认实现。
//可以通过协议扩展来为协议的属性，方法和下标提供默认的实现。 如果遵循协议的类型类这些要求提供自己的实现， 那么这些自定义实现会替代扩展中的默认实现被使用。
//注意：通过协议扩展为协议要求提供的默认实现和可选的协议要求不同。虽然在这两种情况下，遵循协议的类型都无需自己实现这些要求，但是通过扩展提供的默认实现可以直接调用，而无需使用可选链式调用。
//例如：PrettyTextRepresentable 协议继承自 TextRepresentable 协议，可以为其提供一个默认的 prettyTextualDescription 属性 只是简单的返回 textualDescription 属性值
extension PrettyTextRepresentable {
    
    var prettyTextualDescription : String {
        
        return textualDecription
    }
    
}

//为扩展协议添加限制条件 
//在扩展协议的时候，可以指定一些限制条件， 只有遵循协议的类型满足这些限制条件时， 才能获得扩展提供的默认实现， 这些限制条件写在协议名之后， 使用 where 子句来描述
//可以 扩展CollectionType协议 但是知识是适用于集合中的元素遵循了 TextRepresentable协议的情况

extension Collection where Iterator.Element : TextRepresentable {
    
    var textualDescription: String {
        
        let itemAsText = self.map {
            $0.textualDecription
        }
        return "[" + itemAsText.joined(separator: ",") + "]"
        
    }
    
}

//textualDescription 属性返回整个集合的文本描述，它将集合中的每个元素的文本描述以逗号分隔的方式连接起来，包在一对方括号中。

//现在我们来看看先前的 Hamster 结构体，它符合 TextRepresentable 协议，同时这里还有个装有 Hamster 的实例的数组：

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

//因为 Array 符合 CollectionType 协议，而数组中的元素又符合 TextRepresentable 协议，所以数组可以使用 textualDescription 属性得到数组内容的文本表示：

print(hamsters.textualDescription)
// 打印 “[A hamster named Murray, A hamster named Morgan, A hamster named Maurice]”

//注意
//如果多个协议扩展都为同一个协议要求提供了默认实现，而遵循协议的类型又同时满足这些协议扩展的限制条件，那么将会使用限制条件最多的那个协议扩展提供的默认实现。


