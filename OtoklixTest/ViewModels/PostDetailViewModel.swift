import Foundation
import UIKit

protocol PostDetailViewModelDelegate {
    func onShowSuccess()
    func onShowFailed()
}

class PostDetailViewModel {
    var delegate: PostDetailViewModelDelegate?
    var postDetail = PostModel()

    var networkingclient = NetworkingClient()
    
    func showData(_ id: Int) {
        self.networkingclient.execute(Globals.getApiUrl("posts/\(id)")) { [weak self] (response, error) in
            guard let response = response else { return }
            do {
                let decodedJson = try! JSONDecoder().decode(PostModel.self, from: response)
                self?.postDetail = decodedJson
                self?.delegate?.onShowSuccess()
            } catch {
                self?.delegate?.onShowFailed()
            }
        }
    }
}
