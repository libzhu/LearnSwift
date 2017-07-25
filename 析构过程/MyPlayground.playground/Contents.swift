//: Playground - noun: a place where people can play

import UIKit

var str = "析构过程"

/*
 · 析构过程原理
 · 析构器实践
 
 */

//析构器只适用于类类型， 当一个类的实例被释放之前， 析构器会立即被调用。析构器用关键字 deinit 来表示， 类似于 构造器只要用init 来表示。

//析构过程原理
//Swift 会自动释放不再需要的实例已释放资源， Swift 通过 自动应用计数 ARC 处理实例的内存管理。通常当你的实例被释放时不需要手动的去清理。但是，当使用自己的资源时，可能需要进行一些额外的清理。如果创建了一个自定义的类来打开一个文件， 并写入一些数据， 可能需要实例再被释放之前去手动关闭该文件。
//在累的定义中， 每个类最多只能有一个析构器，而且析构器不能带任何参数
/*
 deinit {
 
    // 执行析构过程
 }
 */
//析构器实在实例被释放发生前被自动调用的。不能主动调用析构器。子类继承了父类的析构器， 并且在子类析构器实现的最后， 父类的析构器会被自动调用。即使子类没有提供自己的析构器， 父类的析构器也同样会被调用。因为直到实例的析构器被调用后，，实例才会被释放， 所以析构器可以访问实例的所有属性， 并且可以根据那些属性可以修改它的行为
//析构器实践

//例子： 描述一个简单的游戏， 这里定义了两种新类型，分别是：Bank和 Player。Bank 管理一种虚拟硬币， 并确保流通的硬币数不可能草果 10，000.在游戏中有且只能有一个Bank存在， 因此用 Bank 类来实现， 并且使用类型属性和类型方法来存储和管理当前状态。
class Bank {
    
    static var coinsInBank = 10_000
    static func distribute(conis numberOfConisRequseted : Int) -> Int {
        
        let numberOfConisToVend = min(numberOfConisRequseted, coinsInBank)
        coinsInBank -= numberOfConisToVend
        
        return numberOfConisToVend
        
    }
    
    static func receive(coins : Int) {
        
        coinsInBank += coins
    }
}
//解释：Bank 使用 coinsInBank 属性来跟踪他当前拥有的硬币数。Bank 还提供了两种方法， distribute(coins:) 和 receive（coins；）分别来处理硬币的分发和收集。
//distribute（coins：）方法在Bank 对象分发硬币之前检查是否有足够的硬币。Bank对象会返回一个并请求小的数字。此方法返回一个整型值，表示提供硬币的实际数量
//receive(coins:)方法只是将 Bank实例接收到的硬币数目加回 硬币存储中。


//Player 类描述了游戏中的一个玩家。每个玩家在任意时间都有一个数量的硬币存储到他们的钱包中，通过这个玩家的coinsInPurse 属性来表示。
class Player {
    
    var coinsInPurse : Int
    
    init(coins : Int) {
        coinsInPurse = Bank.distribute(conis: coins)
    }
    
    func win(coins : Int) {
        
        coinsInPurse += Bank.distribute(conis: coins)
    }
    
    deinit {
        
        Bank.receive(coins: coinsInPurse)
    }
    
}

//每个Player 实例在初始化的过程中， 都是从Bank对象获取指定数量的硬币。如果没有足够的硬币可用， Player 实例可能会收到比指定数量少的硬币。
//Player 类定义了一个win（conis：）方法， 该方法从bank 对象获取一定数量的硬币， 并且把他们添加到玩家的钱包中。Player类还实现了一个析构器， 这个析构器在 Player实例释放前被调用。在这里，析构器的作用只是将玩家的所有硬币都返回给Bank对象。

var playerOne : Player? = Player(coins : 100)
print("一个新的玩家加入了游戏，它的游戏币 \(playerOne!.coinsInPurse)")
print("银行中的金额数：\(Bank.coinsInBank)")

//创建一个Player 实例的时候，会向 Bank对象请求 100 个硬币，如果有足够的硬币的话， 这个Player 实例存储在一个名为PlayerOne 的可选类型的变量中。这里使用了一个可选类型的变量， 因为玩家可以随时离开游戏， 设置为可选可以追踪玩家当前是否在游戏中。
//因为 PlayOne是可选的， 所以 访问其coinsInPurse 属性来打印钱包中的硬币数量时， 使用感叹号（！）来解包：
playerOne!.win(coins: 2_000)

print("playOne 赢了 2000 个硬币 并且 现在拥有的硬数：\(playerOne?.coinsInPurse)")
print("银行中剩余的硬数：\(Bank.coinsInBank)")

//这里玩家赢了 2000 枚硬币， 所以玩家的钱包中现在有2100枚硬币， 而bank 对象只剩下7900枚硬币
playerOne = nil
print("玩家离开游戏")

print("现在银行中的硬币数量：\(Bank.coinsInBank)")

//玩家离开游戏， 着通过将可选类型 playerOne 变量设置为nil 来表示， 意味着：“没有Player实例” playerOne 变量对Player 实例的引用被破坏。没有其他属性或则变量应用 Player 实例， 因此该实例会被释放，以便收回内存。在这之前该实例的析构器会自动被调用， 玩家的硬币被返还给银行。
		
