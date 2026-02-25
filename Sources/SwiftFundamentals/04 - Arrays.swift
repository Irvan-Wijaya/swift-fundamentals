import Foundation

// MARK: - Overview
/// **Arrays**
/// An ordered, random-access collection of values of the same type.

// MARK: A. Declaration & Type Safety
/// Arrays must contain a single specific data type.
/// Why: Ensures memory predictability and prevents runtime type-casting errors.

// 1. Type Inference
var cities = ["Jakarta", "Surabaya", "Bali"] // Inferred as [String]

// 2. Explicit Type Annotation
// Use Case: Initializing empty arrays for later use (e.g., fetching data from API).
var transactions: [Double] = []
var userIDs: Array<Int> = [] // Alternative syntax

// Industry Constraint:
// cities.append(100) // Compile-time Error: Cannot insert Int into a String array.

// MARK: B. Memory & Performance (Engineering View)
/// Understanding how Arrays behave in memory is critical for high-performance apps.

// 1. Value Semantics & Copy-on-Write (CoW)
// Arrays are Structs. Assigning an array to a new variable conceptually copies it.
// Optimization: Swift uses "Copy-on-Write". The actual data is not duplicated in RAM until
// one of the copies is modified. This makes passing arrays around very efficient.

var listA = [1, 2, 3]
var listB = listA // Points to the same memory address as listA (Efficient)
listB.append(4)   // Only NOW does Swift allocate new memory for listB (Copy occurs here)

// 2. Capacity & Reallocation
// Arrays reserve a specific amount of memory. When that limit is reached,
// Swift must allocate a new, larger memory block and copy all items over.
// Tip: If you know the size upfront, use `reserveCapacity(_:)` to prevent performance hits during appending.

// MARK: C. Common Operations & Time Complexity (Big O)
/// Knowing the cost of operations prevents UI lags in data-heavy apps.

var numbers = [10, 20, 30, 40, 50]

// 1. Accessing Data: O(1) - Constant Time
// Instant access because arrays are stored in contiguous memory blocks.
let firstItem = numbers[0]

// 2. Appending Data: O(1) - Amortized Constant Time
// Adding to the end is fast (unless reallocation occurs).
numbers.append(60)

// 3. Inserting/Removing from Beginning: O(n) - Linear Time
// Warning: This is expensive. Swift must shift all subsequent elements in memory.
// Industry Advice: Avoid `insert(_, at: 0)` inside loops. Use a specialized data structure (like Deque) if needed.
numbers.remove(at: 0) // Shifts indices 1-5 to 0-4.

// MARK: D. Safety Hazards
/// The most common crash in iOS Development: "Index Out of Range".

let counts = [1, 2, 3]
let danger = counts[99] // ❌ CRASH: Fatal error: Index out of range

// Safe Approach (Industry Standard):
// Always check bounds or use safe access extensions before accessing arbitrary indices.
if counts.indices.contains(99) {
    print(counts[99])
} else {
    // Handle error / Return default
}

// MARK: E. When to use Arrays?
/// 1. Order matters (e.g., Transaction History, To-Do List).
/// 2. Duplicate values are allowed.
/// 3. Random access by index is required.

// MARK: F. Higher-Order Function
/// map,  filter, reduce
//  Doesnt modify the original array, produced new array, suitable value semantics Swift.

// 1. map ->  change each element into another form and the number of elements remains the same
let numbers = [1, 2, 3]
let doubled = numbers.map { $0 * 2 } // [2, 4, 6]
let names = users.map { $0.name } // From [User] → [String]

// 2. filter -> select some, discard others
let evenNumbers = numbers.filter { $0 % 2 == 0 } // [2]
let activeUsers = users.filter { $0.isActive }

// 3. reduce —> combine Everything into one
// structure:
// reduce(initialValue) { partialResult, element in
//     return new partialResult
// }
let sum = [1, 2, 3].reduce(0) { $0 + $1 } // 6 -> (((0 + 1) + 2) + 3) → 6
let totalBalance = accounts
    .map { $0.balance }
    .reduce(0, +)

struct CartItem {
    let price: Double
    let quantity: Int
}
let cart = [
    CartItem(price: 10, quantity: 2),
    CartItem(price: 25, quantity: 1),
    CartItem(price: 25, quantity: 1)

]
let total = cart.reduce(0) {
    $0 + ($1.price * Double($1.quantity)) // 70
}

// simple implementation
let numbers = [1, 2, 3, 4]
let result = numbers
    .filter { $0 % 2 == 0 }
    .map { $0 * 10 }
    .reduce(0, +)
print(result) // 60
