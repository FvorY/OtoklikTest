import UIKit

class Globals: NSObject {
    
    override init() {
        
    }
    
    static func showAlertWithTitle(_ title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    static func showConfirmAlertWithTitle(_ title: String, message: String, viewController: UIViewController, completion:((_ action:UIAlertAction?) -> Void)?) {
        //        var alert:UIAlertView = UIAlertView(title: title, message: message, delegate: delegate, cancelButtonTitle: "NO", otherButtonTitles: "YES", nil)
        //        alert.show()
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: completion))
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func getApiUrl(_ api: String) -> URL {
        return URL(string: String(format: "%@%@", self.getApiBaseUrl(), api))!
    }
    
    static func getApiBaseUrl() -> String {
        return "https://limitless-forest-49003.herokuapp.com/"
    }
    
    static func getImgUrl(_ api: String) -> String {
        return String(format: "%@%@", self.getImgBaseUrl(), api)
    }
    
    static func getImgBaseUrl() -> String {
        return "https://limitless-forest-49003.herokuapp.com/"
    }
    
}

extension UIView {
    @discardableResult
    func corners(_ radius: CGFloat) -> UIView {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        
        return self
    }
    
    @discardableResult
    func shadow(radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float) -> UIView {
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        
        return self
    }
    // OUTPUT 1
    func dropShadow1(scale: Bool = true) {
        layer.masksToBounds = false
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                // User Interface is Dark
                layer.shadowColor = UIColor.white.cgColor
            } else {
                // User Interface is Light
                layer.shadowColor = UIColor.gray.cgColor
            }
        } else {
            // Fallback on earlier versions
            layer.shadowColor = UIColor.gray.cgColor
        }
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 7.0
        layer.shadowOpacity = 0.2
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow2(color: UIColor, opacity: Float = 0.3, offSet: CGSize, radius: CGFloat = 8, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = true ? UIScreen.main.scale : 1
    }
    
    func dropShadow3() {
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                // User Interface is Dark
                layer.shadowColor = UIColor.white.withAlphaComponent(5).cgColor
            } else {
                // User Interface is Light
                layer.shadowColor = UIColor.black.withAlphaComponent(5).cgColor
            }
        } else {
            // Fallback on earlier versions
            layer.shadowColor = UIColor.black.withAlphaComponent(5).cgColor
        }
        
        layer.shadowOffset = CGSize(width: 0 , height: 13)
//        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
//                                                     y: bounds.maxY - layer.shadowRadius,
//                                                     width: bounds.width,
//                                                     height: layer.shadowRadius)).cgPath
    }
    
    func dropShadow4() {
            layer.masksToBounds = false
            layer.shadowRadius = 5
            layer.shadowOpacity = 0.1
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                // User Interface is Dark
                layer.shadowColor = UIColor.white.cgColor
            } else {
                // User Interface is Light
                layer.shadowColor = UIColor.gray.cgColor
            }
        } else {
            // Fallback on earlier versions
            layer.shadowColor = UIColor.gray.cgColor
        }
            layer.shadowOffset = CGSize(width: 0 , height: 5.0)
    }
    
    func dropShadow5() {
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                // User Interface is Dark
                layer.shadowColor = UIColor.white.withAlphaComponent(5).cgColor
            } else {
                // User Interface is Light
                layer.shadowColor = UIColor.gray.withAlphaComponent(5).cgColor
            }
        } else {
            // Fallback on earlier versions
            layer.shadowColor = UIColor.gray.withAlphaComponent(5).cgColor
        }
        layer.shadowOffset = CGSize(width: 0 , height: 3)
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return nil
        }
    }
    var html2String: String? {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String? {
        return html2AttributedString?.string ?? ""
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
