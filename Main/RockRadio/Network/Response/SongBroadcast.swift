//
//  SongBroadcast.swift
//
//  Created by Sheraz Rasheed on 04/12/2020
//  Copyright (c) Sheraz Rasheed. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SongBroadcast: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kSongBroadcastCurrentShowKey: String = "current_show"
	internal let kSongBroadcastCurrentPlaylistKey: String = "current_playlist"
	internal let kSongBroadcastNextShowKey: String = "next_show"


    // MARK: Properties
	public var currentShow: SongCurrentShow?
	public var currentPlaylist: Bool = false
	public var nextShow: SongNextShow?


    // MARK: SwiftyJSON Initalizers
    /**
    Initates the class based on the object
    - parameter object: The object of either Dictionary or Array kind that was passed.
    - returns: An initalized instance of the class.
    */
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }

    /**
    Initates the class based on the JSON that was passed.
    - parameter json: JSON object from SwiftyJSON.
    - returns: An initalized instance of the class.
    */
    public init(json: JSON) {
		currentShow = SongCurrentShow(json: json[kSongBroadcastCurrentShowKey])
		currentPlaylist = json[kSongBroadcastCurrentPlaylistKey].boolValue
		nextShow = SongNextShow(json: json[kSongBroadcastNextShowKey])

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : Any ] {

        var dictionary: [String : Any ] = [ : ]
		if currentShow != nil {
			dictionary.updateValue(currentShow!.dictionaryRepresentation(), forKey: kSongBroadcastCurrentShowKey)
		}
		dictionary.updateValue(currentPlaylist, forKey: kSongBroadcastCurrentPlaylistKey)
		if nextShow != nil {
			dictionary.updateValue(nextShow!.dictionaryRepresentation(), forKey: kSongBroadcastNextShowKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.currentShow = aDecoder.decodeObject(forKey: kSongBroadcastCurrentShowKey) as? SongCurrentShow
        self.currentPlaylist = aDecoder.decodeBool(forKey: kSongBroadcastCurrentPlaylistKey)
        self.nextShow = aDecoder.decodeObject(forKey: kSongBroadcastNextShowKey) as? SongNextShow

    }

    public func encode(with aCoder: NSCoder) {
		aCoder.encode(currentShow, forKey: kSongBroadcastCurrentShowKey)
		aCoder.encode(currentPlaylist, forKey: kSongBroadcastCurrentPlaylistKey)
		aCoder.encode(nextShow, forKey: kSongBroadcastNextShowKey)

    }

}
