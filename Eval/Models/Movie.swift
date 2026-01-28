import Foundation

/// Represents a movie from the OMDB API.
struct Movie: Identifiable, Codable, Equatable {
    /// Movie title
    let title: String

    /// Release year
    let year: String

    /// IMDB unique identifier
    let imdbID: String

    /// Type of content (movie, series, episode)
    let type: String

    /// URL to the movie poster image
    let poster: String

    /// Unique identifier for SwiftUI lists
    var id: String { imdbID }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}

/// Response wrapper for the OMDB search API.
struct MoviesResponse: Codable {
    /// List of movies matching the search query
    let search: [Movie]?

    /// Total number of results available
    let totalResults: String?

    /// API response status ("True" or "False")
    let response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}
