import Quick
import Nimble
@testable import YelpSearch

class YelpClientTest: QuickSpec {

    override func spec() {
        describe("YelpClient") {
            context("makeRequest") {
                let validConsumerKey = "consumerKey"
                let validConsumerSecret = "consumerSecret"
                let validAccessToken = "accessToken"
                let validAccessTokenSecret = "accessTokenSecret"
                let validOAuthToken = YelpOAuthToken(consumerKey: validConsumerKey,
                        consumerSecret: validConsumerSecret, accessToken: validAccessToken,
                        accessTokenSecret: validAccessTokenSecret)
                let client = YelpClient(oauthToken: validOAuthToken)

                it("requires that the location be provided") {
                    let request = YelpSearchRequest()
                    expect {
                        try client.makeSearchRequest(request, success: { _ in }, failure: { _ in })
                    }.to(throwError(YelpConfigurationError.MissingLocationParameter))
                }
            }
        }
    }

}
