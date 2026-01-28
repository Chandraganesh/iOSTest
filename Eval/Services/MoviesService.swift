import Foundation

/// Protocol defining the movies service interface.
protocol MoviesServiceProtocol: Sendable {
    /// Searches for movies matching the given query.
    /// - Parameter query: The search term
    /// - Returns: Array of movies matching the query
    func searchMovies(_ query: String) async throws -> [Movie]
}

/// Service responsible for fetching movie data from the OMDB API.
actor MoviesService: MoviesServiceProtocol {

    /// Shared singleton instance
    static let shared = MoviesService()

    private let session: URLSession
    private let decoder: JSONDecoder

    /// Creates a new MoviesService.
    /// - Parameter session: URLSession to use for network requests
    init(session: URLSession = .shared) {
        self.session = session
        self.decoder = JSONDecoder()
    }

    /// Searches for movies matching the given query.
    /// - Parameter query: The search term
    /// - Returns: Array of movies matching the query
    func searchMovies(_ query: String) async throws -> [Movie] {
        guard var components = URLComponents(url: Configuration.apiBaseURL, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        components.queryItems = [
            URLQueryItem(name: "apikey", value: Configuration.apiKey),
            URLQueryItem(name: "s", value: query)
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await session.data(from: url)
        let moviesResponse = try decoder.decode(MoviesResponse.self, from: data)
        return moviesResponse.search ?? []
    }
}
