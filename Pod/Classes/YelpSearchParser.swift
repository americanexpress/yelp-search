import SwiftyJSON

class YelpSearchParser {

    func parseDataResponse(data: NSData) -> YelpSearchResults {
        var businesses = [YelpBusiness]()
        let json = JSON(data: data)

        if json[YelpErrorKeys.Root].isExists() {
            return YelpSearchResults.Error(error: parseError(json[YelpErrorKeys.Root]))
        }

        guard let total = json[YelpResponseKeys.Total].int,
        let businessResults = json[YelpResponseKeys.Businesses].array else {
            return YelpSearchResults.Error(error: buildErrorMissingFields())
        }

        for business in businessResults {
            let categories = self.parseCategories(business)
            let displayPhone = business[YelpResponseKeys.DisplayPhone].string
            let yelpId = business[YelpResponseKeys.ID].string
            let imageURL = parseValueAsURL(business[YelpResponseKeys.ImageURL].string)
            let isClaimed = business[YelpResponseKeys.IsClaimed].bool
            let isClosed = business[YelpResponseKeys.IsClosed].bool
            let location = self.parseLocation(business)
            let mobileUrl = parseValueAsURL(business[YelpResponseKeys.MobileUrl].string)
            let name = business[YelpResponseKeys.Name].string
            let phone = business[YelpResponseKeys.Phone].string
            let rating = business[YelpResponseKeys.Rating].double
            let ratingImgURL = parseValueAsURL(business[YelpResponseKeys.RatingImageURL].string)
            let ratingImgURLLarge = parseValueAsURL(business[YelpResponseKeys.RatingImageURLLarge].string)
            let ratingImgURLSmall = parseValueAsURL(business[YelpResponseKeys.RatingImageURLSmall].string)
            let reviewCount = business[YelpResponseKeys.ReviewCount].int
            let snippetImageURL = parseValueAsURL(business[YelpResponseKeys.SnippetImageURL].string)
            let snippetText = business[YelpResponseKeys.SnippetText].string
            let url = parseValueAsURL(business[YelpResponseKeys.URL].string)

            businesses.append(
            YelpBusiness(categories: categories,
                    displayPhone: displayPhone,
                    yelpId: yelpId,
                    imageURL: imageURL,
                    isClaimed: isClaimed,
                    isClosed: isClosed,
                    location: location,
                    mobileURL: mobileUrl,
                    name: name,
                    phone: phone,
                    rating: rating,
                    ratingImgURL: ratingImgURL,
                    ratingImgURLLarge: ratingImgURLLarge,
                    ratingImgURLSmall: ratingImgURLSmall,
                    reviewCount: reviewCount,
                    snippetImageURL: snippetImageURL,
                    snippetText: snippetText,
                    url: url))
        }

        return YelpSearchResults.Success(businesses: businesses, total: total)
    }

    /*
    * One possible field on a business returned by yelp is "categories".  That is an
    * array of arrays, where each of the sub-arrays is exactly two elements long.  The first
    * element is the display name of a category (like "Local Flavor") and the second element is a
    * key that represents that category (like "localflavor"). This function uses those assumptions to
    * construct a YelpCategory that contains both elements.
    *
    * This has been confirmed with the Yelp API team. Email api@yelp.com with questions.
    */
    private func parseCategories(business: JSON) -> [YelpCategory]? {
        var parsedCategories = [YelpCategory]()
        if let categories = business[YelpResponseKeys.Categories].arrayObject as? [[String]] {
            for category in categories {
                if (category.count == 2) {
                    parsedCategories.append(YelpCategory(alias: category[0], category: category[1]))
                }
            }
            return parsedCategories
        }

        return nil
    }

    private func parseLocation(business: JSON) -> YelpLocation {
        let location = business[YelpResponseKeys.Location]
        let address = location[YelpResponseKeys.Address].arrayObject as? [String]
        let city = location[YelpResponseKeys.City].string
        let countryCode = location[YelpResponseKeys.CountryCode].string
        let crossStreets = location[YelpResponseKeys.CrossStreets].string
        let displayAddress = location[YelpResponseKeys.DisplayAddress].arrayObject as? [String]
        let geoAccuracy = location[YelpResponseKeys.GeoAccuracy].double
        let neighborhoods = location[YelpResponseKeys.Neighborhoods].arrayObject as? [String]
        let postalCode = location[YelpResponseKeys.PostalCode].string
        let stateCode = location[YelpResponseKeys.StateCode].string

        let coordinate = parseLatLong(location)

        return YelpLocation(address: address,
                city: city,
                coordinate: coordinate,
                countryCode: countryCode,
                crossStreets: crossStreets,
                displayAddress: displayAddress,
                geoAccuracy: geoAccuracy,
                neighborhoods: neighborhoods,
                postalCode: postalCode,
                stateCode: stateCode)
    }

    private func parseLatLong(location: JSON) -> YelpLatLong? {
        guard let coordinate = location[YelpResponseKeys.Coordinate].dictionaryObject,
        let latitude = coordinate[YelpResponseKeys.Latitude],
        let longitude = coordinate[YelpResponseKeys.Longitude] else {
            return nil
        }

        return YelpLatLong(latitude: String(latitude), longitude: String(longitude))
    }

    private func parseError(error: JSON) -> YelpError {
        let errorText: String
        if let text = error[YelpErrorKeys.Text].string {
            errorText = text
        } else {
            errorText = "Unknown error"
        }

        let errorType: YelpErrorType
        if let typeString = error[YelpErrorKeys.ID].string,
        let type = YelpErrorType(rawValue: typeString) {
            errorType = type
        } else {
            errorType = YelpErrorType.Unknown
        }


        let errorField: String
        if let field = error[YelpErrorKeys.Field].string {
            errorField = field
        } else {
            errorField = "Unknown field"
        }

        return YelpError(errorText: errorText, errorType: errorType, field: errorField)
    }

    private func parseValueAsURL(value: String?) -> NSURL? {
        if let valueString = value {
            return NSURL(string: valueString)
        }

        return nil
    }

    private func buildErrorMissingFields() -> YelpError {
        return YelpError(errorText: "Received Yelp response, but missing 'businesses' or 'total' keys",
                errorType: .Unknown,
                field: "Missing 'businesses' or 'total' keys")
    }

}