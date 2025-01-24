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
    func send(url: String, method: HTTPRequest.Method, headerFields: HTTPFields, bodyData: Data?, credential: URLCredential?) async throws -> (data: Data, response: HTTPResponse)
}

extension HttpClientProtocol {
    public func send(url: String, method: HTTPRequest.Method, headerFields: HTTPFields) async throws -> (data: Data, response: HTTPResponse) {
        try await send(url: url, method: method, headerFields: headerFields, bodyData: nil, credential: nil)
    }
    
    public func send(url: String, method: HTTPRequest.Method, headerFields: HTTPFields, bodyData: Data) async throws -> (data: Data, response: HTTPResponse) {
        try await send(url: url, method: method, headerFields: headerFields, bodyData: bodyData, credential: nil)
    }
    
    public func send(url: String, method: HTTPRequest.Method, headerFields: HTTPFields, credential: URLCredential) async throws -> (data: Data, response: HTTPResponse) {
        try await send(url: url, method: method, headerFields: headerFields, bodyData: nil, credential: credential)
    }
}
