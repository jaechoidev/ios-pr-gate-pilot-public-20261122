import XCTest

final class CounterUITests: XCTestCase {
    @MainActor
    func testCounterCountsTaps() {
        let app = XCUIApplication()
        app.launch()
        let count = app.staticTexts["counter-value"]
        XCTAssertTrue(count.waitForExistence(timeout: 10))
        XCTAssertEqual(count.label, "0")
        let increment = app.buttons["increment"]
        XCTAssertTrue(increment.exists)
        increment.tap()
        XCTAssertEqual(count.label, "1")
        increment.tap()
        XCTAssertEqual(count.label, "99", "Counter should display two taps")
    }
}
