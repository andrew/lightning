class TimerView < UIView
  def drawRect(rect)
    @duration ||= default_time
    percentage = 1 - (@duration/default_time)

    UIColor.colorWithRed(percentage, green:0, blue:0, alpha:1.0).set
    UIBezierPath.bezierPathWithRect(rect).fill

    font_size = rect.size.width/3
    font = UIFont.boldSystemFontOfSize(font_size)
    UIColor.whiteColor.set

    text = Time.at(@duration).gmtime.strftime('%M:%S')
    constrain = CGSize.new(rect.size.width, rect.size.height)
    size = text.sizeWithFont(font, constrainedToSize:constrain)

    x = (rect.size.width - size.width)/2
    y = (rect.size.height - size.height)/2

    text.drawAtPoint(CGPoint.new(x, y), withFont: font)
  end

  def touchesEnded(touches, withEvent:event)
    if @duration < 0.1
      @duration = default_time 
      setNeedsDisplay
    elsif @timer
      @timer.invalidate
      @timer = nil
    else
      @timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:'timerFired', userInfo:nil, repeats:true)
    end
  end

  def default_time
    5*60.0
  end

  def timerFired
    if @duration < 0.1
      @timer.invalidate
      @timer = nil
    else
      @duration -= 0.1
    end
    setNeedsDisplay
  end
end