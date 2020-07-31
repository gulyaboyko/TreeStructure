//
//  AVLBinaryTreeTests.swift
//  TreeStructureTests
//
//  Created by Gulya Boiko on 7/22/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import XCTest

final class AVLBinaryTreeTests: XCTestCase {
    
    func test_smallRightRotation_2nodes() {
        let sut = BinaryTree()
        sut.insert(x: 2)
        sut.insert(x: 1)
        sut.insert(x: 0)
        //      <- 2
        //    <- 1
        //  0
        smallRightRotation(&sut.root!.leftChild!) // for 0
        // Expect
        //      <- 2
        //   0 ->
        //       1
        XCTAssert(sut.root?.value == 2)
        XCTAssert(sut.root?.leftChild?.value == 0)
        XCTAssert(sut.root?.leftChild?.rightChild?.value == 1)
        sut.remove(x: 1)
        sut.remove(x: 0)
        sut.insert(x: 5)
        sut.insert(x: 3)
        //      2 ->
        //         <- 5
        //       3
        smallRightRotation(&sut.root!.rightChild!) // for 5
        // Expect
        //      2 ->
        //          3 ->
        //              5
        XCTAssert(sut.root?.value == 2)
        XCTAssert(sut.root?.rightChild?.value == 3)
        XCTAssert(sut.root?.rightChild?.rightChild?.value == 5)
    }
    
    func test_smallLeftRotation_2nodes() {
        let sut = BinaryTree()
        sut.insert(x: 2)
        sut.insert(x: 0)
        sut.insert(x: 1)
        //       <- 2
        //    0 ->
        //        1
        smallLeftRotation(&sut.root!.leftChild!) // for 0
        // Expect
        //       <- 2
        //   <- 1
        // 0
        XCTAssert(sut.root?.value == 2)
        XCTAssert(sut.root?.leftChild?.value == 1)
        XCTAssert(sut.root?.leftChild?.leftChild?.value == 0)
        
        sut.remove(x: 0)
        sut.remove(x: 1)
        sut.remove(x: 2)
        sut.insert(x: 0)
        sut.insert(x: 1)
        sut.insert(x: 2)
        //      0 ->
        //        1 ->
        //            2
        smallLeftRotation(&sut.root!.rightChild!) // for 1
        // Expect
        //      0 ->
        //         <- 2
        //        1
        XCTAssert(sut.root?.value == 0)
        XCTAssert(sut.root?.rightChild?.value == 2)
        XCTAssert(sut.root?.rightChild?.leftChild?.value == 1)
    }
    
    func test_smallLeftRotation_3nodes() {
        let sut = BinaryTree()
        sut.insert(x: 20)
        sut.insert(x: 10)
        sut.insert(x: 11)
        sut.insert(x: 7)
        //         <- 20
        //   <- 10 ->
        // 7         11
        smallLeftRotation(&sut.root!.leftChild!) // for 10
        // Expect
        //           <- 20
        //        <- 11
        //     <- 10
        //   7
        XCTAssert(sut.root?.value == 20)
        XCTAssertNil(sut.root?.rightChild)
        XCTAssert(sut.root?.leftChild?.value == 11)
        XCTAssertNil(sut.root?.leftChild?.rightChild)
        XCTAssert(sut.root?.leftChild?.leftChild?.value == 10)
        XCTAssertNil(sut.root?.leftChild?.leftChild?.rightChild)
        XCTAssert(sut.root?.leftChild?.leftChild?.leftChild?.value == 7)
        XCTAssertNil(sut.root?.leftChild?.leftChild?.leftChild?.rightChild)
        XCTAssertNil(sut.root?.leftChild?.leftChild?.leftChild?.leftChild)
    }
    
    func test_smallLeftRotation_4nodes_v1() {
        let sut = BinaryTree()
        sut.insert(x: 20)
        sut.insert(x: 10)
        sut.insert(x: 18)
        sut.insert(x: 7)
        sut.insert(x: 13)
        //         <- 20
        //   <- 10 ->
        // 7       <-  18
        //        13
        smallLeftRotation(&sut.root!.leftChild!) // for 10
        // Expect
        //           <- 20
        //        <- 18
        //     <- 10 ->
        //   7         13
        XCTAssert(sut.root?.value == 20)
        XCTAssertNil(sut.root?.rightChild)
        XCTAssert(sut.root?.leftChild?.value == 18)
        XCTAssertNil(sut.root?.leftChild?.rightChild)
        XCTAssert(sut.root?.leftChild?.leftChild?.value == 10)
        XCTAssert(sut.root?.leftChild?.leftChild?.rightChild?.value == 13)
        XCTAssert(sut.root?.leftChild?.leftChild?.leftChild?.value == 7)
    }
    
    func test_smallLeftRotation_4nodes_v2() {
        let sut = BinaryTree()
        sut.insert(x: 20)
        sut.insert(x: 10)
        sut.insert(x: 18)
        sut.insert(x: 7)
        sut.insert(x: 19)
        //         <- 20
        //   <- 10 ->
        // 7        18 ->
        //               19
        smallLeftRotation(&sut.root!.leftChild!) // for 10
        // Expect
        //             <- 20
        //       <- 18 ->
        //   <- 10       19
        // 7
        XCTAssert(sut.root?.value == 20)
        XCTAssertNil(sut.root?.rightChild)
        XCTAssert(sut.root?.leftChild?.value == 18)
        XCTAssert(sut.root?.leftChild?.rightChild?.value == 19)
        XCTAssert(sut.root?.leftChild?.leftChild?.value == 10)
        XCTAssert(sut.root?.leftChild?.leftChild?.leftChild?.value == 7)
    }
    
    func test_smallLeftRotation_5nodes() {
        let sut = BinaryTree()
        sut.insert(x: 20)
        sut.insert(x: 10)
        sut.insert(x: 18)
        sut.insert(x: 7)
        sut.insert(x: 19)
        sut.insert(x: 15)
        //         <- 20
        //   <- 10 ->
        // 7      <- 18 ->
        //      15        19
        smallLeftRotation(&sut.root!.leftChild!) // for 10
        // Expect
        //                 <- 20
        //           <- 18 ->
        //    <- 10 ->     19
        //  7         15
        XCTAssert(sut.root?.value == 20)
        XCTAssert(sut.root?.leftChild?.value == 18)
        XCTAssert(sut.root?.leftChild?.rightChild?.value == 19)
        XCTAssertNil(sut.root?.leftChild?.rightChild?.rightChild)
        XCTAssertNil(sut.root?.leftChild?.rightChild?.leftChild)
        XCTAssert(sut.root?.leftChild?.leftChild?.value == 10)
        XCTAssert(sut.root?.leftChild?.leftChild?.rightChild?.value == 15)
        XCTAssertNil(sut.root?.leftChild?.leftChild?.rightChild?.rightChild)
        XCTAssertNil(sut.root?.leftChild?.leftChild?.rightChild?.leftChild)
        XCTAssert(sut.root?.leftChild?.leftChild?.leftChild?.value == 7)
    }
    
    func test_insert_inOrder() {
        let sut = AVLBinaryTree()
        sut.insert(x: 0); sut.insert(x: 1); sut.insert(x: 2);
        //       <- 1 ->
        //    0           2
        XCTAssert(sut.root?.value == 1)
        XCTAssert(sut.root?.rightChild?.value == 2)
        XCTAssert(sut.root?.leftChild?.value == 0)
        XCTAssert(sut.root?.height == 2)
        XCTAssert(sut.root?.rightChild?.height == 1)
        XCTAssert(sut.root?.leftChild?.height == 1)
        sut.insert(x: 3); sut.insert(x: 4); sut.insert(x: 5); sut.insert(x: 6);
        sut.insert(x: 7); sut.insert(x: 8); sut.insert(x: 9); sut.insert(x: 10);
        //              <- 3 ->
        //      <- 1                <- 7 ->
        //   0               <- 5 ->        <- 9 ->
        //                 4         6     8       10
        XCTAssert(sut.root?.value == 3)
        XCTAssert(sut.root?.height == 4)
        XCTAssert(sut.root?.rightChild?.value == 7)
        XCTAssert(sut.root?.rightChild?.height == 3)
        XCTAssert(sut.root?.leftChild?.value == 1)
        XCTAssert(sut.root?.leftChild?.height == 2)
        XCTAssert(sut.root?.leftChild?.leftChild?.value == 0)
        XCTAssert(sut.root?.leftChild?.leftChild?.height == 1)
        XCTAssert(sut.root?.rightChild?.rightChild?.value == 9)
        XCTAssert(sut.root?.rightChild?.rightChild?.height == 2)
        XCTAssert(sut.root?.rightChild?.rightChild?.rightChild?.value == 10)
        XCTAssert(sut.root?.rightChild?.rightChild?.rightChild?.height == 1)
        XCTAssert(sut.root?.rightChild?.rightChild?.leftChild?.value == 8)
        XCTAssert(sut.root?.rightChild?.rightChild?.leftChild?.height == 1)
        XCTAssert(sut.root?.rightChild?.leftChild?.value == 5)
        XCTAssert(sut.root?.rightChild?.leftChild?.height == 2)
        XCTAssert(sut.root?.rightChild?.leftChild?.rightChild?.value == 6)
        XCTAssert(sut.root?.rightChild?.leftChild?.rightChild?.height == 1)
        XCTAssert(sut.root?.rightChild?.leftChild?.leftChild?.value == 4)
        XCTAssert(sut.root?.rightChild?.leftChild?.leftChild?.height == 1)
    }
    
    func test_recalculateHeight() {
        let sut = AVLBinaryTree()
        sut.insert(x: 17)
        // Expect 17
        XCTAssert(sut.root?.height == 1)
        // Expect 13 <- 17
        sut.insert(x: 13)
        XCTAssert(sut.root?.height == 2)
        XCTAssert(sut.root?.leftChild?.height == 1)
        sut.insert(x: 6) // rebalance
        // expect  6 <- 13 -> 17
        XCTAssert(sut.root?.height == 2)
        XCTAssert(sut.root?.leftChild?.height == 1)
        XCTAssert(sut.root?.rightChild?.height == 1)
        sut.insert(x: 1)
        // expect 1 <- 6 <- 13 -> 17
        XCTAssert(sut.root?.height == 3)
        XCTAssert(sut.root?.rightChild?.height == 1)
        XCTAssert(sut.root?.leftChild?.height == 2)
        XCTAssert(sut.root?.leftChild?.leftChild?.height == 1)
        sut.insert(x: 5)
        // expect
        //     5 <- 13 -> 17
        //   1   6
        XCTAssert(sut.root?.height == 3)
        XCTAssert(sut.root?.rightChild?.height == 1)
        XCTAssert(sut.root?.leftChild?.height == 2)
        XCTAssert(sut.root?.leftChild?.leftChild?.height == 1)
        XCTAssert(sut.root?.leftChild?.rightChild?.height == 1)
    }
    
    func test_insert_randomValues() {
        let sut = AVLBinaryTree()
        sut.insert(x: 23);sut.insert(x: 9);sut.insert(x: 37);sut.insert(x: 17)
        sut.insert(x: 12);sut.insert(x: 35);sut.insert(x: 33);sut.insert(x: 44)
        sut.insert(x: 13);sut.insert(x: 3);sut.insert(x: 5);sut.insert(x: 32)
        sut.insert(x: 45);sut.insert(x: 6);sut.insert(x: 25);sut.insert(x: 46)
        sut.insert(x: 2);sut.insert(x: 30);sut.insert(x: 47);sut.insert(x: 22)
        sut.insert(x: 49);sut.insert(x: 11);sut.insert(x: 24);sut.insert(x: 34)
        sut.insert(x: 36);sut.insert(x: 31);sut.insert(x: 42);sut.insert(x: 21)
        sut.insert(x: 8);sut.insert(x: 20);sut.insert(x: 14);sut.insert(x: 16)
        sut.insert(x: 38);sut.insert(x: 29);sut.insert(x: 27);sut.insert(x: 48)
        sut.insert(x: 4);sut.insert(x: 26);sut.insert(x: 43);sut.insert(x: 0)
        sut.insert(x: 18);sut.insert(x: 1);sut.insert(x: 15);sut.insert(x: 39)
        sut.insert(x: 7);sut.insert(x: 10);sut.insert(x: 28);sut.insert(x: 40)
        sut.insert(x: 41);sut.insert(x: 19);
        XCTAssert(sut.root?.value == 23)
        XCTAssert(sut.root?.height == 6)
        XCTAssert(sut.root?.leftChild?.leftChild?.leftChild?.leftChild?.rightChild?.value == 2)
        XCTAssert(sut.root?.rightChild?.leftChild?.leftChild?.rightChild?.value == 27)
        XCTAssert(sut.root?.rightChild?.leftChild?.leftChild?.rightChild?.height == 2)
    }
    
    func test_search() {
        let sut = AVLBinaryTree()
        XCTAssertFalse(sut.search(x: 0))
        sut.insert(x: 0); sut.insert(x: 1); sut.insert(x: 2);
        sut.insert(x: 3); sut.insert(x: 4); sut.insert(x: 5); sut.insert(x: 6);
        sut.insert(x: 7); sut.insert(x: 8); sut.insert(x: 9); sut.insert(x: 10);
        XCTAssertFalse(sut.search(x: 110))
        XCTAssertFalse(sut.search(x: -10))
        XCTAssertFalse(sut.search(x: 11))
        XCTAssertTrue(sut.search(x: 0))
        XCTAssertTrue(sut.search(x: 10))
        XCTAssertTrue(sut.search(x: 4))
        XCTAssertTrue(sut.search(x: 8))
        XCTAssertTrue(sut.search(x: 2))
    }
    
    func test_remove_1Node() {
        let sut = AVLBinaryTree()
        sut.insert(x: 0)
        XCTAssert(sut.root?.value == 0)
        XCTAssert(sut.root?.height == 1)
        sut.remove(x: 0)
        XCTAssertNil(sut.root)
    }
    
    func test_remove_2Nodes() {
        let sut = AVLBinaryTree()
        sut.insert(x: 0)
        sut.insert(x: 1)
        XCTAssert(sut.root?.height == 2)
        // 0 -> 1
        sut.remove(x: 1)
        // expect 0
        XCTAssert(sut.root?.value == 0)
        XCTAssert(sut.root?.height == 1)
        sut.insert(x: -1)
        // -1 <- 0
        sut.remove(x: -1)
        // expect 0
        XCTAssert(sut.root?.value == 0)
        XCTAssert(sut.root?.height == 1)
        sut.insert(x: 1)
        // 0 -> 1
        sut.remove(x: 0)
        // expect 1
        XCTAssert(sut.root?.value == 1)
        XCTAssert(sut.root?.height == 1)
        sut.insert(x: 0)
        // 0 <- 1
        sut.remove(x: 1)
        // expect 0
        XCTAssert(sut.root?.value == 0)
        XCTAssert(sut.root?.height == 1)
    }
    
    func test_remove_3Nodes() {
        let sut = AVLBinaryTree()
        sut.insert(x: 0)
        sut.insert(x: 1)
        sut.insert(x: 2)
        // 0 <- 1 -> 2
        sut.remove(x: 0)
        // expect 1 -> 2
        XCTAssert(sut.root?.value == 1)
        XCTAssert(sut.root?.height == 2)
        XCTAssert(sut.root?.rightChild?.value == 2)
        XCTAssertNil(sut.root?.leftChild)
        sut.insert(x: 0)
        // 0 <- 1 -> 2
        sut.remove(x: 2)
        // expect 0 <- 1
        XCTAssert(sut.root?.value == 1)
        XCTAssert(sut.root?.height == 2)
        XCTAssert(sut.root?.leftChild?.value == 0)
        XCTAssertNil(sut.root?.rightChild)
        sut.insert(x: 2)
        // 0 <- 1 -> 2
        sut.remove(x: 1)
        // expect 0 <- 2
        XCTAssert(sut.root?.value == 2)
        XCTAssert(sut.root?.height == 2)
        XCTAssert(sut.root?.leftChild?.value == 0)
        XCTAssertNil(sut.root?.rightChild)
    }
    
    func test_remove_4Nodes() {
        let sut = AVLBinaryTree()
        sut.insert(x: 0)
        sut.insert(x: 1)
        sut.insert(x: 2)
        sut.insert(x: 3)
        //   <- 1 ->
        // 0        2 -> (3)
        XCTAssert(sut.root?.height == 3)
        sut.remove(x: 3)
        // Expect
        //   <- 1 ->
        // 0         2
        XCTAssert(sut.root?.height == 2)
        sut.insert(x: 3)
        sut.insert(x: -1)
        sut.insert(x: -5)
        sut.insert(x: -15)
        //                <- 1 ->
        //       <- -1 ->         2 ->
        //   <- -5       0            3
        // -15
        sut.remove(x: 1)
        // Expect
        //                <- 0 ->
        //       <- -5 ->         2 ->
        //    -15       -1           3
        XCTAssert(sut.root?.value == 0)
        XCTAssert(sut.root?.height == 3)
        XCTAssert(sut.root?.leftChild?.value == -5)
        XCTAssert(sut.root?.leftChild?.height == 2)
        sut.insert(x: 5)
        sut.insert(x: 15)
        //                       <- 0 ->
        //    <- -5 ->                  <- 3 ->
        // -15        -1             2           5 ->
        //                                           15
        XCTAssert(sut.root?.height == 4)
        sut.remove(x: 0)
        // Expect
        //                       <- 2 ->
        //    <- -5 ->                  <- 5 ->
        // -15        -1             3          15
        XCTAssert(sut.root?.value == 2)
        XCTAssert(sut.root?.height == 3)
        XCTAssert(sut.root?.rightChild?.value == 5)
    }
    
    func test_remove_ManyNodes() {
        let sut = AVLBinaryTree()
        sut.insert(x: 2); sut.insert(x: 10); sut.insert(x: 1); sut.insert(x: 20);
        sut.insert(x: 0); sut.insert(x: 11); sut.insert(x: 3); sut.insert(x: 9);
        sut.insert(x: 7); sut.insert(x: 17); sut.insert(x: 4); sut.insert(x: 12);
        sut.insert(x: 5); sut.insert(x: 8); sut.insert(x: 33); sut.insert(x: 25);
        sut.insert(x: 6); sut.insert(x: 19); sut.insert(x: 18); sut.insert(x: 15);
        sut.insert(x: 16); sut.insert(x: 21); sut.insert(x: 22); sut.insert(x: 23);
        sut.insert(x: 24);
        sut.insert(x: 26); sut.insert(x: 27); sut.insert(x: 28); sut.insert(x: 29);
        sut.insert(x: 30); sut.insert(x: 31); sut.insert(x: 32); sut.insert(x: 34);
        sut.insert(x: 35); sut.insert(x: 36); sut.insert(x: 37); sut.insert(x: 38);
        sut.insert(x: 39);
        //                                 <- 9 ->
        //                 <- 2 ->                           <- 17 ->
        //      <- 1 ->             <- 5 ->           <- 11 ->               <- 25 ->
        //   0                 <- 4      <- 7 ->     10      12 ->        <- 19 ->      33
        //                    3         6       8                15      18      20
//        sut.remove(x: 3)
//        sut.remove(x: 5)
//        sut.remove(x: 2)
//        print(sut.root)
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
            if nodeIsRightChild {
                parent?.rightChild = node
            } else {
                parent?.leftChild = node
            }
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
            if nodeIsRightChild {
                parent?.rightChild = node
            } else {
                parent?.leftChild = node
            }
        } else {
            node.parent = parent
        }
    }
}
