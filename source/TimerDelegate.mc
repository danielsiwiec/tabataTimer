using Toybox.WatchUi as Ui;

class TimerDelegate extends Ui.BehaviorDelegate {

	var model;

    function initialize(mdl) {
    	model = mdl;
        BehaviorDelegate.initialize();
    }

    function onSelect() {
    	if (!model.started){
    		model.start();
    	}
        return true;
    }

}