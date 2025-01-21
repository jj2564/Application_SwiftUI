//
//  MainApp.swift
//  Features
//
//  Created by IrvingHuang on 2025/1/21.
//
import ComposableArchitecture
import SwiftUI

@main
struct BaseApplication: App {
    var body: some Scene {
        WindowGroup {
            AppView(store: .init(
                initialState: AppFeature.State(),
                reducer: { AppFeature() }
            ))
        }
    }
}

struct AppView: View {
    let store: StoreOf<AppFeature>
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        Text("Appliction")
            .onChange(of: scenePhase) { newValue in
                switch newValue {
                case .active:
                    store.send(.scenePhaseBecomeActive)
                case .background, .inactive:
                    break
                default: return
                }
            }
    }
}


#Preview {
    AppView(store: .init(
        initialState: AppFeature.State(),
        reducer: { AppFeature() }
    ))
}
