//
//  SystemServices.swift
//  Features
//
//  Created by IrvingHuang on 2025/1/20.
//
import Dependencies

public struct SystemServices: Sendable {
    public var checkUserEnableNotification: @Sendable (String) async -> Bool
}

extension SystemServices: DependencyKey {
    public static let liveValue = SystemServices(
        checkUserEnableNotification: { _ in
            true
        }
    )
}

public extension DependencyValues {
    var systemService: SystemServices {
        get { self[SystemServices.self] }
        set { self[SystemServices.self] = newValue }
    }
}
