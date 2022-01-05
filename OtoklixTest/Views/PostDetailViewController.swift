import UIKit
import Kingfisher

class PostDetailViewController: BaseViewController, InisiateView, PostDetailViewModelDelegate {
    
    @IBOutlet weak var viewModal: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    
    let viewModel = PostDetailViewModel()
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.initView()
        
        self.viewModel.delegate = self
        
        self.showLoading()
        self.viewModel.showData(self.viewModel.postDetail.id!)
        
        // Do any additional setup after loading the view.
    }
    
    func onShowSuccess() {
        DispatchQueue.main.async {
            print("Masuk")
            self.hideLoading()
            self.setData()
        }
    }
    
    func onShowFailed() {
        DispatchQueue.main.async {
            self.hideLoading()
            Globals.showAlertWithTitle("Error Detail Load", message: "Check your internet connection!", viewController: self)
        }
    }
    
    func initView() {
        //Modal
        self.viewModal.corners(18)
        
        self.setData()
    }
    
    func setData() {
        self.lblTitle.text = self.viewModel.postDetail.title
        self.lblContent.text =  self.viewModel.postDetail.content?.html2String
        
    }
    
    @IBAction func btnCloseTouched(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

}
