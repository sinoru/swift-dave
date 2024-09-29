#pragma once

#include <deque>
#include <functional>
#include <list>
#include <memory>
#include <optional>
#include <string>
#include <vector>
#include <map>
#include <set>

#include "mls/persisted_key_pair.h"
#include "key_ratchet.h"
#include "version.h"

namespace mls {
struct AuthenticatedContent;
struct Credential;
struct ExternalSender;
struct HPKEPrivateKey;
struct KeyPackage;
struct LeafNode;
struct MLSMessage;
struct SignaturePrivateKey;
class State;
} // namespace mls

namespace discord {
namespace dave {
namespace mls {

struct QueuedProposal;

class Session {
public:
    using MLSFailureCallback = std::function<void(std::string const&, std::string const&)>;

    Session(KeyPairContextType context,
            std::string authSessionId,
            MLSFailureCallback callback) noexcept;

    ~Session() noexcept;

    void Init(ProtocolVersion version,
              uint64_t groupId,
              std::string const& selfUserId,
              std::shared_ptr<::mls::SignaturePrivateKey>& transientKey) noexcept;
    void Reset() noexcept;

    void SetProtocolVersion(ProtocolVersion version) noexcept;
    ProtocolVersion GetProtocolVersion() const noexcept { return protocolVersion_; }

    std::vector<uint8_t> GetLastEpochAuthenticator() const noexcept;

    void SetExternalSender(std::vector<uint8_t> const& externalSenderPackage) noexcept;

    std::optional<std::vector<uint8_t>> ProcessProposals(
      std::vector<uint8_t> proposals,
      std::set<std::string> const& recognizedUserIDs) noexcept;

    RosterVariant ProcessCommit(std::vector<uint8_t> commit) noexcept;

    std::optional<RosterMap> ProcessWelcome(
      std::vector<uint8_t> welcome,
      std::set<std::string> const& recognizedUserIDs) noexcept;

    std::vector<uint8_t> GetMarshalledKeyPackage() noexcept;

    std::unique_ptr<IKeyRatchet> GetKeyRatchet(std::string const& userId) const noexcept;

    using PairwiseFingerprintCallback = std::function<void(std::vector<uint8_t> const&)>;

    void GetPairwiseFingerprint(uint16_t version,
                                std::string const& userId,
                                PairwiseFingerprintCallback callback) const noexcept;

private:
    void InitLeafNode(std::string const& selfUserId,
                      std::shared_ptr<::mls::SignaturePrivateKey>& transientKey) noexcept;
    void ResetJoinKeyPackage() noexcept;

    void CreatePendingGroup() noexcept;

    bool HasCryptographicStateForWelcome() const noexcept;

    bool IsRecognizedUserID(const ::mls::Credential& cred,
                            std::set<std::string> const& recognizedUserIDs) const;
    bool ValidateProposalMessage(::mls::AuthenticatedContent const& message,
                                 ::mls::State const& targetState,
                                 std::set<std::string> const& recognizedUserIDs) const;
    bool VerifyWelcomeState(::mls::State const& state,
                            std::set<std::string> const& recognizedUserIDs) const;

    bool CanProcessCommit(const ::mls::MLSMessage& commit) noexcept;

    RosterMap ReplaceState(std::unique_ptr<::mls::State>&& state);

    void ClearPendingState();

    inline static const std::string USER_MEDIA_KEY_BASE_LABEL = "Discord Secure Frames v0";

    ProtocolVersion protocolVersion_;
    std::vector<uint8_t> groupId_;
    std::string signingKeyId_;
    std::string selfUserId_;
    KeyPairContextType keyPairContext_{nullptr};

    std::unique_ptr<::mls::LeafNode> selfLeafNode_;
    std::shared_ptr<::mls::SignaturePrivateKey> selfSigPrivateKey_;
    std::unique_ptr<::mls::HPKEPrivateKey> selfHPKEPrivateKey_;

    std::unique_ptr<::mls::HPKEPrivateKey> joinInitPrivateKey_;
    std::unique_ptr<::mls::KeyPackage> joinKeyPackage_;

    std::unique_ptr<::mls::ExternalSender> externalSender_;

    std::unique_ptr<::mls::State> pendingGroupState_;
    std::unique_ptr<::mls::MLSMessage> pendingGroupCommit_;

    std::unique_ptr<::mls::State> outboundCachedGroupState_;

    std::unique_ptr<::mls::State> currentState_;
    RosterMap roster_;

    std::unique_ptr<::mls::State> stateWithProposals_;
    std::list<QueuedProposal> proposalQueue_;

    MLSFailureCallback onMLSFailureCallback_{};
};

} // namespace mls
} // namespace dave
} // namespace discord
