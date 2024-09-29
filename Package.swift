// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-dave",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DAVE",
            targets: ["DAVE"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sinoru/swift-crypto.git", from: "3.7.1"),
    ],
    targets: [
        .target(
            name: "DAVE",
            dependencies: ["CXXLibdave"],
            swiftSettings: [
                .interoperabilityMode(.Cxx),
            ]),
        .testTarget(
            name: "DAVETests",
            dependencies: ["DAVE"]
        ),
        .target(
            name: "CXXLibdave",
            dependencies: [
                .product(name: "CBoringSSL", package: "swift-crypto"),
                "CMLS++",
            ],
            exclude: [
                "afl_driver",
                "test",
                "mls/persisted_key_pair_null.cpp",
                "mls/detail/persisted_key_pair_apple.cpp",
                "mls/detail/persisted_key_pair_null.cpp",
                "mls/detail/persisted_key_pair_win.cpp",
            ],
            publicHeadersPath: "."),
        .target(
            name: "CJSON",
            path: "Vendors/nlohmann/json",
            sources: ["include"]),
        .target(
            name: "CMLS++Shims"),
        .target(
            name: "CMLS++Bytes",
            dependencies: [
                "CMLS++Shims",
                "CMLS++TLSSyntax",
            ],
            path: "Vendors/mlspp/lib/bytes",
            sources: [
                "src",
            ],
            cSettings: [
                .define("WITH_BORINGSSL"),
            ],
            cxxSettings: [
                .define("WITH_BORINGSSL"),
            ]),
        .target(
            name: "CMLS++HPKE",
            dependencies: [
                .product(name: "CBoringSSL", package: "swift-crypto"),
                "CJSON",
                "CMLS++Shims",
                "CMLS++Bytes",
                "CMLS++TLSSyntax",
            ],
            path: "Vendors/mlspp/lib/hpke",
            sources: [
                "src",
            ],
            cSettings: [
                .define("WITH_BORINGSSL"),
            ],
            cxxSettings: [
                .define("WITH_BORINGSSL"),
            ]),
        .target(
            name: "CMLS++TLSSyntax",
            dependencies: [
                "CMLS++Shims",
            ],
            path: "Vendors/mlspp/lib/tls_syntax",
            sources: [
                "src",
            ],
            cSettings: [
                .define("WITH_BORINGSSL"),
            ],
            cxxSettings: [
                .define("WITH_BORINGSSL"),
            ]),
        .target(
            name: "CMLS++",
            dependencies: [
                "CJSON",
                .product(name: "CBoringSSL", package: "swift-crypto"),
                "CMLS++Bytes",
                "CMLS++HPKE",
                "CMLS++TLSSyntax",
            ],
            path: "Vendors/mlspp",
            sources: [
                "src",
            ],
            cSettings: [
                .define("WITH_BORINGSSL"),
            ],
            cxxSettings: [
                .define("WITH_BORINGSSL"),
            ]),
    ],
    cLanguageStandard: .gnu11,
    cxxLanguageStandard: .gnucxx17
)
