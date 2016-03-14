import Quick
import Nimble
@testable import YelpSearch

class YelpLocationTest: QuickSpec {

    override func spec() {
        describe("YelpLocationTest") {
            it("handles equality correctly") {
                let location1 = YelpTestingData.createYelpLocation()
                let location2 = YelpTestingData.createYelpLocation()
                expect(location1) == location2
            }

            it("handles inequality correctly") {
                let location = YelpTestingData.createYelpLocation()
                let nilLocation = YelpTestingData.createNilYelpLocation()
                expect(location) != nilLocation
            }
        }
    }

}