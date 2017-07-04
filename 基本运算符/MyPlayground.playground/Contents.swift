//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
 
 运算符分为一元、二元和三元运算符:
 
 一元运算符对单一操作对象操作（如 -a）。一元运算符分前置运算符和后置运算符，前置运算符需紧跟在操作对象之前（如 !b），后置运算符需紧跟在操作对象之后（如 c!）。
 二元运算符操作两个操作对象（如 2 + 3），是中置的，因为它们出现在两个操作对象之间。
 三元运算符操作三个操作对象，和 C 语言一样，Swift 只有一个三元运算符，就是三目运算符（a ? b : c）。
 
 受运算符影响的值叫操作数，在表达式 1 + 2 中，加号 + 是二元运算符，它的两个操作数是值 1 和 2。
 
 */
/*-------------------赋值运算符---------------------*/
//赋值运算符（a = b），表示用 b 的值来初始化或更新 a 的值：
let b = 10
var a = 5
a = b

//如果赋值的右边是一个元祖，它的元素可以被分解成多个常量或变量
let (x, y) = (10, 20)
print(x)
print(y)
//语法错误例子
//if x = y {//swift和c oc语言不一样 没有非零即真概念，  只有TRUE FALSE
//    // 此句错误, 因为 x = y 并不返回任何值
//}

"hello" + " " + "world"
3-2
33/3
33%3
9%4
var c = 8
c += 1
c -= 1

let name = "hello world"

if name != "hello world" {
    
    print("true")
    
}else{
    
    print("false")
}

/*
 
 当元组中的值可以比较时，你也可以使用这些运算符来比较它们的大小。例如，因为 Int 和 String 类型的值可以比较，所以类型为 (Int, String) 的元组也可以被比较。相反，Bool 不能被比较，也意味着存有布尔类型的元组不能被比较。
 
 比较元组大小会按照从左到右、逐值比较的方式，直到发现有两个值不等时停止。如果所有的值都相等，那么这一对元组我们就称它们是相等的。例如：
 */

(3, "zebra") < (2, "apple")   // true，因为 1 小于 2
(3, "c") < (3, "b")    // true，因为 3 等于 3，但是 apple 小于 bird
(4, "dog") == (4, "dog")      // true，因为 4 等于 4，dog 等于 dog


/*
 三目运算符（Ternary Conditional Operator）
 
 三目运算符的特殊在于它是有三个操作数的运算符，它的形式是 问题 ? 答案 1 : 答案 2。它简洁地表达根据 问题成立与否作出二选一的操作。如果 问题 成立，返回 答案 1 的结果；反之返回 答案 2 的结果。
 
 三目运算符是以下代码的缩写形式：
 
 if question {
 answer1
 } else {
 answer2
 }
 */

let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)

/*--------------------空和运算符------------------------------*/
//空和运算符（a ?? b） 将对可选类型 a 进行空判断 如果 a 包含一个值就解封，否者就会返回一个默认值 b。表达式 a 必须是可选类型 Optional。默认值 b 的类型必选要和 a 存储值的类型保持一致； 空和运算符的表达式是简化的三目运算符 a != nil ? a! : b

let defaultColorName = "red"
var userDefineColorName : String? //默认值为nil

var colorNameToUse = userDefineColorName ?? defaultColorName//如果可选类型userDefineColorName 值 为nil 就取 defaultColorName的值；
userDefineColorName = "green"
colorNameToUse = userDefineColorName ?? defaultColorName


/*区间运算符
 
 swift提供了两个方便表达一个区间的值的区间运算符
 
 闭区间运算符
 （a ... b）定义一个包含从 a 到 b （包含 a 和 b ）的所有值的区间。a 不能超过 b 。
  闭区间运算符在迭代一个区间的所有值时是非常有用的，如在 for-in 循环中：
 
 */

for index in 1 ... 5 {
    
    print("\(index) * 5 = \(index * 5)")
}

/*
 半开半闭区间
 半开区间运算符（a..<b）定义一个从 a 到 b 但不包括 b 的区间。 之所以称为半开区间，是因为该区间包含第一个值而不包括最后的值。
 半开区间的实用性在于当你使用一个从 0 开始的列表（如数组）时，非常方便地从0数到列表的长度。
 
 */

let nameArr = ["张三", "李四", "王五", "赵六", "马七"]
let count = nameArr.count
for index in 0..<count {
    print("第\(index)元素的值是：\(nameArr[index])")
}


/*
 
 逻辑运算符（Logical Operators）
 
 逻辑运算符的操作对象是逻辑布尔值。Swift 支持基于 C 语言的三个标准逻辑运算。
 
 逻辑非（!a）
 逻辑与（a && b）
 逻辑或（a || b）

 
 */

//逻辑非运算符（!a）对一个布尔值取反，使得 true 变 false，false 变 true。它是一个前置运算符，需紧跟在操作数之前，且不加空格。读作 非 a ，例子如下：
let allowedEntry = false
if !allowedEntry {
    print("不能进入！")
}


var isRead : Bool?

var isSleep = isRead ?? false

isRead = true

isRead = isRead ?? false









