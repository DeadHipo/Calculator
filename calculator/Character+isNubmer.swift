//
//  Character+isNubmer.swift
//  calculator
//
//  Created by  NearlyDeadHipo on 28.09.16.
//  Copyright © 2016  NearlyDeadHipo. All rights reserved.
//

import Foundation

extension Character {
    var isNumber: Bool {
        get {
            switch self {
            case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ".":
                return true
            default:
                return false
            }
        }
    }
}
