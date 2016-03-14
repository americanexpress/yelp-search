public class YelpClient {
    private let oauthClient: YelpOAuthClient

    public init(oauthToken: YelpOAuthToken) {
        self.oauthClient = YelpOAuthClient(oauthToken: oauthToken)
    }

    public func makeSearchRequest(request: YelpSearchRequest, success: (YelpSearchResults) -> Void, failure: (NSError) -> Void) throws {
        try request.validateParameters()

        oauthClient.makeRequest(YelpEndpoints.Search, parameters: request.getMergedSearchParameters(), success: {
            (data, response) -> Void in
            let parser = YelpSearchParser()
            let searchResults = parser.parseDataResponse(data)
            success(searchResults)
        }, failure: {
            (error: NSError!) -> Void in
            failure(error)
        })
    }

}
