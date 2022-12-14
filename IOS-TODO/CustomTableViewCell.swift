/*
 File Name: CustomTableViewCell
 Author: Krisuv Bohara(301274636), Niraj Nepal(301211100)
 Date: 2022-11-13
 Description: Creates the UI for adding Todos of the Todo app and adds all the fuctionality for adding Todo's
 Version: 1.0
 */


import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
