// This class only exists to allow us to make a Yelp Request using keys from a plist.
// Any clients of this Cocoapod will most likely want to have their own error,
// if they don't want to put their Yelp API keys in the source.
enum ExampleError: ErrorType {
    case MissingOAuthKeys
    case MissingYelpKeysPlist
}