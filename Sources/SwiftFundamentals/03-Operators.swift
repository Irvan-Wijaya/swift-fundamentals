import Foundation

// MARK: - Overview
/// **Operators**
/// A breakdown of Swift's strict type-safe operator system.

// MARK: A. Assignment Operators
/// Basic assignment (=) and Compound assignment (+=, -=).

let fixedRate = 0.5
var currentScore = 10
currentScore += 5 // Compound assignment: modifies variable in place

// MARK: B. Arithmetic Operators
/// Standard math (+, -, *, /) and Remainder (%).

// Technical Note (Type Strictness):
// Swift forbids implicit type casting. You cannot add Int to Double without conversion.
// Why: To enforce precision awareness, critical in financial calculations.

let width: Int = 10
let ratio: Double = 1.5
// let result = width * ratio // Error
let result = Double(width) * ratio // Explicit conversion required

// Technical Note (String Concatenation):
// The (+) operator is overloaded for Strings.
// Warning: Avoid using (+) inside loops (O(n^2) complexity). Use String Interpolation or `.joined()` instead.
let fullName = "Irvan" + " " + "Wijaya"

// MARK: C. Comparison Operators
/// Standard comparators (==, !=, >, <, >=, <=).

// Technical Note:
// Works out-of-the-box for standard types (String, Int, Double).
// For custom Structs/Classes, the type must conform to the `Equatable` or `Comparable` protocol.

let name1 = "Alpha"
let name2 = "Beta"
let isOrdered = name1 < name2 // true (Lexicographical comparison)

// MARK: D. Logical Operators
/// Logic gates: !, &&, || 

// Technical Note (Short-Circuit Evaluation):
// Swift evaluates from left to right. If the left side determines the outcome, the right side is NOT executed.
// Use Case: Safety check before accessing a property.

let isUserLoggedIn = false
let hasPremiumAccess = true

// Since `isUserLoggedIn` is false, `hasPremiumAccess` is never checked.
// This prevents crashes if the second condition relies on the first being true (e.g., checking for nil).
let canViewContent = isUserLoggedIn && hasPremiumAccess

// MARK: E. Range Operators
/// Defines a range of values. Heavily used in loops and collection slicing.

// 1. Closed Range Operator (...)
// Includes the final value.
// Use Case: Iterating through precise ranges.
let scoreRange = 1...100 // 1 - 100

// 2. Half-Open Range Operator (..<)
// Excludes the final value.
// Use Case: Zero-based arrays (preventing Index Out of Bounds errors).
let names = ["Alice", "Bob", "Charlie"]
for i in 0..<names.count {
    print(names[i])
} // Alice Bob Charlie
print("Total names: \(names.count)") // Total names: 3
// for i in 0..<count { ... } // Safe iteration -> 0,1,2 (Upper bound not included) | if using closed range will crash index out of range

// 3. One Side Range Operator (1...)
let numbers = [1,2,3,4,5]
let slice = numbers[2...]
print("\(slice)") // [3, 4, 5]

// MARK: F. Nil-Coalescing & Optional Operators
/// Handling Optionals safely without verbose `if-let` structures.

// 1. Nil-Coalescing Operator (??)
// Returns the value if it exists, otherwise returns a default fallback.
// Industry Use Case: Providing default UI values or API fallbacks.
let serverName: String? = nil
let displayName = serverName ?? "Guest" // Returns "Guest"

// 2. Optional (?)
let username: String // without ? means username MUST always contain String value
let username: String = nil // error, because cannot be empty from the values side (different from .isEmpty)

let username: String? // means it may have String or may not
 // ok, this type can be left nil or blank

// Same output, different internal state
let username: String? = "Guest" // A
let username: String? = nil // B
print(username ?? "guest")
/// (A) if print(username) -> `Optional("Guest")`, if unwrap, print(username ?? "fallback") -> ` guest (not fallback, because there is value, which is guest)`
/// (B)  actual data `does not exist`, means  there is no username. if print(username ?? "fallback") -> `fallback`.  So not a real data, only for backup or for better ui/ux.
/// `(A) Real data = Guest | (B) Real data does'nt exist, but show Guest as a bakcup`

// 3. Forced Unwrap Operator (!) -> means SURE this is not nil
var username: String? = "John"
print(username!) // John, safe because there is value

var username: String? = nil
print(username!)
/// CRASH, Unexpectedly found nil while unwrapping an Optional -> This is a very famous Swift error. Safer use `(if let, guard let, ??, ?.)`

// 4. Optional Chaining (?)
// Safely accesses properties of an optional. If any link is nil, the whole chain fails gracefully to nil.
// Industry Use Case: Deeply nested API responses.
let zipCode = user?.address?.zipCode // Returns nil if user OR address is nil (If one is nil → final result is nil).

// MARK: G. Ternary Conditional Operator
/// A concise one-line if-else statement (`condition ? trueValue : falseValue`).

// Why: Reduces code verbosity for simple assignments.
// Warning: Avoid nesting ternary operators. It severely degrades readability.

let themeMode = "Dark"
let backgroundColor = (themeMode == "Dark") ? "Black" : "White"

// UI State Rendering
button.isHidden = !isLoggedIn // more explicit, if login = true, then isHidden = false
// better than
button.isHidden = isLoggedIn ? false : true

// Readable vs Unreadable:
// Good: let color = isSelected ? .red : .blue
// Bad: let color = isSelected ? (isActive ? .red : .green) : .blue // Avoid this complexity
