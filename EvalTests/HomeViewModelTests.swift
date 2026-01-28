import XCTest
@testable import Eval

@MainActor
final class HomeViewModelTests: XCTestCase {

    var sut: HomeViewModel!
    var mockService: MockMoviesService!

    override func setUp() async throws {
        try await super.setUp()
        mockService = MockMoviesService()
        sut = HomeViewModel(moviesService: mockService)
    }

    override func tearDown() async throws {
        sut = nil
        mockService = nil
        try await super.tearDown()
    }

    func testViewModelShouldBeCreated() {
        XCTAssertNotNil(sut)
    }

    func testShouldSearchMovies() async {
        sut.searchQuery = "Star"
        await sut.searchMovies()
        XCTAssertGreaterThan(sut.movies.count, 0)
    }

    func testShouldNotSearchWithEmptyQuery() async {
        sut.searchQuery = ""
        await sut.searchMovies()
        XCTAssertTrue(sut.movies.isEmpty)
    }

    func testShouldNotSearchWithWhitespaceQuery() async {
        sut.searchQuery = "   "
        await sut.searchMovies()
        XCTAssertTrue(sut.movies.isEmpty)
    }
}

final class MockMoviesService: MoviesServiceProtocol {

    func searchMovies(_ query: String) async throws -> [Movie] {
        return [
            Movie(
                title: "Star Wars",
                year: "1977",
                imdbID: "tt0076759",
                type: "movie",
                poster: "https://example.com/poster.jpg"
            ),
            Movie(
                title: "Star Trek",
                year: "2009",
                imdbID: "tt0796366",
                type: "movie",
                poster: "https://example.com/poster2.jpg"
            )
        ]
    }
}
