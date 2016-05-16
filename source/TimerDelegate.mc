using Toybox.WatchUi as Ui;

class TimerDelegate extends Ui.InputDelegate {

	hidden var model;
	hidden var started = false;

  function initialize(mdl) {
  	model = mdl;
    InputDelegate.initialize();
  }

	function onKey(evt) {
		if(evt.getKey() == Ui.KEY_ENTER && !started) {
  		model.start();
			started = true;
			return true;
		} else {
			return InputDelegate.onKey(evt);
		}
	}
}
