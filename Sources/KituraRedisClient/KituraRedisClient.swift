//
//  KituraRedisClient.swift
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

import Foundation
import Dispatch
import RedisClient
import SwiftRedis

extension Redis: RedisClient {

    public func execute(_ command: String, arguments: [String]?) throws -> RedisClientResponse {

        var stringArgs = [command]

        if let arguments = arguments {
            stringArgs.append(contentsOf: arguments)
        }

        let semaphore = DispatchSemaphore(value: 0)

        var _response: RedisClientResponse!

        self.issueCommandInArray(stringArgs) { response in

            _response = RedisClientResponse(response: response)

            semaphore.signal()
        }

        semaphore.wait()

        return _response
    }
}

extension RedisClientResponse {

    init(response: RedisResponse) {

        switch response {
        case .Array(let responses):
            self = .array(responses.map { RedisClientResponse(response: $0) })
        case .Error(let error):
            self = .error(error)
        case .IntegerValue(let value):
            self = .integer(value)
        case .Nil:
            self = .null
        case .Status(let status):
            guard let _status = Status(rawValue: status) else {
                self = .error("Unknown status: \(status)")
                return
            }

            self = .status(_status)

        case .StringValue(let value):
            self = .string(value.asString)
        }
    }
}
