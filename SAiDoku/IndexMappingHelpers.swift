//
//  IndexMappingHelpers.swift
//  SAiDoku
//
//  Created by James Perlman on 6/29/18.
//  Copyright © 2018 SAiD. All rights reserved.
//

import Foundation

func index(of row: Int, at column: Int) -> Int {
    return 9 * column + row;
}

func rowIndex(of index: Int) -> Int {
    return index / 9
}

func columnIndex(of index: Int) -> Int {
    return index - 9 * (index / 9)
}

// returns the section index of a row or column index
func sectionIndex(of regionIndex: Int) -> Int {
    return (regionIndex + 3) / 3 - 1;
}
