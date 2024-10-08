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
                "CBoringSSL",
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
                "CBoringSSL",
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
                "CBoringSSL",
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
        .target(
            name: "CBoringSSL",
            path: "Vendors/BoringSSL",
            exclude: [
                "crypto/abi_self_test.cc",
                "crypto/asn1/asn1_test.cc",
                "crypto/base64/base64_test.cc",
                "crypto/bio/bio_test.cc",
                "crypto/blake2/blake2_test.cc",
                "crypto/buf/buf_test.cc",
                "crypto/bytestring/bytestring_test.cc",
                "crypto/chacha/chacha_test.cc",
                "crypto/cipher_extra/cipher_test.cc",
                "crypto/cipher_extra/test",
                "crypto/cipher_extra/aead_test.cc",
                "crypto/compiler_test.cc",
                "crypto/conf/conf_test.cc",
                "crypto/constant_time_test.cc",
                "crypto/cpu_arm_linux_test.cc",
                "crypto/crypto_test.cc",
                "crypto/curve25519/ed25519_test.cc",
                "crypto/curve25519/spake25519_test.cc",
                "crypto/curve25519/x25519_test.cc",
                "crypto/dh_extra/dh_test.cc",
                "crypto/digest_extra/digest_test.cc",
                "crypto/dilithium/dilithium_test.cc",
                "crypto/dsa/dsa_test.cc",
                "crypto/ecdh_extra/ecdh_test.cc",
                "crypto/err/err_test.cc",
                "crypto/evp/evp_extra_test.cc",
                "crypto/evp/evp_test.cc",
                "crypto/evp/pbkdf_test.cc",
                "crypto/evp/scrypt_test.cc",
                "crypto/fipsmodule/aes/aes_test.cc",
                "crypto/fipsmodule/bn/bn_test.cc",
                "crypto/fipsmodule/bn/test",
                "crypto/fipsmodule/cmac/cmac_test.cc",
                "crypto/fipsmodule/ec/ec_test.cc",
                "crypto/fipsmodule/ec/p256-nistz_test.cc",
                "crypto/fipsmodule/ec/p256_test.cc",
                "crypto/fipsmodule/ecdsa/ecdsa_test.cc",
                "crypto/fipsmodule/hkdf/hkdf_test.cc",
                "crypto/fipsmodule/modes/gcm_test.cc",
                "crypto/fipsmodule/policydocs",
                "crypto/fipsmodule/rand/ctrdrbg_test.cc",
                "crypto/fipsmodule/service_indicator/service_indicator_test.cc",
                "crypto/fipsmodule/sha/sha_test.cc",
                "crypto/hmac_extra/hmac_test.cc",
                "crypto/hpke/hpke_test.cc",
                "crypto/hrss/hrss_test.cc",
                "crypto/impl_dispatch_test.cc",
                "crypto/keccak/keccak_test.cc",
                "crypto/kyber/kyber_test.cc",
                "crypto/lhash/lhash_test.cc",
                "crypto/md5/md5_test.cc",
                "crypto/mldsa/mldsa_test.cc",
                "crypto/mlkem/mlkem_test.cc",
                "crypto/obj/obj_test.cc",
                "crypto/pem/pem_test.cc",
                "crypto/pkcs7/pkcs7_test.cc",
                "crypto/pkcs8/pkcs12_test.cc",
                "crypto/pkcs8/pkcs8_test.cc",
                "crypto/pkcs8/test",
                "crypto/poly1305/poly1305_test.cc",
                "crypto/pool/pool_test.cc",
                "crypto/rand_extra/fork_detect_test.cc",
                "crypto/rand_extra/getentropy_test.cc",
                "crypto/rand_extra/rand_test.cc",
                "crypto/rand_extra/urandom_test.cc",
                "crypto/refcount_test.cc",
                "crypto/rsa_extra/rsa_test.cc",
                "crypto/self_test.cc",
                "crypto/siphash/siphash_test.cc",
                "crypto/slhdsa/slhdsa_test.cc",
                "crypto/spx/spx_test.cc",
                "crypto/stack/stack_test.cc",
                "crypto/test",
                "crypto/thread_test.cc",
                "crypto/trust_token/trust_token_test.cc",
                "crypto/x509/tab_test.cc",
                "crypto/x509/test",
                "crypto/x509/x509_test.cc",
                "crypto/x509/x509_time_test.cc",
            ],
            sources: [
                "crypto",
                "gen/bcm",
                "gen/crypto",
                "include",
                "third_party/fiat/asm",
            ],
            cSettings: [
                .define("_HAS_EXCEPTIONS", to: "0", .when(platforms: [.windows])),
                .define("WIN32_LEAN_AND_MEAN", .when(platforms: [.windows])),
                .define("NOMINMAX", .when(platforms: [.windows])),
                .define("_CRT_SECURE_NO_WARNINGS", .when(platforms: [.windows])),
                .define("_XOPEN_SOURCE", to: "700", .when(platforms: [.linux])),
                .define("BORINGSSL_IMPLEMENTATION"),
            ],
            cxxSettings: [
                .define("_HAS_EXCEPTIONS", to: "0", .when(platforms: [.windows])),
                .define("WIN32_LEAN_AND_MEAN", .when(platforms: [.windows])),
                .define("NOMINMAX", .when(platforms: [.windows])),
                .define("_CRT_SECURE_NO_WARNINGS", .when(platforms: [.windows])),
                .define("_XOPEN_SOURCE", to: "700", .when(platforms: [.linux])),
                .define("BORINGSSL_IMPLEMENTATION"),
            ]),
    ],
    cLanguageStandard: .gnu11,
    cxxLanguageStandard: .gnucxx17
)
