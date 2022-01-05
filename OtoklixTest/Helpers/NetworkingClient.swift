import Foundation
import Alamofire

class NetworkingClient {
    
    typealias WebServiceResponse = (Data?, Error?) -> Void
    
    func execute(_ url: URL, completion: @escaping WebServiceResponse) {
        Alamofire.request(url).validate().responseJSON { response in
            if let error = response.error {
                completion(nil, error)
            } else if let jsonArray = response.data {
                completion(jsonArray, nil)
            }
        }
    }
    
    func post(_ url: URL, parameters: [String: Any]?, parmheader: [String: String]?,  completion: @escaping WebServiceResponse) {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: parmheader).responseJSON { response in
            if let error = response.error {
                completion(nil, error)
            } else if let jsonArray = response.data {
                completion(jsonArray, nil)
            }
        }
    }
    
    func delete(_ url: URL, parameters: [String: Any]?, parmheader: [String: String]?,  completion: @escaping WebServiceResponse) {
        Alamofire.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: parmheader).responseJSON { response in
            if let error = response.error {
                completion(nil, error)
            } else if let jsonArray = response.data {
                completion(jsonArray, nil)
            }
        }
    }
    
    func put(_ url: URL, parameters: [String: Any]?, parmheader: [String: String]?,  completion: @escaping WebServiceResponse) {
        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: parmheader).responseJSON { response in
            if let error = response.error {
                completion(nil, error)
            } else if let jsonArray = response.data {
                completion(jsonArray, nil)
            }
        }
    }
    
}
    

