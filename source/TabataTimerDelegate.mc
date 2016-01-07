using Toybox.WatchUi as Ui;

class TabataTimerDelegate extends Ui.BehaviorDelegate {

	var model;

    function initialize(mdl) {
    	model = mdl;
        BehaviorDelegate.initialize();
    }

    function onSelect() {
    	Toybox.System.println("Clicked start");
        model.start();
        return true;
    }

}