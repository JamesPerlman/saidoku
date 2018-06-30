//
//  [Int]+Sudoku.swift
//  SAiDoku
//
//  Created by James Perlman on 6/29/18.
//  Copyright © 2018 SAiD. All rights reserved.
//

import Foundation

extension Array where Element == Int? {
    
    func noDuplicates(_ index: Int) -> Bool {
        return !(rowValues(at: index).containsDuplicates
            || columnValues(at: index).containsDuplicates
            || regionValues(at: index).containsDuplicates)
    }
    // all values in the same region
    func regionValues(at index: Int) -> [Int] {
        let row = rowIndex(of: index)
        let column = columnIndex(of: index)
        
        let i = sectionIndex(of: row)
        let j = sectionIndex(of: column)
        
        // We are about to create a 1-dimensional array of values
        // First gather arrays of index pairs in x and y components
        
        let iArray = [Int]((3 * i)..<(3 * (i + 1)))
        let jArray = [Int]((3 * j)..<(3 * (j + 1)))
        
        // Then flatten a 2D array of sudoku cell values corresponding to the index pairs
        return iArray
            .map({ i in
                jArray.map({ j in
                    self[9 * i + j]
                })
            }) // Evaluates to [[Int?]]
            .flatMap({ $0 }) // Flattens [[Int?]] into just [Int?]
            .compactMap({ $0 }) // No nils, casted to [Int]
    }
    
    // all values in the same row
    func rowValues(at index: Int) -> [Int] {
        let i = rowIndex(of: index)
        
        return (0..<9)
            .map({ j in
                self[9 * i + j]
            })
            .compactMap({ $0 })
    }
    
    // all values in the same column
    func columnValues(at index: Int) -> [Int] {
        let j = columnIndex(of: index)
        
        return (0..<9)
            .map({ i in
                self[9 * i + j]
            })
            .compactMap({ $0 })
    }
    
    func existingValues(at index: Int) -> [Int] {
        let v = self[index]
        
        let row = rowValues(at: index).removingFirst(where: { $0 == v })
        let col = columnValues(at: index).removingFirst(where: { $0 == v })
        let reg = regionValues(at: index).removingFirst(where: { $0 == v })
        
        return row + col + reg;
    }
    // possible numbers at this index
    func possibilities(at index: Int) -> [Int] {
        // first find existing values in the cell's row, column, and region
        let row = rowValues(at: index)
        let col = columnValues(at: index)
        let reg = regionValues(at: index)
        
        // possible values are 1...9 minus those values in row, col, and reg
        return [Int](1...9).filter({
            !row.contains($0) && !col.contains($0) && !reg.contains($0)
        })
    }
}

