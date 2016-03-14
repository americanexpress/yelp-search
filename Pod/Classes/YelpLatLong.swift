public struct YelpLatLong: CustomStringConvertible, Equatable {
    public let latitude: String
    public let longitude: String
    public var description: String {
        return "\(latitude),\(longitude)"
    }

    public init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

public func ==(lhs: YelpLatLong, rhs: YelpLatLong) -> Bool {
    return lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude
}