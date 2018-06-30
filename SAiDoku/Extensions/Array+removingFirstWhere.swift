//
//  Array+removingFirstWhere.swift
//  SAiDoku
//
//  Created by James Perlman on 6/29/18.
//  Copyright © 2018 SAiD. All rights reserved.
//

import Foundation

extension Array {
    func removingFirst(where predicate: (Element) -> Bool) -> Array<Element> {
        
        if let (i, _) = enumerated().first(where: { _, e in predicate(e) }) {
            return self.enumerated().filter({ j, _ in i != j }).map({ $1 })
        } else {
            return self
        }
        
        
    }
}
