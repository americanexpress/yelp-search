import Quick
import Nimble
@testable import YelpSearch

class YelpCategoryTest: QuickSpec {

    override func spec() {
        describe("YelpCategoryTest") {
            it("handles equality correctly") {
                let category1 = YelpTestingData.createYelpCategory()
                let category2 = YelpTestingData.createYelpCategory()
                expect(category1) == category2
            }

            it("handles inequality correctly") {
                let category1 = YelpTestingData.createYelpCategory()
                let category2 = YelpTestingData.createOtherYelpCategory()
                expect(category1) != category2
            }
        }
    }

}