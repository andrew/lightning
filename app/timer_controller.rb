class TimerController < UIViewController
  def loadView
    self.view = TimerView.alloc.init
  end

  def shouldAutorotateToInterfaceOrientation(*)
    true
  end
end