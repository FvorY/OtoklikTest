import UIKit
import Kingfisher

class PostDetailViewController: UIViewController, InisiateView, PostDetailViewModelDelegate {
    
    @IBOutlet weak var viewModal: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    
    var viewModel = PostDetailViewModel()
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.initView()
        
        self.viewModel.showData(self.viewModel.postDetail.id!)
        // Do any additional setup after loading the view.
    }
    
    func onShowSuccess(_ data: PostModel) {
        DispatchQueue.main.async {
            self.viewModel.postDetail = data
            
            self.setData()
        }
    }
    
    func onShowFailed() {
        DispatchQueue.main.async {
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
