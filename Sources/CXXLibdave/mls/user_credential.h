#pragma once

#include <string>

#include <mls/credential.h>

#include "../version.h"

namespace discord {
namespace dave {
namespace mls {

::mls::Credential CreateUserCredential(const std::string& userId, ProtocolVersion version);
std::string UserCredentialToString(const ::mls::Credential& cred, ProtocolVersion version);

} // namespace mls
} // namespace dave
} // namespace discord
