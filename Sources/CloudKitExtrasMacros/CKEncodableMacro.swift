//
//  CKEncodableMacro.swift
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

public enum CKEncodableMacro {}

extension CKEncodableMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let macros: [MemberMacro.Type] = [
            CKEncodableConformanceMacro.self,
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

extension CKEncodableMacro: ExtensionMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        try CKEncodableConformanceMacro.expansion(
            of: node,
            attachedTo: declaration,
            providingExtensionsOf: type,
            conformingTo: protocols,
            in: context
        )
    }
}
