public struct YelpError: Equatable {
    public let errorText: String
    public let errorType: YelpErrorType
    public let field: String
}

public func ==(lhs: YelpError, rhs: YelpError) -> Bool {
    return lhs.errorText == rhs.errorText &&
            lhs.errorType == rhs.errorType &&
            lhs.field == rhs.field
}