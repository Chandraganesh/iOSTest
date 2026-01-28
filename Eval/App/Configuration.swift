import Foundation

/// Application configuration values.
enum Configuration {

    /// OMDB API key for authentication
    static var apiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String, !apiKey.isEmpty else {
            fatalError("API_KEY not set in xcconfig")
        }
        return apiKey
    }

    /// Base URL for the OMDB API
    static var apiBaseURL: URL {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String,
              let url = URL(string: urlString) else {
            fatalError("API_BASE_URL not set in xcconfig")
        }
        return url
    }
}
