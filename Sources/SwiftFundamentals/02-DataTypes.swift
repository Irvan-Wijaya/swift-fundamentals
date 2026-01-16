import Foundation

// MARK: - Overview
/// **Simple Data Types**
/// Swift provides type-safe constructs for text, numbers, and logic.
/// Understanding memory behavior and precision is critical for enterprise apps.

// MARK: 1. Strings
/// Swift Strings are value types (structs), offering safety and performance via Copy-on-Write.
/// Copy-on-Write is only duplicates data in memory when it's mutation (changed when is var), thus remaining memory efficient.

// A. Multi-line Strings
// Why: Perfect for hardcoded formatting like SQL Queries, JSON mocks, or HTML text.
// When: Unit Testing or displaying formatted legal text/T&C.
let jsonMock = """
{
    "status": "success",
    "data": { "balance": 9000000 }
}
"""

// B. String Interpolation
// The safest way to inject values into text without type casting issues.
let salary = 5_000_000
let message = "Your current salary is IDR \(salary)"

// MARK: 2. Integers (Whole Numbers)
/// `Int` is the standard integer type. On 64-bit platforms, it is `Int64`.

// Code Readability Trick: Use underscores for large numbers.
let monthlySalary = 9_000_000
let rawSalary = 9000000

// MARK: 3. Floating Points
// A. Double (64-bit) vs Float (32-bit)
// General Rule: Always prefer `Double` for non-financial calculations (coordinates, animations).
let latitude: Double = -6.2088 // High precision
let animationSpeed: Float = 0.5 // Lower precision is acceptable here

// B. The "Decimal" Rule for Banking
// NEVER use Double/Float for money due to binary floating-point errors.
// Example: 0.1 + 0.2 != 0.3 in Double.

let badBalanceCalculation: Double = 0.1 + 0.2 // Result: 0.30000000000000004
let safeBalanceCalculation: Decimal = 0.1 + 0.2 // Result: 0.3

// MARK: 4. Booleans
/// Simple true/false logic.
/// Convention: Use prefixes like `is`, `has`, or `should` for readability.

let isAccountActive = true
let hasCreditCard = false
// vs
let active = true // Ambiguous: active what?
