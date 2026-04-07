import Foundation

// MARK: - Overview
/// **Advanced Functions & Closures**
/// - Explicit failure handling using `throws`
/// - Passing executable logic as values (Closures)
/// - Managing lifetime & memory with escaping closures

// MARK: A. Throwing Functions (Error Handling)
enum TransferError: Error {
    case insufficientFunds
}

func executeTransfer(amount: Double, balance: Double) throws -> Double {
    guard amount <= balance else {
        throw TransferError.insufficientFunds
    }
    return balance - amount
}

// Explicit error handling
do {
    let remaining = try executeTransfer(amount: 50_000, balance: 10_000)
    print("Success. Balance: \(remaining)")
} catch TransferError.insufficientFunds {
    print("Transaction Failed: Not enough balance")
} catch {
    print("System Error")
}

// Error propagation example
func processTransfer() throws {
    try executeTransfer(amount: 10_000, balance: 5_000)
}

// Optional error handling
let safeResult = try? executeTransfer(amount: 10_000, balance: 5_000)
// `safeResult` becomes nil if error occurs

// MARK: B. Closures (Anonymous Functions)
let formatCurrency = { (amount: Double) -> String in
    "IDR \(amount)"
}

print(formatCurrency(150000.0))

// Shorthand syntax
let numbers = [1, 2, 3]
let squared = numbers.map { $0 * $0 }

// MARK: C. Closures as Parameters (Completion Handlers)
func fetchHoldingBalance(completion: (Double) -> Void) {
    let fetchedAmount = 2_500_000.0
    completion(fetchedAmount)
}

// Trailing closure syntax
fetchHoldingBalance { amount in
    print("Holding Balance is: \(amount)")
}

// MARK: D. Escaping Closures (@escaping)
var pendingRequests: [() -> Void] = []

func queueTransaction(request: @escaping () -> Void) {
    pendingRequests.append(request)
    print("Request Queued")
}

queueTransaction {
    print("Executing queued transaction...")
}

pendingRequests.first?()

// MARK: E. Capturing Values (Closure State Retention)
func makeCounter() -> () -> Int {
    var count = 0
    return {
        count += 1
        return count
    }
}

let counter = makeCounter()
print(counter()) // 1
print(counter()) // 2

// MARK: F. Memory Safety (Avoid Retain Cycles)
class TransactionManager {
    var onComplete: (() -> Void)?

    func setup() {
        onComplete = { [weak self] in
            self?.finish()
        }
    }

    func finish() {
        print("Transaction finished")
    }
}
