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
    let possibilities: IndexSet
    
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
    
    init(cells: [SudokuCell]) {
        self.cells = cells
    }
    
    init(_ str: String) {
        let rawValues = str.map(Int.init)
        
        // generate cells array
        let cells = rawValues
            .enumerated()
            .map({ i, value -> SudokuCell in
                // already has value, no unknowns
                if let v = value {
                    return SudokuCell(index: i, value: v, possibilities: IndexSet())
                } else {
                    // nil value.  find possibilities
                    
                    // first find existing values in the cell's row, column, and region
                    let row = rawValues.rowSet(of: i)
                    let col = rawValues.columnSet(of: i)
                    let reg = rawValues.regionSet(of: i)
                    
                    // possible values are 0..<9 minus those values in row, col, and reg
                    let p = IndexSet(0..<9)
                        .subtracting(row)
                        .subtracting(col)
                        .subtracting(reg)
                    
                    return SudokuCell(index: i, value: nil, possibilities: p)
                }
            })
        
        self.cells = cells
    }
    
    // A game is solved if all the cells have values
    var isSolved: Bool {
        return cells.filter({ $0.hasValue }).count == cells.count
    }
    
    var isInvalid: Bool {
        return cells.first(where: { $0.isInvalid }) != nil
    }
    
    func solve(_ success: @escaping (SudokuGame) -> (), _ failure: @escaping () -> () = { }) {
        if isSolved {
            success(self)
            
        } else if isInvalid {
            failure()
            
        } else {
            var solved = false;
            // Loop through all cells
            cells
                // Only solve for cells that have possibilities
                .filter({ $0.hasValue })
                // Sorted by number of possibilities, ascending
                .sorted(by: { $0.possibilities.indices.count < $1.possibilities.indices.count })
                // For each unsolved cell...
                .forEach({ cell in
                    // create new cells, each with its value as one possibility of the unsolved cell
                    cell.possibilities
                        .map({ p -> SudokuCell in
                            let newSet = cell.possibilities.subtracting(IndexSet(integer: p))
                            return SudokuCell(
                                index: cell.index,
                                value: p,
                                possibilities: newSet
                            )
                        })
                        // using each cell, create a new game to solve, replacing the unsolved cell with the potentially solved new cell
                        .map({ newCell -> SudokuGame in
                            return self.replacing(cell, with: newCell)
                        })
                        // Try to solve each new game
                })
        }
    }
    
    // Returns a new game, replacing one cell with another
    func replacing(_ cell: SudokuCell, with newCell: SudokuCell) -> SudokuGame {
        precondition(cell.index == newCell.index, "Can't replace cells with different indices.")
        let i = cell.index
        let newCells = cells.map({ $0.index == i ? newCell : $0 })
        
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
