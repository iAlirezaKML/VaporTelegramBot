// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation
import SwiftyJSON

/// Represents a link to a photo stored on the Telegram servers. By default, this photo will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the photo.
///
/// - SeeAlso: <https://core.telegram.org/bots/api#inlinequeryresultcachedphoto>

public struct InlineQueryResultCachedPhoto: JsonConvertible {
    /// Original JSON for fields not yet added to Swift structures.
    public var json: JSON

    /// Type of the result, must be photo
    public var type_string: String {
        get { return json["type"].stringValue }
        set { json["type"].stringValue = newValue }
    }

    /// Unique identifier for this result, 1-64 bytes
    public var id: String {
        get { return json["id"].stringValue }
        set { json["id"].stringValue = newValue }
    }

    /// A valid file identifier of the photo
    public var photo_file_id: String {
        get { return json["photo_file_id"].stringValue }
        set { json["photo_file_id"].stringValue = newValue }
    }

    /// Optional. Title for the result
    public var title: String? {
        get { return json["title"].string }
        set { json["title"].string = newValue }
    }

    /// Optional. Short description of the result
    public var description: String? {
        get { return json["description"].string }
        set { json["description"].string = newValue }
    }

    /// Optional. Caption of the photo to be sent, 0-200 characters
    public var caption: String? {
        get { return json["caption"].string }
        set { json["caption"].string = newValue }
    }

    /// Optional. Inline keyboard attached to the message
    public var reply_markup: InlineKeyboardMarkup? {
        get {
            let value = json["reply_markup"]
            return value.isNullOrUnknown ? nil : InlineKeyboardMarkup(json: value)
        }
        set {
            json["reply_markup"] = newValue?.json ?? JSON.null
        }
    }

    /// Optional. Content of the message to be sent instead of the photo
    public var input_message_content: InputMessageContent? {
        get {
            let value = json["input_message_content"]
            return value.isNullOrUnknown ? nil : InputMessageContent(json: value)
        }
        set {
            json["input_message_content"] = newValue?.json ?? JSON.null
        }
    }

    public init(json: JSON = [:]) {
        self.json = json
    }
}
