import UIKit

class ListPostTableViewCell: UITableViewCell {
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!

    var postData: PostModel?
    
    var indexPath: IndexPath?
    
    var editTouched: ((PostModel) -> Void)?
    
    var deleteTouched: ((PostModel, IndexPath) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.viewBack.corners(19)
        self.btnEdit.corners(self.btnEdit.frame.size.width / 2)
        self.btnDelete.corners(self.btnEdit.frame.size.width / 2)
    }
    
    func renderData(_ post: PostModel, indexPath: IndexPath) {
        self.postData = post
        self.indexPath = indexPath
        
        self.lblTitle.text = post.title ?? ""
        self.lblContent.text = post.content?.html2String ?? ""
    }

    @IBAction func btnEditTouched(_ sender: Any) {
        guard let unwrapData = postData else { return }
        
        editTouched?(unwrapData)
    }
    
    @IBAction func btnDeleteTouched(_ sender: Any) {
        guard let unwrapData = postData else { return }
        guard let unwrapIndex = indexPath else { return }
        
        deleteTouched?(unwrapData, unwrapIndex)
    }
    
}
