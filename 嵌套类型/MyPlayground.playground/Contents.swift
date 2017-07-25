//: Playground - noun: a place where people can play

import UIKit

var str = "嵌套类型"

/*
 · 嵌套类型实践
 · 引用嵌套类型

 */

//枚举常被用于特定类或结构体实现某些功能。类似的， 枚举可以方便的定义工具类或结构体，从而为某个复杂的类型所使用，为了实现这种功能， Swift 允许你定义嵌套类型， 可以在支持的类型中定义嵌套的枚举、类和结构体。
//要在一个类型中嵌套另一个类型，将嵌套类型的定义写在其外部类型的{}中， 而且可以根据定义多级嵌套。

//嵌套类型实践
//例子：定义了一个结构体 BlackJackCard（二十一点）用来模拟BlackJackCard中的扑克牌点数。 BlackJackCard 结构体包含两个嵌套定义的枚举类型 Suit 和 Rank
//在BlackJackCard 中， Ace牌可以表示1 或者11 Ace牌的这一特征通过一个嵌套在Rank枚举中的结构体Values 来表示。
struct BlackJackCard {
    
    //嵌套的Suit枚举
    enum Suit : Character {
        case Spades = "♠︎" , hearts = "♥︎", Diamonds = "♦︎", Clusb = "♣︎"
    }
    
    //嵌套枚举Rank
    enum Rank : Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        
        struct Values {
            let first: Int, second : Int?
        }
        
        var values : Values {
            
            switch self {
                
            case .Ace:
                
                return Values(first : 1, second : 11)
                
            case .Jack, .Queen, .King:
                
                return Values(first: 10, second: nil)
                
            default:
                
                return Values(first : self.rawValue, second : nil)
            }
        }
        
        
    }
    
    let rank : Rank, suit : Suit
    
    var  description : String {
        
        var output = "suit is \(suit.rawValue) "
        output += "value is \(rank.values.first)"
        
        if let second = rank.values.second {
            
            output += " or \(second)"
        }
        
        return output
        
    }
 
}

//Suit 枚举用来描述扑克牌的四种颜色， 并用一个Character 类型的原始值表示花色。
//Rank枚举用来描述扑克牌从Ace~10 以及J Q K 这13中牌， 并用一个 Int 类型的原始值来表示牌的面值。这个（Int类型的原始值未用Ace J Q K 这 4中牌）
//Rank 枚举在内部定义了一个嵌套结构体 Values 结构体Values 中定义了两个属性，用于反映只有Ace 有两个值，  其余牌只有一个值。· first为Int类型， second 的类型为 Int？ 或者说是 可选 Int
//Rank还定义了 一个计算属性values , 它将返回一个 Value结构体实例。这个计算属性会根据牌的面值，用是单的数值去初始化values实例，对于J  Q,K Ace这四中牌， 会用特殊值。对于数字面值的牌， 使用枚举实例的原始值。
//BlackJackCard 结构体拥有两个属性 -- rank 和 Suit 也同样定义了一个计算属性description ，description 属性用rank 和 suit 中的内容来构建对扑克牌名字和数字的描述。该属性使用可选绑定来检查可选类型second是否有值， 若有值则在原有的描述中增加对second 的描述。

//因为BlackJackCard 是一个没有自定义构造器的结构体， 结构体有默认的成员构造器-- 逐一成员构造器， 所以可以使用默认的构造器去初始化新常量theAceOfSpades : 
var theAceOfSpades = BlackJackCard(rank : .Ace, suit : .Spades)
print("theAceOfSpades: \(theAceOfSpades.description)")

theAceOfSpades = BlackJackCard(rank : .King, suit : .hearts)
print("theAceOfSpades: \(theAceOfSpades.description)")
//尽管Rank和Suit嵌套在BlackjackCard中，但它们的类型仍可从上下文中推断出来，所以在初始化实例时能够单独通过成员名称（.Ace和.Spades）引用枚举实例。在上面的例子中，description属性正确地反映了黑桃A牌具有1和11两个值。

//引用嵌套类型
//在外部引用嵌套类型时， 在嵌套类型的类型名前加上其外部的类型名作为前缀

let heartSymbol = BlackJackCard.Suit.hearts.rawValue
print(heartSymbol)














