import UIKit

class ListPostTableViewCell: UITableViewCell {
    
    var index = 0
    
    var isEdit: ((_ result: Bool) -> ())? = nil
    
    func didEdit(completed: @escaping(_ result: Bool) -> ()) {
        self.isEdit = completed
    }
    
    var isDelete: ((_ result: Bool) -> ())? = nil
    
    func didDelete(completed: @escaping(_ result: Bool) -> ()) {
        self.isDelete = completed
    }
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnEditTouched(_ sender: Any) {
        if let completed = isEdit {
            completed(true)
        }
    }
    
    @IBAction func btnDeleteTouched(_ sender: Any) {
        if let completed = isDelete {
            completed(true)
        }
    }
    
}
