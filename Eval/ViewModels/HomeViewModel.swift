import Foundation
import Observation

/// ViewModel for the Home screen.
@MainActor
@Observable
final class HomeViewModel {

    /// Current text in the search field
    var searchQuery = ""

    /// List of movies returned from search
    var movies: [Movie] = []

    private let moviesService: MoviesServiceProtocol
    
    /// Creates a new HomeViewModel.
    /// - Parameter moviesService: Service for fetching movie data
    init(moviesService: MoviesServiceProtocol = MoviesService.shared) {
        self.moviesService = moviesService
    }

    /// Triggers a movie search using the current search query.
    func searchMovies() async {
        guard !searchQuery.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        do {
            movies = try await moviesService.searchMovies(searchQuery)
        } catch {
            print("Search error: \(error)")
        }
    }
}
