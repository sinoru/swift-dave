#include "parameters.h"

namespace discord {
namespace dave {
namespace mls {

::mls::CipherSuite::ID CiphersuiteIDForProtocolVersion(ProtocolVersion version) noexcept
{
    return ::mls::CipherSuite::ID::P256_AES128GCM_SHA256_P256;
}

::mls::CipherSuite CiphersuiteForProtocolVersion(ProtocolVersion version) noexcept
{
    return ::mls::CipherSuite{CiphersuiteIDForProtocolVersion(version)};
}

::mls::CipherSuite::ID CiphersuiteIDForSignatureVersion(SignatureVersion version) noexcept
{
    return ::mls::CipherSuite::ID::P256_AES128GCM_SHA256_P256;
}

::mls::CipherSuite CiphersuiteForSignatureVersion(SignatureVersion version) noexcept
{
    return ::mls::CipherSuite{CiphersuiteIDForProtocolVersion(version)};
}

::mls::Capabilities LeafNodeCapabilitiesForProtocolVersion(ProtocolVersion version) noexcept
{
    auto capabilities = ::mls::Capabilities::create_default();

    capabilities.cipher_suites = {CiphersuiteIDForProtocolVersion(version)};
    capabilities.credentials = {::mls::CredentialType::basic};

    return capabilities;
}

::mls::ExtensionList LeafNodeExtensionsForProtocolVersion(ProtocolVersion version) noexcept
{
    return ::mls::ExtensionList{};
}

::mls::ExtensionList GroupExtensionsForProtocolVersion(
  ProtocolVersion version,
  const ::mls::ExternalSender& externalSender) noexcept
{
    auto extensionList = ::mls::ExtensionList{};

    extensionList.add(::mls::ExternalSendersExtension{{
      {externalSender.signature_key, externalSender.credential},
    }});

    return extensionList;
}

} // namespace mls
} // namespace dave
} // namespace discord
