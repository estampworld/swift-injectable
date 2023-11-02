import SwiftDiagnostics

enum InjectableDiagnostic: String, DiagnosticMessage, Error {
    case onlyApplicableToProtocol, missingParameter, missingProtocolName

    var message: String {
        switch self {
        case .onlyApplicableToProtocol: "'@Injectable' can only be applied to a 'protocol'"
        case .missingParameter: "Paramter for default value is missing"
        case .missingProtocolName: "Paramter for default value is missing"
        }
    }
    
    var diagnosticID: MessageID {
        MessageID(domain: "InjectableMacro", id: rawValue)
    }
    
    var severity: DiagnosticSeverity {
        switch self {
        case .onlyApplicableToProtocol: .error
        case .missingParameter: .error
        case .missingProtocolName: .error
        }
    }
}
