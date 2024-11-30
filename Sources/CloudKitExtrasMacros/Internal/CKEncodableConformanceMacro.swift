//
//  File.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 25.11.2024.
//

import SwiftDiagnostics
import SwiftOperators
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros

enum CKEncodableConformanceMacro {
    private static let moduleName = "CloudKitExtras"
}

extension CKEncodableConformanceMacro: MemberMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let structDecl = declaration.as(StructDeclSyntax.self) else {
            throw MacroExpansionErrorMessage("@CKEncodableMacro can only be applied to structs")
        }

        let assignments = structDecl.instanceVariableNames
            .map { name in
                "case .\(name): return \(name)"
            }
            .joined(separator: "\n")

        let functionDecl = """
        public func value(for field: Fields) -> (any CKRecordValueProtocol)? {
        switch field {
        \(assignments)
        }
        }
        """

        return [
            DeclSyntax(stringLiteral: functionDecl)
        ]
    }
}

extension CKEncodableConformanceMacro: ExtensionMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        let decl = try ExtensionDeclSyntax("extension \(type.trimmed): \(raw: Self.moduleName).CKEncodable {}")
        return [decl]
    }
}
