//
//  PDFGenerator.swift
//  Sample
//
//  Created by Thejus Jose on 05/05/20.
//  Copyright © 2020 Isham. All rights reserved.
//

import Foundation
import PDFKit

class PDFHeader: NSObject {
  
  let logo:UIImage
  let mainTitle: String
  let subTitle: String
  
  init(logo:UIImage, mainTitle: String, subTitle: String) {
    self.logo = logo
    self.mainTitle = mainTitle
    self.subTitle = subTitle
  }
  
}

class PDFPage:NSObject{
  let noCol:Int
  let pageNum:Int
  let pageTitle:String
  let sections: [PDFSection]
  
  init(noCol:Int,pageNum:Int,pageTitle:String,sections:[PDFSection]){
    self.noCol = noCol
    self.pageNum = pageNum
    self.pageTitle = pageTitle
    self.sections = sections
    
  }
}

class PDFSection: NSObject {
  let title: String
  let body: String
  
  init(title: String, body: String) {
    self.title = title
    self.body = body
  }
}

class PDFGenerator {
  
  lazy var pageWidth : CGFloat  = {
    return 8.5 * 72.0
  }()
  
  lazy var pageHeight : CGFloat = {
    return 11 * 72.0
  }()
  
  lazy var pageRect : CGRect = {
    CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
  }()
  
  lazy var headerMarginPoint : CGPoint = {
    return CGPoint(x: 10, y: 10)
  }()

  lazy var marginPoint : CGPoint = {
    return CGPoint(x: 10, y: 110)
  }()
  
  lazy var marginSize : CGSize = {
    return CGSize(width: self.marginPoint.x * 2 , height: self.marginPoint.y * 2)
  }()
  
  var currentPage = 0
  

  let logoMaxHeightRatio = CGFloat(0.1)
  let logoMaxWidthRatio = CGFloat(0.2)
  
  let logoImage = UIImage(named: "rw-logo")
  
  public let treatmentText:String = "Antiviral medications are under investigation for COVID-19, as well as medications targeting the immune response.[474] None has yet been shown to be clearly effective on mortality in published randomised controlled trials.[474] However, remdesivir may have an effect on the time it takes to recover from the virus.[475] Emergency use authorisation for remdesivir was granted in the U.S. on 1 May, for people hospitalised with severe COVID-19. The interim authorisation was granted considering the lack of other specific treatments being available, and that its potential benefits appear to outweigh the potential risks.[476] Taking over-the-counter cold medications,[477] drinking fluids, and resting may help alleviate symptoms.[414] Depending on the severity, oxygen therapy, intravenous fluids, and breathing support may be required.[478] The use of steroids may worsen outcomes.[479] Several compounds which were previously approved for treatment of other viral diseases are being investigated for use in treating COVID-19.[480]"
  public let containmentText:String = "Strategies in the control of an outbreak are containment or suppression, and mitigation. Containment is undertaken in the early stages of the outbreak and aims to trace and isolate those infected as well as introduce other measures of infection control and vaccinations to stop the disease from spreading to the rest of the population. When it is no longer possible to contain the spread of the disease, efforts then move to the mitigation stage: measures are taken to slow the spread and mitigate its effects on the healthcare system and society. A combination of both containment and mitigation measures may be undertaken at the same time.[455] Suppression requires more extreme measures so as to reverse the pandemic by reducing the basic reproduction number to less than 1.[386] Part of managing an infectious disease outbreak is trying to delay and decrease the epidemic peak, known as flattening the epidemic curve.[451] This decreases the risk of health services being overwhelmed and provides more time for vaccines and treatments to be developed.[451] Non-pharmaceutical interventions that may manage the outbreak include personal preventive measures, such as hand hygiene, wearing face masks, and self-quarantine; community measures aimed at physical distancing such as closing schools and cancelling mass gathering events; community engagement to encourage acceptance and participation in such interventions; as well as environmental measures such surface cleaning.[456] More drastic actions aimed at containing the outbreak were taken in China once the severity of the outbreak became apparent, such as quarantining entire cities and imposing strict travel bans.[457] Other countries also adopted a variety of measures aimed at limiting the spread of the virus. South Korea introduced mass screening and localised quarantines, and issued alerts on the movements of infected individuals. Singapore provided financial support for those infected who quarantined themselves and imposed large fines for those who failed to do so. Taiwan increased face mask production and penalised hoarding of medical supplies.[458] Simulations for Great Britain and the United States show that mitigation (slowing but not stopping epidemic spread) and suppression (reversing epidemic growth) have major challenges. Optimal mitigation policies might reduce peak healthcare demand by two-thirds and deaths by half, but still result in hundreds of thousands of deaths and overwhelmed health systems. Suppression can be preferred but needs to be maintained for as long as the virus is circulating in the human population (or until a vaccine becomes available), as transmission otherwise quickly rebounds when measures are relaxed. Long-term intervention to suppress the pandemic has considerable social and economic costs.[386]"
  
  public let veryLongText:String = "Strategies in the control of an outbreak are containment or suppression, and mitigation. Containment is undertaken in the early stages of the outbreak and aims to trace and isolate those infected as well as introduce other measures of infection control and vaccinations to stop the disease from spreading to the rest of the population. When it is no longer possible to contain the spread of the disease, efforts then move to the mitigation stage: measures are taken to slow the spread and mitigate its effects on the healthcare system and society. A combination of both containment and mitigation measures may be undertaken at the same time.[455] Suppression requires more extreme measures so as to reverse the pandemic by reducing the basic reproduction number to less than 1.[386] Part of managing an infectious disease outbreak is trying to delay and decrease the epidemic peak, known as flattening the epidemic curve.[451] This decreases the risk of health services being overwhelmed and provides more time for vaccines and treatments to be developed.[451] Non-pharmaceutical interventions that may manage the outbreak include personal preventive measures, such as hand hygiene, wearing face masks, and self-quarantine; community measures aimed at physical distancing such as closing schools and cancelling mass gathering events; community engagement to encourage acceptance and participation in such interventions; as well as environmental measures such surface cleaning.[456] More drastic actions aimed at containing the outbreak were taken in China once the severity of the outbreak became apparent, such as quarantining entire cities and imposing strict travel bans.[457] Other countries also adopted a variety of measures aimed at limiting the spread of the virus. South Korea introduced mass screening and localised quarantines, and issued alerts on the movements of infected individuals. Singapore provided financial support for those infected who quarantined themselves and imposed large fines for those who failed to do so. Taiwan increased face mask production and penalised hoarding of medical supplies.[458] Simulations for Great Britain and the United States show that mitigation (slowing but not stopping epidemic spread) and suppression (reversing epidemic growth) have major challenges. Optimal mitigation policies might reduce peak healthcare demand by two-thirds and deaths by half, but still result in hundreds of thousands of deaths and overwhelmed health systems. Suppression can be preferred but needs to be maintained for as long as the virus is circulating in the human population (or until a vaccine becomes available), as transmission otherwise quickly rebounds when measures are relaxed. Long-term intervention to suppress the pandemic has considerable social and economic costs.[386] Strategies in the control of an outbreak are containment or suppression, and mitigation. Containment is undertaken in the early stages of the outbreak and aims to trace and isolate those infected as well as introduce other measures of infection control and vaccinations to stop the disease from spreading to the rest of the population. When it is no longer possible to contain the spread of the disease, efforts then move to the mitigation stage: measures are taken to slow the spread and mitigate its effects on the healthcare system and society. A combination of both containment and mitigation measures may be undertaken at the same time.[455] Suppression requires more extreme measures so as to reverse the pandemic by reducing the basic reproduction number to less than 1.[386] Part of managing an infectious disease outbreak is trying to delay and decrease the epidemic peak, known as flattening the epidemic curve.[451] This decreases the risk of health services being overwhelmed and provides more time for vaccines and treatments to be developed.[451] Non-pharmaceutical interventions that may manage the outbreak include personal preventive measures, such as hand hygiene, wearing face masks, and self-quarantine; community measures aimed at physical distancing such as closing schools and cancelling mass gathering events; community engagement to encourage acceptance and participation in such interventions; as well as environmental measures such surface cleaning.[456] More drastic actions aimed at containing the outbreak were taken in China once the severity of the outbreak became apparent, such as quarantining entire cities and imposing strict travel bans.[457] Other countries also adopted a variety of measures aimed at limiting the spread of the virus. South Korea introduced mass screening and localised quarantines, and issued alerts on the movements of infected individuals. Singapore provided financial support for those infected who quarantined themselves and imposed large fines for those who failed to do so. Taiwan increased face mask production and penalised hoarding of medical supplies.[458] Simulations for Great Britain and the United States show that mitigation (slowing but not stopping epidemic spread) and suppression (reversing epidemic growth) have major challenges. Optimal mitigation policies might reduce peak healthcare demand by two-thirds and deaths by half, but still result in hundreds of thousands of deaths and overwhelmed health systems. Suppression can be preferred but needs to be maintained for as long as the virus is circulating in the human population (or until a vaccine becomes available), as transmission otherwise quickly rebounds when measures are relaxed. Long-term intervention to suppress the pandemic has considerable social and economic costs.[386] Strategies in the control of an outbreak are containment or suppression, and mitigation. Containment is undertaken in the early stages of the outbreak and aims to trace and isolate those infected as well as introduce other measures of infection control and vaccinations to stop the disease from spreading to the rest of the population. When it is no longer possible to contain the spread of the disease, efforts then move to the mitigation stage: measures are taken to slow the spread and mitigate its effects on the healthcare system and society. A combination of both containment and mitigation measures may be undertaken at the same time.[455] Suppression requires more extreme measures so as to reverse the pandemic by reducing the basic reproduction number to less than 1.[386] Part of managing an infectious disease outbreak is trying to delay and decrease the epidemic peak, known as flattening the epidemic curve.[451] This decreases the risk of health services being overwhelmed and provides more time for vaccines and treatments to be developed.[451] Non-pharmaceutical interventions that may manage the outbreak include personal preventive measures, such as hand hygiene, wearing face masks, and self-quarantine; community measures aimed at physical distancing such as closing schools and cancelling mass gathering events; community engagement to encourage acceptance and participation in such interventions; as well as environmental measures such surface cleaning.[456] More drastic actions aimed at containing the outbreak were taken in China once the severity of the outbreak became apparent, such as quarantining entire cities and imposing strict travel bans.[457] Other countries also adopted a variety of measures aimed at limiting the spread of the virus. South Korea introduced mass screening and localised quarantines, and issued alerts on the movements of infected individuals. Singapore provided financial support for those infected who quarantined themselves and imposed large fines for those who failed to do so. Taiwan increased face mask production and penalised hoarding of medical supplies.[458] Simulations for Great Britain and the United States show that mitigation (slowing but not stopping epidemic spread) and suppression (reversing epidemic growth) have major challenges. Optimal mitigation policies might reduce peak healthcare demand by two-thirds and deaths by half, but still result in hundreds of thousands of deaths and overwhelmed health systems. Suppression can be preferred but needs to be maintained for as long as the virus is circulating in the human population (or until a vaccine becomes available), as transmission otherwise quickly rebounds when measures are relaxed. Long-term intervention to suppress the pandemic has considerable social and economic costs.[386] Strategies in the control of an outbreak are containment or suppression, and mitigation. Containment is undertaken in the early stages of the outbreak and aims to trace and isolate those infected as well as introduce other measures of infection control and vaccinations to stop the disease from spreading to the rest of the population. When it is no longer possible to contain the spread of the disease, efforts then move to the mitigation stage: measures are taken to slow the spread and mitigate its effects on the healthcare system and society. A combination of both containment and mitigation measures may be undertaken at the same time.[455] Suppression requires more extreme measures so as to reverse the pandemic by reducing the basic reproduction number to less than 1.[386] Part of managing an infectious disease outbreak is trying to delay and decrease the epidemic peak, known as flattening the epidemic curve.[451] This decreases the risk of health services being overwhelmed and provides more time for vaccines and treatments to be developed.[451] Non-pharmaceutical interventions that may manage the outbreak include personal preventive measures, such as hand hygiene, wearing face masks, and self-quarantine; community measures aimed at physical distancing such as closing schools and cancelling mass gathering events; community engagement to encourage acceptance and participation in such interventions; as well as environmental measures such surface cleaning.[456] More drastic actions aimed at containing the outbreak were taken in China once the severity of the outbreak became apparent, such as quarantining entire cities and imposing strict travel bans.[457] Other countries also adopted a variety of measures aimed at limiting the spread of the virus. South Korea introduced mass screening and localised quarantines, and issued alerts on the movements of infected individuals. Singapore provided financial support for those infected who quarantined themselves and imposed large fines for those who failed to do so. Taiwan increased face mask production and penalised hoarding of medical supplies.[458] Simulations for Great Britain and the United States show that mitigation (slowing but not stopping epidemic spread) and suppression (reversing epidemic growth) have major challenges. Optimal mitigation policies might reduce peak healthcare demand by two-thirds and deaths by half, but still result in hundreds of thousands of deaths and overwhelmed health systems. Suppression can be preferred but needs to be maintained for as long as the virus is circulating in the human population (or until a vaccine becomes available), as transmission otherwise quickly rebounds when measures are relaxed. Long-term intervention to suppress the pandemic has considerable social and economic costs.[386]"
  
  func createPatientReport(mainTitle: String,subTitle:String, sections:[PDFSection]) -> Data {
    
    // 1
    let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
    
    // 2
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .natural
    paragraphStyle.lineBreakMode = .byWordWrapping
    
    // 3
    let textAttributes = [
      NSAttributedString.Key.paragraphStyle: paragraphStyle,
      NSAttributedString.Key.font: textFont
    ]
    
    
    
    //parameter list
    // pageWidth:CGFloat,pageHeight:CGFloat
    // 1
    let pdfMetaData = [
      kCGPDFContextCreator: "RPM",
      kCGPDFContextAuthor: "RPM",
      kCGPDFContextTitle: mainTitle
    ]
    let format = UIGraphicsPDFRendererFormat()
    format.documentInfo = pdfMetaData as [String: Any]
    
    // 3
    let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
    // 4
    let data = renderer.pdfData { (context) in
      // 5
      context.beginPage()
      // 6
      var nextTop:CGFloat = 20;
      
      //            let logo = UIImage(named: "rw-logo")
      //            let headerBottom = addHeader(logo: logo! ,mainTitle: mainTitle, subTitle:subTitle, pageRect: pageRect, textTop: nextTop)
      ////            let titleBottom = addMainTitle(mainTitle: mainTitle,pageRect: pageRect, textTop:nextTop)
      //
      //            //            nextTop = titleBottom + 18.0
      //            nextTop = headerBottom + 10.0
      
      
      
      
      for sect in sections{
        //                addBodyText(body: sect.title,pageRect: pageRect, textTop: nextTop)
        //6
        self.addText( sect.body,context: context)
        nextTop += 5.0
      }
      //      let context = context.cgContext
      //      drawTearOffs(context, pageRect: pageRect, tearOffY: pageRect.height * 4.0 / 5.0, numberTabs: 8)
      //      drawContactLabels(context, pageRect: pageRect, numberTabs: 8)
      
      //          LineAnnotation().draw(with: .mediaBox, in: context as! CGContext)
      
      //          let radioButton = PDFAnnotation(bounds: CGRect(x: 135, y: 200, width: 24, height: 24), forType: .widget, withProperties: nil)
      //          radioButton.widgetFieldType = .button
      //          radioButton.widgetControlType = .radioButtonControl
      //          radioButton.backgroundColor = UIColor.blue
      //          page.addAnnotation(radioButton)
      
    }
    
    return data
  }
  
  func addHeader(logo:UIImage, mainTitle: String, subTitle: String, pageRect: CGRect,textTop: CGFloat) -> CGFloat {
    
    let imageBottom = self.addImage(image:logo,imageX:CGFloat(20),maxHeightRatio:CGFloat(0.8),maxWidthRatio: CGFloat(0.2) ,pageRect:pageRect,imageTop:textTop)
    let headerBottom = self.addTitle(titleText:mainTitle, titleX: CGFloat(pageRect.width * 0.3)   , pageRect:pageRect, textTop:textTop)
    let headerBottom2 = self.addTitle(titleText:subTitle, titleX: CGFloat(pageRect.width * 0.3)   , pageRect:pageRect, textTop:headerBottom + 5 )
    //        return titleStringRect.origin.y + titleStringRect.size.height
    return max(imageBottom,headerBottom)
  }
  
  /**
   - imageX : the starting point of the image x-axis
   - imageTop : the starting point of the image  y-axis
   - maxHeightRatio : eg 0.6 wrt Page Height
   - maxWidthRatio : eg 0.4 wrt Page Width
   
   */
  func addImage(image:UIImage,imageX:CGFloat,maxHeightRatio:CGFloat,maxWidthRatio:CGFloat,pageRect: CGRect, imageTop: CGFloat) -> CGFloat {
    // 1
    let maxHeight = pageRect.height * maxHeightRatio
    let maxWidth = pageRect.width * maxWidthRatio
    // 2
    let aspectWidth = maxWidth / image.size.width
    let aspectHeight = maxHeight / image.size.height
    let aspectRatio = min(aspectWidth, aspectHeight)
    // 3
    let scaledWidth = image.size.width * aspectRatio
    let scaledHeight = image.size.height * aspectRatio
    // 4
    //        let imageX = (pageRect.width - scaledWidth) / 2.0
    let imageRect = CGRect(x: imageX, y: imageTop,
                           width: scaledWidth, height: scaledHeight)
    // 5
    image.draw(in: imageRect)
    return imageRect.origin.y + imageRect.size.height
  }
  
  
  func addTitle(titleText: String,titleX:CGFloat,pageRect: CGRect,textTop: CGFloat) -> CGFloat {
    // 1
    let titleFont = UIFont.systemFont(ofSize: 20.0, weight: .bold)
    // 2
    let titleAttributes: [NSAttributedString.Key: Any] =
      [NSAttributedString.Key.font: titleFont]
    let attributedTitle = NSAttributedString(string: titleText, attributes: titleAttributes)
    // 3
    let titleStringSize = attributedTitle.size()
    // 4
    //        let titleStringRect = CGRect(x: (pageRect.width - titleStringSize.width) / 2.0,
    //                                     y: textTop, width: titleStringSize.width,
    //                                     height: titleStringSize.height)
    let titleStringRect = CGRect(x: titleX,
                                 y: textTop, width: titleStringSize.width,
                                 height: titleStringSize.height)
    
    // 5
    attributedTitle.draw(in: titleStringRect)
    // 6
    
    return titleStringRect.origin.y + titleStringRect.size.height
  }
  
  
  
  @discardableResult
  func addText(_ text : String, context : UIGraphicsPDFRendererContext) -> CGFloat {
    
    // 1
    let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
    
    // 2
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .natural
    paragraphStyle.lineBreakMode = .byWordWrapping
    
    // 3
    let textAttributes = [
      NSAttributedString.Key.paragraphStyle: paragraphStyle,
      NSAttributedString.Key.font: textFont
    ]
    
    //4
    let currentText = CFAttributedStringCreate(nil,
                                               text as CFString,
                                               textAttributes as CFDictionary)
    //5
    let framesetter = CTFramesetterCreateWithAttributedString(currentText!)
    
    //6
    var currentRange = CFRangeMake(0, 0)
    var done = false
    repeat {
      
      //7
      /* Mark the beginning of a new page.*/
      if(currentPage != 0){
        context.beginPage()
      }
      //8
      /*Draw a page number at the bottom of each page.*/
      currentPage += 1
      print("----currentPage = \(currentPage)")
      drawPageNumber(currentPage)
      drawHeader(currentPage)
      drawCustomrName("MenaCare")
      let path = UIBezierPath()
      path.lineWidth = 0.5
      path.move(to: CGPoint(x: 10, y:100))
      path.addLine(to: CGPoint(x: pageRect.width-10 , y: 100))
      UIColor.systemGray.setStroke()
      path.stroke()
      
      //9
      /*Render the current page and update the current range to
       point to the beginning of the next page. */
      currentRange = self.renderPage(currentPage,
                                withTextRange: currentRange,
                                andFramesetter: framesetter)
      
      //10
      /* If we're at the end of the text, exit the loop. */
      if currentRange.location == CFAttributedStringGetLength(currentText) {
        done = true
      }
      
    } while !done
    
    return CGFloat(currentRange.location + currentRange.length)
  }
  
  func drawCustomrName(_ customerName: String) {
    
    // 1
    let maxHeight = pageRect.height * logoMaxHeightRatio
    let maxWidth = pageRect.width * logoMaxWidthRatio
    
    // 2
    let aspectWidth = maxWidth / self.logoImage!.size.width
    let aspectHeight = maxHeight / self.logoImage!.size.height
    let aspectRatio = min(aspectWidth, aspectHeight)
    // 3
    let scaledWidth = self.logoImage!.size.width * aspectRatio
    let scaledHeight = self.logoImage!.size.height * aspectRatio
    
    
    
    let theFont = UIFont.systemFont(ofSize: 40, weight: .bold)
    
    let pageString = NSMutableAttributedString(string: "\(customerName)")
    pageString.addAttribute(NSAttributedString.Key.font, value: theFont, range: NSRange(location: 0, length: pageString.length))
    
    let pageStringSize =  pageString.size()
    
    let stringRect = CGRect(x: headerMarginPoint.x + scaledWidth + 5,
                            y: headerMarginPoint.y,
                            width: pageStringSize.width,
                            height: pageStringSize.height)
    
    pageString.draw(in: stringRect)
    
    //PART-II
    let pageString2 = NSMutableAttributedString(string: "Transforming Care around the world")
    // 1
    let maxSubTextHeight = 20
    let maxSubTextWidth = stringRect.width
    
    // 2
    let aspectSubHeadWidth = maxSubTextWidth / CGFloat(pageString2.length)
    let aspectSubHeadHeight = maxSubTextHeight
    let aspectSubHeadRatio = min(aspectWidth, aspectHeight)
    // 3
    let scaledSubHeadWidth = CGFloat(pageString2.length) * aspectSubHeadRatio
    let scaledSubHeadHeight = maxSubTextHeight
    let theFont2 = UIFont.systemFont(ofSize: 15, weight: .bold)
    
    pageString2.addAttribute(NSAttributedString.Key.font, value: theFont2, range: NSRange(location: 0, length: Int(scaledSubHeadWidth)))
//    pageString2.addAttribute(NSAttributedString.Key.expansion, value: 1, range: NSRange(location: 1, length: 1))
    
    let pageStringSize2 =  pageString2.size()
    
    let stringRect2 = CGRect(x: headerMarginPoint.x + scaledWidth + 5,
                             y: headerMarginPoint.y + stringRect.height,
                            width: stringRect.width,
                            height: 20)
    
    pageString2.draw(in: stringRect2)
    
  }
  
  
  func addBodyText(body:String,pageRect: CGRect, textTop: CGFloat) {
    // 1
    let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
    // 2
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .natural
    paragraphStyle.lineBreakMode = .byWordWrapping
    // 3
    let textAttributes = [
      NSAttributedString.Key.paragraphStyle: paragraphStyle,
      NSAttributedString.Key.font: textFont
    ]
    let attributedText = NSAttributedString(string: body, attributes: textAttributes)
    // 4
    let textRect = CGRect(x: 10, y: textTop, width: pageRect.width - 20,
                          height: pageRect.height - textTop - pageRect.height / 5.0)
    attributedText.draw(in: textRect)
  }
  
  
  
  
  
  func renderPage(_ pageNum: Int, withTextRange currentRange: CFRange, andFramesetter framesetter: CTFramesetter?) -> CFRange {
    var currentRange = currentRange
    // Get the graphics context.
    let currentContext = UIGraphicsGetCurrentContext()
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    currentContext?.textMatrix = .identity
    
    // Create a path object to enclose the text. Use 72 point
    // margins all around the text.
    let frameRect = CGRect(x: self.marginPoint.x, y: 20, width: self.pageWidth - self.marginSize.width, height: self.pageHeight - 130)
    let framePath = CGMutablePath()
    framePath.addRect(frameRect, transform: .identity)
    
    // Get the frame that will do the rendering.
    // The currentRange variable specifies only the starting point. The framesetter
    // lays out as much text as will fit into the frame.
    let frameRef = CTFramesetterCreateFrame(framesetter!, currentRange, framePath, nil)
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    currentContext?.translateBy(x: 0, y: self.pageHeight)
    currentContext?.scaleBy(x: 1.0, y: -1.0)
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext!)
    
    // Update the current range based on what was drawn.
    currentRange = CTFrameGetVisibleStringRange(frameRef)
    currentRange.location += currentRange.length
    currentRange.length = CFIndex(0)
    
    return currentRange
  }
  
  func drawPageNumber(_ pageNum: Int) {
    
    let theFont = UIFont.systemFont(ofSize: 20)
    
    let pageString = NSMutableAttributedString(string: "--\(pageNum)--")
    pageString.addAttribute(NSAttributedString.Key.font, value: theFont, range: NSRange(location: 0, length: pageString.length))
    
    let pageStringSize =  pageString.size()
    
    let stringRect = CGRect(x: (pageRect.width - pageStringSize.width) / 2.0,
                            y: pageRect.height - (pageStringSize.height) / 2.0 - 15,
                            width: pageStringSize.width,
                            height: pageStringSize.height)
    
    pageString.draw(in: stringRect)
    
  }
  
  func drawHeader(_ pageNum: Int) {
    
    
//    let theFont = UIFont.systemFont(ofSize: 20)
//
//    let pageString = NSMutableAttributedString(string: "--\(pageNum)--")
//    pageString.addAttribute(NSAttributedString.Key.font, value: theFont, range: NSRange(location: 0, length: pageString.length))
//
//    let pageStringSize =  pageString.size()
//
//    let stringRect = CGRect(x: (pageRect.width - pageStringSize.width) / 2.0,
//                            y: pageRect.height - (pageStringSize.height) / 2.0 - 15,
//                            width: pageStringSize.width,
//                            height: pageStringSize.height)
//
//    pageString.draw(in: stringRect)
    
      // 1
      let maxHeight = pageRect.height * logoMaxHeightRatio
      let maxWidth = pageRect.width * logoMaxWidthRatio
      // 2
      let aspectWidth = maxWidth / self.logoImage!.size.width
      let aspectHeight = maxHeight / self.logoImage!.size.height
      let aspectRatio = min(aspectWidth, aspectHeight)
      // 3
      let scaledWidth = self.logoImage!.size.width * aspectRatio
      let scaledHeight = self.logoImage!.size.height * aspectRatio
      // 4
      //        let imageX = (pageRect.width - scaledWidth) / 2.0
      let imageRect = CGRect(x: headerMarginPoint.x, y: headerMarginPoint.y,
                             width: scaledWidth, height: scaledHeight)
      // 5
      self.logoImage!.draw(in: imageRect)
      
      
    }
    
    // 1
    func drawTearOffs(_ drawContext: CGContext, pageRect: CGRect,
                      tearOffY: CGFloat, numberTabs: Int) {
      // 2
      drawContext.saveGState()
      drawContext.setLineWidth(2.0)
      
      // 3
      drawContext.move(to: CGPoint(x: 0, y: tearOffY))
      drawContext.addLine(to: CGPoint(x: pageRect.width, y: tearOffY))
      drawContext.strokePath()
      drawContext.restoreGState()
      
      // 4
      drawContext.saveGState()
      let dashLength = CGFloat(72.0 * 0.2)
      drawContext.setLineDash(phase: 0, lengths: [dashLength, dashLength])
      // 5
      let tabWidth = pageRect.width / CGFloat(numberTabs)
      for tearOffIndex in 1..<numberTabs {
        // 6
        let tabX = CGFloat(tearOffIndex) * tabWidth
        drawContext.move(to: CGPoint(x: tabX, y: tearOffY))
        drawContext.addLine(to: CGPoint(x: tabX, y: pageRect.height))
        drawContext.strokePath()
      }
      // 7
      drawContext.restoreGState()
    }
    
    func drawContactLabels(contactInfo: String ,_ drawContext: CGContext, pageRect: CGRect, numberTabs: Int) {
      let contactTextFont = UIFont.systemFont(ofSize: 10.0, weight: .regular)
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .natural
      paragraphStyle.lineBreakMode = .byWordWrapping
      let contactBlurbAttributes = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: contactTextFont
      ]
      let attributedContactText = NSMutableAttributedString(string: contactInfo, attributes: contactBlurbAttributes)
      // 1
      let textHeight = attributedContactText.size().height
      let tabWidth = pageRect.width / CGFloat(numberTabs)
      let horizontalOffset = (tabWidth - textHeight) / 2.0
      drawContext.saveGState()
      // 2
      drawContext.rotate(by: -90.0 * CGFloat.pi / 180.0)
      for tearOffIndex in 0...numberTabs {
        let tabX = CGFloat(tearOffIndex) * tabWidth + horizontalOffset
        // 3
        attributedContactText.draw(at: CGPoint(x: -pageRect.height + 5.0, y: tabX))
      }
      drawContext.restoreGState()
    }
}


