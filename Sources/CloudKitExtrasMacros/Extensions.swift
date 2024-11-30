//
//  File.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 25.11.2024.
//

import SwiftSyntax

extension VariableDeclSyntax {
    var isStatic: Bool {
        for modifier in modifiers {
            for token in modifier.tokens(viewMode: .all) {
                if token.tokenKind == .keyword(.static) {
                    return true
                }
            }
        }
        return false
    }
}

extension TypeSyntax {
    var isOptionalType: Bool {
        self.as(OptionalTypeSyntax.self) != nil
    }

    var hasOptionalIdentifier: Bool {
        if let identifier = self.as(IdentifierTypeSyntax.self) {
            return identifier.name.text == "Optional"
        }

        return false
    }
}

extension StructDeclSyntax {
    var instanceVariableNames: [String] {
        memberBlock.members.compactMap { member -> String? in
            guard let variableDecl = member.decl.as(VariableDeclSyntax.self) else { return nil }

            if variableDecl.isStatic {
                return nil
            }

            return variableDecl.bindings.first?.pattern.description.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    var instanceVariableNamesWithOptionality: [(name: String, isOptional: Bool)] {
        memberBlock.members.compactMap { member -> (String, Bool)? in
            guard let variableDecl = member.decl.as(VariableDeclSyntax.self) else { return nil }
            let type = variableDecl.bindings.compactMap {
                $0.as(PatternBindingSyntax.self)
            }.first

            if let type = type?.typeAnnotation?.type, let name = variableDecl.bindings.first?.pattern.description.trimmingCharacters(in: .whitespacesAndNewlines) {
                let optional = type.isOptionalType || type.hasOptionalIdentifier
                return (name, optional)
            } else {
                return nil
            }
        }
    }
}

extension DeclSyntax {
    static func fields(variables: [String]) -> Self {
        let enumCases = variables
            .map { name in
                "case \(name)"
            }
            .joined(separator: "\n")

        let enumDecl = """
        public enum Fields: String, CloudKitExtras.RecordFields {
            \(enumCases)
        }
        """

        return DeclSyntax(stringLiteral: enumDecl)
    }
}
