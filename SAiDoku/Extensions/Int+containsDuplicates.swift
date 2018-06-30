//
//  Int+containsDuplicates.swift
//  SAiDoku
//
//  Created by James Perlman on 6/29/18.
//  Copyright © 2018 SAiD. All rights reserved.
//

import Foundation
extension Array where Element == Int {
    var containsDuplicates: Bool {
        return filter({ i in self.filter({ $0 == i }).count > 1}).count > 1
    }
}
