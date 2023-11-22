//
//  SongCurrentShow.swift
//
//  Created by Sheraz Rasheed on 04/12/2020
//  Copyright (c) Sheraz Rasheed. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SongCurrentShow: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kSongCurrentShowSplitKey: String = "split"
	internal let kSongCurrentShowDateKey: String = "date"
	internal let kSongCurrentShowDayKey: String = "day"
	internal let kSongCurrentShowEncoreKey: String = "encore"
	internal let kSongCurrentShowStartKey: String = "start"
	internal let kSongCurrentShowEndKey: String = "end"
	internal let kSongCurrentShowOverrideKey: String = "override"
	internal let kSongCurrentShowShowKey: String = "show"


    // MARK: Properties
	public var split: Bool = false
	public var date: String?
	public var day: String?
	public var encore: Bool = false
	public var start: String?
	public var end: String?
	public var override: Bool = false
	public var show: SongShow?


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
		split = json[kSongCurrentShowSplitKey].boolValue
		date = json[kSongCurrentShowDateKey].string
		day = json[kSongCurrentShowDayKey].string
		encore = json[kSongCurrentShowEncoreKey].boolValue
		start = json[kSongCurrentShowStartKey].string
		end = json[kSongCurrentShowEndKey].string
		override = json[kSongCurrentShowOverrideKey].boolValue
		show = SongShow(json: json[kSongCurrentShowShowKey])

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : Any ] {

        var dictionary: [String : Any ] = [ : ]
		dictionary.updateValue(split, forKey: kSongCurrentShowSplitKey)
		if date != nil {
			dictionary.updateValue(date!, forKey: kSongCurrentShowDateKey)
		}
		if day != nil {
			dictionary.updateValue(day!, forKey: kSongCurrentShowDayKey)
		}
		dictionary.updateValue(encore, forKey: kSongCurrentShowEncoreKey)
		if start != nil {
			dictionary.updateValue(start!, forKey: kSongCurrentShowStartKey)
		}
		if end != nil {
			dictionary.updateValue(end!, forKey: kSongCurrentShowEndKey)
		}
		dictionary.updateValue(override, forKey: kSongCurrentShowOverrideKey)
		if show != nil {
			dictionary.updateValue(show!.dictionaryRepresentation(), forKey: kSongCurrentShowShowKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.split = aDecoder.decodeBool(forKey: kSongCurrentShowSplitKey)
        self.date = aDecoder.decodeObject(forKey: kSongCurrentShowDateKey) as? String
        self.day = aDecoder.decodeObject(forKey: kSongCurrentShowDayKey) as? String
        self.encore = aDecoder.decodeBool(forKey: kSongCurrentShowEncoreKey)
        self.start = aDecoder.decodeObject(forKey: kSongCurrentShowStartKey) as? String
        self.end = aDecoder.decodeObject(forKey: kSongCurrentShowEndKey) as? String
        self.override = aDecoder.decodeBool(forKey: kSongCurrentShowOverrideKey)
        self.show = aDecoder.decodeObject(forKey: kSongCurrentShowShowKey) as? SongShow

    }

    public func encode(with aCoder: NSCoder) {
		aCoder.encode(split, forKey: kSongCurrentShowSplitKey)
		aCoder.encode(date, forKey: kSongCurrentShowDateKey)
		aCoder.encode(day, forKey: kSongCurrentShowDayKey)
		aCoder.encode(encore, forKey: kSongCurrentShowEncoreKey)
		aCoder.encode(start, forKey: kSongCurrentShowStartKey)
		aCoder.encode(end, forKey: kSongCurrentShowEndKey)
		aCoder.encode(override, forKey: kSongCurrentShowOverrideKey)
		aCoder.encode(show, forKey: kSongCurrentShowShowKey)

    }

}
