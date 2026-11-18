import SwiftUI

struct AppContentView: View {
    @State private var showingHome = false

    var body: some View {
        if showingHome {
            HomePlaceholderView()
        } else {
            SplashView {
                showingHome = true
            }
        }
    }
}

private struct HomePlaceholderView: View {
    var body: some View {
        Text("Home is not implemented yet.")
    }
}
