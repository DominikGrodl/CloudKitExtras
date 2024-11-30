//
//  RecordFields.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import Foundation

public protocol RecordFields: CaseIterable, RawRepresentable where RawValue == String {}

extension RecordFields {
    static var fields: [String] {
        self.allCases.map(\.rawValue)
    }
}
