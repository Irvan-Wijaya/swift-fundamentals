import Foundation

// MARK: - Overview
/// **Classes**
/// Complex data types similar to Structs, but with fundamental differences in memory management and inheritance.
/// Focus in Swift: Reference Type semantics, Inheritance, and Shared State.

// MARK: A. Initialization
/// Unlike Structs, Classes DO NOT automatically generate a memberwise initializer.
/// You must explicitly write the `init` method to ensure all properties are properly populated.

class BankAccount {
    var accountName: String
    var balance: Double
    
    // Explicit initializer is strictly required
    init(accountName: String, balance: Double) {
        self.accountName = accountName
        self.balance = balance
    }
}

let primaryAccount = BankAccount(accountName: "Daily Savings", balance: 50_000.0)

// MARK: B. Reference Type Semantics (Crucial Concept)
/// When you assign a Class instance to a new variable or pass it to a function, it is NOT copied.
/// Both variables point to the EXACT SAME object in memory.

let secondaryAccount = primaryAccount // Points to the same memory address as primaryAccount

secondaryAccount.balance = 1_500_000.0

// Modifying secondaryAccount ALSO modifies primaryAccount because they share the same data!
print(primaryAccount.balance) // Output: 1500000.0
print(secondaryAccount.balance) // Output: 1500000.0

// MARK: C. Inheritance & Overriding
/// Classes can inherit properties and methods from another class (Superclass / Subclass relationship).
/// Structs CANNOT do this. This is the foundation of UIKit (e.g., overriding viewDidLoad).

class PremiumAccount: BankAccount {
    var cashbackRate: Double
    
    init(accountName: String, balance: Double, cashbackRate: Double) {
        self.cashbackRate = cashbackRate
        // Call the superclass initializer to handle its portion of the setup
        super.init(accountName: accountName, balance: balance)
    }
    
    func calculateBonus() -> Double {
        return balance * cashbackRate
    }
}

let vipAccount = PremiumAccount(accountName: "VIP", balance: 1_000_000.0, cashbackRate: 0.05)
print(vipAccount.calculateBonus()) // Output: 50000.0

// MARK: D. Mutability with Constants (let)
/// If a Struct is a constant (`let`), ALL its properties become constants.
/// If a Class is a constant (`let`), you CAN still change its `var` properties.
/// Why: The constant protects the memory REFERENCE, not the data inside that memory.

let sharedNetworkSession = BankAccount(accountName: "API Session", balance: 0)
sharedNetworkSession.balance = 500.0 // ✅ Perfectly valid in a Class.
// sharedNetworkSession = BankAccount(...) // ❌ Error: Cannot change the reference to point to a new object.

// MARK: E. Deinitialization (deinit)
/// Code that runs automatically just before a Class instance is destroyed and removed from memory.
/// Industry Use Case: Cleaning up resources, like closing web sockets or removing NotificationCenter observers.

class SecureSession {
    let sessionToken: String
    
    init(sessionToken: String) {
        self.sessionToken = sessionToken
        print("Session \(sessionToken) started")
    }
    
    deinit {
        print("Session \(sessionToken) securely closed and memory freed")
    }
}

// Creating an artificial scope using `do` to demonstrate memory destruction
do {
    let session = SecureSession(sessionToken: "ABC_123") // Output: Session ABC_123 started
    // The scope ends here, so 'session' is no longer needed and is destroyed.
}
// Output immediately after the block: Session ABC_123 securely closed and memory freed


// MARK: F. Real-World Patterns
// 1. Dependency Injection (Service Layer)

class APIService {
    func fetchData() {
        print("Fetching data...")
    }
}

class DashboardViewModel {
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func load() {
        apiService.fetchData()
    }
}


// 2. Singleton (Shared State)
class SessionManager {
    static let shared = SessionManager()

    private init() {}
    
    var token: String?
}


// 3. Retain Cycle Prevention
class NetworkManager {
    var completion: (() -> Void)?
}

class ExampleController {
    let network = NetworkManager()
    
    func setup() {
        network.completion = { [weak self] in
            self?.handle()
        }
    }
    
    func handle() {
        print("Handled")
    }
}

//MARK: Simpe Implementation
class SessionManager {
    static let shared = SessionManager()
    
    var isLoggedIn: Bool = false
    var userToken: String?
    
    private init() {}
    
    func login(token: String) {
        self.isLoggedIn = true
        self.userToken = token
        print("User login dengan token: \(token)")
    }
    
    func logout() {
        self.isLoggedIn = false
        self.userToken = nil
        print("User logout")
    }
    
    deinit {
        print("SessionManager dihapus dari memory")
    }
}

let session1 = SessionManager.shared
let session2 = SessionManager.shared

if session1 === session2 {
    print("Mereka adalah objek yang sama di memory")
}

session1.login(token: "ABC123")
print(session2.userToken ?? "No Token") // prove shared state

session2.logout()
print(session1.isLoggedIn) // false
