import Quick
import Nimble
@testable import YelpSearch

class YelpLatLongTest: QuickSpec{
    override func spec() {
        describe("YelpLatLong") {
            it ("can be converted into a string correctly") {
                let latLong = String(YelpLatLong(latitude:"123.456", longitude: "78.901"))
                expect(latLong) == "123.456,78.901"
            }

            it ("can be converted into a string with negative numbers") {
                let latLong = String(YelpLatLong(latitude:"-23.4567", longitude: "-100.9999"))
                expect(latLong) == "-23.4567,-100.9999"
            }

            it ("handles equality correctly") {
                let latLong1 = YelpTestingData.createYelpLatLong()
                let latLong2 = YelpTestingData.createYelpLatLong()
                expect(latLong1) == latLong2
            }

            it ("handles inequality correctly") {
                let latLong = YelpTestingData.createYelpLatLong()
                let otherLatLong = YelpTestingData.createOtherYelpLatLong()
                expect(latLong) != otherLatLong
            }
        }
    }
}
