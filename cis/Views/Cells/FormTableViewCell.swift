//
//  FormTableViewCell.swift
//  cis
//
//  Created by cici on 12/6/2023.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updateModel: EditProfileFormModel)
}

class FormTableViewCell: UITableViewCell,UITextFieldDelegate {
   
    
    static let identifier  = "FormTableViewCell"
    private var model: EditProfileFormModel?
    public weak var delegate: FormTableViewCellDelegate?
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(textField)
        textField.delegate = self
        selectionStyle = .none
    }
    public func configure(with model:EditProfileFormModel){
        formLabel.text =  model.label
        textField.placeholder = model.placeholder
        textField.text = model.value
        self.model = model
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text =  nil
        textField.placeholder = nil
        textField.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //assign frames
        formLabel.frame = CGRect(x: 10, y: 0, width: contentView.width/3, height: contentView.height)
        textField.frame = CGRect(x: formLabel.right + 5, y: 0, width: contentView.width-10-formLabel.width, height: contentView.height)

    }
    //MARK: TEXTFIELD
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else{
            return true
        }
            delegate?.formTableViewCell(self, didUpdateField: model)
            textField.resignFirstResponder()
            return true
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   

}
