public enum YelpSearchResults: Equatable {
    case Success(businesses: [YelpBusiness], total: Int)
    case Error(error: YelpError)
}

public func ==(lhs: YelpSearchResults, rhs: YelpSearchResults) -> Bool {
    switch (lhs, rhs) {
    case (let .Success(businesses1, total1), let .Success(businesses2, total2)):
        return businesses1 == businesses2 &&
                total1 == total2
    case (let .Error(error1), let .Error(error2)):
        return error1 == error2
    default:
        return false
    }
}