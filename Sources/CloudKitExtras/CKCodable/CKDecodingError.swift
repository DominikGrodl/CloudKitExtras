//
//  CKDecodingError.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import Foundation

public enum CKDecodingError: Error, LocalizedError {
    case typeMismatch(String)
    case missingField(String)

    public var errorDescription: String? {
        switch self {
        case let .typeMismatch(key):
            return "Type mismatch for key \(key)."
        case let .missingField(key):
            return "Record does not include value for key \(key)"
        }
    }
}
