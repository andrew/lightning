class PreferencesController < UIViewController
  def viewDidLoad
    super
    self.view.addSubview @label

    self.view.backgroundColor = UIColor.colorWithRed(255, green:255, blue:255, alpha:0.8  )

    @action = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @action.setTitle('Save', forState:UIControlStateNormal)
    @action.addTarget(self, action:'actionTapped', forControlEvents:UIControlEventTouchUpInside)
    @action.frame = [[20, 300], [view.frame.size.width - 20 * 2, 40]]
    self.view.addSubview(@action)

    @label = UILabel.alloc.initWithFrame(CGRectZero)
    @label.text = "Trolololo"
    @label.sizeToFit
    @label.backgroundColor = UIColor.colorWithRed(255, green:255, blue:255, alpha:0)
    @label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
    self.view.addSubview @label
  end
  
  def actionTapped
    dismissModalViewControllerAnimated(true)
  end
end