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
    
    var networkingclient = NetworkingClient()
    
    func getData() {
        self.networkingclient.execute(Globals.getApiUrl("posts")) { [weak self] (response, error) in
            guard let response = response else { return }
            do {
                let decodedJson = try! JSONDecoder().decode([PostModel].self, from: response)
                self?.postList = decodedJson
                self?.delegate?.onSuccess()
            } catch {
                self?.delegate?.onFailed()
            }
        }
    }
 
    func deleteData(_ id: Int, indexPath: IndexPath) {
        self.networkingclient.delete(Globals.getApiUrl("posts/\(id)"), parameters: nil, parmheader: ["Content-type": "application/json; charset=UTF-8"]) { [weak self] (response, error) in
            guard let _ = response else { return }
            do {
                self?.postList.remove(at: indexPath.row)
                self?.delegate?.onDeleteSuccess(indexPath)
            } catch {
                self?.delegate?.onDeleteFailed()
            }
        }
        
    }
}
