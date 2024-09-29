#include "user_credential.h"

#include <string>

#include "mls/util.h"

namespace discord {
namespace dave {
namespace mls {

::mls::Credential CreateUserCredential(const std::string& userId, ProtocolVersion version)
{
    // convert the string user ID to a big endian uint64_t
    auto userID = std::stoull(userId);
    auto credentialBytes = BigEndianBytesFrom(userID);

    return ::mls::Credential::basic(credentialBytes);
}

std::string UserCredentialToString(const ::mls::Credential& cred, ProtocolVersion version)
{
    if (cred.type() != ::mls::CredentialType::basic) {
        return "";
    }

    const auto& basic = cred.template get<::mls::BasicCredential>();

    auto uidVal = FromBigEndianBytes(basic.identity);

    return std::to_string(uidVal);
}

} // namespace mls
} // namespace dave
} // namespace discord
