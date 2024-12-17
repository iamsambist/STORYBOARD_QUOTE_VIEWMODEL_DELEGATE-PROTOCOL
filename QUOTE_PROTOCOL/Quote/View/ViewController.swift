//
//  ViewController.swift
//  QUOTE_PROTOCOL
//
//  Created by MacBook Two on 17/12/2024.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet var quoteLable : UILabel!
    @IBOutlet var authorLabel : UILabel!
    @IBOutlet var errorLabel : UILabel!
    var quoteViewModel  : QuoteViewModel?
    
    var errorLabelVisibility : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteViewModel = QuoteViewModel()
        quoteViewModel?.delegate = self
        quoteViewModel?.loadInitialDataSet()
        errorLabel.isHidden = !errorLabelVisibility
    }
    
    @IBAction func nextButtonTapped() {
        if errorLabelVisibility {
            clearErrorActions()
        }
        quoteViewModel?.fetchNextDataSet()
    }
    
    @IBAction func previousButtonTapped(){
        if errorLabelVisibility {
            clearErrorActions()
        }
        quoteViewModel?.fetchPreviousDataSet()
    }
    
    func clearErrorActions(){
        toogleErrorLabelVisibility()
        errorLabel.text = ""
    }
    func toogleErrorLabelVisibility(){
        if errorLabelVisibility {
            errorLabelVisibility = false
            errorLabel.isHidden = !errorLabelVisibility
        } else {
            errorLabelVisibility = true
            errorLabel.isHidden = !errorLabelVisibility
        }
    }
 

}
extension ViewController : QuoteViewModelDelegate {
    func showError(message: String) {
        toogleErrorLabelVisibility()
        errorLabel.text = message
        
    }
    
    func dataSetUpdatated(dataset: DataSet) {
        quoteLable.text = dataset.quote
        authorLabel.text = dataset.quthor
    }
}

