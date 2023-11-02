import XCTest
@testable import Injectable

final class swift_injectableTests: XCTestCase {
    
    func test_AccessService() throws {
        @Injected(\.testService) var testService
        XCTAssertEqual(testService, 1)
    }
    
    func test_UpdateService() throws {
        @Injected(\.testService) var testService

        testService = 2

        XCTAssertEqual(testService, 2)
    }
}

struct TestKey: InjectionKey {
    static var currentValue: Int = 1
}

extension InjectedValues {
    var testService: Int {
        get { Self[TestKey.self] }
        set { Self[TestKey.self] = newValue }
    }
}
