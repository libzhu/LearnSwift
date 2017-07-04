//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
 
 本页内容：
 · 实例方法
 · 类型方法
 
 */

//方法是与某些特定类型相关联的函数。类、 结构体、 枚举都可以定义实例方法；实例方法给特定的类型的实例封装了具体的任务与功能。类、结构体、枚举也可以定义类型方法；类型方法与类型本身相关联。类型方法与Objective-C中的类方法相似；
//结构体和枚举能够定义方法是Swift 与 c/objective - c 的主要区别之一。在Objective-C中 类是唯一能定义方法的类型。但在Swift 当中你不仅能选择是否要定义一个类、结构体。枚举，还能够灵活的在你创建的类型上定义方法；

//实例方法（instance Methods）
//实例方法属于某个特定类、结构体或枚举类型实例的方法。实例方法提供访问和修改属性的方法或提供与实例目的相关功能，并以此来支撑实例的功能。实例方法的语法与函数完全一致。
//实例方法主要写在它所属的类型的前后的大括号中。实例方法能够隐式的访问它所属类型的所有的其他实例方法和属性。实例方法只能被它所属的类的某个特定的实例调用。实例方法不能脱离于现实的实例而被调用
//下面的例子，定义一个很简单的 Counter 类， counter 能被用来对一个动作的发生次数进行计数

class Counter {
    
    var count = 0
    
    func increment() {
        
        count += 1
    }
    
    
    func increment(by amount : Int) {
        
        self.count += amount
    }
    
    func reset() {
        count = 0
    }
    
}

//Counter 类定义类三个实例方法：
/*
 
 · increment 让基数器按一递增
 · increment（by：Int）让计数器按照指定的整数递增
 · reset 将计数器重置为 0
 
 */

//Counter 这个类还声明了一个可变属性 Count 用来保存对当前计数器值的追踪。
//和调用属性方法一样， 使用点语法(dot syntax) 调用实例方法
let counter  = Counter()
counter.increment()
print(counter.count)

counter.increment(by: 5)
print(counter.count)

counter.reset()
print(counter.count)

//self 属性
//类型的每一个实例都有一个隐含属性叫做self， self完全等同于该实例本事。你可以在一个实例的方法中使用这个隐含的 self 属性来引用当前的实例.实际上，你不必在你的代码里经常写self.不论何时， 只要在一个地方使用一个已知的属性或者方法名称，如果你没有明确的写self Swift假定你是指当前实例的属性或者方法。这种假定 上面的 Counter 中已经示范了 
//使用这条规则的主要场景是实例的方法的某个参数名称名与实例的某个属性名称相同的时候，在这种情况下，参数名称享有优先权，并且在引用属性时必须使用一种更严格的方式。这时你可以使用self属性来区分参数名称和属性名称。
struct Point {
    
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x : Double) -> Bool {
        
        return self.x > x
    }
    
}

let  somePoint = Point(x : 4.0, y : 5.0)

if  somePoint.isToTheRightOfX(x: 1.0) {
    
    print("This point is to the right of the line where x == 1.0")
}

//在实例方法中修改值类型
//结构体和枚举是值类型。默认情况下，值类型的属性不能在他的实例方法中被修改。
//但是， 如果你确定需要在某个特定的方法中修改结构体或者枚举的属性，可以为这个方法 选择 可变mutating 行为，让后就可以从其他内部方法改变他的属性；并且这个方法做的任何改变都会在方法执行结束以后才写回到原始结构中。方法可以给它隐含的 self 属性赋予一个全新的实例，这个心实例在方法结束时会替换现存实例
//要使用 可变 方法 将关键字 mutating 放到 func 关键字之前就可以了：
struct OtherPoint {
    
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX : Double, y deltaY : Double) {
        
        x += deltaX
        y += deltaY
    }
    
}

var someOtherPoint = OtherPoint(x : 1.0, y : 2.0)

someOtherPoint.moveByX(deltaX: 2.0, y: 3.0)
print("现在的坐标（\(someOtherPoint.x), \(someOtherPoint.y)）")

//注意：不能再结构体类型的额常量上调用可变方法，因为其属性不能被改变。即使属性是属性变量。
let fixedPoint = OtherPoint(x : 2.0, y : 3.0)
//fixedPoint.moveByX(deltaX: 2.0, y: 3.0)

//在可变方法中给self赋值。
//在可变方法给隐含属性self 一个全新的实例。
struct AnotherPoint {
    
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX : Double, y deltaY : Double){
        
        self = AnotherPoint(x : x + deltaX, y : y + deltaY)
    }
    
    
}

var  anotherPoint = AnotherPoint()

anotherPoint.moveBy(x: 2.0, y: 3.0)

print("新的点：\(anotherPoint.x), \(anotherPoint.y)")


//枚举的可变方法可以把self 设置为同一枚举类型中不同的成员
enum TriStateSwitch {
    
    case Off, Low, High
    mutating func next(){
        
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}

var ovenLight = TriStateSwitch.Low

ovenLight.next()

ovenLight.next()

ovenLight.next()

//上面的例子定义了三个状态的开关枚举，每次调用next（）方法时，开关在不同的电源状态（Off， Low， High ）之前循环切换。

//类型方法：
//实例方法是被某个类型的实例调用的方法， 用类型本身调用的方法，这种方法叫做类型方法。在方法的 ffunc 关键字之前加上关键字 static来指定类型方法。类还可以用关键字 class 来允许子类重写父类的实现方法
//注意：在Objective-C 中 你只能为Objective-C的类类型定义类型方法。在Swift中，你可以为所有的类，结构体，枚举定义类型方法， 每个类型方法都被它所支持的类型显示的包含。
//类型方法和实例方法一样用点语法调用。 但是在类型上调用这个方法，而不是实例上调用。下面的例子如何在SomeClass 类上调用 类型方法。
class SomeClass {
    
    class func someTypeMethod() {
        //这里写实现类型方法
    }
}

SomeClass.someTypeMethod()
//在类型方法的body中 self 指向这个类型本身，而不是类型的某个实例。这意味着你可以用self 来消除类型属性和类型方法参数之间的额企业，
//一般来说，在类型方法的方法体中，任何未限定的方法和属性名称，可以被本类中其他的类型方法和类型属性引用。一个类型方法可以直接通过类型方法的名称调用本类中的其他类型方法。而无需在方法名称前面加上类型名称。类似的，在结构体 和 枚举中，也能够直接通过类型属性的名称访问本类中的类型属性，而不需要前面加上类型名称。
//下面的例子定义了 一个名为LevelTracker 结构体，他监听玩家的游戏发展情况（游戏的不同层次或阶段）。这是一个单人游戏，但可以存储多个玩家在同一设备上的游戏信息。
//游戏初始化时。所有的游戏等级（除了等级1）都被锁定。每次有玩家完成一个等级，这个等级就对这个设备上的所有玩家解锁。LeverTracker 结构体用 类型属性 和 方法监测游戏的那个阶段已经被解锁。他还监测每个玩家的当前等级
struct LevelTracker {
    
    static var highesUnlockedLevel = 1
    var currentLeverl = 1
    
    static func unlock(_ level : Int) {
        
        if level > highesUnlockedLevel {
            
            highesUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level : Int) -> Bool {
        
        
        return level <= highesUnlockedLevel
    }
    
//    @discardableResult
    mutating func advance(to level : Int) -> Bool {
        
        if LevelTracker.isUnlocked(level) {
            
            currentLeverl = level
            return true
            
        }else{
            
            return false
        }
    }
    
}
//解释：监测玩家已解锁的最高等级：这个值存储在类型属性 highesUnlockedLevel 中 
// levelTracker 还定义了 两个类型方法与 highesUnlockedLevel 配合工作。 unlock（_：）一旦新等级被解锁，他会更新 highesUnlockedLevel 的值。 isUnlocked(_:)如果某个给定的等级已经被解锁，他将返回TRUE。监听 玩家的进度：用实例属性 currentLevel 来监测 为了便于管理currentLevel属性，LevelTracker定义了实例方法advance(to:)。这个方法会在更新currentLevel之前检查所请求的新等级是否已经解锁。advance(to:)方法返回布尔值以指示是否能够设置currentLevel。因为允许在调用advance(to:)时候忽略返回值，不会产生编译警告，所以函数被标注为@ discardableResult属性，更多关于属性信息，请参考属性章节。

//Player 类使用 LeverTracker 来监听和更新每个玩家的发展进度。
class Player {
    
    var tracker = LevelTracker()
    let playName : String
    func complete(level : Int) {
        
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    
    init(name : String) {
        
        playName = name
    }
    
    
}

//解释：Player 类创建一个新的 LevelTracker 实例来监测这用用户的进度。他提供了 complete（Level：）方法， 一旦玩家完成某个指定登记就调用它。这个方法为所有玩家解锁下一等级， 并且将当前玩家的进度更新为下一等级。（）

var player = Player(name : "zhansan")
player.complete(level: 1)

print("highest unlocked level is now \(LevelTracker.highesUnlockedLevel)")

player = Player(name : "lisi")


print("\(player.playName) highest unlocked level is now \(player.tracker.currentLeverl)")
if player.tracker.advance(to: 6) {
    
    print("player is now on level 6")
}else{
    
     print("level 6 has not yet been unlocked")
}



