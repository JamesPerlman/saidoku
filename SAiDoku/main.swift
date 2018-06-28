//
//  main.swift
//  SAiDoku
//
//  Created by Robert Johnson on 6/27/18.
//  Copyright © 2018 SAiD. All rights reserved.
//

import Foundation

var array = [[[["","",""],["","",""],["","",""],],[["","",""],["","",""],["","",""],],[["","",""],["","",""],["","",""],],],[[["","",""],["","",""],["","",""],],[["","",""],["","",""],["","",""],],[["","",""],["","",""],["","",""],],],[[["","",""],["","",""],["","",""],],[["","",""],["","",""],["","",""],],[["","",""],["","",""],["","", ""],],]]

do {
    let data = try String(contentsOfFile: CommandLine.arguments[1])
    // print(data)
    
    // NOTE: Normally you should run, not walk, away from a codebase with four nested for loops, but in this case I think it's ok
    for w in 0...2 {
        for x in 0...2 {
            for y in 0...2 {
                for z in 0...2 {
                    let value = (w * 27) + (x * 9) + (y * 3) + z
                    let char = String(data[data.index(data.startIndex, offsetBy: value)])
                    // print(char)
                    // NOTE: x and y are transposed because I went board by board and qqwing went row by row
                    array[w][y][x][z] = (char == ".") ? " " : char
                }
            }
        }
    }
    
    // print(array)
} catch {
}

// http://patorjk.com/software/taag/#p=testall&f=ANSI%20Shadow&t=SAiDoku
print("""

███████╗ █████╗ ██╗██████╗  ██████╗ ██╗  ██╗██╗   ██╗
██╔════╝██╔══██╗██║██╔══██╗██╔═══██╗██║ ██╔╝██║   ██║
███████╗███████║██║██║  ██║██║   ██║█████╔╝ ██║   ██║
╚════██║██╔══██║██║██║  ██║██║   ██║██╔═██╗ ██║   ██║
███████║██║  ██║██║██████╔╝╚██████╔╝██║  ██╗╚██████╔╝
╚══════╝╚═╝  ╚═╝╚═╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝

""")

// We can use our information about a box, a row, a column



func missingNumbers(existingNumbers: Array<Int>) -> Array<Int> {
    return Array(Set([1,2,3,4,5,6,7,8,9]).subtracting(Set(existingNumbers)))
}

func existingNumbersForRowsIn(board: Int, region: Int) -> Array<Int> {
    for x in 0...2 {
        
    }
}
// array[0]

func displayBoard() {
    
    // Board Row, Board Column, Region Row, Region Column
    
    print("""
        
        ╔═══╤═══╤═══╦═══╤═══╤═══╦═══╤═══╤═══╗
        ║ \(array[0][0][0][0]) │ \(array[0][0][0][1]) │ \(array[0][0][0][2]) ║ \(array[0][1][0][0]) │ \(array[0][1][0][1]) │ \(array[0][1][0][2]) ║ \(array[0][2][0][0]) │ \(array[0][2][0][1]) │ \(array[0][2][0][2]) ║
        ╟───┼───┼───╫───┼───┼───╫───┼───┼───╢
        ║ \(array[0][0][1][0]) │ \(array[0][0][1][1]) │ \(array[0][0][1][2]) ║ \(array[0][1][1][0]) │ \(array[0][1][1][1]) │ \(array[0][1][1][2]) ║ \(array[0][2][1][0]) │ \(array[0][2][1][1]) │ \(array[0][2][1][2]) ║
        ╟───┼───┼───╫───┼───┼───╫───┼───┼───╢
        ║ \(array[0][0][2][0]) │ \(array[0][0][2][1]) │ \(array[0][0][2][2]) ║ \(array[0][1][2][0]) │ \(array[0][1][2][1]) │ \(array[0][1][2][2]) ║ \(array[0][2][2][0]) │ \(array[0][2][2][1]) │ \(array[0][2][2][2]) ║
        ╠═══╪═══╪═══╬═══╪═══╪═══╬═══╪═══╪═══╣
        ║ \(array[1][0][0][0]) │ \(array[1][0][0][1]) │ \(array[1][0][0][2]) ║ \(array[1][1][0][0]) │ \(array[1][1][0][1]) │ \(array[1][1][0][2]) ║ \(array[1][2][0][0]) │ \(array[1][2][0][1]) │ \(array[1][2][0][2]) ║
        ╟───┼───┼───╫───┼───┼───╫───┼───┼───╢
        ║ \(array[1][0][1][0]) │ \(array[1][0][1][1]) │ \(array[1][0][1][2]) ║ \(array[1][1][1][0]) │ \(array[1][1][1][1]) │ \(array[1][1][1][2]) ║ \(array[1][2][1][0]) │ \(array[1][2][1][1]) │ \(array[1][2][1][2]) ║
        ╟───┼───┼───╫───┼───┼───╫───┼───┼───╢
        ║ \(array[1][0][2][0]) │ \(array[1][0][2][1]) │ \(array[1][0][2][2]) ║ \(array[1][1][2][0]) │ \(array[1][1][2][1]) │ \(array[1][1][2][2]) ║ \(array[1][2][2][0]) │ \(array[1][2][2][1]) │ \(array[1][2][2][2]) ║
        ╠═══╪═══╪═══╬═══╪═══╪═══╬═══╪═══╪═══╣
        ║ \(array[2][0][0][0]) │ \(array[2][0][0][1]) │ \(array[2][0][0][2]) ║ \(array[2][1][0][0]) │ \(array[2][1][0][1]) │ \(array[2][1][0][2]) ║ \(array[2][2][0][0]) │ \(array[2][2][0][1]) │ \(array[2][2][0][2]) ║
        ╟───┼───┼───╫───┼───┼───╫───┼───┼───╢
        ║ \(array[2][0][1][0]) │ \(array[2][0][1][1]) │ \(array[2][0][1][2]) ║ \(array[2][1][1][0]) │ \(array[2][1][1][1]) │ \(array[2][1][1][2]) ║ \(array[2][2][1][0]) │ \(array[2][2][1][1]) │ \(array[2][2][1][2]) ║
        ╟───┼───┼───╫───┼───┼───╫───┼───┼───╢
        ║ \(array[2][0][2][0]) │ \(array[2][0][2][1]) │ \(array[2][0][2][2]) ║ \(array[2][1][2][0]) │ \(array[2][1][2][1]) │ \(array[2][1][2][2]) ║ \(array[2][2][2][0]) │ \(array[2][2][2][1]) │ \(array[2][2][2][2]) ║
        ╚═══╧═══╧═══╩═══╧═══╧═══╩═══╧═══╧═══╝
        
        """)
}

displayBoard()







