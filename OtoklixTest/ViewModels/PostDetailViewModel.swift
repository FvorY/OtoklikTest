import Foundation
import UIKit

protocol PostDetailViewModelDelegate {
    func onShowSuccess(_ data: PostModel)
    func onShowFailed()
}

class PostDetailViewModel {
    var delegate: PostDetailViewModelDelegate?
    var postDetail = PostModel()
    
    var controller: UIViewController?
    var networkingclient = NetworkingClient()
    
    func setupLoader() {
        networkingclient.controller = controller
        networkingclient.setupLoadingView()
    }

    func showData(_ id: Int) {
        self.networkingclient.showLoading()
        
        self.networkingclient.execute(Globals.getApiUrl("posts/\(id)")) { [weak self] (response, error) in
            guard let response = response else { return }
            do {
                let decodedJson = try! JSONDecoder().decode(PostModel.self, from: response)
                self?.delegate?.onShowSuccess(decodedJson)
            } catch {
                self?.delegate?.onShowFailed()
            }
            
            self?.networkingclient.hideLoading()
        }
    }
}
