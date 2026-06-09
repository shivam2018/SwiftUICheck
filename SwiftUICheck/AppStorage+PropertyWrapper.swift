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
// MARK: - Feature Flags

/// A lightweight feature flag system backed by UserDefaults.
/// Usage:
///   1. Define a flag key in `FeatureFlags.Key`.
///   2. Access via `FeatureFlags.isEnabled(_:)` or use the `@FeatureFlag` wrapper.
///   3. Toggle flags at runtime using `FeatureFlags.enable/disable`.
struct FeatureFlags {
    /// Namespace for feature keys to avoid typos.
    struct Key: RawRepresentable, Hashable, ExpressibleByStringLiteral {
        let rawValue: String
        init(rawValue: String) { self.rawValue = rawValue }
        init(stringLiteral value: StringLiteralType) { self.rawValue = value }

        // Define your flags here
        static let newOnboarding: Key = "feature.newOnboarding"
        static let experimentalCheckout: Key = "feature.experimentalCheckout"
        static let debugMenu: Key = "feature.debugMenu"
    }

    private static let defaults: UserDefaults = .standard

    /// Returns whether a flag is enabled. If the key is missing, returns the provided default (false by default).
    static func isEnabled(_ key: Key, default defaultValue: Bool = false) -> Bool {
        if defaults.object(forKey: key.rawValue) == nil {
            return defaultValue
        }
        return defaults.bool(forKey: key.rawValue)
    }

    /// Enable a flag.
    static func enable(_ key: Key) {
        defaults.set(true, forKey: key.rawValue)
    }

    /// Disable a flag.
    static func disable(_ key: Key) {
        defaults.set(false, forKey: key.rawValue)
    }

    /// Reset a flag (removes from defaults, falling back to wrapper default when used).
    static func reset(_ key: Key) {
        defaults.removeObject(forKey: key.rawValue)
    }
}

/// Property wrapper for boolean feature flags stored in UserDefaults.
/// Supports a per-usage default value and an optional explicit key override.
@propertyWrapper
struct FeatureFlag {
    private let key: FeatureFlags.Key
    private let defaultValue: Bool
    private let store: UserDefaults

    init(_ key: FeatureFlags.Key, defaultValue: Bool = false, store: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.store = store
    }

    var wrappedValue: Bool {
        get {
            if store.object(forKey: key.rawValue) == nil { return defaultValue }
            return store.bool(forKey: key.rawValue)
        }
        set {
            store.set(newValue, forKey: key.rawValue)
        }
    }

    var projectedValue: FeatureFlag { self }

    func enable() { store.set(true, forKey: key.rawValue) }
    func disable() { store.set(false, forKey: key.rawValue) }
    func reset() { store.removeObject(forKey: key.rawValue) }
}

// MARK: - Example usage of FeatureFlag
struct FeatureConfig {
    @FeatureFlag(.newOnboarding, defaultValue: false)
    static var newOnboardingEnabled: Bool

    @FeatureFlag(.experimentalCheckout, defaultValue: false)
    static var experimentalCheckoutEnabled: Bool

    @FeatureFlag(.debugMenu, defaultValue: false)
    static var debugMenuEnabled: Bool
}

