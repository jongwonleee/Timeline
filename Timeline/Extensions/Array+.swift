//
//  Array+.swift
//  Timeline
//
//  Created by user on 2021/12/01.
//

import Foundation

public extension Array {
    subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}
