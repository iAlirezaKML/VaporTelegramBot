import Foundation
import SwiftyJSON
import Vapor
import HTTP


extension TelegramBot {
	public func request(_ name: String,
	                    json: SwiftyJSON.JSON = SwiftyJSON.JSON([:])
		) throws -> Response {
		guard let json = try drop.client.post(url, query: json.dictionaryValue).json?.toSwiftyJSON() else {
			throw Error.badResponse
		}
		return Response(json: json)
	}
	
	public func request(_ method: Method) throws -> Response {
		return try request(method.name, json: method.parameters(for: .request))
	}
	
	
	
	
	
	
	/// A simple method for testing your bot's auth token. Requires no parameters. Returns basic information about the bot in form of a User object.
	///
	public func getMe() throws -> User {
		let method = Method.getMe
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = User(json: response.result)
		return result
	}
	
	
	
	
	/// Use this method to get a list of profile pictures for a user. Returns a UserProfilePhotos object.
	///
	/// - Parameters:
	///   - userId: Unique identifier of the target user
	///   - offset: Sequential number of the first photo to be returned. By default, all photos are returned.
	///   - limit: Limits the number of photos to be retrieved. Values between 1—100 are accepted. Defaults to 100.
	public func getUserProfilePhotos(userId: Int,
	                                 offset: Int? = nil,
	                                 limit: Int? = nil
		) throws -> UserProfilePhotos {
		let method = Method.getUserProfilePhotos(userId: userId,
		                                         offset: offset,
		                                         limit: limit)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = UserProfilePhotos(json: response.result)
		return result
	}
	
	
	
	/// Use this method to get basic info about a file and prepare it for downloading. For the moment, bots can download files of up to 20MB in size. On success, a File object is returned. The file can then be downloaded via the link https://api.telegram.org/file/bot<token>/<file_path>, where <file_path> is taken from the response. It is guaranteed that the link will be valid for at least 1 hour. When the link expires, a new one can be requested by calling getFile again.
	///
	/// - Note: This function may not preserve the original file name and MIME type. You should save the file's MIME type and name (if available) when the File object is received.
	/// - Parameter fileId: File identifier to get info about
	public func getFile(fileId: String
		) throws -> File {
		let method = Method.getFile(fileId: fileId)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = File(json: response.result)
		return result
	}
	
	
	
	/// Use this method to kick a user from a group or a supergroup. In the case of supergroups, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the group for this to work. Returns True on success.
	///
	/// - Note: This will method only work if the ‘All Members Are Admins’ setting is off in the target group. Otherwise members may only be removed by the group's creator or by the member that added them.
	/// - Parameters:
	///   - chatId: Unique identifier for the target group or username of the target supergroup (in the format @supergroupusername)
	///   - userId: Unique identifier of the target user
	public func kickChatMember(chatId: String,
	                           userId: Int
		) throws -> Bool {
		let method = Method.kickChatMember(chatId: chatId,
		                                   userId: userId)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = response.result.boolValue
		return result
	}
	
	
	
	/// Use this method for your bot to leave a group, supergroup or channel. Returns True on success.
	///
	/// - Parameter chatId: Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
	public func leaveChat(chatId: String
		) throws -> Bool {
		let method = Method.leaveChat(chatId: chatId)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = response.result.boolValue
		return result
	}
	
	
	
	/// Use this method to unban a previously kicked user in a supergroup. The user will not return to the group automatically, but will be able to join via link, etc. The bot must be an administrator in the group for this to work. Returns True on success.
	///
	/// - Parameters:
	///   - chatId: Unique identifier for the target group or username of the target supergroup (in the format @supergroupusername)
	///   - userId: Unique identifier of the target user
	public func unbanChatMember(chatId: String,
	                            userId: Int
		) throws -> Bool {
		let method = Method.unbanChatMember(chatId: chatId,
		                                   userId: userId)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = response.result.boolValue
		return result
	}
	
	
	
	/// Use this method to get up to date information about the chat (current name of the user for one-on-one conversations, current username of a user, group or channel, etc.). Returns a Chat object on success.
	///
	/// - Parameter chatId: Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
	public func getChat(chatId: String
		) throws -> Chat {
		let method = Method.getChat(chatId: chatId)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = Chat(json: response.result)
		return result
	}
	
	
	
	
	/// Use this method to get a list of administrators in a chat. On success, returns an Array of ChatMember objects that contains information about all chat administrators except other bots. If the chat is a group or a supergroup and no administrators were appointed, only the creator will be returned.
	///
	/// - Parameter chatId: Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
	public func getChatAdministrators(chatId: String
		) throws -> [ChatMember] {
		let method = Method.getChatAdministrators(chatId: chatId)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = response.result.arrayValue.map({ ChatMember(json: $0) })
		return result
	}
	
	
	
	
	
	/// Use this method to get the number of members in a chat. Returns Int on success.
	///
	/// - Parameter chatId: Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
	public func getChatMembersCount(chatId: String
		) throws -> Int {
		let method = Method.getChatMembersCount(chatId: chatId)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = response.result.intValue
		return result
	}
	
	
	
	
	/// Use this method to get information about a member of a chat. Returns a ChatMember object on success.
	///
	/// - Parameters:
	///   - chatId: Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
	///   - userId: Unique identifier of the target user
	public func getChatMember(chatId: String,
	                          userId: Int
		) throws -> ChatMember {
		let method = Method.getChatMember(chatId: chatId,
		                                  userId: userId)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = ChatMember(json: response.result)
		return result
	}
	
	
	
	
	/// Use this method to send answers to callback queries sent from inline keyboards. The answer will be displayed to the user as a notification at the top of the chat screen or as an alert. On success, True is returned.
	///
	/// - Parameters:
	///   - callback_query_id: Unique identifier for the query to be answered
	///   - text: Text of the notification. If not specified, nothing will be shown to the user, 0-200 characters
	///   - show_alert: If true, an alert will be shown by the client instead of a notification at the top of the chat screen. Defaults to false.
	///   - url: URL that will be opened by the user's client. If you have created a Game and accepted the conditions via @Botfather, specify the URL that opens your game – note that this will only work if the query comes from a callback_game button. Otherwise, you may use links like telegram.me/your_bot?start=XXXX that open your bot with a parameter.
	///   - cache_time: The maximum amount of time in seconds that the result of the callback query may be cached client-side. Telegram apps will support caching starting in version 3.14. Defaults to 0.
	public func answerCallbackQuery(callbackQueryId: String,
	                                text: String? = nil,
	                                showAlert: Bool? = nil,
	                                url: String? = nil,
	                                cacheTime: Int? = nil
		) throws -> Bool {
		let method = Method.answerCallbackQuery(callbackQueryId: callbackQueryId,
		                                        text: text,
		                                        showAlert: showAlert,
		                                        url: url,
		                                        cacheTime: cacheTime)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = response.result.boolValue
		return result
	}

	
	
	
	
	/// Use this method to send text messages. On success, the sent `Message` is returned.
	///
	/// - Parameters:
	///   - chatId: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	///   - text: Text of the message to be sent
	///   - parseMode: Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
	///   - disableWebPagePreview: Disables link previews for links in this message
	///   - disableNotification: Sends the message silently. iOS users will not receive a notification, Android users will receive a notification with no sound.
	///   - replyToMessageId: If the message is a reply, ID of the original message
	///   - replyMarkup: Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
	public func sendMessage(chatId: String,
	                        text: String,
	                        parseMode: ParseMode? = nil,
	                        disableWebPagePreview: Bool? = nil,
	                        disableNotification: Bool? = nil,
	                        replyToMessageId: Int? = nil,
	                        replyMarkup: ReplyMarkup? = nil
		) throws -> Message {
		let method = Method.sendMessage(chatId: chatId,
		                                text: text,
		                                parseMode: parseMode,
		                                disableWebPagePreview: disableWebPagePreview,
		                                disableNotification: disableNotification,
		                                replyToMessageId: replyToMessageId,
		                                replyMarkup: replyMarkup)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = Message(json: response.result)
		return result
	}

	
	
	/// Use this method to forward messages of any kind. On success, the sent Message is returned.
	///
	/// - Parameters:
	///   - chatId: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	///   - fromChatId: Unique identifier for the chat where the original message was sent (or channel username in the format @channelusername)
	///   - messageId: Sends the message silently. iOS users will not receive a notification, Android users will receive a notification with no sound.
	///   - disableNotification: Message identifier in the chat specified in from_chat_id
	public func forwardMessage(chatId: String,
	                           fromChatId: String,
	                           messageId: Int,
	                           disableNotification: Bool? = nil
		) throws -> Message {
		let method = Method.forwardMessage(chatId: chatId,
		                                   fromChatId: fromChatId,
		                                   messageId: messageId,
		                                   disableNotification: disableNotification)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = Message(json: response.result)
		return result
	}
	
	
	
	
	/// Use this method to send point on the map. On success, the sent Message is returned.
	///
	/// - Parameters:
	///   - chatId: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	///   - latitude: Latitude of location
	///   - longitude: Longitude of location
	///   - disableNotification: Sends the message silently. iOS users will not receive a notification, Android users will receive a notification with no sound.
	///   - replyToMessageId: If the message is a reply, ID of the original message
	///   - replyMarkup: Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
	public func sendLocation(chatId: String,
	                         latitude: Double,
	                         longitude: Double,
	                         disableNotification: Bool? = nil,
	                         replyToMessageId: Int? = nil,
	                         replyMarkup: ReplyMarkup? = nil
		) throws -> Message {
		let method = Method.sendLocation(chatId: chatId,
		                                 latitude: latitude,
		                                 longitude: longitude,
		                                 disableNotification: disableNotification,
		                                 replyToMessageId: replyToMessageId,
		                                 replyMarkup: replyMarkup)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = Message(json: response.result)
		return result
	}
	
	
	
	
	/// Use this method to send information about a venue. On success, the sent Message is returned.
	///
	/// - Parameters:
	///   - chatId: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	///   - latitude: Latitude of location
	///   - longitude: Longitude of location
	///   - title: Name of the venue
	///   - address: Address of the venue
	///   - foursquareId: Foursquare identifier of the venue
	///   - disableNotification: Sends the message silently. iOS users will not receive a notification, Android users will receive a notification with no sound.
	///   - replyToMessageId: If the message is a reply, ID of the original message
	///   - replyMarkup: Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
	public func sendVenue(chatId: String,
	                      latitude: Double,
	                      longitude: Double,
	                      title: String,
	                      address: String,
	                      foursquareId: String? = nil,
	                      disableNotification: Bool? = nil,
	                      replyToMessageId: Int? = nil,
	                      replyMarkup: ReplyMarkup? = nil
		) throws -> Message {
		let method = Method.sendVenue(chatId: chatId,
		                              latitude: latitude,
		                              longitude: longitude,
		                              title: title,
		                              address: address,
		                              foursquareId: foursquareId,
		                              disableNotification: disableNotification,
		                              replyToMessageId: replyToMessageId,
		                              replyMarkup: replyMarkup)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = Message(json: response.result)
		return result
	}
	
	
	
	
	/// Use this method to send phone contacts. On success, the sent Message is returned.
	///
	/// - Parameters:
	///   - chatId: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	///   - phoneNumber: Contact's phone number
	///   - firstName: Contact's first name
	///   - lastName: Contact's last name
	///   - disableNotification: Sends the message silently. iOS users will not receive a notification, Android users will receive a notification with no sound.
	///   - replyToMessageId: If the message is a reply, ID of the original message
	///   - replyMarkup: Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
	public func sendContact(chatId: String,
	                        phoneNumber: String,
	                        firstName: String,
	                        lastName: String? = nil,
	                        disableNotification: Bool? = nil,
	                        replyToMessageId: Int? = nil,
	                        replyMarkup: ReplyMarkup? = nil
		) throws -> Message {
		let method = Method.sendContact(chatId: chatId,
		                                phoneNumber: phoneNumber,
		                                firstName: firstName,
		                                lastName: lastName,
		                                disableNotification: disableNotification,
		                                replyToMessageId: replyToMessageId,
		                                replyMarkup: replyMarkup)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = Message(json: response.result)
		return result
	}
	
	
	
	/// Use this method when you need to tell the user that something is happening on the bot's side. The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients clear its typing status). Returns True on success.
	///
	/// - Parameters:
	/// - Note: Example: The ImageBot needs some time to process a request and upload the image. Instead of sending a text message along the lines of “Retrieving image, please wait…”, the bot may use sendChatAction with action = upload_photo. The user will see a “sending photo” status for the bot.
	///   - chatId: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	///   - action: Type of action to broadcast. Choose one, depending on what the user is about to receive: typing for text messages, upload_photo for photos, record_video or upload_video for videos, record_audio or upload_audio for audio files, upload_document for general files, find_location for location data.
	public func sendChatAction(chatId: String,
	                           action: ChatAction
		) throws -> Bool {
		let method = Method.sendChatAction(chatId: chatId,
		                                   action: action)
		let response = try request(method)
		guard response.ok else {
			throw Error.requestFailed(response.description)
		}
		let result = response.result.boolValue
		return result
	}

}



