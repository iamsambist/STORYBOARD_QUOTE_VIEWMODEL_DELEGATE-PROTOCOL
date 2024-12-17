//
//  QuoteViewModel.swift
//  QUOTE_PROTOCOL
//
//  Created by MacBook Two on 17/12/2024.
//

import Foundation

struct DataSet {
    var quote : String
    var quthor : String
}
protocol QuoteViewModelDelegate {
    func dataSetUpdatated(dataset : DataSet)
    func showError(message : String)
}
class QuoteViewModel {
    
    var delegate : QuoteViewModelDelegate?
    var dataSource : QuoteSource?
    
    // MARK: - Stored Property : class variables which store values
    var currentQuoteIndex : Int = 0
    
    init() {
        self.dataSource = QuoteSource()
    }
    
    func loadInitialDataSet(){
        let data = dataSource?.quotes[0]
        guard let unWrappedQuote = data?.quote,
              let unWrappedAuthor = data?.WrittenBy else { return }
        delegate?.dataSetUpdatated(dataset: DataSet(quote: unWrappedQuote, quthor: unWrappedAuthor))
    }
    
    func fetchNextDataSet(){
        let nextIndex = currentQuoteIndex + 1
        let data =  dataSource?.fetchNextDataSet(index: nextIndex)
        guard let unWrappedData = data else {
            delegate?.showError(message: "NO MORE QUOTES LEFT !")
            return}
        print(unWrappedData)
        currentQuoteIndex = currentQuoteIndex + 1
        delegate?.dataSetUpdatated(dataset: DataSet(quote: unWrappedData.quote, quthor: unWrappedData.WrittenBy))
        
    }
    
    func fetchPreviousDataSet() {
        let nextIndex = currentQuoteIndex - 1
        let data =  dataSource?.fetchPreviousDataSet(index: nextIndex)
        
        if let unWrappData = data {
            currentQuoteIndex = currentQuoteIndex - 1
            delegate?.dataSetUpdatated(dataset: DataSet(quote: unWrappData.quote, quthor: unWrappData.WrittenBy))
        } else {
            delegate?.showError(message: "INITIAL QUOTE")
        }
     
    }
    
    
}
