import UIKit

class BaseViewController: UIViewController {
    var firstLoad = true
    var loadingView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLoadingView()
    }
    
    func setupLoadingView() {
        if loadingView == nil {
            let width:CGFloat = 60.0
            let height: CGFloat = 60.0
            
            loadingView = UIView()
            loadingView?.translatesAutoresizingMaskIntoConstraints = false
            
            loadingView?.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
            loadingView?.alpha = 0.7
            loadingView?.layer.cornerRadius = 8.0
            self.view.addSubview(loadingView!)
            
            self.view.addConstraint(NSLayoutConstraint(
                item: loadingView,
                attribute: NSLayoutConstraint.Attribute.width,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: nil,
                attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                multiplier: 1,
                constant: width
            ))
            
            self.view.addConstraint(NSLayoutConstraint(
                item: loadingView,
                attribute: NSLayoutConstraint.Attribute.height,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: nil,
                attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                multiplier: 1,
                constant: height
                ))
            
            self.view.addConstraint(NSLayoutConstraint(
                item: loadingView,
                attribute: NSLayoutConstraint.Attribute.centerX,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: self.view,
                attribute: NSLayoutConstraint.Attribute.centerX,
                multiplier: 1,
                constant: 0
                ))
            
            self.view.addConstraint(NSLayoutConstraint(
                item: loadingView,
                attribute: NSLayoutConstraint.Attribute.centerY,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: self.view,
                attribute: NSLayoutConstraint.Attribute.centerY,
                multiplier: 1,
                constant: 0
                ))
            
            let loadingProcess: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            if #available(iOS 13.0, *) {
                loadingProcess.style = UIActivityIndicatorView.Style.large
            } else {
                // Fallback on earlier versions
                loadingProcess.style = UIActivityIndicatorView.Style.whiteLarge
            }
            loadingProcess.color = UIColor(red: 107/255, green: 107/255, blue: 107/255, alpha: 1.0)
            loadingProcess.startAnimating()
            
            loadingView?.addSubview(loadingProcess)
        }
        
        loadingView?.isHidden = true
    }
    
    func showLoading() {
        if loadingView != nil {
            loadingView?.isHidden = false
            self.view.bringSubviewToFront(loadingView!)
        }
    }
    
    func hideLoading() {
        if loadingView != nil {
            loadingView?.isHidden = true
            self.view.sendSubviewToBack(loadingView!)
        }
    }
    
    func isLoading() -> Bool {
        if loadingView != nil {
            return loadingView!.isHidden ? false : true
        }
        return false
    }
    
}
