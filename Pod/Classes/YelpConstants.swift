struct YelpErrorKeys {
    static let Root = "error"
    static let Text = "text"
    static let ID = "id"
    static let Field = "field"
}

struct YelpResponseKeys {
    static let Total = "total"
    static let Businesses = "businesses"
    static let Categories = "categories"
    static let DisplayPhone = "display_phone"
    static let ID = "id"
    static let ImageURL = "image_url"
    static let IsClaimed = "is_claimed"
    static let IsClosed = "is_closed"
    static let Location = "location"
    static let Address = "address"
    static let City = "city"
    static let Coordinate = "coordinate"
    static let Latitude = "latitude"
    static let Longitude = "longitude"
    static let CountryCode = "country_code"
    static let CrossStreets = "cross_streets"
    static let DisplayAddress = "display_address"
    static let GeoAccuracy = "geo_accuracy"
    static let Neighborhoods = "neighborhoods"
    static let PostalCode = "postal_code"
    static let StateCode = "state_code"
    static let MobileUrl = "mobile_url"
    static let Name = "name"
    static let Phone = "phone"
    static let Rating = "rating"
    static let RatingImageURL = "rating_img_url"
    static let RatingImageURLLarge = "rating_img_url_large"
    static let RatingImageURLSmall = "rating_img_url_small"
    static let ReviewCount = "review_count"
    static let SnippetImageURL = "snippet_image_url"
    static let SnippetText = "snippet_text"
    static let URL = "url"
}

struct YelpQueryParameters {
    static let NeighborhoodCoordinate = "cll"
    static let LocaleCountryCode = "cc"
    static let LocaleLanguageCode = "lang"
    static let ActionLinks = "actionlinks"
    static let Term = "term"
    static let Limit = "limit"
    static let Offset = "offset"
    static let Sort = "sort"
    static let CategoryFilter = "category_filter"
    static let RadiusFilter = "radius_filter"
    static let DealsFilter = "deals_filter"
}

struct YelpLocationQueryParameters {
    static let Neighborhood = "location"
    static let BoundingBox = "bounds"
    static let Coordinate = "ll"
}

struct YelpSortOrderParameters {
    static let BestMatch = "0"
    static let Distance = "1"
    static let HighestRated = "2"
}

struct YelpEndpoints {
    static let Search = "https://api.yelp.com/v2/search"
}
