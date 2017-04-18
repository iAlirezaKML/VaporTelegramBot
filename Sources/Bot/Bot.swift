import Foundation
import SwiftyJSON
import Vapor
import HTTP
import Types




public class TelegramBot {
	public enum Error: Swift.Error {
		case noTelegramBotConfig
		case missingConfig(String)
		case badResponse
		case requestFailed(String)
	}
	
	/// Vapor droplet.
	public let drop: Droplet
	
	/// Telegram server URL.
	public let telegramURL = "https://api.telegram.org/bot"
	
	/// Telegram bot URL.
	public var url: String
	
	/// Unique authentication token obtained from BotFather.
	public var token: String {
		didSet {
			url = telegramURL + token
		}
	}
	
	/// Request handler
	public let handler: (Request) throws -> ResponseRepresentable
	
	
	public init(drop: Droplet, handler: @escaping (Request) throws -> ResponseRepresentable) throws {
		guard let telegramBot = drop.config["telegramBot"]?.object else {
			throw Error.noTelegramBotConfig
		}
		guard let token = telegramBot["token"]?.string else {
			throw Error.missingConfig("token")
		}
		
		self.drop = drop
		self.token = token
		self.url = telegramURL + token
		self.handler = handler
	}
}


