## libdave

This repository contains the JS and C++ libraries which together implement Discord's Audio & Video End-to-End Encryption (DAVE) protocol. These libraries are leveraged by Discord's native clients to support the DAVE protocol.

The DAVE protocol is described in detail in the [protocol whitepaper](https://github.com/discord/dave-protocol).

## libdave C++

Contains the libdave C++ library, which handles the bulk of the DAVE protocol implementation for Discord's native clients.

### Dependencies

- [mlspp](https://github.com/cisco/mlspp)
- [boringssl](https://boringssl.googlesource.com/boringssl)

#### Testing
- [googletest](https://github.com/google/googletest)
- [AFLplusplus](https://github.com/AFLplusplus/AFLplusplus)
