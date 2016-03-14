import Quick
import Nimble
@testable import YelpSearch

class YelpSearchParserTest: QuickSpec {

    override func spec() {
        describe("YelpSearchParser") {
            context("handles a Yelp error") {
                context("with known errors") {
                    let parser = YelpSearchParser()
                    let testBundle = NSBundle(forClass: YelpSearchParserTest.self)
                    let testDataPath = testBundle.pathForResource("YelpErrorResponse", ofType: "json")
                    let results: YelpSearchResults = parser.parseDataResponse(NSData(contentsOfFile: testDataPath!)!)

                    it("sets the properties of a yelp error") {
                        let expectedError = YelpError(errorText: "Invalid parameter", errorType: .InvalidParameter, field: "location")
                        let expectedResults = YelpSearchResults.Error(error: expectedError)
                        expect(results) == expectedResults
                    }
                }

                context("with unknown errors") {
                    let parser = YelpSearchParser()
                    let testBundle = NSBundle(forClass: YelpSearchParserTest.self)
                    let testDataPath = testBundle.pathForResource("YelpUnknownErrorResponse", ofType: "json")
                    let results: YelpSearchResults = parser.parseDataResponse(NSData(contentsOfFile: testDataPath!)!)

                    it("returns an unknown error when unable to match a Yelp error code") {
                        let expectedError = YelpError(errorText: "Yelp introduced a new error type", errorType: .Unknown, field: "new field")
                        let expectedResults = YelpSearchResults.Error(error: expectedError)
                        expect(results) == expectedResults
                    }
                }

                context("with missing keys") {
                    let parser = YelpSearchParser()
                    let testBundle = NSBundle(forClass: YelpSearchParserTest.self)
                    let testDataPath = testBundle.pathForResource("YelpMissingKeysErrorResponse", ofType: "json")
                    let results: YelpSearchResults = parser.parseDataResponse(NSData(contentsOfFile: testDataPath!)!)

                    it("returns an unknown error when Yelp error keys are missing") {
                        let expectedError = YelpError(errorText: "Unknown error", errorType: .Unknown, field: "Unknown field")
                        let expectedResults = YelpSearchResults.Error(error: expectedError)
                        expect(results) == expectedResults
                    }
                }


            }

            context("handles a well-formed Yelp response and ") {
                let parser = YelpSearchParser()
                let testBundle = NSBundle(forClass: YelpSearchParserTest.self)
                let testDataPath = testBundle.pathForResource("YelpFullResponse", ofType: "json")
                let results: YelpSearchResults = parser.parseDataResponse(NSData(contentsOfFile: testDataPath!)!)
                var business: YelpBusiness = YelpBusiness(categories: nil, displayPhone: nil, yelpId: nil, imageURL: nil, isClaimed: nil, isClosed: nil, location: nil, mobileURL: nil, name: nil, phone: nil, rating: nil, ratingImgURL: nil, ratingImgURLLarge: nil, ratingImgURLSmall: nil, reviewCount: nil, snippetImageURL: nil, snippetText: nil, url: nil)
                var totalResults: Int = 0

                beforeEach {
                    switch (results) {
                    case .Error:
                        fail()
                    case .Success(let businesses, let total):
                        business = businesses[0]
                        totalResults = total
                    }
                }

                it("parses the total correctly") {
                    expect(totalResults) == 2316
                }

                describe("parses the categories correctly and ") {
                    it("handles multiple categories") {
                        expect(business.categories!.count) == 2
                    }

                    it("parses the alias correctly") {
                        expect(business.categories![0].alias) == "Local Flavor"
                        expect(business.categories![1].alias) == "Mass Media"
                    }

                    it("parses the category correctly") {
                        expect(business.categories![0].category) == "localflavor"
                        expect(business.categories![1].category) == "massmedia"
                    }
                }

                it("parses the displayphone correctly") {
                    expect(business.displayPhone) == "+1-415-908-3801"
                }

                it("parses the yelp id correctly") {
                    expect(business.yelpId) == "yelp-san-francisco"
                }

                it("parses the image url correctly") {
                    expect(business.imageURL!.description) == "http://s3-media3.fl.yelpcdn.com/bphoto/nQK-6_vZMt5n88zsAS94ew/ms.jpg"
                }

                it("parses is claimed correctly") {
                    expect(business.isClaimed).to(beTrue())
                }

                it("parses is closed correctly") {
                    expect(business.isClosed).to(beFalse())
                }

                describe("parses the location correctly and ") {
                    var location: YelpLocation?
                    beforeEach {
                        location = business.location
                    }
                    it("parses the address correctly") {
                        expect(location!.address!.count) == 1
                        expect(location!.address![0]) == "140 New Montgomery St"
                    }

                    it("parses the city correctly") {
                        expect(location!.city!) == "San Francisco"
                    }

                    it("parses the coordinate correctly") {
                        expect(location!.coordinate!.latitude) == "37.7867703362929"
                        expect(location!.coordinate!.longitude) == "-122.399958372115"
                    }

                    it("parses the country code correctly") {
                        expect(location!.countryCode) == "US"
                    }

                    it("parses the cross streets correctly") {
                        expect(location!.crossStreets) == "Natoma St & Minna St"
                    }

                    it("parses the display address correctly") {
                        expect(location!.displayAddress!.count) == 3
                        expect(location!.displayAddress![0]) == "140 New Montgomery St"
                        expect(location!.displayAddress![1]) == "Financial District"
                        expect(location!.displayAddress![2]) == "San Francisco, CA 94105"
                    }

                    it("parses the geo accuracy correctly") {
                        expect(location!.geoAccuracy) == 9.5
                    }

                    it("parses the neighborhoods correctly") {
                        expect(location!.neighborhoods!.count) == 2
                        expect(location!.neighborhoods![0]) == "Financial District"
                        expect(location!.neighborhoods![1]) == "SoMa"
                    }

                    it("parses the postal code correctly") {
                        expect(location!.postalCode) == "94105"
                    }

                    it("parses the state code correctly") {
                        expect(location!.stateCode) == "CA"
                    }
                }

                it("parses the mobile url correctly") {
                    expect(business.mobileURL!.description) == "http://m.yelp.com/biz/yelp-san-francisco"
                }

                it("parses the name correctly") {
                    expect(business.name) == "Yelp"
                }

                it("parses the phone correctly") {
                    expect(business.phone) == "4159083801"
                }

                it("parses the rating correctly") {
                    expect(business.rating) == 2.5
                }

                it("parses the rating image url correctly") {
                    expect(business.ratingImgURL!.description) == "http://s3-media4.fl.yelpcdn.com/assets/2/www/img/c7fb9aff59f9/ico/stars/v1/stars_2_half.png"
                }

                it("parses the rating image url large correctly") {
                    expect(business.ratingImgURLLarge!.description) == "http://s3-media2.fl.yelpcdn.com/assets/2/www/img/d63e3add9901/ico/stars/v1/stars_large_2_half.png"
                }

                it("parses the rating image url small correctly") {
                    expect(business.ratingImgURLSmall!.description) == "http://s3-media4.fl.yelpcdn.com/assets/2/www/img/8e8633e5f8f0/ico/stars/v1/stars_small_2_half.png"
                }

                it("parses the review count correctly") {
                    expect(business.reviewCount) == 7140
                }

                it("parses the snippet image url correctly") {
                    expect(business.snippetImageURL!.description) == "http://s3-media4.fl.yelpcdn.com/photo/YcjPScwVxF05kj6zt10Fxw/ms.jpg"
                }

                it("parses the snippet text correctly") {
                    expect(business.snippetText) == "What would I do without Yelp?\n\nI wouldn't be HALF the foodie I've become it weren't for this business.    \n\nYelp makes it virtually effortless to discover new..."
                }

                it("parses the url correctly") {
                    expect(business.url!.description) == "http://www.yelp.com/biz/yelp-san-francisco"
                }
            }

        }
    }

}
