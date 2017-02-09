# iOS Test Harness

A little iOS library that enables running Rust tests in the iOS simulator.

## Usage

Use XCode to build `libiosharness.a`.

Build your rust tests with these extra linker arguments:

```
cargo rustc --verbose --test test --target $TARGET -- \
  -L $PATH_CONTAINING_LIBIOSHARNESS \
  -C link-args="-mios-simulator-version-min=7.0 -e _ios_main -liosharness"
```

Where `$TARGET` is the iOS target triple (for example `x86_64-apple-ios`).

The compiled executable should run on the iOS simulator.

## Rational

Running code in the iOS simulator is not super straightforward. An application
launched in the simulator has 20 seconds to "check in" with the OS before it
gets force killed. Checking in requires starting the iOS app by calling
`UIApplicationMain`.

Now, one cannot simply call `UIApplicationMain` in a thread as part of the rust
test runner. For some reason (I have no idea how or why), `UIApplicationMain`
has to be called on the main thread or it is unable to communicate with the OS.
The Rust test runner does not provide the ability to hook into the main thread,
so we have to jump through some hoops.

## License

This library is primarily distributed under the terms of both the MIT license
and the Apache License (Version 2.0), with portions covered by various BSD-like
licenses.

See LICENSE-APACHE, and LICENSE-MIT for details.
