//
//  BinaryTreeTests.swift
//  TreeStructureTests
//
//  Created by Gulya Boiko on 7/22/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import XCTest

final class BinaryTreeTests: XCTestCase {

    func test_binaryTree_insert() {
        let sut = BinaryTree()
        XCTAssertNil(sut.root)
        sut.insert(x: 0)
        XCTAssert(sut.root?.value == 0)
        XCTAssertNil(sut.root?.parent)
        XCTAssertNil(sut.root?.rightChild)
        XCTAssertNil(sut.root?.leftChild)
        sut.insert(x: 5)
        XCTAssert(sut.root?.value == 0)
        XCTAssertNil(sut.root?.parent)
        XCTAssertNotNil(sut.root?.rightChild)
        XCTAssert(sut.root?.rightChild?.value == 5)
        XCTAssert(sut.root?.rightChild?.parent?.value == 0)
        XCTAssertNil(sut.root?.leftChild)
        sut.insert(x: 10)
        sut.insert(x: 3)
        sut.insert(x: 15)
        sut.insert(x: 31)
        sut.insert(x: 7)
        sut.insert(x: 8)
        sut.insert(x: 1)
        sut.insert(x: 13)
        sut.insert(x: -13)
        XCTAssert(sut.root?.value == 0)
        XCTAssertNil(sut.root?.parent)
        XCTAssert(sut.root?.rightChild?.value == 5)
        XCTAssert(sut.root?.rightChild?.parent?.value == 0)
        XCTAssert(sut.root?.leftChild?.value == -13)
        XCTAssert(sut.root?.leftChild?.parent?.value == 0)
        XCTAssert(sut.root?.rightChild?.rightChild?.value == 10)
        XCTAssert(sut.root?.rightChild?.leftChild?.value == 3)
        XCTAssertNil(sut.root?.rightChild?.leftChild?.rightChild)
        XCTAssert(sut.root?.rightChild?.leftChild?.leftChild?.value == 1)
        XCTAssert(sut.root?.rightChild?.rightChild?.rightChild?.rightChild?.value == 31)
        XCTAssert(sut.root?.rightChild?.rightChild?.rightChild?.rightChild?.parent?.value == 15)
        XCTAssert(sut.root?.rightChild?.rightChild?.rightChild?.rightChild?.parent?.leftChild?.value == 13)
    }
    
    func test_binaryTree_search() {
        let sut = BinaryTree()
        sut.insert(x: 0)
        XCTAssertTrue(sut.search(x: 0))
        sut.insert(x: 5)
        sut.insert(x: 10)
        sut.insert(x: 3)
        sut.insert(x: 15)
        sut.insert(x: 31)
        sut.insert(x: 7)
        sut.insert(x: 8)
        sut.insert(x: 1)
        sut.insert(x: 13)
        sut.insert(x: -13)
        XCTAssertTrue(sut.search(x: 0))
        XCTAssertTrue(sut.search(x: 13))
        XCTAssertTrue(sut.search(x: 31))
        XCTAssertTrue(sut.search(x: -13))
        XCTAssertFalse(sut.search(x: 100))
        XCTAssertFalse(sut.search(x: 11))
    }
    
    func test_binaryTree_remove_element_from_1() {
        let sut = BinaryTree()
        /// Remove 1 element from 1
        sut.insert(x: 0)
        sut.remove(x: 0)
        XCTAssertNil(sut.root)
    }
    
    func test_binaryTree_remove_element_from_2() {
        let sut = BinaryTree()
        /// Remove 1 element from 2
        // Remove root 0 with right child: 0 -> 10
        sut.insert(x: 0)
        sut.insert(x: 10)
        sut.remove(x: 0)
        XCTAssert(sut.root?.value == 10)
        XCTAssertNil(sut.root?.rightChild)
        XCTAssertNil(sut.root?.leftChild)
        // Remove right child 20: 10 -> 20
        sut.insert(x: 20)
        sut.remove(x: 20)
        XCTAssert(sut.root?.value == 10)
        XCTAssertNil(sut.root?.rightChild)
        XCTAssertNil(sut.root?.leftChild)
        // Remove root 10 with left child: -10 <- 10
        sut.insert(x: -10)
        sut.remove(x: 10)
        XCTAssert(sut.root?.value == -10)
        XCTAssertNil(sut.root?.rightChild)
        XCTAssertNil(sut.root?.leftChild)
        // Remove left child -20: -20 <- -10
        sut.insert(x: -20)
        sut.remove(x: -20)
        XCTAssert(sut.root?.value == -10)
    }
    
    func test_binaryTree_remove_element_from_3() {
        let sut = BinaryTree()
        // Remove root
        sut.insert(x: 5)
        sut.insert(x: 10)
        sut.insert(x: 3)
        sut.remove(x: 5)
        XCTAssert(sut.root?.value == 10)
        XCTAssertNil(sut.root?.rightChild)
        XCTAssert(sut.root?.leftChild?.value == 3)
        // Remove left child
        sut.insert(x: 15)
        sut.remove(x: 3)
        XCTAssert(sut.root?.value == 10)
        XCTAssertNil(sut.root?.leftChild)
        XCTAssert(sut.root?.rightChild?.value == 15)
        // Remove right child
        sut.insert(x: 3)
        sut.remove(x: 15)
        XCTAssert(sut.root?.value == 10)
        XCTAssertNil(sut.root?.rightChild)
        XCTAssert(sut.root?.leftChild?.value == 3)
    }
    
    func test_binaryTree_remove_element_from_11() {
        let sut = BinaryTree()
        sut.insert(x: 60); sut.insert(x: 80); sut.insert(x: 90); sut.insert(x: 88)
        sut.insert(x: 70); sut.insert(x: 75); sut.insert(x: 40); sut.insert(x: 30)
        sut.insert(x: 20); sut.insert(x: 48); sut.insert(x: 42); sut.insert(x: 49)
        //                       <- 60 ->
        //          <- 40 ->                     <- 80 ->
        //   <- 30       <- 48 ->          70 ->          <- 90
        // 20          42        49             75      88
        // Remove root 60
        sut.remove(x: 60)
        XCTAssert(sut.root?.value == 80)
        XCTAssert(sut.root?.rightChild?.value == 90)
        XCTAssertNil(sut.root?.rightChild?.rightChild)
        XCTAssert(sut.root?.rightChild?.leftChild?.value == 88)
        XCTAssert(sut.root?.leftChild?.value == 70)
        XCTAssert(sut.root?.leftChild?.rightChild?.value == 75)
        XCTAssert(sut.root?.leftChild?.leftChild?.value == 40)
        //                            <- 80 ->
        //                   <- 70 ->            <- 90
        //             <- 40 ->      75        88
        //   <- 30       <- 48 ->
        // 20          42        49
        // Remove leaf 20 and 49
        sut.remove(x: 20)
        sut.remove(x: 49)
        XCTAssert(sut.root?.leftChild?.leftChild?.leftChild?.value == 30)
        XCTAssertNil(sut.root?.leftChild?.leftChild?.leftChild?.rightChild)
        XCTAssertNil(sut.root?.leftChild?.leftChild?.leftChild?.leftChild)
        XCTAssert(sut.root?.leftChild?.leftChild?.rightChild?.value == 48)
        XCTAssertNil(sut.root?.leftChild?.leftChild?.rightChild?.rightChild)
        XCTAssert(sut.root?.leftChild?.leftChild?.rightChild?.leftChild?.value == 42)
        //                       <- 80 ->
        //              <- 70 ->           <- 90
        //        <- 40 ->      75       88
        //     30        <- 48
        //             42
        // Remove from middle
        // Remove leaf 40
        sut.remove(x: 40)
        XCTAssert(sut.root?.leftChild?.leftChild?.value == 30)
        XCTAssertNil(sut.root?.leftChild?.leftChild?.leftChild)
        XCTAssert(sut.root?.leftChild?.leftChild?.rightChild?.value == 48)
        XCTAssertNil(sut.root?.leftChild?.leftChild?.rightChild?.rightChild)
        XCTAssert(sut.root?.leftChild?.leftChild?.rightChild?.leftChild?.value == 42)
        //                        <- 80 ->
        //              <- 70 ->            <- 90
        //           30 ->      75        88
        //               <- 48
        //            42
        // Remove leaf 48
        sut.remove(x: 48)
        // Expect
        //                        <- 80 ->
        //              <- 70 ->            <- 90
        //            30 ->      75        88
        //                 42
        XCTAssert(sut.root?.leftChild?.leftChild?.value == 30)
        XCTAssert(sut.root?.leftChild?.leftChild?.rightChild?.value == 42)
        XCTAssertNil(sut.root?.leftChild?.leftChild?.leftChild)
        XCTAssertNil(sut.root?.leftChild?.leftChild?.rightChild?.rightChild)
        XCTAssertNil(sut.root?.leftChild?.leftChild?.rightChild?.leftChild)
    }
    
    func test_insertSubtree() {
        // sut1
        //        <- 10 ->
        //      9         15
        let sut1 = BinaryTree()
        sut1.insert(x: 10)
        sut1.insert(x: 15)
        sut1.insert(x: 9)
        // sut2
        //          <- 7 ->
        //      6            8
        let sut2 = BinaryTree()
        sut2.insert(x: 7)
        sut2.insert(x: 6)
        sut2.insert(x: 8)
        sut2.insertSubtree(root: sut2.root!, subtree: sut1.root)
        // Insert sut1 into sut2
        // Expect Result
        //               <- 7 ->
        //           6            8 ->
        //                          <- 10 ->
        //                        9          15
        XCTAssert(sut2.root?.value == 7)
        XCTAssert(sut2.root?.rightChild?.value == 8)
        XCTAssert(sut2.root?.rightChild?.rightChild?.value == 10)
        XCTAssert(sut2.root?.rightChild?.rightChild?.rightChild?.value == 15)
        XCTAssert(sut2.root?.rightChild?.rightChild?.leftChild?.value == 9)
        // Set sut2 to init state
        sut2.remove(x: 10)
        sut2.remove(x: 9)
        sut2.remove(x: 15)
        
        sut1.insertSubtree(root: sut1.root!, subtree: sut2.root)
        // Insert sut2 into sut1
        // Expect Result
        //             <- 10 ->
        //        <- 9            15
        //    <-  7  ->
        //   6         8
        XCTAssert(sut1.root?.value == 10)
        XCTAssert(sut1.root?.rightChild?.value == 15)
        XCTAssertNil(sut1.root?.rightChild?.rightChild)
        XCTAssertNil(sut1.root?.rightChild?.leftChild)
        XCTAssert(sut1.root?.leftChild?.leftChild?.value == 7)
        XCTAssert(sut1.root?.leftChild?.leftChild?.rightChild?.value == 8)
        XCTAssert(sut1.root?.leftChild?.leftChild?.leftChild?.value == 6)
    }

}
