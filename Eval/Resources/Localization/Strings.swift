import Foundation

/// Centralized access to localized strings.
/// All strings are defined in Localizable.xcstrings.
enum Strings {

    enum Home {
        /// Navigation bar title for the home screen
        static let navigationTitle = String(localized: "home.navigation.title")

        enum Search {
            /// Placeholder text for the search text field
            static let placeholder = String(localized: "home.search.placeholder")

            /// Label for the search button
            static let button = String(localized: "home.search.button")
        }
    }
}
