//
//  KituraRedisClientTests.swift
//  KituraRedisClient
//
//  Created by Valerio Mazzeo on 21/03/2017.
//  Copyright © 2017 VMLabs Limited. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
//  See the GNU Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public License
//  along with this program. If not, see <http://www.gnu.org/licenses/>.
//

import XCTest
import Foundation
import SwiftRedis
import RedisClient
@testable import KituraRedisClient

class KituraRedisClientTests: XCTestCase {

    static let allTests = [
        ("testExecute", testExecute),
        ("testInitWithResponseArray", testInitWithResponseArray),
        ("testInitWithResponseError", testInitWithResponseError),
        ("testInitWithResponseIntegerValue", testInitWithResponseIntegerValue),
        ("testInitWithResponseNil", testInitWithResponseNil),
        ("testInitWithResponseStatus", testInitWithResponseStatus),
        ("testInitWithResponseStatusUnknown", testInitWithResponseStatusUnknown),
        ("testInitWithResponseString", testInitWithResponseString),
    ]

    func testExecute() throws {

        let client = Redis()

        client.connect(host: "localhost", port: 6379) { _ in }

        let flushResponse = try client.execute("FLUSHALL", arguments: nil)
        XCTAssertEqual(flushResponse.status, .ok)

        let setResponse = try client.execute("SET", arguments: "test", "1234")
        XCTAssertEqual(setResponse.status, .ok)

        let getResponse = try client.execute("GET", arguments: "test")
        XCTAssertEqual(getResponse.string, "1234")
    }

    func testInitWithResponseArray() {

        let kituraResponse = RedisResponse.Array([.Error("error 1"), .Error("error 2")])
        let response = RedisClientResponse(response: kituraResponse)

        XCTAssertEqual(response.array?[0].error, "error 1")
        XCTAssertEqual(response.array?[1].error, "error 2")
    }

    func testInitWithResponseError() {

        let kituraResponse = RedisResponse.Error("error")
        let response = RedisClientResponse(response: kituraResponse)

        XCTAssertEqual(response.error, "error")
    }

    func testInitWithResponseIntegerValue() {

        let kituraResponse = RedisResponse.IntegerValue(1)
        let response = RedisClientResponse(response: kituraResponse)

        XCTAssertEqual(response.integer, 1)
    }

    func testInitWithResponseNil() {

        let kituraResponse = RedisResponse.Nil
        let response = RedisClientResponse(response: kituraResponse)

        XCTAssertTrue(response.isNull)
    }

    func testInitWithResponseStatus() {

        let kituraResponse = RedisResponse.Status("OK")
        let response = RedisClientResponse(response: kituraResponse)

        XCTAssertEqual(response.status, .ok)
    }

    func testInitWithResponseStatusUnknown() {

        let kituraResponse = RedisResponse.Status("ERR")
        let response = RedisClientResponse(response: kituraResponse)

        XCTAssertEqual(response.error, "Unknown status: ERR")
    }

    func testInitWithResponseString() {

        let kituraResponse = RedisResponse.StringValue(RedisString("test"))
        let response = RedisClientResponse(response: kituraResponse)

        XCTAssertEqual(response.string, "test")
    }
}
