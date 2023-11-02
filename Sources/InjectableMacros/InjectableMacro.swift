import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public enum InjectableMacro: PeerMacro {

    public static func expansion(of node: AttributeSyntax, providingPeersOf declaration: some DeclSyntaxProtocol, in context: some MacroExpansionContext) throws -> [DeclSyntax] {

        guard let protocolDeclaration = declaration.as(ProtocolDeclSyntax.self) else {
            throw InjectableDiagnostic.onlyApplicableToProtocol
        }

        guard let defaultImplentaionName = node.arguments?.as(LabeledExprListSyntax.self)?.first?.expression.as(MemberAccessExprSyntax.self)?.base?.as(DeclReferenceExprSyntax.self)?.baseName else {
            throw InjectableDiagnostic.missingParameter
        }

        let structName = TokenSyntax.identifier(protocolDeclaration.name.text + "InjectionKey")

        let structDec = StructInjectedKeysFactory().structDeclaration(
            name: structName,
            type: TypeSyntax(stringLiteral: protocolDeclaration.name.text),
            defaultImplentaionName: defaultImplentaionName
        )
        return [
            DeclSyntax(structDec)
        ]

    }
}

public enum InjectableValuesMacro: MemberMacro {

    public static func expansion(of node: SwiftSyntax.AttributeSyntax, providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {

        guard let protocolName = node.arguments?.as(LabeledExprListSyntax.self)?.first?.expression.as(MemberAccessExprSyntax.self)?.base?.as(DeclReferenceExprSyntax.self)?.baseName.text else {
            throw InjectableDiagnostic.onlyApplicableToProtocol
        }

        return [
"""
    var \(raw: protocolName.capitalizedSentence): (any \(raw: protocolName)) {
        get { return Self[\(raw: protocolName)InjectionKey.self] }
        set { Self[\(raw: protocolName)InjectionKey.self] = newValue }
    }
"""
        ]

    }
}

@main
struct InjectablePlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        InjectableMacro.self,
        InjectableValuesMacro.self
    ]
}
