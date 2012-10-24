class TimerController < UIViewController
  def loadView
    self.view = UIView.new
  end

  def viewDidLoad
    @paused = true
    @duration = default_time

    initialize_label
    update_label
    initalize_pref_button
  end

  def initialize_label
    constrain = CGSize.new(view.frame.size.width, view.frame.size.height)
    size = label_text.sizeWithFont(font, constrainedToSize:constrain)

    x = (view.frame.size.width - size.width)/2
    y = (view.frame.size.height - size.height)/2

    @label = UILabel.alloc.initWithFrame([[x,y], [size.width, view.frame.size.height]])
    @label.font = font
    @label.userInteractionEnabled = true
    @label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
    @label.addGestureRecognizer(double_tap)
    @label.addGestureRecognizer(single_tap)

    self.view.addSubview @label
  end
  
  def initalize_pref_button
    @pref_button = UIButton.buttonWithType(UIButtonTypeInfoLight)
    @pref_button.addTarget(self, action:'showPreferences', forControlEvents:UIControlEventTouchUpInside)
    @pref_button.frame = [[view.frame.size.width - 40, view.frame.size.height - 40], [20, 20]]
    
    self.view.addSubview(@pref_button)
  end
  
  def label_text
    Time.at(@duration).gmtime.strftime('%M:%S')
  end
  
  def font
    font_size = view.frame.size.width/3
    UIFont.boldSystemFontOfSize(font_size)
  end
  
  def background_color
    percentage = 1 - (@duration/default_time)
    UIColor.colorWithRed(percentage, green:0, blue:0, alpha:1.0)
  end
  
  def label_color
    UIColor.colorWithRed(1, green:1, blue:1, alpha:(@paused ? 0.3 : 1.0))
  end
  
  def single_tap
    tap = UITapGestureRecognizer.alloc.initWithTarget(self, action: :'tapped:')
    tap.requireGestureRecognizerToFail(double_tap)
    return tap
  end
  
  def double_tap
    doubletap = UITapGestureRecognizer.alloc.initWithTarget(self, action: :'reset:')
    doubletap.numberOfTapsRequired = 2
    return doubletap
  end
  
  def update_label
    self.view.backgroundColor = background_color
    @label.text = label_text
    @label.backgroundColor = background_color
    @label.color = label_color
  end

  def tapped(sender)
    if @timer || @duration < 0.1
      @duration = default_time if @duration < 0.1
      pause
    else
      @paused = false
      @timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:'timerFired', userInfo:nil, repeats:true)
      update_label
    end
  end

  def reset(sender)
    @duration = default_time
    pause
  end

  def shouldAutorotateToInterfaceOrientation(*)
    true
  end

  def default_time
    5*60.0
  end

  def removeTimer
    @timer.invalidate unless @timer.nil?
    @timer = nil
  end

  def timerFired
    if @duration < 0.1
      time_out
    else
      @duration -= 0.1
      update_label
    end
  end
  
  def pause
    @paused = true
    removeTimer
    update_label
  end

  def time_out
    removeTimer
    play_buzzer
  end

  def play_buzzer
    BW::Media.play(NSURL.fileURLWithPath(File.join(NSBundle.mainBundle.resourcePath, 'buzzer.wav'))) {}
  end
  
  def showPreferences
    pause
    new_controller = PreferencesController.alloc.init
    new_controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal
    self.presentModalViewController(new_controller, animated: true)
  end
end