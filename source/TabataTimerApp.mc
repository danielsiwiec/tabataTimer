using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class TabataTimerApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }


    //! Return the initial view of your application here
    function getInitialView() {
        return [ new SplitView(), new SplitDelegate() ];
    }

}
