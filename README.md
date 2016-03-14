# YelpSearch

This project is designed to make it easy to programmatically search Yelp for businesses using the
public [version 2.0 of the Yelp Search API](https://www.yelp.com/developers/documentation/v2/search_api).
In order to use this, you'll need to create a Yelp account and then request some API keys [here](https://www.yelp.com/developers/manage_api_keys).

### Note on compliance
This pod was created to make it easier to use the Yelp Search API. It is the responsibility of the user to make sure that their application complies with all of Yelp's usage policies, including, but not limited to the [display requirements](https://www.yelp.com/developers/display_requirements)

# Add YelpSearch to your app
You can add this functionality to your app with Cocoapods.

## Cocoapods
Turn on frameworks and add this project to your podfile

	use_frameworks!
	target 'MyApp'
		pod 'YelpSearch', :git => 'https://github.com/americanexpress/yelp-search.git'
	end

Run `pod install` and start searching!

# Usage
##Initialization
Once you've installed the Pod, you can verify that you have access to the project by adding

	import YelpSearch

to the top of your AppDelegate file, or wherever you initialize tools that are used across your app.

All of the search functionality is exposed through the `YelpClient` class. Typically clients like this are exposed through some `sharedInstance` static property or through a global variable. It is unlikely that the inputs to this client's creation (in this case, OAuth tokens) will change, so it might be beneficial to only construct the client in one place. However, in the included example project, the `YelpClient` is constructed in the view controller right before it needs to be used. The singleton pattern was specifically avoided in this Cocoapod to allow greater flexibility for the users of the pod.

In order to construct an instance of `YelpClient`, you only need to provide the four keys that Yelp uses for OAuth. These can be inserted into the `YelpOAuthToken`, which serves as a container for these keys.

	let clientOauthToken = YelpOAuthToken(consumerKey: "consumer key",
		consumerSecret: "consumer secret",
		accessToken: "access token",
		accessTokenSecret: "access token secret")

The above example sets the OAuth keys inline, but in order to keep your keys out of source control, it is recommended to add your keys to a plist file and then add that file to your .gitignore. The example project that is packaged with this Cocoapod demonstrates how to do this. In order to run the example project as-is, you'll have to create a `YelpKeys.plist` file in the same directory as your `AppDelegate.swift` file and add the keys to match the `initializeYelpSearch` function inside `YelpResultsTableViewController.swift`. Failure to provide these credentials will result in an error being thrown before a request is made.

Once you have a `YelpOAuthToken`, you can create an instance of the client that will allow you to search:

	let yelpClient = YelpClient(oauthToken: clientOauthToken)

##Search
In order to actually perform a search, you'll need to create a `YelpSearchRequest` object. This object has setters for all of the search parameters that Yelp exposes. A `YelpSearchRequest` can be passed to the `YelpClient` instance that was previously created, along with success and failure blocks.

The [Yelp documentation](https://www.yelp.com/developers/documentation/v2/search_api) is a good place to start looking at what search parameters are acceptable. In general, there is only one parameter that is actually required: the location.  A search without a location doesn't really make sense, so the Yelp API and this cocoapod both require that the client specifies location through one of three ways.

###Neighborhood
If you don't have a specific latitude and longitude to search around, you can provide a String specifying where Yelp should search.  This is a very flexible type of search and you can specify anything like "431 Waverley Street" or "Palo Alto" or "California".  Obviously, the more detail you can provide, the better the search results are going to be. In fact, this type of search has an optional latitude/longitude parameter so that Yelp can better resolve ambiguous locations.

	let neighborhoodRequest = YelpSearchRequest()
	let location = 
		YelpLocationParameter.Neighborhood(neighborhood: "431 Waverley Street", latLong: nil)
	neighborhoodRequest.setLocation(location)
	
	yelpClient.makeSearchRequest(neighborhoodRequest, ...)

###BoundingBox
It's also possible to search within a bounding box. In order to do this, you need to define the box using two coordinates: a southwest latitude/longitude and a northeast latitude/longitude.

	let bbRequest = YelpSearchRequest()
	let southwestLatLong = YelpLatLong(...)
	let northeastLatLong = YelpLatLong(...)
	let location =
		YelpLocationParameter.BoundingBox(boundsSWCoordinate: southwestLatLong, boundsNECoordinate: northeastLatLong)
	bbRequest.setLocation(location)
	
	yelpClient.makeSearchRequest(bbRequest, ...)

###Coordinate
The coordinate search is the most useful for any client that needs to search around variable locations. In this case a single latitude/longitude is required, but the client can increase the accuracy of the results by providing some extra metadata about the coordinate.

	let coordRequest = YelpSearchRequest()
	let latLong = YelpLatLong(...)
	let location = 
		YelpLocationParameter.Coordinate(coordinate: latLong, accuracy: nil, altitude: nil, altitudeAccuracy: nil)
	coordRequest.setLocation(location)
	
	yelpClient.makeSearchRequest(coordRequest, ...)

###Example Request
This request will search for the 10 nearest businesses to a coordinate. That coordinate matches the address of the American Express Palo Alto Campus at 431 Waverley Street in Palo Alto.

	let request = YelpSearchRequest()
	let coordinate = YelpLatLong(latitude: "37.4476340", longitude: "-122.1609400")
	let location = YelpLocationParameter.Coordinate(coordinate: coordinate, altitude: nil, accuracy: nil, altitudeAccuracy: nil)
	
	request.setLocation(location)
		.setLimit(10)
		.setSortOrder(YelpSearchOrder.DISTANCE)
		.setRadiusFilterInMeters(50)
	
	do {
		try yelpClient.makeRequest(request, success: {
			(businesses: YelpSearchResults) in
				// Do whatever you need to do with the search results
			}, failure: {
			(error: NSError) in
				// Handle the error by looking at the localized description
			})
		} catch {
			// Handle the error
		}
	}
            
A very similar request could be made using the neighborhood search method:
 
	let request = YelpSearchRequest()
	let location = YelpLocationParameter.Neighborhood(neighborhood: "431 Waverley Street, Palo Alto, CA", latLong: nil)
	
	request.setLocation(location)
		.setLimit(10)
		.setSortOrder(YelpSearchOrder.DISTANCE)
		.setRadiusFilterInMeters(50)
	
	do {
		try yelpClient.makeRequest(request, success: {
			(businesses: YelpSearchResults) in
				// Do whatever you need to do with the search results
			}, failure: {
			(error: NSError) in
				// Handle the error by looking at the localized description
			})
		} catch {
			// Handle the error
		}
	}
            
####Note on search radius
One of the parameters that Yelp exposes is "radius", which makes sense in the coordinate search. It's unconfirmed, but experimentation with the Yelp Search API makes it seem like the absense of this field will cause Yelp to return businesses by some internal scoring system, rather than distance, regardless of which search type is specified.  If you're looking for the closest business of any kind to some coordinate, it seems safer to set the radiusFilterInMeters property on the request.

##Results
The results of any given search are attached to the `YelpSearchResults` enum as associated values. This provides the benefit of not attaching `nil` errors to successful responses (and vice versa). Additionally, since Swift's compiler forces you to handle all the cases of a `switch`, it becomes very clear when you're ignoring the handling of a possible error.

You can access the associated data that is attached to this enum by specifying the values that you expect to receive inside of the case that you're handling.

	switch (results) {
		case .Success(let businesses, let total):
			// Handle success
		case .Error(let error)
			// Handle error
	}	

As demonstrated in the code above, the `Success` enum has associated data in the form of `([YelpBusiness], Int)`, and the `Error` enum has associated data in the form of `(YelpError)`.

Yelp necessarily has a very flexible data model. The data in the response could have a large set of fields, but there are very few that are guaranteed. Unfortunately, in a language like Swift, with optional values, this means that you might incur an unfortunately large penalty (in the form of boilerplate) in order to unwrap the object in a response. Nearly every field in the domain model of this cocoapod is optional. Unwrapping is largely outside the scope of this, but an example would look like: 

	let business: YelpBusiness = businesses[0]
	if let name = business.name {
			//Do something with the name
        }

        if let location = business.location {
            if let address = location.displayAddress {
                if address.count > 0 {
    				// Do something with one of the availabe addresses
                }
            }
        }

        if let phone = business.displayPhone {
        	// Do something with the phone number
        }
    }
    
###Error Handling
There are essentially two types of errors that might be returned when making a request. The first is usually the result of network issues and is very difficult to diagnose. When this happens, it usually makes itself known by calling the provided failure block on the `makeRequest` method of a `YelpClient`. In this case, there's very little a client can do except retry the request and examine the error that gets passed to the failure block.

The other type of error comes directly from the Yelp API. These errors are [documented by Yelp](https://www.yelp.com/developers/documentation/v2/errors) and usually represent violations of some business logic. When these errors occur, the request to Yelp was actually successful, so they get attached to the `YelpSearchResults` object. Details of what went wrong are attached to the error and can be used in combination with Yelp's documentation to figure out how to modify the request to make it acceptable.

# Contributing

We welcome Your interest in the American Express Open Source Community on Github. Any Contributor to any Open Source Project managed by the American Express Open Source Community must accept and sign an Agreement indicating agreement to the terms below. Except for the rights granted in this Agreement to American Express and to recipients of software distributed by American Express, You reserve all right, title, and interest, if any, in and to Your Contributions. Please [fill out the Agreement](http://goo.gl/forms/mIHWH1Dcuy).

# License

Any contributions made under this project will be governed by the [Apache License 2.0](https://github.com/americanexpress/yelp-search/blob/master/LICENSE.txt).

# Code of Conduct

This project adheres to the [American Express Community Guidelines](https://github.com/americanexpress/yelp-search/wiki/Code-of-Conduct).
By participating, you are expected to honor these guidelines.
