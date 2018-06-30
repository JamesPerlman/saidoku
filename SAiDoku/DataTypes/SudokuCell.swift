//
//  SudokuCell.swift
//  SAiDoku
//
//  Created by James Perlman on 6/30/18.
//  Copyright © 2018 SAiD. All rights reserved.
//

import Foundation

// A single cell
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
    
    var description: String {
        return "index: \(index),\n value: \(value),\n poss: \(possibilities)\n";
    }
}
