public struct YelpLocation: Equatable {
    public let address: [String]?
    public let city: String?
    public let coordinate: YelpLatLong?
    public let countryCode: String?
    public let crossStreets: String?
    public let displayAddress: [String]?
    public let geoAccuracy: Double?
    public let neighborhoods: [String]?
    public let postalCode: String?
    public let stateCode: String?
}

public func ==(lhs: YelpLocation, rhs: YelpLocation) -> Bool {
    var addressIsEqual = false
    switch (lhs.address, rhs.address) {
    case (.Some(let lhs), .Some(let rhs)):
        addressIsEqual = lhs == rhs
    case (.None, .None):
        addressIsEqual = true
    default:
        return false
    }

    var displayAddressIsEqual = false
    switch (lhs.displayAddress, rhs.displayAddress) {
    case (.Some(let lhs), .Some(let rhs)):
        displayAddressIsEqual = lhs == rhs
    case (.None, .None):
        displayAddressIsEqual = true
    default:
        return false
    }

    var neighborhoodsIsEqual = false
    switch (lhs.neighborhoods, rhs.neighborhoods) {
    case (.Some(let lhs), .Some(let rhs)):
        neighborhoodsIsEqual = lhs == rhs
    case (.None, .None):
        neighborhoodsIsEqual = true
    default:
        return false
    }

    return addressIsEqual &&
            lhs.city == rhs.city &&
            lhs.coordinate == rhs.coordinate &&
            lhs.countryCode == rhs.countryCode &&
            lhs.crossStreets == rhs.crossStreets &&
            displayAddressIsEqual &&
            lhs.geoAccuracy == rhs.geoAccuracy &&
            neighborhoodsIsEqual &&
            lhs.postalCode == rhs.postalCode &&
            lhs.stateCode == rhs.stateCode
}