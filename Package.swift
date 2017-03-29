//
//  Package.swift
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

import PackageDescription

let package = Package(
	name: "KituraRedisClient",
	targets: [
		Target(name: "KituraRedisClient")
	],
	dependencies: [
		.Package(url: "https://github.com/reswifq/redis-client.git", majorVersion: 1),
		.Package(url: "https://github.com/IBM-Swift/Kitura-redis.git", majorVersion: 1, minor: 7)
	]
)
