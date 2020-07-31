//
//  Node.swift
//  TreeStructure
//
//  Created by Gulya Boiko on 7/20/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import Foundation

class Node {
    let value: Int
    var parent: Node?
    var leftChild: Node? {
        didSet {
            leftChild?.parent = self
        }
    }
    var rightChild: Node? {
        didSet {
            rightChild?.parent = self
        }
    }

    required init(value: Int) {
        self.value = value
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        var s = ""
        if let left = leftChild {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = rightChild {
            s += " -> (\(right.description))"
        }
        return s
    }
}
