public struct YelpCategory: Equatable {
    public let alias: String
    public let category: String
}

public func ==(lhs: YelpCategory, rhs: YelpCategory) -> Bool {
    return lhs.alias == rhs.alias &&
            lhs.category == rhs.category
}