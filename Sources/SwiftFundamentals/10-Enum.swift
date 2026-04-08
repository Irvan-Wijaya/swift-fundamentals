import Foundation

// MARK: - Overview
/// **Enumerations (Enums)**
/// A type that defines a finite set of related values.
/// Core purpose in Swift:
/// - Enforce type safety
/// - Eliminate invalid states
/// - Enable exhaustive handling via switch
/// - Replace fragile string / integer-based logic

// MARK: - A. Basic Enum & Exhaustive Switching
/// Use case: Representing finite transaction states.

enum TransactionState {
    case pending
    case success
    case failed
}

/// Type inference allows shorthand syntax
var currentState: TransactionState = .pending
currentState = .success

/// Exhaustive switch (compile-time safety)
switch currentState {
case .pending:
    print("Waiting for server...")
case .success:
    print("Transaction complete.")
case .failed:
    print("Transaction failed.")
}

/// Engineering Insight:
/// - Adding a new case (e.g., `refunded`) forces all switch statements to update.
/// - Prevents unhandled states at runtime.


// MARK: - B. Raw Values (External Representation)
/// Use case: Mapping external data (API, database, HTTP codes)

enum HTTPStatusCode: Int {
    case ok = 200
    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
}

let responseCode = HTTPStatusCode.unauthorized
print(responseCode.rawValue) // 401

/// Initialization from raw value → Optional (unsafe input)
if let parsed = HTTPStatusCode(rawValue: 200) {
    print("Valid status: \(parsed)")
}

/// Engineering Insight:
/// - Raw values bridge external system ↔ internal type-safe model.
/// - Always treat rawValue init as unsafe input boundary.


// MARK: - C. Associated Values (State + Data)
/// Use case: Modeling state that carries data.
/// Eliminates invalid combinations (e.g., success + error simultaneously).

enum PaymentResult {
    case success(receiptID: String, amount: Double)
    case failure(errorCode: Int, message: String)
}

let checkoutResult: PaymentResult = .success(
    receiptID: "RCP-8899",
    amount: 150_000.0
)

switch checkoutResult {
case let .success(receiptID, amount):
    print("Receipt \(receiptID) for IDR \(amount)")
    
case let .failure(errorCode, message):
    print("Error \(errorCode): \(message)")
}

/// Why this is superior:
/// - No ambiguous state (cannot have success + error at the same time)
/// - Strongly typed data per state


// MARK: - D. Enum with Methods (Behavior Co-location)
/// Enums can contain logic, not just data.

enum UserRole {
    case admin
    case user
    case guest
    
    func canAccessAdminPanel() -> Bool {
        switch self {
        case .admin:
            return true
        case .user, .guest:
            return false
        }
    }
}

let role: UserRole = .user
print(role.canAccessAdminPanel()) // false

/// Engineering Insight:
/// - Moves logic closer to data
/// - Reduces scattered conditional checks


// MARK: - E. CaseIterable (Iteration Support)
/// Useful for UI (dropdowns, filters, settings list)

enum Menu: CaseIterable {
    case home
    case profile
    case settings
}

for item in Menu.allCases {
    print(item)
}

/// Engineering Insight:
/// - Avoid hardcoding arrays of values
/// - Keeps enum as single source of truth


// MARK: - F. Enum vs Multiple Booleans (Anti-Pattern Fix)
/// ❌ Bad (ambiguous state)
var isLoading = false
var isSuccess = true
var isError = false

/// Problem:
/// - Multiple states can be true at once (invalid state)

/// ✅ Better (single source of truth)

enum ViewState {
    case loading
    case success(data: String)
    case error(message: String)
}

let state: ViewState = .success(data: "User loaded")

switch state {
case .loading:
    print("Loading...")
case let .success(data):
    print(data)
case let .error(message):
    print(message)
}

// MARK: Example Implementatiom
enum TransactionStatus {
    case pending
    case success(receiptID: String, timestamp: Date)
    case failed(reason: ErrorReason)
    
    enum ErrorReason {
        case insufficientFunds
        case timeout
        case systemMaintenance
    }
}

extension TransactionStatus.ErrorReason {
    var message: String {
        switch self {
        case .insufficientFunds:
            return "Saldo tidak cukup. Silakan top-up."
        case .timeout:
            return "Permintaan tidak dapat diproses. Silakan coba lagi."
        case .systemMaintenance:
            return "Sistem sedang maintenance. Silakan hubungi support."
        }
    }
}

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter.string(from: date)
}

func handleTransaction(status: TransactionStatus) {
    switch status {
    case .pending:
        print("Menampilkan loading spinner...")
        
    case .success(let receipt, let time):
        let formattedTime = formatDate(time)
        print("Transaksi berhasil. Resi: \(receipt) pada \(formattedTime)")
        
    case .failed(let reason):
        print(reason.message)
    }
}

// 1. Pending
handleTransaction(status: .pending)

// 2. Success
let successStatus = TransactionStatus.success(
    receiptID: "ABC123XYZ",
    timestamp: Date()
)
handleTransaction(status: successStatus)

// 3. Failed
let failedStatus = TransactionStatus.failed(reason: .insufficientFunds)
handleTransaction(status: failedStatus)


/// Engineering Insight:
/// - Enum guarantees only ONE state at a time
/// - Eliminates invalid combinations

// MARK: - Summary
/// Use enum when:
/// - Domain has finite states
/// - You want type safety
/// - You want to eliminate invalid states
/// - You want cleaner switch-based logic

/// Avoid:
/// - String-based state ("success", "error")
/// - Multiple boolean flags for state modeling
