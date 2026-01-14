import Foundation

// MARK: - Overview
/// **Fundamentals of Variables and Constants**
/// This document focuses on the *engineering perspective* of storage in Swift.
/// We explore **Why** immutability is preferred and **When** mutability is strictly necessary.

// MARK: 1. Mutability (var vs let)
// The syntax is simple, but the decision carries architectural weight.

var name = "Irvan"       // Mutable
let lastName = "Wijaya"  // Immutable

/// **A. Why does Swift "Force" Immutability (let)?**
/// Swift encourages `let` by default for three critical reasons:
///
/// 1. **Safety & Predictability**
///    - Values cannot change unexpectedly.
///    - If everything is `var`, there is a risk of unintended side effects by external functions.
///    - `let` guarantees the value remains the source of truth throughout its scope.
///
/// 2. **Thread Safety (Concurrency)**
///    - Accessing `let` across multiple threads is inherently safe (prevents race conditions).
///    - Using `var` in a multithreaded environment requires expensive synchronization mechanisms (Locks/Actors) to prevent crashes.
///
/// 3. **Compiler Optimization**
///    - The compiler can optimize memory allocation for `let` because the size and value are fixed. This results in slightly faster runtime performance.

// MARK: 2. Usage Strategy (When to use What?)

/// **B. When strictly to use `var`?**
/// Use `var` only when the **State** is required to mutate over time, such as handling user input, active transactions, or asynchronous results.

var usernameText: String = ""

// Context: State Management in a ViewModel
class LoginViewModel {
    var email: String = ""
    var password: String = ""
    
    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
}

/// **C. When to use `let`?**
/// Use `let` for configuration, static dependencies, and constants. Ideally, 80-90% of your code should be `let`.

let maxRetryCount = 3
let apiTimeout: TimeInterval = 30
let baseURL = "https://api.mybank.com/v1"

// MARK: 3. Type Safety

/// **D. Type Inference vs. Type Annotation**
/// Swift is a Type-Safe language. Every variable must have a defined type.

// 1. Type Inference
// Allowing the compiler to deduce the type based on the value.
// Why: Cleaner, less verbose code.
// When: The initial value makes the type obvious.
let maxRedeemCount = 3
var isEligible = false

// 2. Type Annotation
// Explicitly defining the data type.
// Why: Essential when initializing empty variables or when specific precision is needed (e.g., Double vs Int).
// When: For visual documentation (explicit intent) and to avoid ambiguity.
let requestTimeout: TimeInterval = 30
var username: String? = nil
