
import UIKit
import PDFKit

class PDFPreviewViewController: UIViewController {
  public var documentData: Data?
  @IBOutlet weak var pdfView: PDFView!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Add the share icon and action
    let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(saveLocalAction))
    self.toolbarItems?.append(shareButton)
    
    
    if let data = documentData {
      pdfView.document = PDFDocument(data: data)
      pdfView.autoScales = true
    }
  }
  
  
  @objc func saveLocalAction() {
  
    return
    
  }
  
  
}
