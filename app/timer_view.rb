class TimerView < UIView
  def drawRect(rect)
    @paused = true if @paused.nil?
    @duration ||= default_time
    percentage = 1 - (@duration/default_time)

    UIColor.colorWithRed(percentage, green:0, blue:0, alpha:1.0).set
    UIBezierPath.bezierPathWithRect(rect).fill

    font_size = rect.size.width/3
    font = UIFont.boldSystemFontOfSize(font_size)
    UIColor.colorWithRed(1, green:1, blue:1, alpha:(@paused ? 0.3 : 1.0)).set

    text = Time.at(@duration).gmtime.strftime('%M:%S')
    constrain = CGSize.new(rect.size.width, rect.size.height)
    size = text.sizeWithFont(font, constrainedToSize:constrain)

    x = (rect.size.width - size.width)/2
    y = (rect.size.height - size.height)/2

    text.drawAtPoint(CGPoint.new(x, y), withFont: font)
  end

  def touchesEnded(touches, withEvent:event)
    touch = event.touchesForView(self).anyObject
    if @duration < 0.1 || touch.tapCount > 1
      @duration = default_time
      @paused = true
    elsif @timer
      @paused = true
      @timer.invalidate
      @timer = nil
    else
      @paused = false
      @timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:'timerFired', userInfo:nil, repeats:true)
    end
    setNeedsDisplay
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