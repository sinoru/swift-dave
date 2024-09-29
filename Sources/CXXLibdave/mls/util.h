#pragma once

#include <string>

#include <bytes/bytes.h>

namespace discord {
namespace dave {
namespace mls {

::mls::bytes_ns::bytes BigEndianBytesFrom(uint64_t value) noexcept;
uint64_t FromBigEndianBytes(const ::mls::bytes_ns::bytes& value) noexcept;

} // namespace mls
} // namespace dave
} // namespace discord
