
//
//import Foundation
//import PDFKit
//
//class AssessmentReport{
//
//  lazy var pageWidth : CGFloat  = {
//    return 8.5 * 72.0
//  }()
//
//  lazy var pageHeight : CGFloat = {
//    return 11 * 72.0
//  }()
//
//  lazy var pageRect : CGRect = {
//    CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
//  }()
//
//  lazy var marginPoint : CGPoint = {
//    return CGPoint(x: 10, y: 90)
//  }()
//
//  lazy var marginSize : CGSize = {
//    return CGSize(width: self.marginPoint.x * 2 , height: self.marginPoint.y * 2)
//  }()
//
//  let mainTitle:String
//  let subTitle:String
//  let sections:[PDFSection]
//
//  let currentContext = UIGraphicsGetCurrentContext()
//
//
//  public let treatmentText:String = "Antiviral medications are under investigation for COVID-19, as well as medications targeting the immune response.[474] None has yet been shown to be clearly effective on mortality in published randomised controlled trials.[474] However, remdesivir may have an effect on the time it takes to recover from the virus.[475] Emergency use authorisation for remdesivir was granted in the U.S. on 1 May, for people hospitalised with severe COVID-19. The interim authorisation was granted considering the lack of other specific treatments being available, and that its potential benefits appear to outweigh the potential risks.[476] Taking over-the-counter cold medications,[477] drinking fluids, and resting may help alleviate symptoms.[414] Depending on the severity, oxygen therapy, intravenous fluids, and breathing support may be required.[478] The use of steroids may worsen outcomes.[479] Several compounds which were previously approved for treatment of other viral diseases are being investigated for use in treating COVID-19.[480]"
//  public let containmentText:String = "Strategies in the control of an outbreak are containment or suppression, and mitigation. Containment is undertaken in the early stages of the outbreak and aims to trace and isolate those infected as well as introduce other measures of infection control and vaccinations to stop the disease from spreading to the rest of the population. When it is no longer possible to contain the spread of the disease, efforts then move to the mitigation stage: measures are taken to slow the spread and mitigate its effects on the healthcare system and society. A combination of both containment and mitigation measures may be undertaken at the same time.[455] Suppression requires more extreme measures so as to reverse the pandemic by reducing the basic reproduction number to less than 1.[386] Part of managing an infectious disease outbreak is trying to delay and decrease the epidemic peak, known as flattening the epidemic curve.[451] This decreases the risk of health services being overwhelmed and provides more time for vaccines and treatments to be developed.[451] Non-pharmaceutical interventions that may manage the outbreak include personal preventive measures, such as hand hygiene, wearing face masks, and self-quarantine; community measures aimed at physical distancing such as closing schools and cancelling mass gathering events; community engagement to encourage acceptance and participation in such interventions; as well as environmental measures such surface cleaning.[456] More drastic actions aimed at containing the outbreak were taken in China once the severity of the outbreak became apparent, such as quarantining entire cities and imposing strict travel bans.[457] Other countries also adopted a variety of measures aimed at limiting the spread of the virus. South Korea introduced mass screening and localised quarantines, and issued alerts on the movements of infected individuals. Singapore provided financial support for those infected who quarantined themselves and imposed large fines for those who failed to do so. Taiwan increased face mask production and penalised hoarding of medical supplies.[458] Simulations for Great Britain and the United States show that mitigation (slowing but not stopping epidemic spread) and suppression (reversing epidemic growth) have major challenges. Optimal mitigation policies might reduce peak healthcare demand by two-thirds and deaths by half, but still result in hundreds of thousands of deaths and overwhelmed health systems. Suppression can be preferred but needs to be maintained for as long as the virus is circulating in the human population (or until a vaccine becomes available), as transmission otherwise quickly rebounds when measures are relaxed. Long-term intervention to suppress the pandemic has considerable social and economic costs.[386]"
//
//  init(mainTitle: String,subTitle:String, sections:[PDFSection]){
//    self.mainTitle = mainTitle
//    self.subTitle = subTitle
//    self.sections = sections
//  }
//
//  func createCOVIDReport() -> Data {
//
//    //parameter list
//    // pageWidth:CGFloat,pageHeight:CGFloat
//    // 1
//    let pdfMetaData = [
//      kCGPDFContextCreator: "RPM",
//      kCGPDFContextAuthor: "RPM",
//      kCGPDFContextTitle: mainTitle
//    ]
//    let format = UIGraphicsPDFRendererFormat()
//    format.documentInfo = pdfMetaData as [String: Any]
//
//    // 1
//    let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
//
//    // 2
//    let paragraphStyle = NSMutableParagraphStyle()
//    paragraphStyle.alignment = .natural
//    paragraphStyle.lineBreakMode = .byWordWrapping
//
//    // 3
//    let textAttributes = [
//        NSAttributedString.Key.paragraphStyle: paragraphStyle,
//        NSAttributedString.Key.font: textFont
//    ]
//
//    //4
//    let currentText = CFAttributedStringCreate(nil,
//                                               self.containmentText as CFString,
//                                               textAttributes as CFDictionary)
//    //5
//    let framesetter = CTFramesetterCreateWithAttributedString(currentText!)
//
//
//    // 3
//    let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
//    // 4
//    let data = renderer.pdfData { (context) in
//
//      var currentRange = CFRangeMake(0, 0)
//      var currentPage = 0
//      var done = false
//      repeat {
//
//        currentRange = renderPage(currentPage,
//                                  withTextRange: currentRange,
//                                  andFramesetter: framesetter)
//        let logo = UIImage(named: "rw-logo")
//        let headerBottom = addHeader(logo: logo! ,mainTitle: mainTitle, subTitle:subTitle, pageRect: pageRect, textTop:10)
//        //
//        /* If we're at the end of the text, exit the loop. */
//        if currentRange.location == CFAttributedStringGetLength(currentText) {
//          done = true
//        }
//
//      } while !done
//    }
//
//    return data
//  }
//
//
//  func renderPage(_ pageNum: Int, withTextRange currentRange: CFRange, andFramesetter framesetter: CTFramesetter?) -> CFRange {
//    var currentRange = currentRange
//    // Get the graphics context.
//    let currentContext = UIGraphicsGetCurrentContext()
//
//    // Put the text matrix into a known state. This ensures
//    // that no old scaling factors are left in place.
//    currentContext?.textMatrix = .identity
//
//    // Create a path object to enclose the text. Use 72 point
//    // margins all around the text.
//    let frameRect = CGRect(x: self.marginPoint.x, y: self.marginPoint.y, width: self.pageWidth - self.marginSize.width, height: self.pageHeight - self.marginSize.height)
//    let framePath = CGMutablePath()
//    framePath.addRect(frameRect, transform: .identity)
//
//    // Get the frame that will do the rendering.
//    // The currentRange variable specifies only the starting point. The framesetter
//    // lays out as much text as will fit into the frame.
//    let frameRef = CTFramesetterCreateFrame(framesetter!, currentRange, framePath, nil)
//
//    // Core Text draws from the bottom-left corner up, so flip
//    // the current transform prior to drawing.
//    currentContext?.translateBy(x: 0, y: self.pageHeight)
//    currentContext?.scaleBy(x: 1.0, y: -1.0)
//
//    // Draw the frame.
//    CTFrameDraw(frameRef, currentContext!)
//
//    // Update the current range based on what was drawn.
//    currentRange = CTFrameGetVisibleStringRange(frameRef)
//    currentRange.location += currentRange.length
//    currentRange.length = CFIndex(0)
//
//    return currentRange
//  }
//
//
//  func addHeader(logo:UIImage, mainTitle: String, subTitle: String, pageRect: CGRect,textTop: CGFloat) -> CGFloat {
//    let imageBottom = self.addImage(image:logo,imageX:CGFloat(20),maxHeightRatio:CGFloat(0.8),maxWidthRatio: CGFloat(0.2) ,pageRect:pageRect,imageTop:textTop)
//    let headerBottom = self.addTitle(titleText:mainTitle, titleX: CGFloat(pageRect.width * 0.3)   , pageRect:pageRect, textTop:textTop)
//    let headerBottom2 = self.addTitle(titleText:subTitle, titleX: CGFloat(pageRect.width * 0.3)   , pageRect:pageRect, textTop:headerBottom + 5 )
//    //        return titleStringRect.origin.y + titleStringRect.size.height
//    return max(imageBottom,headerBottom)
//  }
//
//  /**
//   - imageX : the starting point of the image x-axis
//   - imageTop : the starting point of the image  y-axis
//   - maxHeightRatio : eg 0.6 wrt Page Height
//   - maxWidthRatio : eg 0.4 wrt Page Width
//
//   */
//  func addImage(image:UIImage,imageX:CGFloat,maxHeightRatio:CGFloat,maxWidthRatio:CGFloat,pageRect: CGRect, imageTop: CGFloat) -> CGFloat {
//    // 1
//    let maxHeight = pageRect.height * maxHeightRatio
//    let maxWidth = pageRect.width * maxWidthRatio
//    // 2
//    let aspectWidth = maxWidth / image.size.width
//    let aspectHeight = maxHeight / image.size.height
//    let aspectRatio = min(aspectWidth, aspectHeight)
//    // 3
//    let scaledWidth = image.size.width * aspectRatio
//    let scaledHeight = image.size.height * aspectRatio
//    // 4
//    //        let imageX = (pageRect.width - scaledWidth) / 2.0
//    let imageRect = CGRect(x: imageX, y: imageTop,
//                           width: scaledWidth, height: scaledHeight)
//    // 5
//    image.draw(in: imageRect)
//    return imageRect.origin.y + imageRect.size.height
//  }
//
//  func addTitle(titleText: String,titleX:CGFloat,pageRect: CGRect,textTop: CGFloat) -> CGFloat {
//    // 1
//    let titleFont = UIFont.systemFont(ofSize: 20.0, weight: .bold)
//    // 2
//    let titleAttributes: [NSAttributedString.Key: Any] =
//      [NSAttributedString.Key.font: titleFont]
//    let attributedTitle = NSAttributedString(string: titleText, attributes: titleAttributes)
//    // 3
//    let titleStringSize = attributedTitle.size()
//    // 4
//    //        let titleStringRect = CGRect(x: (pageRect.width - titleStringSize.width) / 2.0,
//    //                                     y: textTop, width: titleStringSize.width,
//    //                                     height: titleStringSize.height)
//    let titleStringRect = CGRect(x: titleX,
//                                 y: textTop, width: titleStringSize.width,
//                                 height: titleStringSize.height)
//
//    // 5
//    attributedTitle.draw(in: titleStringRect)
//    // 6
//
//    return titleStringRect.origin.y + titleStringRect.size.height
//  }
//
//
//}
//
