//
//  Int+initWithCharacter.swift
//  SAiDoku
//
//  Created by James Perlman on 6/29/18.
//  Copyright © 2018 SAiD. All rights reserved.
//

import Foundation

extension Int {
    init?(_ char: Character) {
        self.init(String(char))
    }
}
