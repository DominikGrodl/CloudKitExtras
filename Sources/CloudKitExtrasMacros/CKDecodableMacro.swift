//
//  CKDecodableMacro.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import SwiftDiagnostics
import SwiftOperators
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros

public enum CKDecodableMacro {}

extension CKDecodableMacro: MemberMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        let macros: [MemberMacro.Type] = [
            CKDecodableConformanceMacro.self,
            FieldsMacro.self
        ]

        return try macros.flatMap {
            try $0.expansion(
                of: node,
                providingMembersOf: declaration,
                in: context
            )
        }
    }
}

extension CKDecodableMacro: ExtensionMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        try CKDecodableConformanceMacro.expansion(
            of: node,
            attachedTo: declaration,
            providingExtensionsOf: type,
            conformingTo: protocols,
            in: context
        )
    }
}
