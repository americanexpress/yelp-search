public class YelpSearchRequest {
    private var parameters: Dictionary<String, String>
    private var locationParam: YelpLocationParameter?

    public init() {
        parameters = Dictionary<String, String>()
    }

    public func setLocation(location: YelpLocationParameter) -> YelpSearchRequest {
        locationParam = location
        return self
    }

    public func setTerm(term: String) -> YelpSearchRequest {
        parameters[YelpQueryParameters.Term] = term
        return self
    }

    public func setLimit(limit: Int) -> YelpSearchRequest {
        parameters[YelpQueryParameters.Limit] = String(limit)
        return self
    }

    public func setOffset(offset: Int) -> YelpSearchRequest {
        parameters[YelpQueryParameters.Offset] = String(offset)
        return self
    }

    public func setSortOrder(sortOrder: YelpSearchOrder) -> YelpSearchRequest {
        switch (sortOrder) {
        case .BestMatch:
            parameters[YelpQueryParameters.Sort] = YelpSortOrderParameters.BestMatch
            return self
        case .Distance:
            parameters[YelpQueryParameters.Sort] = YelpSortOrderParameters.Distance
            return self
        case .HighestRated:
            parameters[YelpQueryParameters.Sort] = YelpSortOrderParameters.HighestRated
            return self
        }
    }

    public func setCategoryFilter(categoryFilter: String) -> YelpSearchRequest {
        parameters[YelpQueryParameters.CategoryFilter] = categoryFilter
        return self
    }

    public func setRadiusFilterInMeters(radius: Int) -> YelpSearchRequest {
        parameters[YelpQueryParameters.RadiusFilter] = String(radius)
        return self
    }

    public func setDealsFilter(dealsFilter: Bool) -> YelpSearchRequest {
        parameters[YelpQueryParameters.DealsFilter] = String(dealsFilter)
        return self
    }

    public func setCountryCode(countryCode: String) -> YelpSearchRequest {
        parameters[YelpQueryParameters.LocaleCountryCode] = countryCode
        return self
    }

    public func setLanguageCode(languageCode: String) -> YelpSearchRequest {
        parameters[YelpQueryParameters.LocaleLanguageCode] = languageCode
        return self
    }

    public func setActionLinks(useActionLinks: Bool) -> YelpSearchRequest {
        parameters[YelpQueryParameters.ActionLinks] = String(useActionLinks)
        return self
    }

    public func validateParameters() throws {
        guard let _ = locationParam else {
            throw YelpConfigurationError.MissingLocationParameter
        }
    }

    public func getMergedSearchParameters() -> Dictionary<String, String> {
        var params = Dictionary<String, String>()
        for key in parameters.keys {
            params[key] = parameters[key]
        }
        if let location = locationParam {
            for key in location.getLocationParameters().keys {
                params[key] = location.getLocationParameters()[key]
            }
        }

        return params
    }
}