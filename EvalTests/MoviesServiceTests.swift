import XCTest
@testable import Eval

final class MoviesServiceTests: XCTestCase {

    var sut: MoviesService!

    override func setUp() {
        super.setUp()
        sut = MoviesService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testServiceShouldBeCreated() {
        XCTAssertNotNil(sut)
    }

    func testShouldSearchMovies() async throws {
        let movies = try await sut.searchMovies("Star")
        XCTAssertGreaterThan(movies.count, 0)
    }
}
