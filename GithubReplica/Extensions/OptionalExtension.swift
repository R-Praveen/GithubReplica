import Foundation

extension Optional {
    public func nilCoalesing(_ otherwise: @autoclosure () -> Wrapped) -> Wrapped {
        if let value = self {
            return value
        }
        return otherwise()
    }
}

extension Optional where Wrapped: ExpressibleByStringLiteral {
    public var emptyIfNil: Wrapped {
        return nilCoalesing("")
    }
}

extension Optional where Wrapped: ExpressibleByIntegerLiteral {
    public var zeroIfNil: Wrapped {
        return nilCoalesing(0)
    }
}
