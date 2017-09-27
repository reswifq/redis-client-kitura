# KituraRedisClient

![Swift](https://img.shields.io/badge/swift-4.0-brightgreen.svg)
[![Build Status](https://api.travis-ci.org/reswifq/redis-client-kitura.svg?branch=master)](https://travis-ci.org/reswifq/redis-client-kitura)
[![Code Coverage](https://codecov.io/gh/reswifq/redis-client-kitura/branch/master/graph/badge.svg)](https://codecov.io/gh/reswifq/redis-client-kitura)

Adapter to use [IBM-Swift/Kitura-redis](https://github.com/IBM-Swift/Kitura-redis) with [Reswifq](https://github.com/reswifq/reswifq).

## 🏁 Getting Started

#### Import KituraRedisClient into your project using [Swift Package Manager](https://swift.org/package-manager):

``` swift
import PackageDescription

let package = Package(
    name: "YourProject",
    products: [
      .executable(name: "YourProject", targets: ["YourProject"])
    ],
    dependencies: [
        .package(url: "https://github.com/reswifq/redis-client-kitura", .upToNextMajor(from: "1.2.0"))
    ],
    targets: [
      .target(name: "YourProject", dependencies: ["KituraRedisClient"])
    ]
)
```

_**Note:** This will also import some [IBM-Swift/Kitura-redis](https://github.com/IBM-Swift/Kitura-redis) related packages into your project._

#### Create a client and a queue:

```
let client = Redis()

client.connect(host: "localhost", port: 6379) { _ in }

let queue = Reswifq(client: client)
```

For more information on how to use [Reswifq](https://github.com/reswifq/reswifq) and the [IBM-Swift/Kitura-redis](https://github.com/IBM-Swift/Kitura-redis)'s client, please refer to the related documentation.

## 🔧 Compatibility

This package has been tested on macOS and Ubuntu.

## 📖 License

Created by [Valerio Mazzeo](https://github.com/valeriomazzeo).

Copyright © 2017 [VMLabs Limited](https://www.vmlabs.it). All rights reserved.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the [GNU Lesser General Public License](http://www.gnu.org/licenses) for more details.
