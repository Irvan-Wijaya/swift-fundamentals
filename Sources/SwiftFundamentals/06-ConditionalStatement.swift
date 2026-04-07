import Foundation

// MARK: - Overview
/// **Conditional Statements**
/// Control flow mechanism used to execute code based on Boolean evaluation.
/// Swift requires explicit Bool conditions (no implicit truthiness).

// 1. if / else
/// Used for dynamic logical evaluation.
/// Suitable for numeric comparison, validation, and branching logic.

let balance = 750.0
if balance > 1000 {
    print("Premium")
} else if balance > 0 {
    print("Standard")
} else {
    print("Inactive")
}

/// Use when:
/// - Multiple logical comparisons are required
/// - Branching depends on runtime values

// 2. switch (Pattern Matching)
/// Preferred for enum-based state management.
/// More scalable than multiple else-if chains.

enum AppState {
    case loading
    case success(String)
    case failure(String)
}

let state = AppState.loading

switch state {
case .loading:
    print("Loading...")
case .success(let data):
    print("Data: \(data)")
case .failure(let error):
    print("Error: \(error)")
}

/// Advantages:
/// - Exhaustive checking
/// - Cleaner state handling
/// - Supports ranges and associated values

// 3. guard (Early Exit Pattern)
/// Used for precondition validation.
/// Reduces nesting and keeps the "happy path" flat.

func processPayment(amount: Double?) {
    
    guard let amount = amount else {
        print("Amount is nil")
        return
    }
    
    guard amount > 0 else {
        print("Invalid amount")
        return
    }
    
    print("Processing payment: \(amount)")
}

/// guard characteristics:
/// - Must exit scope (return, break, continue, throw)
/// - Ideal for validation and defensive programming
/// - Improves readability by preventing nested if

// MARK: Comparison: Nested If vs Guard
/// Nested If (harder to scale)
func processOrderNested(user: String?, amount: Double?) {
    if let user = user {
        if let amount = amount {
            if amount > 0 {
                print("Processing order for \(user)")
            }
        }
    }
}

/// Guard Version (flat and readable)
func processOrderGuard(user: String?, amount: Double?) {
    
    guard let user = user else { return }
    guard let amount = amount, amount > 0 else { return }
    
    print("Processing order for \(user)")
}

/// Why guard is better:
/// - Avoids deep indentation
/// - Makes failure conditions explicit
/// - Keeps main logic readable

// 4. Ternary Operator
/// Use only for simple binary assignment.

let points = 1200
let membership = points > 1000 ? "Gold" : "Regular"
/// Avoid ternary when logic becomes complex.

// MARK: Personal Notes
/// Use if:
/// - For general logical comparisons
///
/// Use switch:
/// - For enum state modeling
/// - For pattern matching
///
/// Use guard:
/// - For input validation
/// - For early exit
/// - To reduce cyclomatic complexity
///
/// Avoid:
/// - Deep nested if (>2 levels)
/// - String-based condition checks when enum is possible
