import Foundation
import UIKit

protocol PostViewModelDelegate {
    func onSuccess()
    func onFailed()
    
    func onDeleteSuccess(_ indexPath: IndexPath)
    func onDeleteFailed()
}

class PostViewModel {
    var delegate: PostViewModelDelegate?
    var postList: [PostModel] = []
    
    var controller: UIViewController?
    var networkingclient = NetworkingClient()
    
    func setupLoader() {
        networkingclient.controller = controller
        networkingclient.setupLoadingView()
    }
    
    func getData() {
        self.networkingclient.showLoading()
        
        self.networkingclient.execute(Globals.getApiUrl("posts")) { [weak self] (response, error) in
            guard let response = response else { return }
            do {
                let decodedJson = try! JSONDecoder().decode([PostModel].self, from: response)
                self?.postList = decodedJson
                self?.delegate?.onSuccess()
            } catch {
                self?.delegate?.onFailed()
            }
            
            self?.networkingclient.hideLoading()
            self?.networkingclient.firstLoad = false
        }
    }

    func deleteData(_ id: Int, indexPath: IndexPath) {
        
        self.networkingclient.showLoading()
        
        self.networkingclient.delete(Globals.getApiUrl("posts/\(id)"), parameters: nil, parmheader: ["Content-type": "application/json; charset=UTF-8"]) { [weak self] (response, error) in
            guard let response = response else { return }
            do {
                self?.postList.remove(at: indexPath.row)
                self?.delegate?.onDeleteSuccess(indexPath)
            } catch {
                self?.delegate?.onDeleteFailed()
            }
            
            self?.networkingclient.hideLoading()
        }
        
    }
}
