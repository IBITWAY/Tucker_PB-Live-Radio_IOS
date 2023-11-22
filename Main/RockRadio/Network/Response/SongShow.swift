//
//  SongShow.swift
//
//  Created by Sheraz Rasheed on 04/12/2020
//  Copyright (c) Sheraz Rasheed. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SongShow: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kSongShowFeedKey: String = "feed"
	internal let kSongShowHostsKey: String = "hosts"
	internal let kSongShowGenresKey: String = "genres"
	internal let kSongShowWebsiteKey: String = "website"
	internal let kSongShowNameKey: String = "name"
	internal let kSongShowLatestKey: String = "latest"
	internal let kSongShowProducersKey: String = "producers"
	internal let kSongShowInternalIdentifierKey: String = "id"
	internal let kSongShowLanguagesKey: String = "languages"
	internal let kSongShowRouteKey: String = "route"
	internal let kSongShowAvatarUrlKey: String = "avatar_url"
	internal let kSongShowImageUrlKey: String = "image_url"
	internal let kSongShowUrlKey: String = "url"
	internal let kSongShowSlugKey: String = "slug"


    // MARK: Properties
	public var feed: String?
	public var website: String?
	public var name: String?
	public var latest: String?
	public var internalIdentifier: Int?
	public var route: String?
	public var avatarUrl: String?
	public var imageUrl: String?
	public var url: String?
	public var slug: String?


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
		feed = json[kSongShowFeedKey].string
		website = json[kSongShowWebsiteKey].string
		name = json[kSongShowNameKey].string
		latest = json[kSongShowLatestKey].string
		internalIdentifier = json[kSongShowInternalIdentifierKey].int
		route = json[kSongShowRouteKey].string
		avatarUrl = json[kSongShowAvatarUrlKey].string
		imageUrl = json[kSongShowImageUrlKey].string
		url = json[kSongShowUrlKey].string
		slug = json[kSongShowSlugKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : Any ] {

        var dictionary: [String : Any ] = [ : ]
		if feed != nil {
			dictionary.updateValue(feed!, forKey: kSongShowFeedKey)
		}
		if website != nil {
			dictionary.updateValue(website!, forKey: kSongShowWebsiteKey)
		}
		if name != nil {
			dictionary.updateValue(name!, forKey: kSongShowNameKey)
		}
		if latest != nil {
			dictionary.updateValue(latest!, forKey: kSongShowLatestKey)
		}
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier!, forKey: kSongShowInternalIdentifierKey)
		}
		if route != nil {
			dictionary.updateValue(route!, forKey: kSongShowRouteKey)
		}
		if avatarUrl != nil {
			dictionary.updateValue(avatarUrl!, forKey: kSongShowAvatarUrlKey)
		}
		if imageUrl != nil {
			dictionary.updateValue(imageUrl!, forKey: kSongShowImageUrlKey)
		}
		if url != nil {
			dictionary.updateValue(url!, forKey: kSongShowUrlKey)
		}
		if slug != nil {
			dictionary.updateValue(slug!, forKey: kSongShowSlugKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.feed = aDecoder.decodeObject(forKey: kSongShowFeedKey) as? String
        self.website = aDecoder.decodeObject(forKey: kSongShowWebsiteKey) as? String
        self.name = aDecoder.decodeObject(forKey: kSongShowNameKey) as? String
        self.latest = aDecoder.decodeObject(forKey: kSongShowLatestKey) as? String
        self.internalIdentifier = aDecoder.decodeObject(forKey: kSongShowInternalIdentifierKey) as? Int
        self.route = aDecoder.decodeObject(forKey: kSongShowRouteKey) as? String
        self.avatarUrl = aDecoder.decodeObject(forKey: kSongShowAvatarUrlKey) as? String
        self.imageUrl = aDecoder.decodeObject(forKey: kSongShowImageUrlKey) as? String
        self.url = aDecoder.decodeObject(forKey: kSongShowUrlKey) as? String
        self.slug = aDecoder.decodeObject(forKey: kSongShowSlugKey) as? String

    }

    public func encode(with aCoder: NSCoder) {
		aCoder.encode(feed, forKey: kSongShowFeedKey)
		aCoder.encode(website, forKey: kSongShowWebsiteKey)
		aCoder.encode(name, forKey: kSongShowNameKey)
		aCoder.encode(latest, forKey: kSongShowLatestKey)
		aCoder.encode(internalIdentifier, forKey: kSongShowInternalIdentifierKey)
		aCoder.encode(route, forKey: kSongShowRouteKey)
		aCoder.encode(avatarUrl, forKey: kSongShowAvatarUrlKey)
		aCoder.encode(imageUrl, forKey: kSongShowImageUrlKey)
		aCoder.encode(url, forKey: kSongShowUrlKey)
		aCoder.encode(slug, forKey: kSongShowSlugKey)

    }

}
