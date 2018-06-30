//
//  GameTypes.swift
//  SAiDoku
//
//  Created by James Perlman on 6/29/18.
//  Copyright © 2018 SAiD. All rights reserved.
//

import Foundation

//: Playground - noun: a place where people can play

import Dispatch

struct SudokuPuzzle {
    let state: [[Int]]
}



var str = "Hello, playground"

// arr[i][j]


// The value of a single cell
struct SudokuCell {
    let index: Int
    let value: Int?
    let possibilities: [Int]
    
    var hasValue: Bool {
        return value != nil
    }
    
    // A cell is invalid if it has no value and no possibilities
    var isInvalid: Bool {
        return value == nil && possibilities.isEmpty
    }
}

// Can be row, column, or 3x3 section
struct SudokuRegion {
    let cells: [SudokuCell]
    
    var isComplete: Bool {
        return cells.count == 9
    }
}

struct SudokuGame {
    let cells: [SudokuCell]
    let rawValues: [Int?]
    
    init(cells: [SudokuCell]) {
        self.cells = cells
        self.rawValues = cells.map({ $0.value })
    }
    
    init(_ str: String) {
        let rawValues = str.map(Int.init)
        
        // generate cells array
        let cells = rawValues
            .enumerated()
            .map({ i, value -> SudokuCell in
                // already has value, no unknowns
                if let v = value {
                    return SudokuCell(index: i, value: v, possibilities: [])
                } else {
                    return SudokuCell(index: i, value: nil, possibilities: rawValues.possibilities(at: i))
                }
            })
        
        self.cells = cells
        self.rawValues = rawValues
        
        print(self.description)
    }
    
    // A game is solved if all the rules are satisfied
    var isSolved: Bool {
        return cells
            .filter({ $0.hasValue })
            .map({ cell in
                
                if cell.hasValue {
                    return self.rawValues.noDuplicates(cell.index) ? 1 : 0
                } else {
                    return 0
                }
            }).reduce(0, +) == cells.count
    }
    
    var isInvalid: Bool {
        return cells.first(where: { cell in
            if cell.hasValue {
                return !self.rawValues.noDuplicates(cell.index)
            } else {
                return self.rawValues.possibilities(at: cell.index).count == 0
            }
        }) != nil
    }
    
    func solve(_ success: @escaping (SudokuGame) -> (), _ failure: @escaping () -> () = { }) {
        if isSolved {
            success(self)
        } else if isInvalid {
            failure()
            
        } else {
            // Loop through all cells
            cells
                // Only solve for cells that have possibilities
                .filter({ !$0.hasValue && $0.possibilities.count > 0 })
                // Sorted by number of possibilities, ascending
                .sorted(by: { $0.possibilities.indices.count < $1.possibilities.indices.count })
                // For each unsolved cell...
                .forEach({ cell in
                    // create new cells, each with its value as one possibility of the unsolved cell
                    cell.possibilities
                        .map({ p -> SudokuCell in
                            let newPossibilities = cell.possibilities.removingFirst(where: { $0 == p })
                            return SudokuCell(
                                index: cell.index,
                                value: p,
                                possibilities: newPossibilities
                            )
                        })
                        // using each cell, create a new game to solve, replacing the unsolved cell with the potentially solved new cell
                        .map({ newCell -> SudokuGame in
                            return self.replacing(cell, with: newCell)
                        })
                        // Try to solve each new game
                        .forEach({ game in
                            // TODO: figure out async
                            // async doesn't work??? wtf
                            DispatchQueue.global(qos: .background).sync {
                                game.solve(success)
                            }
                        })
                })
        }
    }
    
    // Returns a new game, replacing one cell with another
    func replacing(_ cell: SudokuCell, with newCell: SudokuCell) -> SudokuGame {
        precondition(cell.index == newCell.index, "Can't replace cells with different indices.")
        let i = cell.index
        let newCells = cells.map({ $0.index == i ? newCell : $0 })
        print(description)
        return SudokuGame(cells: newCells)
    }
    /*
     // 2d array of rows
     var rows:[SudokuRegion] {
     return SudokuRegion(cells: (0..<9)
     .map({ i -> [SudokuCell] in
     Array((9 * i)..<(9 * (i + 1)))
     .map({ j -> SudokuCell in
     self.cells[9 * i + j]
     })
     }))
     }*/
}
