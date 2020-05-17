

import Foundation
import PDFKit

class LineAnnotation: PDFAnnotation {
  override func draw(with box: PDFDisplayBox, in context: CGContext) {
    // Draw original content under the new content.
    super.draw(with: box, in: context)
    
    // Draw a custom purple line.
    UIGraphicsPushContext(context)
    context.saveGState()
    
    let path = UIBezierPath()
    path.lineWidth = 10
    path.move(to: CGPoint(x: bounds.minX + startPoint.x, y: bounds.minY + startPoint.y))
    path.addLine(to: CGPoint(x: bounds.minX + endPoint.x, y: bounds.minY + endPoint.y))
    UIColor.systemPurple.setStroke()
    path.stroke()
    
    context.restoreGState()
    UIGraphicsPopContext()
  }
}
