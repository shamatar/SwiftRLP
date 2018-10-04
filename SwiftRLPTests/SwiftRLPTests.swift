//
//  SwiftRLPTests.swift
//  SwiftRLPTests
//
//  Created by Alex Vlasov on 04/10/2018.
//  Copyright © 2018 Alex Vlasov. All rights reserved.
//

import XCTest
import BigInt
@testable import SwiftRLP

class SwiftRLPTests: XCTestCase {
    
    func testRLPencodeShortString() {
        let testString = "dog"
        let encoded = RLP.encode(testString)
        var expected = Data([UInt8(0x83)])
        expected.append(testString.data(using: .ascii)!)
        XCTAssert(encoded == expected, "Failed to RLP encode short string")
    }
    
    func testRLPencodeListOfShortStrings() {
        let testInput = ["cat","dog"]
        let encoded = RLP.encode(testInput as [AnyObject])
        var expected = Data()
        expected.append(Data([UInt8(0xc8)]))
        expected.append(Data([UInt8(0x83)]))
        expected.append("cat".data(using: .ascii)!)
        expected.append(Data([UInt8(0x83)]))
        expected.append("dog".data(using: .ascii)!)
        XCTAssert(encoded == expected, "Failed to RLP encode list of short strings")
    }
    
    func testRLPdecodeListOfShortStrings() {
        let testInput = ["cat","dog"]
        var expected = Data()
        expected.append(Data([UInt8(0xc8)]))
        expected.append(Data([UInt8(0x83)]))
        expected.append("cat".data(using: .ascii)!)
        expected.append(Data([UInt8(0x83)]))
        expected.append("dog".data(using: .ascii)!)
        var result = RLP.decode(expected)!
        XCTAssert(result.isList, "Failed to RLP decode list of short strings") // we got something non-empty
        XCTAssert(result.count == 1, "Failed to RLP decode list of short strings") // we got something non-empty
        result = result[0]!
        XCTAssert(result.isList, "Failed to RLP decode list of short strings") // we got something non-empty
        XCTAssert(result.count == 2, "Failed to RLP decode list of short strings") // we got something non-empty
        XCTAssert(result[0]!.data == testInput[0].data(using: .ascii), "Failed to RLP decode list of short strings")
        XCTAssert(result[1]!.data == testInput[1].data(using: .ascii), "Failed to RLP decode list of short strings")
    }
    
    func testRLPencodeLongString() {
        let testInput = "Lorem ipsum dolor sit amet, consectetur adipisicing elit"
        let encoded = RLP.encode(testInput)
        var expected = Data()
        expected.append(Data([UInt8(0xb8)]))
        expected.append(Data([UInt8(0x38)]))
        expected.append("Lorem ipsum dolor sit amet, consectetur adipisicing elit".data(using: .ascii)!)
        XCTAssert(encoded == expected, "Failed to RLP encode long string")
    }
    
    func testRLPdecodeLongString() {
        let testInput = "Lorem ipsum dolor sit amet, consectetur adipisicing elit"
        var expected = Data()
        expected.append(Data([UInt8(0xb8)]))
        expected.append(Data([UInt8(0x38)]))
        expected.append(testInput.data(using: .ascii)!)
        let result = RLP.decode(expected)!
        XCTAssert(result.count == 1, "Failed to RLP decode long string")
        XCTAssert(result[0]!.data == testInput.data(using: .ascii), "Failed to RLP decode long string")
    }
    
    func testRLPencodeEmptyString() {
        let testInput = ""
        let encoded = RLP.encode(testInput)
        var expected = Data()
        expected.append(Data([UInt8(0x80)]))
        XCTAssert(encoded == expected, "Failed to RLP encode empty string")
    }
    
    func testRLPdecodeEmptyString() {
        let testInput = ""
        var expected = Data()
        expected.append(Data([UInt8(0x80)]))
        let result = RLP.decode(expected)!
        XCTAssert(result.count == 1, "Failed to RLP decode empty string")
        XCTAssert(result[0]!.data == testInput.data(using: .ascii), "Failed to RLP decode empty string")
    }
    
    func testRLPencodeEmptyArray() {
        let testInput = [Data]() as [AnyObject]
        let encoded = RLP.encode(testInput)
        var expected = Data()
        expected.append(Data([UInt8(0xc0)]))
        XCTAssert(encoded == expected, "Failed to RLP encode empty array")
    }
    
    func testRLPdecodeEmptyArray() {
        //        let testInput = [Data]()
        var expected = Data()
        expected.append(Data([UInt8(0xc0)]))
        var result = RLP.decode(expected)!
        XCTAssert(result.count == 1, "Failed to RLP decode empty array")
        result = result[0]!
        guard case .noItem = result.content else {return XCTFail()}
    }
    
    func testRLPencodeShortInt() {
        let testInput = 15
        let encoded = RLP.encode(testInput)
        let expected = Data([UInt8(0x0f)])
        XCTAssert(encoded == expected, "Failed to RLP encode short int")
    }
    
    func testRLPdecodeShortInt() {
        let testInput = 15
        let expected = Data([UInt8(0x0f)])
        let result = RLP.decode(expected)!
        
        XCTAssert(result.count == 1, "Failed to RLP decode short int")
        XCTAssert(BigUInt(result[0]!.data!) == testInput, "Failed to RLP decode short int")
    }
    
    func testRLPencodeLargeInt() {
        let testInput = 1024
        let encoded = RLP.encode(testInput)
        var expected = Data()
        expected.append(Data([UInt8(0x82)]))
        expected.append(Data([UInt8(0x04)]))
        expected.append(Data([UInt8(0x00)]))
        XCTAssert(encoded == expected, "Failed to RLP encode large int")
    }
    
    func testRLPdecodeLargeInt() {
        let testInput = 1024
        var expected = Data()
        expected.append(Data([UInt8(0x82)]))
        expected.append(Data([UInt8(0x04)]))
        expected.append(Data([UInt8(0x00)]))
        let result = RLP.decode(expected)!
        
        XCTAssert(result.count == 1, "Failed to RLP decode large int")
        XCTAssert(BigUInt(result[0]!.data!) == testInput, "Failed to RLP decode large int")
    }

}
