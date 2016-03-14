import Quick
import Nimble
@testable import YelpSearch

class YelpBusinessTest: QuickSpec {

    override func spec() {
        describe("YelpBusinessTest") {
            it("handles equality correctly") {
                let business1 = YelpTestingData.createYelpBusiness()
                let business2 = YelpTestingData.createYelpBusiness()
                expect(business1) == business2
            }

            it("handles inequality correctly") {
                let nilBusiness = YelpTestingData.createNilYelpBusiness()
                let business = YelpTestingData.createYelpBusiness()
                expect(nilBusiness) != business
            }
        }
    }

}