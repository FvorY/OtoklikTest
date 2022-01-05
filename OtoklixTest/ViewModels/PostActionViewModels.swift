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
    
    var networkingclient = NetworkingClient()
    
    func postData(_ title: String, content: String) {

        let params = [
            "title": title,
            "content": content
        ]
        
        self.networkingclient.post(Globals.getApiUrl("posts"), parameters: params, parmheader: ["Content-type": "application/json; charset=UTF-8"]) { [weak self] (response, error) in
            guard let _ = response else { return }
            do {
                self?.delegate?.onCreateSuccess()
            } catch {
                self?.delegate?.onCreateFailed()
            }
        }
        
    }
    
    func editData(_ id: Int, title: String, content: String) {
        let params = [
            "title": title,
            "content": content
        ]
        
        self.networkingclient.put(Globals.getApiUrl("posts/\(id)"), parameters: params, parmheader: ["Content-type": "application/json; charset=UTF-8"]) { [weak self] (response, error) in
            guard let _ = response else { return }
            do {
                self?.delegate?.onCreateSuccess()
            } catch {
                self?.delegate?.onCreateFailed()
            }
        }
        
    }
}
