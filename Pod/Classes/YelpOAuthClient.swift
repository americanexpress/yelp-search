import OAuthSwift

class YelpOAuthClient {
    private let oauthSwiftClient: OAuthSwiftClient

    init(oauthToken: YelpOAuthToken) {
        self.oauthSwiftClient = OAuthSwiftClient(consumerKey: (oauthToken.consumerKey),
                consumerSecret: (oauthToken.consumerSecret),
                accessToken: (oauthToken.accessToken),
                accessTokenSecret: (oauthToken.accessTokenSecret)
        )
    }

    func makeRequest(url: String, parameters: Dictionary<String, String>, success: (data:NSData, response:NSHTTPURLResponse) -> Void, failure: (NSError) -> Void) {
        oauthSwiftClient.get(url, parameters: parameters, success: {
            (data, response) -> Void in
            success(data: data, response: response)

        }, failure: {
            (error: NSError!) -> Void in
            failure(error)
        })
    }
}