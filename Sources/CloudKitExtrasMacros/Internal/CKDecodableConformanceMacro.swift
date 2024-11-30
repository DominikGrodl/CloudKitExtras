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

enum CKDecodableConformanceMacro {
    private static let moduleName = "CloudKitExtras"
}

extension CKDecodableConformanceMacro: MemberMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let structDecl = declaration.as(StructDeclSyntax.self) else {
            throw MacroExpansionErrorMessage("@CKDecodableMacro can only be applied to structs")
        }

        let assignments = structDecl.instanceVariableNamesWithOptionality
            .map { variable in
                let extract = variable.isOptional ? "Self.extractOptional" : "try Self.extract"
                return "self.\(variable.name) = \(extract)(.\(variable.name), from: record)"
            }
            .joined(separator: "\n")

        let initDecl = """
        public init(record: CKRecord) throws {
        \(assignments)
        }
        """

        return [
            DeclSyntax(stringLiteral: initDecl)
        ]
    }
}

extension CKDecodableConformanceMacro: ExtensionMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        let decl = try ExtensionDeclSyntax("extension \(type.trimmed): \(raw: Self.moduleName).CKDecodable {}")
        return [decl]
    }
}
