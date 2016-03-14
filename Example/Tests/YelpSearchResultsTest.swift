import Quick
import Nimble
@testable import YelpSearch

class YelpSearchResultsTest: QuickSpec {

    override func spec() {
        describe("YelpSearchResultsTest") {
            it("handles equality correctly for two errors") {
                let searchResults1 = YelpTestingData.createYelpSearchResultsError()
                let searchResults2 = YelpTestingData.createYelpSearchResultsError()
                expect(searchResults1) == searchResults2
            }

            it("handles equality correctly for two successes") {
                let searchResults1 = YelpTestingData.createYelpSearchResultsSuccess()
                let searchResults2 = YelpTestingData.createYelpSearchResultsSuccess()
                expect(searchResults1) == searchResults2
            }

            it("handles inequality correctly for two errors") {
                let searchResults1 = YelpTestingData.createYelpSearchResultsError()
                let searchResults2 = YelpTestingData.createOtherYelpSearchResultsError()
                expect(searchResults1) != searchResults2
            }

            it("handles inequality correctly for two successes") {
                let searchResults1 = YelpTestingData.createYelpSearchResultsSuccess()
                let searchResults2 = YelpTestingData.createOtherYelpSearchResultsSuccess()
                expect(searchResults1) != searchResults2
            }

            it("handles inequality correctly for one error one success") {
                let successSearchResults = YelpTestingData.createYelpSearchResultsSuccess()
                let errorSearchResults = YelpTestingData.createYelpSearchResultsError()
                expect(successSearchResults) != errorSearchResults
            }
        }
    }

}