import Kingfisher

extension KingfisherError {
    var isTaskCancelledError: Bool {
        if case .requestError(reason: .taskCancelled) = self {
            return true
        } else {
            return false
        }
    }
}
