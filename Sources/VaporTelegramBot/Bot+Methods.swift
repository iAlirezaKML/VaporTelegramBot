import Foundation
import SwiftyJSON
import Vapor
import HTTP


extension TelegramBot {
	public enum Action {
		case request
		case response
	}
	
	public enum Method {
		/// A simple method for testing your bot's auth token. Requires no parameters. Returns basic information about the bot in form of a User object.
		case getMe
		
		
		
		/// Use this method to get a list of profile pictures for a user. Returns a UserProfilePhotos object.
		///
		/// - userId: Unique identifier of the target user
		/// - offset: Sequential number of the first photo to be returned. By default, all photos are returned.
		/// - limit: Limits the number of photos to be retrieved. Values between 1—100 are accepted. Defaults to 100.
		case getUserProfilePhotos(userId: Int, offset: Int?, limit: Int?)
		
		
		
		/// Use this method to get basic info about a file and prepare it for downloading. For the moment, bots can download files of up to 20MB in size. On success, a File object is returned. The file can then be downloaded via the link https://api.telegram.org/file/bot<token>/<file_path>, where <file_path> is taken from the response. It is guaranteed that the link will be valid for at least 1 hour. When the link expires, a new one can be requested by calling getFile again.
		///
		/// - Note: This function may not preserve the original file name and MIME type. You should save the file's MIME type and name (if available) when the File object is received.
		/// - fileId: File identifier to get info about
		case getFile(fileId: String)
		
		
		
		/// Use this method to kick a user from a group or a supergroup. In the case of supergroups, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the group for this to work. Returns True on success.
		///
		/// - Note: This will method only work if the ‘All Members Are Admins’ setting is off in the target group. Otherwise members may only be removed by the group's creator or by the member that added them.
		/// - chatId: Unique identifier for the target group or username of the target supergroup (in the format @supergroupusername)
		/// - userId: Unique identifier of the target user
		case kickChatMember(chatId: String, userId: Int)
		
		
		
		/// Use this method for your bot to leave a group, supergroup or channel. Returns True on success.
		///
		/// - chatId: Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
		case leaveChat(chatId: String)
		
		
		
		/// Use this method to unban a previously kicked user in a supergroup. The user will not return to the group automatically, but will be able to join via link, etc. The bot must be an administrator in the group for this to work. Returns True on success.
		///
		/// - chatId: Unique identifier for the target group or username of the target supergroup (in the format @supergroupusername)
		/// - userId: Unique identifier of the target user
		case unbanChatMember(chatId: String, userId: Int)
		
		
		
		/// Use this method to get up to date information about the chat (current name of the user for one-on-one conversations, current username of a user, group or channel, etc.). Returns a Chat object on success.
		///
		/// - chatId: Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
		case getChat(chatId: String)
		
		
		
		
		/// Use this method to get a list of administrators in a chat. On success, returns an Array of ChatMember objects that contains information about all chat administrators except other bots. If the chat is a group or a supergroup and no administrators were appointed, only the creator will be returned.
		///
		/// - chatId: Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
		case getChatAdministrators(chatId: String)
		
		
		
		
		/// Use this method to get the number of members in a chat. Returns Int on success.
		///
		/// - chatId: Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
		case getChatMembersCount(chatId: String)
		
		
		
		
		/// Use this method to get information about a member of a chat. Returns a ChatMember object on success.
		///
		/// - Parameters:
		///   - chatId: Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
		///   - userId: Unique identifier of the target user
		case getChatMember(chatId: String, userId: Int)
		
		
		
		
		/// Use this method to send answers to callback queries sent from inline keyboards. The answer will be displayed to the user as a notification at the top of the chat screen or as an alert. On success, True is returned.
		///
		/// - callback_query_id: Unique identifier for the query to be answered
		/// - text: Text of the notification. If not specified, nothing will be shown to the user, 0-200 characters
		/// - show_alert: If true, an alert will be shown by the client instead of a notification at the top of the chat screen. Defaults to false.
		/// - url: URL that will be opened by the user's client. If you have created a Game and accepted the conditions via @Botfather, specify the URL that opens your game – note that this will only work if the query comes from a callback_game button. Otherwise, you may use links like telegram.me/your_bot?start=XXXX that open your bot with a parameter.
		/// - cache_time: The maximum amount of time in seconds that the result of the callback query may be cached client-side. Telegram apps will support caching starting in version 3.14. Defaults to 0.
		case answerCallbackQuery(callbackQueryId: String,
			text: String?,
			showAlert: Bool?,
			url: String?,
			cacheTime: Int?)
		
		
		
		
		/// Use this method to send text messages. On success, the sent `Message` is returned.
		///
		/// - chatId: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
		/// - text: Text of the message to be sent
		/// - parseMode: Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
		/// - disableWebPagePreview: Disables link previews for links in this message
		/// - disableNotification: Sends the message silently. iOS users will not receive a notification, Android users will receive a notification with no sound.
		/// - replyToMessageId: If the message is a reply, ID of the original message
		/// - replyMarkup: Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
		case sendMessage(chatId: String,
			text: String,
			parseMode: ParseMode?,
			disableWebPagePreview: Bool?,
			disableNotification: Bool?,
			replyToMessageId: Int?,
			replyMarkup: ReplyMarkup?)

		
		
		/// Use this method to forward messages of any kind. On success, the sent Message is returned.
		///
		///   - chatId: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
		///   - fromChatId: Unique identifier for the chat where the original message was sent (or channel username in the format @channelusername)
		///   - messageId: Sends the message silently. iOS users will not receive a notification, Android users will receive a notification with no sound.
		///   - disableNotification: Message identifier in the chat specified in from_chat_id
		case forwardMessage(
			chatId: String,
			fromChatId: String,
			messageId: Int,
			disableNotification: Bool?)
		
		
		
		
		/// Use this method to send point on the map. On success, the sent Message is returned.
		///
		///   - chatId: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
		///   - latitude: Latitude of location
		///   - longitude: Longitude of location
		///   - disableNotification: Sends the message silently. iOS users will not receive a notification, Android users will receive a notification with no sound.
		///   - replyToMessageId: If the message is a reply, ID of the original message
		///   - replyMarkup: Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
		case sendLocation(
			chatId: String,
			latitude: Double,
			longitude: Double,
			disableNotification: Bool?,
			replyToMessageId: Int?,
			replyMarkup: ReplyMarkup?)
		
		
		
		
		/// Use this method to send information about a venue. On success, the sent Message is returned.
		///
		///   - chatId: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
		///   - latitude: Latitude of location
		///   - longitude: Longitude of location
		///   - title: Name of the venue
		///   - address: Address of the venue
		///   - foursquareId: Foursquare identifier of the venue
		///   - disableNotification: Sends the message silently. iOS users will not receive a notification, Android users will receive a notification with no sound.
		///   - replyToMessageId: If the message is a reply, ID of the original message
		///   - replyMarkup: Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
		case sendVenue(
			chatId: String,
			latitude: Double,
			longitude: Double,
			title: String,
			address: String,
			foursquareId: String?,
			disableNotification: Bool?,
			replyToMessageId: Int?,
			replyMarkup: ReplyMarkup?)
		
		
		
		
		/// Use this method to send phone contacts. On success, the sent Message is returned.
		///
		///   - chatId: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
		///   - phoneNumber: Contact's phone number
		///   - firstName: Contact's first name
		///   - lastName: Contact's last name
		///   - disableNotification: Sends the message silently. iOS users will not receive a notification, Android users will receive a notification with no sound.
		///   - replyToMessageId: If the message is a reply, ID of the original message
		///   - replyMarkup: Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
		case sendContact(
			chatId: String,
			phoneNumber: String,
			firstName: String,
			lastName: String?,
			disableNotification: Bool?,
			replyToMessageId: Int?,
			replyMarkup: ReplyMarkup?)
		
		
		
		/// Use this method when you need to tell the user that something is happening on the bot's side. The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients clear its typing status). Returns True on success.
		///
		/// - Note: Example: The ImageBot needs some time to process a request and upload the image. Instead of sending a text message along the lines of “Retrieving image, please wait…”, the bot may use sendChatAction with action = upload_photo. The user will see a “sending photo” status for the bot.
		///   - chatId: Unique identifier for the target chat or username of the target channel (in the format @channelusername)
		///   - action: Type of action to broadcast. Choose one, depending on what the user is about to receive: typing for text messages, upload_photo for photos, record_video or upload_video for videos, record_audio or upload_audio for audio files, upload_document for general files, find_location for location data.
		case sendChatAction(chatId: String, action: ChatAction)
		
		
		
		
		
		
		public var name: String {
			switch self {
			case .getMe:
				return "getMe"
				
			case .getUserProfilePhotos:
				return "getUserProfilePhotos"
				
			case .getFile:
				return "getFile"
				
			case .kickChatMember:
				return "kickChatMember"
				
			case .leaveChat:
				return "leaveChat"
				
			case .unbanChatMember:
				return "unbanChatMember"
				
			case .getChat:
				return "getChat"
				
			case .getChatAdministrators:
				return "getChatAdministrators"
				
			case .getChatMembersCount:
				return "getChatMembersCount"
				
			case .getChatMember:
				return "getChatMember"
				
			case .answerCallbackQuery:
				return "answerCallbackQuery"
				
				
				
				
			case .sendMessage:
				return "sendMessage"
				
			case .forwardMessage:
				return "forwardMessage"
				
			case .sendLocation:
				return "sendLocation"
				
			case .sendVenue:
				return "sendVenue"
				
			case .sendContact:
				return "sendContact"
				
			case .sendChatAction:
				return "sendChatAction"
			}
		}
		
		public func parameters(for action: Action) -> SwiftyJSON.JSON {
			var json: SwiftyJSON.JSON
			switch self {
			case .getMe:
				json = SwiftyJSON.JSON([:])
				
			case let .getUserProfilePhotos(userId, offset, limit):
				json = SwiftyJSON.JSON(optionalDict: [
					"user_id": userId,
					"offset": offset,
					"limit": limit,
					])
				
			case let .getFile(fileId):
				json = SwiftyJSON.JSON(optionalDict: [
					"file_id": fileId,
					])
				
			case let .kickChatMember(chatId, userId):
				json = SwiftyJSON.JSON(optionalDict: [
					"chat_id": chatId,
					"user_id": userId,
					])
				
			case let .leaveChat(chatId):
				json = SwiftyJSON.JSON(optionalDict: [
					"chat_id": chatId,
					])
				
			case let .unbanChatMember(chatId, userId):
				json = SwiftyJSON.JSON(optionalDict: [
					"chat_id": chatId,
					"user_id": userId,
					])
				
			case let .getChat(chatId):
				json = SwiftyJSON.JSON(optionalDict: [
					"chat_id": chatId,
					])
				
			case let .getChatAdministrators(chatId):
				json = SwiftyJSON.JSON(optionalDict: [
					"chat_id": chatId,
					])
				
			case let .getChatMembersCount(chatId):
				json = SwiftyJSON.JSON(optionalDict: [
					"chat_id": chatId,
					])
				
			case let .getChatMember(chatId, userId):
				json = SwiftyJSON.JSON(optionalDict: [
					"chat_id": chatId,
					"user_id": userId,
					])
				
			case let .answerCallbackQuery(callbackQueryId, text, showAlert, url, cacheTime):
				json = SwiftyJSON.JSON(optionalDict: [
					"callback_query_id": callbackQueryId,
					"text": text,
					"show_alert": showAlert,
					"url": url,
					"cache_time": cacheTime,
					])
				
				
				
				
			case let .sendMessage(chatId, text, parseMode, disableWebPagePreview, disableNotification, replyToMessageId, replyMarkup):
				json = SwiftyJSON.JSON(optionalDict: [
					"chat_id": chatId,
					"text": text,
					"parse_mode": parseMode,
					"disable_web_page_preview": disableWebPagePreview,
					"disable_notification": disableNotification,
					"reply_to_message_id": replyToMessageId,
					"reply_markup": replyMarkup,
					])
				
			case let .forwardMessage(chatId, fromChatId, messageId, disableNotification):
				json = SwiftyJSON.JSON(optionalDict: [
					"chat_id": chatId,
					"from_chat_id": fromChatId,
					"message_id": messageId,
					"disable_notification": disableNotification,
					])
				
			case let .sendLocation(chatId, latitude, longitude, disableNotification, replyToMessageId, replyMarkup):
				json = SwiftyJSON.JSON(optionalDict: [
					"chat_id": chatId,
					"latitude": latitude,
					"longitude": longitude,
					"disable_notification": disableNotification,
					"reply_to_message_id": replyToMessageId,
					"reply_markup": replyMarkup,
					])
				
			case let .sendVenue(chatId, latitude, longitude, title, address, foursquareId, disableNotification, replyToMessageId, replyMarkup):
				json = SwiftyJSON.JSON(optionalDict: [
					"chat_id": chatId,
					"latitude": latitude,
					"longitude": longitude,
					"title": title,
					"address": address,
					"foursquare_id": foursquareId,
					"disable_notification": disableNotification,
					"reply_to_message_id": replyToMessageId,
					"reply_markup": replyMarkup,
					])
				
			case let .sendContact(chatId, phoneNumber, firstName, lastName, disableNotification, replyToMessageId, replyMarkup):
				json = SwiftyJSON.JSON(optionalDict: [
					"chat_id": chatId,
					"phone_number": phoneNumber,
					"first_name": firstName,
					"last_name": lastName,
					"disable_notification": disableNotification,
					"reply_to_message_id": replyToMessageId,
					"reply_markup": replyMarkup,
					])
				
			case let .sendChatAction(chatId, action):
				json = SwiftyJSON.JSON(optionalDict: [
					"chat_id": chatId,
					"action": action,
					])
			}
			
			if action == .response {
				json["method"].stringValue = name
			}
			
			return json
		}
	}
}


	
