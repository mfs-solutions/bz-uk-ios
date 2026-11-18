import SwiftUI

struct SplashView: View {
    let onFinished: () -> Void

    @Environment(\.displayScale) private var displayScale
    @State private var animated = false

    private let logoURL = URL(
        string: "https://res.cloudinary.com/ditsmq3r6/image/upload/v1793754886/bzeadlogo_vigrqh.png"
    )

    var body: some View {
        GeometryReader { geometry in
            let size = min(512 / displayScale, geometry.size.width * 0.85, geometry.size.height * 0.85)

            Button(action: onFinished) {
                ZStack {
                    Color.white.ignoresSafeArea()

                    AsyncImage(url: logoURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .tint(Color(red: 30 / 255, green: 41 / 255, blue: 59 / 255))
                        case .success(let image):
                            image.resizable().scaledToFit()
                        case .failure:
                            fallbackLogo
                        @unknown default:
                            fallbackLogo
                        }
                    }
                    .frame(width: size, height: size)
                    .opacity(animated ? 1 : 0)
                    .scaleEffect(animated ? 1 : 0.88)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Continue to Home")
        }
        .task {
            withAnimation(.easeInOut(duration: 3)) {
                animated = true
            }
            do {
                try await Task.sleep(nanoseconds: 3_000_000_000)
                guard !Task.isCancelled else { return }
                onFinished()
            } catch {
                return
            }
        }
    }

    private var fallbackLogo: some View {
        Text("BZEAD")
            .font(.system(size: 36, weight: .bold))
            .foregroundColor(Color(red: 15 / 255, green: 23 / 255, blue: 42 / 255))
    }
}
