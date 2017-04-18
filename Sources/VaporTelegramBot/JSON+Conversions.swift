import Foundation
import SwiftyJSON
import Vapor

public extension SwiftyJSON.JSON {
	public init(_ json: Vapor.JSON) throws {
		self.init(data: Data.init(bytes: try json.makeBytes()))
	}
	
	public func toVaporJSON() throws -> Vapor.JSON {
		return try Vapor.JSON.init(self)
	}
}

public extension Vapor.JSON {
	public init(_ json: SwiftyJSON.JSON) throws {
		try self.init(bytes: try json.rawData().makeBytes())
	}
	
	public func toSwiftyJSON() throws -> SwiftyJSON.JSON {
		return try SwiftyJSON.JSON.init(self)
	}
}

