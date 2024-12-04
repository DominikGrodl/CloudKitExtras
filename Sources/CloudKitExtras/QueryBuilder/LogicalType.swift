//
//  LogicalType.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 04.12.2024.
//

import Foundation

public enum LogicalType {
    case not, and
}

extension LogicalType {
    var nsCompountPredicateLogicalTypeRepresentation: NSCompoundPredicate.LogicalType {
        switch self {
        case .and: return .and
        case .not: return .not
        }
    }
}
