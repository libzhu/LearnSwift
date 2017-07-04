//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/*
 本页包含内容：
 
 下标语法
 下标用法
 下标选项
 
 下标可以定义在类、结构体和枚举中，是访问集合，列表或序列中元素的快捷方式。可以使用下标的索引，设置和获取值，而不需要再调用对应的存取方法。举例来说，用下标访问一个Array实例中的元素可以写作someArray[index]，访问Dictionary实例中的元素可以写作someDictionary[key]。
 
 一个类型可以定义多个下标，通过不同索引类型进行重载。下标不限于一维，你可以定义具有多个入参的下标满足自定义类型的需求。
 */

struct TimesTable {
    
    let multiplier : Int
    subscript(index : Int) -> Int {
        
        return multiplier * index
    }
    
}

let  threeTimesTable = TimesTable(multiplier : 3)

threeTimesTable[6]  //通过下标语法 访问


//下标选项

//下标可以接受任意数量的入参，并且这些入参可以是任意类型。下标的返回值也可以是任意类型。下标可以使用变量参数和可变参数，但不能使用输入输出参数，也不能给参数设置默认值。

//一个类或结构体可以根据自身需要提供多个下标实现，使用下标时将通过入参的数量和类型进行区分，自动匹配合适的下标，这就是下标的重载。

//虽然接受单一入参的下标是最常见的，但也可以根据情况定义接受多个入参的下标。例如下例定义了一个Matrix结构体，用于表示一个Double类型的二维矩阵。Matrix结构体的下标接受两个整型参数

struct Matrix {
    
    let rows : Int, colums : Int
    var grid : [Double]
    init(rows : Int, colums : Int) {
        
        self.rows = rows
        self.colums = colums
        grid = Array(repeating: 0.0, count: rows * colums)
    }
    
    
    func indexIsValidForRow(row : Int , column : Int) -> Bool {
        
        return row >= 0 && row < rows && column >= 0 && column < colums
    }
    
    subscript(row : Int, column : Int) -> Double {
        
        get {
            
            assert(indexIsValidForRow(row: row, column: column), "index out of  range")
            
            return grid[(row * colums) + column]
            
        }
        
        set {
            
            assert(indexIsValidForRow(row: row, column: column), "超出范围")
            
            grid[(row * colums) + column] = newValue
        }
        
    }
}

var matrix = Matrix(rows : 2, colums : 2)

matrix[1, 0] = 100.0
matrix[0, 1] = 3.2


//Matrix下标的 getter 和 setter 中都含有断言，用来检查下标入参row和column的值是否有效。为了方便进行断言，Matrix包含了一个名为indexIsValidForRow(_:column:)的便利方法，用来检查入参row和column的值是否在矩阵范围内：

//let someValue = matrix[2, 2]




















