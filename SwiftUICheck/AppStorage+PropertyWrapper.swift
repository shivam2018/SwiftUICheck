//
//  AppStorage+PropertyWrapper.swift
//  SwiftUICheck
//
//  Created by Shivam Trivedi on 08/06/26.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    private let store: UserDefaults

    init(key: String, defaultValue: T, store: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.store = store
    }

    var wrappedValue: T {
        get { store.object(forKey: key) as? T ?? defaultValue }
        set { store.set(newValue, forKey: key) }
    }

    var projectedValue: UserDefault<T> { self }

    func reset() {
        store.removeObject(forKey: key)
    }
}

// Usage example
struct AppSettings {
    @UserDefault(key: "isDarkModeEnabled", defaultValue: false)
    static var isDarkModeEnabled: Bool

    @UserDefault(key: "authToken", defaultValue: "")
    static var authToken: String

    @UserDefault(key: "launchCount", defaultValue: 0)
    static var launchCount: Int
}
