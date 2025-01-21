import ComposableArchitecture
@testable import Features
import Testing

@MainActor
struct ApplicationTests {
    
    @Test
    func appBecomeActive() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        } withDependencies: {
            $0.systemService.checkUserEnableNotification =  { _ in true }
        }
        
        await store.send(.scenePhaseBecomeActive)
        await store.receive(.checkUserEnableNotification)
        await store.receive(.userEnableNotification(true))
    }
}

