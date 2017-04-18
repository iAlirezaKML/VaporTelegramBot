// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "VaporTelegramBot",
    dependencies: [
		.Package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", majorVersion: 15),
		.Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 5),
	]
)
