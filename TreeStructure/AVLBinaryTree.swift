//
//  AVLBinaryTree.swift
//  TreeStructure
//
//  Created by Gulya Boiko on 7/22/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import Foundation

final class AVLBinaryTree: BinaryTree {
    
    @discardableResult
    override func insert(x: Int) -> Node {
        var node = super.insert(x: x)
        recalculateHeight(node)
        rebalance(node: &node)
        return node
    }
    
    @discardableResult
    override func remove(x: Int) -> Node? {
        guard var node = searchNode(x: x) else { return nil }
        if node.rightChild == nil && node.leftChild == nil {
            // This is a leaf or root with 1 node
            if var p = node.parent {
                p.value < node.value ? (p.rightChild = nil) : (p.leftChild = nil)
                recalculateHeight(p)
                if abs(p.balance) == 2 {
                    rebalance(node: &p)
                }
                
            } else {
                root = nil
            }
        } else {
            // Has left and/or right child
            var nodeToRebalance: Node!
            let p = node.parent
            var l = node.leftChild
            var r = node.rightChild
            let height = node.height
            if node.balance > 0 { // there is a left child
                let maxNode = findMax(in: node.leftChild!)
                super.remove(x: maxNode.value)
                l = node.leftChild
                node = maxNode
                nodeToRebalance = l == nil ? node : node.parent
            } else {
                let minNode = findMin(in: node.rightChild!)
                super.remove(x: minNode.value)
                r = node.rightChild
                node = minNode
                nodeToRebalance = r == nil ? node : node.parent
            }
            node.leftChild = l
            node.rightChild = r
            node.height = height
            if let p = p {
                p.value < node.value ? (p.rightChild = node) : (p.leftChild = node)
            } else {
                root = node
            }
            recalculateHeight(nodeToRebalance)
            if abs(nodeToRebalance.balance) == 2 {
                rebalance(node: &nodeToRebalance)
            }
        }
        return node
    }
    
    private func findMax(in node: Node) -> Node {
        var maxNode = node
        while true {
            if let rightChild = maxNode.rightChild {
                maxNode = rightChild
            } else {
                return maxNode
            }
        }
    }
    
    private func findMin(in node: Node) -> Node {
        var minNode = node
        while true {
            if let leftChild = minNode.leftChild {
                minNode = leftChild
            } else {
                return minNode
            }
        }
    }
    
    func rebalance(node: inout Node) {
        if abs(node.balance) == 2 {
            if node.balance == 2 { // right rotation
                if (node.leftChild?.rightChild?.height ?? 0) <= (node.leftChild?.leftChild?.height ?? 0) {
                    smallRightRotation(&node)
                } else {
                    bigRightRotation(&node)
                }
                recalculateHeight(node.rightChild!)
                if node.leftChild != nil {
                    recalculateHeight(node.leftChild!)
                }
            } else { // left rotation
                if (node.rightChild?.leftChild?.height ?? 0) <= (node.rightChild?.rightChild?.height ?? 0){
                    smallLeftRotation(&node)
                } else {
                    bigLeftRotation(&node)
                }
                recalculateHeight(node.leftChild!)
                if node.rightChild != nil {
                    recalculateHeight(node.rightChild!)
                }
            }
        } else if var parent = node.parent {
            rebalance(node: &parent)
            if parent.parent == nil {
                root = parent
            }
        }
    }
    
    private func bigLeftRotation(_ node: inout Node) {
        guard var b = node.rightChild else { return }
        smallRightRotation(&b)
        smallLeftRotation(&node)
    }
    
    private func bigRightRotation(_ node: inout Node) {
        guard var b = node.leftChild else { return }
        smallLeftRotation(&b)
        smallRightRotation(&node)
    }
    
    private func smallLeftRotation(_ node: inout Node) {
        guard let b = node.rightChild else { return }
        let parent = node.parent
        let nodeIsRightChild = parent?.rightChild?.value == node.value
        let c = node.rightChild?.leftChild
        let a = node
        a.rightChild = nil
        b.leftChild = nil
        node = b
        node.leftChild = a
        a.rightChild = c
        if parent != nil {
            nodeIsRightChild ? (parent?.rightChild = node) : (parent?.leftChild = node)
        } else {
           node.parent = parent
        }
    }
    
    private func smallRightRotation(_ node: inout Node) {
        guard let b = node.leftChild else { return }
        let parent = node.parent
        let nodeIsRightChild = parent?.rightChild?.value == node.value
        let c = node.leftChild?.rightChild
        let a = node
        a.leftChild = nil
        b.rightChild = nil
        node = b
        node.rightChild = a
        a.leftChild = c
        if parent != nil {
            nodeIsRightChild ? (parent?.rightChild = node) : (parent?.leftChild = node)
        } else {
            node.parent = parent
        }
    }
    
    private func recalculateHeight(_ node: Node) {
        var subtree: Node? = node
        while subtree != nil {
            let oldHeight = subtree?.height
            subtree?.height = max((subtree?.rightChild?.height ?? 0), (subtree?.leftChild?.height ?? 0)) + 1
            if oldHeight == subtree?.height, subtree?.parent?.height == subtree!.height + 1 { return }
            subtree = subtree?.parent
        }
    }
        
}

extension Node {
    private static var _height = [String: Int]()
    
    var height: Int {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return Node._height[tmpAddress] ?? 1
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            Node._height[tmpAddress] = newValue
        }
    }
    var balance: Int {
        return (leftChild?.height ?? 0) - (rightChild?.height ?? 0)
    }
}
