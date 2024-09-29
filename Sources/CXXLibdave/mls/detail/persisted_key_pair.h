#pragma once

#include <string>
#include <memory>

#include <mls/crypto.h>

#include "mls/persisted_key_pair.h"

namespace discord {
namespace dave {
namespace mls {
namespace detail {

std::shared_ptr<::mls::SignaturePrivateKey> GetNativePersistedKeyPair(KeyPairContextType ctx,
                                                                        const std::string& keyID,
                                                                        ::mls::CipherSuite suite,
                                                                        bool& supported);
std::shared_ptr<::mls::SignaturePrivateKey> GetGenericPersistedKeyPair(
  KeyPairContextType ctx,
  const std::string& keyID,
  ::mls::CipherSuite suite);

bool DeleteNativePersistedKeyPair(KeyPairContextType ctx, const std::string& keyID);
bool DeleteGenericPersistedKeyPair(KeyPairContextType ctx, const std::string& keyID);

} // namespace detail
} // namespace mls
} // namespace dave
} // namespace discord
