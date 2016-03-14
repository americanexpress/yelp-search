public struct YelpOAuthToken {
    let consumerKey: String
    let consumerSecret: String
    let accessToken: String
    let accessTokenSecret: String

    public init(consumerKey: String, consumerSecret: String, accessToken: String, accessTokenSecret: String) {
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.accessToken = accessToken
        self.accessTokenSecret = accessTokenSecret
    }
}