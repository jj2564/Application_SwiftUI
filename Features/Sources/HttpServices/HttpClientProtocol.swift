//
//  HttpClientProtocol.swift
//  Features
//
//  Created by IrvingHuang on 2025/1/21.
//

import HTTPTypes
import HTTPTypesFoundation
import OSLog

public protocol HttpClientProtocol {
    func send() async throws -> HTTPResponse
}
