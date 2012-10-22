class PreferencesView < UIView
  def drawRect(rect)
    UIColor.colorWithRed(1, green:1, blue:1, alpha:1.0).set
    UIBezierPath.bezierPathWithRect(rect).fill
  end
  
  def touchesEnded(touches, withEvent:event)
    
  end
end