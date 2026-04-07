import Foundation

// MARK: - Overview
/// **Dictionary**
/// A collection of unique Key-Value pairs optimized for fast lookup.

// MARK: - A. Declaration & Type Safety

/// Keys must conform to `Hashable`.
/// Hashable enables Swift to compute a stable hash value,
/// allowing efficient bucket placement inside the hash table.
/// Values can be any type, including structs, classes, or other collections.

// Type Inference
var responseCodes = [200: "OK", 400: "Bad Request", 500: "Internal Server Error"]

// Explicit Type Annotation
// Use case: initializing empty dictionaries (common in production systems)
var accountBalances: [String: Double] = [:]

// Custom Hashable Key (Domain Modeling)
struct TransactionID: Hashable {
    let rawValue: String
}
var transactions: [TransactionID: Double] = [:]

// MARK: - B. Performance Characteristics
/// Dictionary lookup is average-case O(1).
/// Worst-case can degrade due to hash collisions,
/// but in practice remains highly efficient.

/// Arrays → ordered data, O(n) lookup.
/// Dictionaries → identity-based lookup, O(1) average.
var cachedTransactions = [
    "TRX001": 500.0,
    "TRX002": 1500.0
]

// MARK: - C. Safe Access & Optionals
/// Standard dictionary subscripting returns an Optional.
/// Reason: the requested key may not exist.

let requestedID = "TRX009"
let amount = cachedTransactions[requestedID] // Type: Double?

// Safe Access Pattern (Industry Standard)
if let safeAmount = cachedTransactions[requestedID] {
    // Process transaction
} else {
    // Handle missing data gracefully
}
// Avoid force unwrapping (!) with dynamic backend data.

// MARK: - D. Providing Default Values
/// When a sensible fallback exists, use the default subscript.
/// This avoids Optional handling and improves readability.

let jsonPayload = [
    "status": "Success",
    "message": "Transfer Complete"
]

// Provides concrete String instead of Optional
let displayMessage = jsonPayload["errorMessage", default: "Unknown Error Occurred"]

// MARK: - E. Modifying Data

var config: [String: String] = [
    "theme": "light",
    "pushNotifications": "enabled"
]

//  Update or Insert
config["theme"] = "dark"          // Update
config["biometrics"] = "enabled"  // Insert

//  Remove
config["pushNotifications"] = nil // Safely removes the key

// MARK: - F. Copy-On-Write (Memory Behavior)
/// Dictionary is a value type with Copy-On-Write (CoW).
/// Memory is only duplicated when mutation occurs
/// AND the storage is shared between multiple references.

var a = ["A": 1, "B": 2]
var b = a       // Shared storage
b["C"] = 3      // Triggers CoW

// MARK: - G. Aggregation & Advanced Usage
/// Frequency counting (common in analytics pipelines)
let transactionIDs = ["A", "B", "A", "C", "B", "A"]
let frequency = transactionIDs.reduce(into: [String: Int]()) { result, id in
    result[id, default: 0] += 1
} // ["A": 3, "B": 2, "C": 1] -> Grouping (useful for dashboard & reporting)

struct User {
    let name: String
    let role: String
}

let users = [
    User(name: "Alice", role: "Admin"),
    User(name: "Bob", role: "User"),
    User(name: "Charlie", role: "Admin")
]
let groupedUsers = Dictionary(grouping: users, by: { $0.role }) // ["Admin": [...], "User": [...]]

// MARK: - H. When NOT to Use Dictionary
/// Avoid Dictionary when:
/// - Order has semantic meaning.
/// - Duplicate keys are required.
/// - Sequential traversal is more common than lookup.
/// - Index-based access is primary.
