#pragma once

#include <mls/core_types.h>
#include <mls/crypto.h>
#include <mls/messages.h>

#include "../version.h"

namespace discord {
namespace dave {
namespace mls {

::mls::CipherSuite::ID CiphersuiteIDForProtocolVersion(ProtocolVersion version) noexcept;
::mls::CipherSuite CiphersuiteForProtocolVersion(ProtocolVersion version) noexcept;
::mls::CipherSuite::ID CiphersuiteIDForSignatureVersion(SignatureVersion version) noexcept;
::mls::CipherSuite CiphersuiteForSignatureVersion(SignatureVersion version) noexcept;
::mls::Capabilities LeafNodeCapabilitiesForProtocolVersion(ProtocolVersion version) noexcept;
::mls::ExtensionList LeafNodeExtensionsForProtocolVersion(ProtocolVersion version) noexcept;
::mls::ExtensionList GroupExtensionsForProtocolVersion(
  ProtocolVersion version,
  const ::mls::ExternalSender& externalSender) noexcept;

} // namespace mls
} // namespace dave
} // namespace discord
