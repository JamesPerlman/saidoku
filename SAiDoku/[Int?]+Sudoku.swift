//
//  [Int]+Sudoku.swift
//  SAiDoku
//
//  Created by James Perlman on 6/29/18.
//  Copyright © 2018 SAiD. All rights reserved.
//

import Foundation

extension Array where Element == Int? {
    // all values in the same region
    func regionSet(of index: Int) -> IndexSet {
        let row = rowIndex(of: index)
        let column = columnIndex(of: index)
        
        let i = sectionIndex(of: column)
        let j = sectionIndex(of: row)
        
        // We are about to create a 1-dimensional array of values
        // First gather arrays of index pairs in x and y components
        
        let iArray = [Int]((3 * i)..<(3 * (i + 1)))
        let jArray = [Int]((3 * j)..<(3 * (j + 1)))
        
        // Then flatten a 2D array of sudoku cell values corresponding to the index pairs
        let values = iArray
            .map({ i in
                jArray.map({ j in
                    self[9 * i + j]
                })
            }) // Evaluates to [[Int?]]
            .flatMap({ $0 }) // Flattens [[Int?]] into just [Int?]
            .compactMap({ $0 }) // No nils, casted to [Int]
        
        return IndexSet(values)
    }
    
    // all values in the same row
    func rowSet(of index: Int) -> IndexSet {
        let j = rowIndex(of: index)
        
        let values = (0..<9)
            .map({ i in
                self[9 * i + j]
            })
            .compactMap({ $0 })
        
        return IndexSet(values)
    }
    
    // all values in the same column
    func columnSet(of index: Int) -> IndexSet {
        let i = columnIndex(of: index)
        
        let values = (0..<9)
            .map({ j in
                self[9 * i + j]
            })
            .compactMap({ $0 })
        
        return IndexSet(values)
    }
}

