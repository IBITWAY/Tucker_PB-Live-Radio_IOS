//
//  SongEndpoints.swift
//
//  Created by Sheraz Rasheed on 04/12/2020
//  Copyright (c) Sheraz Rasheed. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SongEndpoints: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kSongEndpointsStationKey: String = "station"
	internal let kSongEndpointsGenresKey: String = "genres"
	internal let kSongEndpointsBroadcastKey: String = "broadcast"
	internal let kSongEndpointsShowsKey: String = "shows"
	internal let kSongEndpointsLanguagesKey: String = "languages"
	internal let kSongEndpointsScheduleKey: String = "schedule"


    // MARK: Properties
	public var station: String?
	public var genres: String?
	public var broadcast: String?
	public var shows: String?
	public var languages: String?
	public var schedule: String?


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
		station = json[kSongEndpointsStationKey].string
		genres = json[kSongEndpointsGenresKey].string
		broadcast = json[kSongEndpointsBroadcastKey].string
		shows = json[kSongEndpointsShowsKey].string
		languages = json[kSongEndpointsLanguagesKey].string
		schedule = json[kSongEndpointsScheduleKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : Any ] {

        var dictionary: [String : Any ] = [ : ]
		if station != nil {
			dictionary.updateValue(station!, forKey: kSongEndpointsStationKey)
		}
		if genres != nil {
			dictionary.updateValue(genres!, forKey: kSongEndpointsGenresKey)
		}
		if broadcast != nil {
			dictionary.updateValue(broadcast!, forKey: kSongEndpointsBroadcastKey)
		}
		if shows != nil {
			dictionary.updateValue(shows!, forKey: kSongEndpointsShowsKey)
		}
		if languages != nil {
			dictionary.updateValue(languages!, forKey: kSongEndpointsLanguagesKey)
		}
		if schedule != nil {
			dictionary.updateValue(schedule!, forKey: kSongEndpointsScheduleKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.station = aDecoder.decodeObject(forKey: kSongEndpointsStationKey) as? String
        self.genres = aDecoder.decodeObject(forKey: kSongEndpointsGenresKey) as? String
        self.broadcast = aDecoder.decodeObject(forKey: kSongEndpointsBroadcastKey) as? String
        self.shows = aDecoder.decodeObject(forKey: kSongEndpointsShowsKey) as? String
        self.languages = aDecoder.decodeObject(forKey: kSongEndpointsLanguagesKey) as? String
        self.schedule = aDecoder.decodeObject(forKey: kSongEndpointsScheduleKey) as? String

    }

    public func encode(with aCoder: NSCoder) {
		aCoder.encode(station, forKey: kSongEndpointsStationKey)
		aCoder.encode(genres, forKey: kSongEndpointsGenresKey)
		aCoder.encode(broadcast, forKey: kSongEndpointsBroadcastKey)
		aCoder.encode(shows, forKey: kSongEndpointsShowsKey)
		aCoder.encode(languages, forKey: kSongEndpointsLanguagesKey)
		aCoder.encode(schedule, forKey: kSongEndpointsScheduleKey)

    }

}
