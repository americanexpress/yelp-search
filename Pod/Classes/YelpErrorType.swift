public enum YelpErrorType: String {
    case InternalError = "INTERNAL_ERROR"
    case ExceededRequestLimit = "EXCEEDED_REQS"
    case MissingParameter = "MISSING_PARAMETER"
    case InvalidParameter = "INVALID_PARAMETER"
    case InvalidSignature = "INVALID_SIGNATURE"
    case InvalidCredentials = "INVALID_CREDENTIALS"
    case InvalidOAuthCredentials = "INVALID_OAUTH_CREDENTIALS"
    case InvalidOAuthUser = "INVALID_OAUTH_USER"
    case AccountUnconfirmed = "ACCOUNT_UNCONFIRMED"
    case PasswordTooLong = "PASSWORD_TOO_LONG"
    case UnavailableForLocation = "UNAVAILABLE_FOR_LOCATION"
    case AreaTooLarge = "AREA_TOO_LARGE"
    case MultipleLocations = "MULTIPLE_LOCATIONS"
    case BusinessUnavailable = "BUSINESS_UNAVAILABLE"
    // Unknown is for when we can't match a string to Yelp's error docs
    case Unknown = "Unknown"
}
