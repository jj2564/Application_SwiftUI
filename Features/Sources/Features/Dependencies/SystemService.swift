//
//  SystemService.swift
//  Features
//
//  Created by IrvingHuang on 2025/1/20.
//

import Dependencies
import Foundation

struct SystemService: Sendable {
    var checkUserEnableNotification: @Sendable (String) async -> Bool
}

extension SystemService: DependencyKey {
    static let liveValue = SystemService(
        checkUserEnableNotification: { _ in
            true
        }
    )
}

//extension SystemService: TestDependencyKey {
//    static let testValue = SystemService(
//        checkUserEnableNotification: unimplemented("checkUserEnableNotification is not implemented")
//    )
//}


extension DependencyValues {
    var systemService: SystemService {
        get { self[SystemService.self] }
        set { self[SystemService.self] = newValue }
    }
}
