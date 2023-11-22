//
//  SongNextShow.swift
//
//  Created by Sheraz Rasheed on 04/12/2020
//  Copyright (c) Sheraz Rasheed. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SongNextShow: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kSongNextShowSplitKey: String = "split"
	internal let kSongNextShowDateKey: String = "date"
	internal let kSongNextShowDayKey: String = "day"
	internal let kSongNextShowEncoreKey: String = "encore"
	internal let kSongNextShowStartKey: String = "start"
	internal let kSongNextShowEndKey: String = "end"
	internal let kSongNextShowOverrideKey: String = "override"
	internal let kSongNextShowShowKey: String = "show"


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
		split = json[kSongNextShowSplitKey].boolValue
		date = json[kSongNextShowDateKey].string
		day = json[kSongNextShowDayKey].string
		encore = json[kSongNextShowEncoreKey].boolValue
		start = json[kSongNextShowStartKey].string
		end = json[kSongNextShowEndKey].string
		override = json[kSongNextShowOverrideKey].boolValue
		show = SongShow(json: json[kSongNextShowShowKey])

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : Any ] {

        var dictionary: [String : Any ] = [ : ]
		dictionary.updateValue(split, forKey: kSongNextShowSplitKey)
		if date != nil {
			dictionary.updateValue(date!, forKey: kSongNextShowDateKey)
		}
		if day != nil {
			dictionary.updateValue(day!, forKey: kSongNextShowDayKey)
		}
		dictionary.updateValue(encore, forKey: kSongNextShowEncoreKey)
		if start != nil {
			dictionary.updateValue(start!, forKey: kSongNextShowStartKey)
		}
		if end != nil {
			dictionary.updateValue(end!, forKey: kSongNextShowEndKey)
		}
		dictionary.updateValue(override, forKey: kSongNextShowOverrideKey)
		if show != nil {
			dictionary.updateValue(show!.dictionaryRepresentation(), forKey: kSongNextShowShowKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.split = aDecoder.decodeBool(forKey: kSongNextShowSplitKey)
        self.date = aDecoder.decodeObject(forKey: kSongNextShowDateKey) as? String
        self.day = aDecoder.decodeObject(forKey: kSongNextShowDayKey) as? String
        self.encore = aDecoder.decodeBool(forKey: kSongNextShowEncoreKey)
        self.start = aDecoder.decodeObject(forKey: kSongNextShowStartKey) as? String
        self.end = aDecoder.decodeObject(forKey: kSongNextShowEndKey) as? String
        self.override = aDecoder.decodeBool(forKey: kSongNextShowOverrideKey)
        self.show = aDecoder.decodeObject(forKey: kSongNextShowShowKey) as? SongShow

    }

    public func encode(with aCoder: NSCoder) {
		aCoder.encode(split, forKey: kSongNextShowSplitKey)
		aCoder.encode(date, forKey: kSongNextShowDateKey)
		aCoder.encode(day, forKey: kSongNextShowDayKey)
		aCoder.encode(encore, forKey: kSongNextShowEncoreKey)
		aCoder.encode(start, forKey: kSongNextShowStartKey)
		aCoder.encode(end, forKey: kSongNextShowEndKey)
		aCoder.encode(override, forKey: kSongNextShowOverrideKey)
		aCoder.encode(show, forKey: kSongNextShowShowKey)

    }

}
