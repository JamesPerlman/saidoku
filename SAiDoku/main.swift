import Foundation

// var array = [[[[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],],],[[[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],],],[[[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0, 0],],]]

struct members {
    var Int row;
    var Int column;
    var Int region;
}

struct State {
    
    var data: Array<Int> = Array(repeating: 0, count: 81)
    
    var rows: Int[][];
    var columns: Int[][];
    var regions: Int[][];
    
    var cells: Array<members>;
    
    func coordOf(index: Int) -> (Int, Int, Int) {
        
    }

    func indexOf(region: Int, row: Int, column: Int) -> Int {
        return region * 9 + row * 3 + column
    }

}

do {
    let data = try String(contentsOfFile: CommandLine.arguments[1])
    
    // NOTE: Normally you should run, not walk, away from a codebase with four nested for loops, but in this case I think it's ok
    for w in 0...2 {
        for x in 0...2 {
            for y in 0...2 {
                for z in 0...2 {
                    let value = (w * 27) + (x * 9) + (y * 3) + z
                    let char = String(data[data.index(data.startIndex, offsetBy: value)])
                    // NOTE: x and y are transposed because I went board by board and qqwing went row by row
                    array[w][y][x][z] = Int(char) ?? 0
                }
            }
        }
    }
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

func missingNumbers(_ existingNumbers: Array<Int>) -> Array<Int> {
    return Array(Set(1...9).subtracting(Set(existingNumbers)))
}

func existingNumbersForRowsIn(board: Int, region: Int) -> Array<Int> {
    var numbers: Array<Int> = []
    for x in 0...2 {
        for y in 0...2 {
            if (array[board][x][region][y] != 0) {
                numbers.append( array[board][x][region][y] );
            }
        }
    }
    
    return numbers
}

print("Missing numbers from row 0: \( missingNumbers(existingNumbersForRowsIn(board: 0, region: 0))  )")




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







