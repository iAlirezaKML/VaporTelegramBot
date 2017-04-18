import Foundation
import SwiftyJSON

extension SwiftyJSON.JSON {
	init(optionalDict: [String: Any?]) {
		var dictionary = [String: Any]()
		
		for (key, json) in optionalDict {
			if let json = json {
				dictionary[key] = json
			}
		}
		self.init(dictionary as Any)
	}
}
