import Foundation

// MARK: - Overview
/// **Structs (Structures)**
/// Complex data types that allow you to group multiple related properties and functions into a single unit.
/// Focus in Swift: Immutability by default, safety, and Value Type semantics.

// MARK: A. Declaration & Memberwise Initializer
/// Structs automatically generate an initializer for all their properties behind the scenes.
/// Industry Standard: Used for defining data models (e.g., API responses, UI state).

struct BankTransaction {
    let transactionID: String
    let amount: Double
    var note: String // 'var' means this specific property can be changed later
}

// The "Memberwise Initializer" is automatically provided by Swift
var dailyTransfer = BankTransaction(transactionID: "TRX-101", amount: 500_000.0, note: "Lunch split")
print(dailyTransfer.amount) // Output: 500000.0

// MARK: B. Value Type Semantics (Crucial Concept)
/// When you assign a Struct to a new variable or pass it to a function, it is COPIED.
/// They do NOT share the same data in memory. Modifying the copy does not affect the original.

var originalTransfer = BankTransaction(transactionID: "TRX-102", amount: 100_000.0, note: "Coffee")
var copiedTransfer = originalTransfer // A completely separate copy is created in memory

copiedTransfer.note = "Coffee and Pastry"

print(originalTransfer.note) // Output: Coffee (Original remains unchanged)
print(copiedTransfer.note)   // Output: Coffee and Pastry

// MARK: C. Computed Properties
/// Properties that do not store a value directly. Instead, they calculate their value on the fly every time they are accessed.
/// Why: Keeps the data source of truth in one place.

struct SavingsAccount {
    var principalBalance: Double
    var interestRate: Double
    
    // Computed property: Calculates projected balance
    var projectedBalance: Double {
        return principalBalance + (principalBalance * interestRate)
    }
}

let myAccount = SavingsAccount(principalBalance: 10_000_000, interestRate: 0.05)
print(myAccount.projectedBalance) // Output: 10500000.0

// MARK: D. Property Observers (willSet & didSet)
/// Code blocks that run automatically whenever a property's value changes.
/// Industry Use Case: Updating the UI or logging analytics whenever a data model updates.

struct UserProfile {
    var email: String {
        didSet {
            // 'oldValue' is a built-in variable inside didSet
            print("Email updated from \(oldValue) to \(email)")
        }
    }
}

var activeUser = UserProfile(email: "user@example.com")
activeUser.email = "new_user@example.com" // Output: Email updated from user@example.com to new_user@example.com

// MARK: E. Mutating Methods
/// By default, a Struct's properties cannot be modified by its own methods if the Struct is assigned to a constant (let).
/// Even if it's a variable (var), you must explicitly mark the method with the `mutating` keyword to change its internal state.

struct RewardPointSystem {
    var points: Int = 0
    
    mutating func addPoints(_ earned: Int) {
        // Without the 'mutating' keyword, this line would throw a compiler error
        points += earned
        print("Total points: \(points)")
    }
}

var customerRewards = RewardPointSystem()
customerRewards.addPoints(500) // Output: Total points: 500


//MARK: Example Simple Implementation
enum TransactionSource {
    case shopping
    case promo
    case referral
}

// MARK: - Transaction Model
struct PoinXtraTransaction {
    let transactionID: String
    let pointsEarned: Int
    let date: Date
    let source: TransactionSource
}

// MARK: - Computed Property Extension
extension PoinXtraTransaction {
    var description: String {
        return "ID: \(transactionID), Points: \(pointsEarned), Source: \(source)"
    }
}

// MARK: - User Profile
struct UserProfile {
    let name: String
    var email: String
    
    mutating func updateEmail(newEmail: String) {
        self.email = newEmail
    }
}

let transaction = PoinXtraTransaction(
    transactionID: "TRX001",
    pointsEarned: 100,
    date: Date(),
    source: .shopping
)
print(transaction.description)
var user = UserProfile(name: "Van", email: "van@email.com")
user.updateEmail(newEmail: "new@email.com")
print(user)
