import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField(Strings.Home.Search.placeholder, text: $viewModel.searchQuery)
                    .textFieldStyle(.roundedBorder)

                Button(Strings.Home.Search.button) {
                    Task {
                        await viewModel.searchMovies()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()

            if viewModel.movies.isEmpty {
                Spacer()
            } else {
                List(viewModel.movies) { movie in
                    MovieListItem(movie: movie)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(Strings.Home.navigationTitle)
    }
}

struct MovieListItem: View {
    let movie: Movie

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: movie.poster)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(.gray.opacity(0.3))
            }
            .frame(width: 60, height: 90)
            .clipShape(RoundedRectangle(cornerRadius: 4))

            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.year)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
