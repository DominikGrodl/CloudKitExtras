//
//  CKRecord+extract.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import Foundation
import CloudKit

extension CKRecord {
    public func extract<T>(_ key: String) throws -> T {
        guard let fieldValue = self[key] else {
            throw CKDecodingError.missingField(key)
        }
        guard let value = fieldValue as? T else {
            throw CKDecodingError.typeMismatch(key)
        }

        return value
    }

    public func extractOptional<T>(_ key: String) -> T? {
        guard let fieldValue = self[key] else {
            return nil
        }

        return fieldValue as? T
    }
}
