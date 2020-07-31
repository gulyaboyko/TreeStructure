//
//  BinaryTreePerformanceTests.swift
//  TreeStructureTests
//
//  Created by Gulya Boiko on 7/22/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import XCTest

final class BinaryTreePerformanceTests: XCTestCase {
    static let sutRandomBinaryTree = BinaryTree()
    static let sutRandomAVL = AVLBinaryTree()
    static var tenPersentValues = [Int]() // 1/10 от всего массива
    static var orderedValues: [Int] = []
    static var randomValues: [Int] = []
    
    override class func setUp() {
        for i in 0..<500_000 {
            orderedValues.append(i)
        }
        let firstHalf = orderedValues.dropLast(5_000).shuffled() // Удалить последнии 100
        let secondHalf = orderedValues.dropFirst(495_000)
        randomValues = secondHalf + firstHalf
        tenPersentValues = orderedValues.shuffled().dropLast(450_000)
    }
    
    func test_create_AVLBinaryTree_randomValue() {
        BinaryTreePerformanceTests.randomValues.forEach {
            BinaryTreePerformanceTests.sutRandomAVL.insert(x: $0)
        }
    }
    
    func test_delete_AVLBinaryTree() {
        BinaryTreePerformanceTests.tenPersentValues.forEach {
            BinaryTreePerformanceTests.sutRandomAVL.remove(x: $0)
        }
    }
    
    func test_search_AVLBinaryTree() {
        BinaryTreePerformanceTests.tenPersentValues.forEach {
            XCTAssertTrue(BinaryTreePerformanceTests.sutRandomAVL.search(x: $0))
        }
    }

    func test_createBinaryTree_withRandomValues() {
        BinaryTreePerformanceTests.randomValues.forEach {
            BinaryTreePerformanceTests.sutRandomBinaryTree.insert(x: $0)
        }
    }

    func test_search_inRandomBinaryTree() {
        BinaryTreePerformanceTests.tenPersentValues.forEach {
            XCTAssertTrue(BinaryTreePerformanceTests.sutRandomBinaryTree.search(x: $0))
        }
    }

    func test_delete_inRandomBinaryTree() {
        BinaryTreePerformanceTests.tenPersentValues.forEach {
            BinaryTreePerformanceTests.sutRandomBinaryTree.remove(x: $0)
        }
    }

}
