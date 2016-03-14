@testable import YelpSearch

class YelpTestingData {

    static func createYelpCategory() -> YelpCategory {
        return YelpCategory(alias: "Test Alias", category: "Test Category")
    }

    static func createOtherYelpCategory() -> YelpCategory {
        return YelpCategory(alias: "Other", category: "Other")
    }

    static func createYelpLocation() -> YelpLocation {
        return YelpLocation(address: ["Test Address1", "Test Address 2"],
                city: "Test City",
                coordinate: YelpLatLong(latitude: "Test Location Latitude", longitude: "Test Location Longitude"),
                countryCode: "Test Country Code",
                crossStreets: "Test Cross Streets",
                displayAddress: ["Test Display Address1", "Test Display Address 2"],
                geoAccuracy: 12345.67890,
                neighborhoods: ["Test Neighborhood 1", "Test Neighborhood 2"],
                postalCode: "Test Postal Code",
                stateCode: "Test State Code"
        )
    }

    static func createNilYelpLocation() -> YelpLocation {
        return YelpLocation(address: nil,
                city: nil,
                coordinate: nil,
                countryCode: nil,
                crossStreets: nil,
                displayAddress: nil,
                geoAccuracy: nil,
                neighborhoods: nil,
                postalCode: nil,
                stateCode: nil
        )
    }

    static func createYelpBusiness() -> YelpBusiness {
        return YelpBusiness(categories: [YelpTestingData.createYelpCategory()],
                displayPhone: "Test Display Phone",
                yelpId: "Test Yelp Id",
                imageURL: NSURL(string: "Test Image URL"),
                isClaimed: true,
                isClosed: false,
                location: YelpTestingData.createYelpLocation(),
                mobileURL: NSURL(string: "Test Mobile URL"),
                name: "Test Name",
                phone: "Test Phone",
                rating: 987.654,
                ratingImgURL: NSURL(string: "Test Rating Image URL"),
                ratingImgURLLarge: NSURL(string: "Test Rating Image URL Large"),
                ratingImgURLSmall: NSURL(string: "Test Rating Image URL Small"),
                reviewCount: 12345,
                snippetImageURL: NSURL(string: "Test Snippet Image URL"),
                snippetText: "Test Snippet Text",
                url: NSURL(string: "Test URL")
        )
    }

    static func createNilYelpBusiness() -> YelpBusiness {
        return YelpBusiness(categories: nil,
                displayPhone: nil,
                yelpId: nil,
                imageURL: nil,
                isClaimed: nil,
                isClosed: nil,
                location: nil,
                mobileURL: nil,
                name: nil,
                phone: nil,
                rating: nil,
                ratingImgURL: nil,
                ratingImgURLLarge: nil,
                ratingImgURLSmall: nil,
                reviewCount: nil,
                snippetImageURL: nil,
                snippetText: nil,
                url: nil
        )
    }

    static func createYelpLatLong() -> YelpLatLong {
        return YelpLatLong(latitude: "Test Latitude", longitude: "Test Longitude")
    }

    static func createOtherYelpLatLong() -> YelpLatLong {
        return YelpLatLong(latitude: "Other Test Latitude", longitude: "Other Test Longitude")
    }

    static func createYelpError() -> YelpError {
        return YelpError(errorText: "Test Error Text", errorType: .Unknown, field: "Test Error Field")
    }

    static func createOtherYelpError() -> YelpError {
        return YelpError(errorText: "Other Error Text", errorType: .Unknown, field: "Other Error Field")
    }

    static func createYelpSearchResultsError() -> YelpSearchResults {
        return YelpSearchResults.Error(error: createYelpError())
    }

    static func createOtherYelpSearchResultsError() -> YelpSearchResults {
        return YelpSearchResults.Error(error: createOtherYelpError())
    }

    static func createYelpSearchResultsSuccess() -> YelpSearchResults {
        return YelpSearchResults.Success(businesses: [createYelpBusiness()], total: 1)
    }

    static func createOtherYelpSearchResultsSuccess() -> YelpSearchResults {
        return YelpSearchResults.Success(businesses: [createNilYelpBusiness()], total: 0)
    }

}
