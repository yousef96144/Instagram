//
//  FormTableViewCell.swift
//  instagram
//
//  Created by yousef Elaidy on 22/12/2023.
//

import UIKit

protocol formtableviewcelldelegate: AnyObject {
    func formtableviewcell(_ cell: FormTableViewCell,didupdatefield updatedmodel: EditProfileModel)
}
class FormTableViewCell: UITableViewCell, UITextFieldDelegate {

   static let identifier = "formcell"
    
    public weak var delegate: formtableviewcelldelegate?
    
    private var model: EditProfileModel?
    
    private var formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    private var field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.text = nil
        field.placeholder = nil
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else{
            return true
        }
        delegate?.formtableviewcell(self, didupdatefield: model)
        textField.resignFirstResponder()
        return true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        formLabel.frame = CGRect(x: 0,
                                 y: 0,
                                 width: contentView.width/3,
                                 height: contentView.height)
        field.frame = CGRect(x: formLabel.right+5,
                             y: 0,
                             width: contentView.width-10-formLabel.width,
                             height: contentView.height)
    }
    public func configure(with model: EditProfileModel){
        self.model = model
        field.text = model.value
        field.placeholder = model.placeholder
    }
    

}
