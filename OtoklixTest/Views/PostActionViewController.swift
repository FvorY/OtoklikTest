import UIKit
import Kingfisher

class PostActionViewController: BaseViewController, InisiateView, PostActionViewModelDelegate {
    
    @IBOutlet weak var viewModal: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblTxtTitle: UILabel!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var viewTxtTitle: UIView!
    
    @IBOutlet weak var lblTxtContent: UILabel!
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var viewTxtContent: UIView!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    let viewModel = PostActionViewModel()
    
    var postData: PostModel?
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.delegate = self
        
        self.hideKeyboardWhenTappedAround()
    
        self.initView()
        
        // Do any additional setup after loading the view.
    }
    
    func initView() {
        DispatchQueue.main.async {
            self.viewModal.corners(18)
            
            //Title
            self.viewTxtTitle.corners(12)
            self.viewTxtTitle.layer.borderWidth = 1
            self.viewTxtTitle.layer.borderColor = UIColor.white.cgColor
            
            //Content
            self.viewTxtContent.corners(12)
            self.viewTxtContent.layer.borderWidth = 1
            self.viewTxtContent.layer.borderColor = UIColor.white.cgColor
            self.txtContent.tintColor = UIColor.white
            self.txtContent.tintColorDidChange()
            
            //Submit
            self.btnSubmit.corners(18)
            
            if self.postData != nil {
                self.lblTitle.text = "Edit Post"
                
                self.txtTitle.text = self.postData?.title ?? ""
                self.txtContent.text = self.postData?.content ?? ""
            }
        }
    }
    
    @IBAction func btnSubmitTouched(_ sender: Any) {
        let title = self.txtTitle.text ?? ""
        let content = self.txtContent.text ?? ""
        
        if self.postData != nil {
            if let iddata = self.postData?.id {
                self.showLoading()
                self.viewModel.editData(iddata, title: title, content: content)
            }
        } else {
            self.showLoading()
            self.viewModel.postData(title, content: content)
        }
    }
    
    @IBAction func btnCloseTouched(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func refreshData() {
        DispatchQueue.main.async {
            self.hideLoading()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshData"), object: nil)
            
            self.btnCloseTouched(self)
        }
    }
    
    func onCreateSuccess() {
        self.refreshData()
    }
    
    func onCreateFailed() {
        DispatchQueue.main.async {
            self.hideLoading()
            Globals.showAlertWithTitle("Error Create Data", message: "Check your internet connection!", viewController: self)
        }
    }
    
    func onEditSuccess() {
        self.refreshData()
    }
    
    func onEditFailed() {
        DispatchQueue.main.async {
            self.hideLoading()
            Globals.showAlertWithTitle("Error Edit Data", message: "Check your internet connection!", viewController: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.postData = nil
    }
    
}
