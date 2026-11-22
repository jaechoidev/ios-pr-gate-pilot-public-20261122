# iOS PR gate pilot

A disposable SwiftUI counter fixture for demonstrating a required iOS UI test
on pull requests to `dev`. The test launches the app and checks the count
after a button tap. A second-tap assertion is used to demonstrate a passing
and an intentionally failing change. The PRs are test evidence, not releases.
