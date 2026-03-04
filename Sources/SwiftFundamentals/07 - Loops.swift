import Foundation

// MARK: - Overview
/// **Loops**
/// Control flow constructs used to execute code repeatedly.
/// In Swift, loops emphasize safe iteration, predictable behavior,
/// and minimizing runtime errors such as out-of-bounds access.

// A. for-in Loop (Preferred Iteration Mechanism)
/// The safest and most idiomatic way to iterate over collections.
/// Swift automatically handles index management,
/// preventing manual indexing mistakes.
let recentTransactions = [250_000, 50_000, 1_000_000]

// 1. Array Iteration
// Common use case: Transforming or processing API response data.
for amount in recentTransactions {
    // Business logic processing
}

// 2. Dictionary Iteration
// Each iteration returns a tuple (key, value).
let accountStatuses = ["1001": "Active", "1002": "Suspended"]
for (accountID, status) in accountStatuses {
    // Validation, filtering, or state mapping
}

// 3. Range Iteration
for i in 1...5 {
    // Executes exactly 5 times (closed range)
}

// Half-open range (common in index logic)
for i in 0..<5 {
    // Executes 5 times (0 to 4)
}

// 4. Ignoring Loop Variable (_)
// Used when iteration value is irrelevant.
for _ in 1...3 {
    // Retry mechanism, delay simulation, etc.
}

// B. while Loop (Condition-Driven Iteration)
/// Used when the number of iterations is unknown beforehand.
/// Loop continues as long as the condition evaluates to true.
var retryCount = 0
let maxRetries = 3
var isConnectionEstablished = false

/// Important: Ensure the condition eventually becomes false.
/// Failure to do so results in an infinite loop.

while retryCount < maxRetries && !isConnectionEstablished {
    retryCount += 1
}

// C. repeat-while Loop (Post-Condition Evaluation)
/// Guarantees at least one execution before checking condition.
/// Equivalent to `do-while` in other languages.
var isSessionValid = false
repeat {
    // Prompt biometric or PIN validation
    // Update `isSessionValid` based on result
} while isSessionValid == false

var counter = 0
while true {
    print("Counter now is: \(counter)")
    counter += 1
    if counter >= 8{
        break
    }
}

// D. Loop Control Statements
let networkLogs = ["Success", "Timeout", "Success", "Critical Error", "Success"]
// 1. continue
// Skips the current iteration but keeps the loop running, useful for filtering scenarios.
for log in networkLogs {
    if log == "Success" {
        continue
    }
    // Handle only non-success logs
}

// 2. break
// Terminates the loop immediately, optimizes performance in search scenarios.
for log in networkLogs {
    if log == "Critical Error" {
        // Trigger fail-safe protocol
        break
    }
}

// E. Performance Awareness
/// Single loop → O(n)
/// Nested loops → O(n²) (potential performance risk)
for i in recentTransactions {
    for j in recentTransactions {
        // Quadratic complexity
    }
}
