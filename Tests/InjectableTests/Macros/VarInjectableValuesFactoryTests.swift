import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
@testable import InjectableMacros

final class VarInjectableValuesFactoryTests: XCTestCase {

    private let sut = VarInjectableValuesFactory()

    func testMacroWithStringLiteral() throws {
        let name = "TestService"

        let result = sut.varDeclaration(protocolName: name)

        assertBuildResult(
            result,
            """
            var testService: any TestService {
                get {
                    return Self [TestServiceInjectionKey.self]
                }
                set {
                    Self [TestServiceInjectionKey.self] = newValue
                }
            }
            """
        )
    }


}
