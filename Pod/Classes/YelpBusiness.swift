public struct YelpBusiness: Equatable {
    public let categories: [YelpCategory]?
    public let displayPhone: String?
    public let yelpId: String?
    public let imageURL: NSURL?
    public let isClaimed: Bool?
    public let isClosed: Bool?
    public let location: YelpLocation?
    public let mobileURL: NSURL?
    public let name: String?
    public let phone: String?
    public let rating: Double?
    public let ratingImgURL: NSURL?
    public let ratingImgURLLarge: NSURL?
    public let ratingImgURLSmall: NSURL?
    public let reviewCount: Int?
    public let snippetImageURL: NSURL?
    public let snippetText: String?
    public let url: NSURL?
}

public func ==(lhs: YelpBusiness, rhs: YelpBusiness) -> Bool {
    var locationIsEqual = false
    switch (lhs.location, rhs.location) {
    case (.Some(let lhs), .Some(let rhs)):
        locationIsEqual = lhs == rhs
    case (.None, .None):
        locationIsEqual = true
    default:
        return false
    }

    return locationIsEqual &&
            lhs.displayPhone == rhs.displayPhone &&
            lhs.yelpId == rhs.yelpId &&
            lhs.imageURL == rhs.imageURL &&
            lhs.isClaimed == rhs.isClaimed &&
            lhs.isClosed == rhs.isClosed &&
            lhs.location == rhs.location &&
            lhs.mobileURL == rhs.mobileURL &&
            lhs.name == rhs.name &&
            lhs.phone == rhs.phone &&
            lhs.rating == rhs.rating &&
            lhs.ratingImgURL == rhs.ratingImgURL &&
            lhs.ratingImgURLLarge == rhs.ratingImgURLLarge &&
            lhs.ratingImgURLSmall == rhs.ratingImgURLSmall &&
            lhs.reviewCount == rhs.reviewCount &&
            lhs.snippetImageURL == rhs.snippetImageURL &&
            lhs.snippetText == rhs.snippetText &&
            lhs.url == rhs.url
}