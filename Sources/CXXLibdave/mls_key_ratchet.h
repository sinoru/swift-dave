#pragma once

#include <mls/key_schedule.h>

#include "key_ratchet.h"

namespace discord {
namespace dave {

class MlsKeyRatchet : public IKeyRatchet {
public:
    MlsKeyRatchet(::mls::CipherSuite suite, bytes baseSecret) noexcept;
    ~MlsKeyRatchet() noexcept override;

    EncryptionKey GetKey(KeyGeneration generation) noexcept override;
    void DeleteKey(KeyGeneration generation) noexcept override;

private:
    ::mls::HashRatchet hashRatchet_;
};

} // namespace dave
} // namespace discord
