//
//  BinaryTree.swift
//  TreeStructure
//
//  Created by Gulya Boiko on 7/20/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import Foundation

class BinaryTree {
    var root: Node? {
        didSet {
            root?.parent = nil
        }
    }
    
    @discardableResult
    func insert(x: Int) -> Node {
        guard let root = root else {
            self.root = Node(value: x)
            return self.root.unsafelyUnwrapped
        }
        var subtree = root
        while true {
            if x > subtree.value { // Add to right subtree
                if let rightNode = subtree.rightChild {
                    subtree = rightNode
                } else {
                    subtree.rightChild = Node(value: x)
                    return subtree.rightChild.unsafelyUnwrapped
                }
            } else { // Add to left subtree
                if let leftNode = subtree.leftChild {
                    subtree = leftNode
                } else {
                    subtree.leftChild = Node(value: x)
                    return subtree.leftChild.unsafelyUnwrapped
                }
            }
        }
    }
    
    func search(x: Int) -> Bool {
        var subtree: Node? = root
        while subtree != nil {
            if x == subtree?.value { return true }
            if x < subtree.unsafelyUnwrapped.value { // Search from left subtree
                subtree = subtree?.leftChild
            } else { // Search from right subtree
                subtree = subtree?.rightChild
            }
        }
        return false
    }
    
    @discardableResult
    func remove(x: Int) -> Node? {
        guard let node = searchNode(x: x) else { return nil }
        if let parent = node.parent { // There is a parent
            if parent.value > node.value { // delete node from left side
                if let l1 = node.leftChild {
                    parent.leftChild = l1
                    insertSubtree(root: l1, subtree: node.rightChild)
                } else {
                    parent.leftChild = node.rightChild
                }
            } else { // delete node from right side
                if let r1 = node.rightChild {
                    parent.rightChild = r1
                    insertSubtree(root: r1, subtree: node.leftChild)
                } else {
                    parent.rightChild = node.leftChild
                }
            }
        } else { // remote root
            if let rightChild = node.rightChild {
                root = rightChild
                insertSubtree(root: rightChild, subtree: node.leftChild)
            } else if let leftChild = node.leftChild {
                root = leftChild
            } else {
                root = nil
            }
        }
        return node
    }
    
    internal func searchNode(x: Int) -> Node? {
        var subtree: Node? = root
        while subtree != nil {
            if x == subtree?.value { return subtree }
            if x < subtree.unsafelyUnwrapped.value { // Search from left subtree
                subtree = subtree?.leftChild
            } else { // Search from right subtree
                subtree = subtree?.rightChild
            }
        }
        return nil
    }
    
    func insertSubtree(root: Node, subtree: Node?) {
        guard let subtree = subtree else { return }
        var root = root
        while true {
            if root.value > subtree.value { // search place from the left
                if let leftChild = root.leftChild {
                    root = leftChild
                } else {
                    root.leftChild = subtree
                    return
                }
            } else { // search place from the right
                if let rightChild = root.rightChild {
                    root = rightChild
                } else {
                    root.rightChild = subtree
                    return
                }
            }
        }
    }
        
}
