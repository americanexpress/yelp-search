public enum YelpLocationParameter {
    case Neighborhood(neighborhood: String, latLong: YelpLatLong?)
    case BoundingBox(boundsSWCoordinate: YelpLatLong, boundsNECoordinate: YelpLatLong)
    case Coordinate(coordinate: YelpLatLong, accuracy: Double?, altitude: Double?, altitudeAccuracy: Double?)

    func getLocationParameters() -> [String: String] {
        switch self {
        case .Neighborhood(let neighborhood, let latLong):
            var locationParams = Dictionary<String, String>()
            locationParams[YelpLocationQueryParameters.Neighborhood] = neighborhood
            if let coordinate = latLong {
                locationParams[YelpQueryParameters.NeighborhoodCoordinate] = String(coordinate)
            }
            return locationParams
        case .BoundingBox(let swBound, let neBound):
            var locationParams = Dictionary<String, String>()
            locationParams[YelpLocationQueryParameters.BoundingBox] = String(swBound) + "|" + String(neBound)
            return locationParams
        case .Coordinate(let coordinate, let accuracy, let altitude, let altitudeAccuracy):
            var locationParams = Dictionary<String, String>()
            var coord = String(coordinate)

            // These parameters are optional, but they can be supplied indepedently, so before each
            // parameter, we send a comma, so that the API can distinguish which field we were
            // trying to send.  This means that the fields are ordered.
            // Email api@yelp.com with questions about this.
            coord.appendContentsOf(",")
            if let acc = accuracy {
                coord.appendContentsOf(String(acc))
            }
            coord.appendContentsOf(",")
            if let alt = altitude {
                coord.appendContentsOf(String(alt))
            }
            coord.appendContentsOf(",")
            if let altAcc = altitudeAccuracy {
                coord.appendContentsOf(String(altAcc))
            }
            locationParams[YelpLocationQueryParameters.Coordinate] = coord
            return locationParams
        }
    }
}
