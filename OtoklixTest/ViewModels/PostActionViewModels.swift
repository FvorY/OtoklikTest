import Foundation
import UIKit

protocol PostActionViewModelDelegate {
    func onCreateSuccess()
    func onCreateFailed()
    
    func onEditSuccess()
    func onEditFailed()
}

class PostActionViewModel {
    var delegate: PostActionViewModelDelegate?
    
    var controller: UIViewController?
    var networkingclient = NetworkingClient()
    
    func setupLoader() {
        networkingclient.controller = controller
        networkingclient.setupLoadingView()
    }
    
    func postData(_ title: String, content: String) {
        
        self.networkingclient.showLoading()
        
        let params = [
            "title": title,
            "content": content
        ]
        
        self.networkingclient.post(Globals.getApiUrl("posts"), parameters: params, parmheader: ["Content-type": "application/json; charset=UTF-8"]) { [weak self] (response, error) in
            guard let response = response else { return }
            do {
                self?.delegate?.onCreateSuccess()
            } catch {
                self?.delegate?.onCreateFailed()
            }
            
            self?.networkingclient.hideLoading()
        }
        
    }
    
    func editData(_ id: Int, title: String, content: String) {
        
        self.networkingclient.showLoading()
        
        let params = [
            "title": title,
            "content": content
        ]
        
        self.networkingclient.put(Globals.getApiUrl("posts/\(id)"), parameters: params, parmheader: ["Content-type": "application/json; charset=UTF-8"]) { [weak self] (response, error) in
            guard let response = response else { return }
            do {
                self?.delegate?.onCreateSuccess()
            } catch {
                self?.delegate?.onCreateFailed()
            }
            
            self?.networkingclient.hideLoading()
        }
        
    }
}
