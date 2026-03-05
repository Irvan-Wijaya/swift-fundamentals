import Foundation

// MARK: - Overview
/// **Optionals**
/// A fundamental type safety feature in Swift. An Optional represents two possibilities:
/// Either it contains a value (and you can unwrap it to access it), or it contains no value (`nil`).
/// Industry Focus: Preventing Null Pointer Exceptions, the primary cause of runtime crashes.

// MARK: A. Declaration & The "Box" Concept
/// Think of an Optional as a sealed box. It might contain data, or it might be empty.
/// You cannot use the data directly; you must safely open the box first.

var middleName: String? = nil // Explicitly stating it can hold nil
var transactionNote: String? = "Gift" // Contains a value, but it is still wrapped in the "box"

// print(transactionNote) // Output: Optional("Gift") - This is NOT the raw string!

// MARK: B. Force Unwrapping (!)
/// Forcibly prying the box open. If the box is empty (`nil`), the application CRASHES instantly.
/// Industry Rule: Strictly prohibited in banking/enterprise apps unless dealing with static App Bundle URLs.

let forcedNote = transactionNote!
print(forcedNote) // Output: Gift

// var emptyNote: String? = nil
// let crash = emptyNote! // ❌ Fatal error: Unexpectedly found nil while unwrapping an Optional value

// MARK: C. Optional Binding (if let)
/// The safe way to unwrap. "If there is a value inside, let me use it temporarily."
/// Why: Safely handles missing data without halting the application.

let userAccountStatus: String? = "Active"

if let safeStatus = userAccountStatus {
    // `safeStatus` is now a regular, non-optional String, accessible only inside these brackets.
    print("Account is \(safeStatus)") // Output: Account is Active
} else {
    // Graceful fallback if `userAccountStatus` was nil
    print("Status unavailable")
}

// MARK: D. Early Exit (guard let)
/// The industry standard for handling Optionals in functions.
/// "Ensure there is a value. If not, exit the current scope immediately."
/// Why: Prevents the "Pyramid of Doom" (deeply nested if-statements) and makes the unwrapped variable available globally within the function.

func processRefund(transactionID: String?) {
    // Validate the optional first
    guard let safeID = transactionID else {
        print("Error: Missing Transaction ID")
        return // Must exit the function
    }
    
    // `safeID` is available for the rest of the function block without further unwrapping
    print("Processing refund for \(safeID)")
}

processRefund(transactionID: nil)       // Output: Error: Missing Transaction ID
processRefund(transactionID: "TRX999")  // Output: Processing refund for TRX999

// MARK: E. Nil-Coalescing Operator (??)
/// Unwraps an optional, but provides a default fallback value if the optional is `nil`.
/// When: Perfect for UI rendering where a concrete value is strictly required for display.

var fetchedDisplayName: String? = nil
let uiName = fetchedDisplayName ?? "Guest User"
print(uiName) // Output: Guest User

// MARK: F. Optional Chaining (?)
/// Safely queries properties or methods on an optional that might currently be `nil`.
/// If the optional contains a value, the property call succeeds. If `nil`, the call gracefully fails and returns `nil`.

struct Customer {
    var phoneNumber: String?
}

let newCustomer = Customer(phoneNumber: nil)

// Instead of unwrapping Customer, then unwrapping phoneNumber, we chain them.
// Note: The result of optional chaining is ALWAYS an Optional itself.
let areaCodeLength = newCustomer.phoneNumber?.count

if areaCodeLength == nil {
    print("No phone number provided") // Output: No phone number provided
}
