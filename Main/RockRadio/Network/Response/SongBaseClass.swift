//
//  SongBaseClass.swift
//
//  Created by Sheraz Rasheed on 04/12/2020
//  Copyright (c) Sheraz Rasheed. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SongBaseClass: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kSongBaseClassTimezoneKey: String = "timezone"
	internal let kSongBaseClassDateTimeKey: String = "date_time"
	internal let kSongBaseClassBroadcastKey: String = "broadcast"
	internal let kSongBaseClassSuccessKey: String = "success"
	internal let kSongBaseClassScheduleUrlKey: String = "schedule_url"
	internal let kSongBaseClassEndpointsKey: String = "endpoints"
	internal let kSongBaseClassTimestampKey: String = "timestamp"
	internal let kSongBaseClassStreamUrlKey: String = "stream_url"
	internal let kSongBaseClassStationUrlKey: String = "station_url"
	internal let kSongBaseClassLanguageKey: String = "language"
	internal let kSongBaseClassUpdatedKey: String = "updated"


    // MARK: Properties
	public var timezone: String?
	public var dateTime: String?
	public var broadcast: SongBroadcast?
	public var success: Bool = false
	public var scheduleUrl: String?
	public var endpoints: SongEndpoints?
	public var timestamp: String?
	public var streamUrl: String?
	public var stationUrl: String?
	public var language: String?
	public var updated: String?


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
		timezone = json[kSongBaseClassTimezoneKey].string
		dateTime = json[kSongBaseClassDateTimeKey].string
		broadcast = SongBroadcast(json: json[kSongBaseClassBroadcastKey])
		success = json[kSongBaseClassSuccessKey].boolValue
		scheduleUrl = json[kSongBaseClassScheduleUrlKey].string
		endpoints = SongEndpoints(json: json[kSongBaseClassEndpointsKey])
		timestamp = json[kSongBaseClassTimestampKey].string
		streamUrl = json[kSongBaseClassStreamUrlKey].string
		stationUrl = json[kSongBaseClassStationUrlKey].string
		language = json[kSongBaseClassLanguageKey].string
		updated = json[kSongBaseClassUpdatedKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : Any ] {

        var dictionary: [String : Any ] = [ : ]
		if timezone != nil {
			dictionary.updateValue(timezone!, forKey: kSongBaseClassTimezoneKey)
		}
		if dateTime != nil {
			dictionary.updateValue(dateTime!, forKey: kSongBaseClassDateTimeKey)
		}
		if broadcast != nil {
			dictionary.updateValue(broadcast!.dictionaryRepresentation(), forKey: kSongBaseClassBroadcastKey)
		}
		dictionary.updateValue(success, forKey: kSongBaseClassSuccessKey)
		if scheduleUrl != nil {
			dictionary.updateValue(scheduleUrl!, forKey: kSongBaseClassScheduleUrlKey)
		}
		if endpoints != nil {
			dictionary.updateValue(endpoints!.dictionaryRepresentation(), forKey: kSongBaseClassEndpointsKey)
		}
		if timestamp != nil {
			dictionary.updateValue(timestamp!, forKey: kSongBaseClassTimestampKey)
		}
		if streamUrl != nil {
			dictionary.updateValue(streamUrl!, forKey: kSongBaseClassStreamUrlKey)
		}
		if stationUrl != nil {
			dictionary.updateValue(stationUrl!, forKey: kSongBaseClassStationUrlKey)
		}
		if language != nil {
			dictionary.updateValue(language!, forKey: kSongBaseClassLanguageKey)
		}
		if updated != nil {
			dictionary.updateValue(updated!, forKey: kSongBaseClassUpdatedKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.timezone = aDecoder.decodeObject(forKey: kSongBaseClassTimezoneKey) as? String
        self.dateTime = aDecoder.decodeObject(forKey: kSongBaseClassDateTimeKey) as? String
        self.broadcast = aDecoder.decodeObject(forKey: kSongBaseClassBroadcastKey) as? SongBroadcast
        self.success = aDecoder.decodeBool(forKey: kSongBaseClassSuccessKey)
        self.scheduleUrl = aDecoder.decodeObject(forKey: kSongBaseClassScheduleUrlKey) as? String
        self.endpoints = aDecoder.decodeObject(forKey: kSongBaseClassEndpointsKey) as? SongEndpoints
        self.timestamp = aDecoder.decodeObject(forKey: kSongBaseClassTimestampKey) as? String
        self.streamUrl = aDecoder.decodeObject(forKey: kSongBaseClassStreamUrlKey) as? String
        self.stationUrl = aDecoder.decodeObject(forKey: kSongBaseClassStationUrlKey) as? String
        self.language = aDecoder.decodeObject(forKey: kSongBaseClassLanguageKey) as? String
        self.updated = aDecoder.decodeObject(forKey: kSongBaseClassUpdatedKey) as? String

    }

    public func encode(with aCoder: NSCoder) {
		aCoder.encode(timezone, forKey: kSongBaseClassTimezoneKey)
		aCoder.encode(dateTime, forKey: kSongBaseClassDateTimeKey)
		aCoder.encode(broadcast, forKey: kSongBaseClassBroadcastKey)
		aCoder.encode(success, forKey: kSongBaseClassSuccessKey)
		aCoder.encode(scheduleUrl, forKey: kSongBaseClassScheduleUrlKey)
		aCoder.encode(endpoints, forKey: kSongBaseClassEndpointsKey)
		aCoder.encode(timestamp, forKey: kSongBaseClassTimestampKey)
		aCoder.encode(streamUrl, forKey: kSongBaseClassStreamUrlKey)
		aCoder.encode(stationUrl, forKey: kSongBaseClassStationUrlKey)
		aCoder.encode(language, forKey: kSongBaseClassLanguageKey)
		aCoder.encode(updated, forKey: kSongBaseClassUpdatedKey)

    }

}
