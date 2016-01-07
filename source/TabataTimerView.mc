using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class TabataTimerView extends Ui.View {

    var model;
    
    function initialize(mdl) {
    	model = mdl;
        View.initialize();
    }

    function onUpdate(dc) {
    	setupDisplay(dc);
    	if (model.running){
    		updateTime(dc);
	    	bottomText("" + model.round, dc);
	    	if (model.phase == :rest){
	    		topText("rest", dc);
	    	} else {
	    		topText("work", dc);
	    	}
    	} else if (model.done){
    		middleText("DONE!", dc);
    	} else {
    		middleText("Press START", dc);
    	}
    }
    
    function updateTime(dc){
    	largeText(model.timerString(), dc);
    	
    }
    
    function setupDisplay(dc){
    	dc.setColor( Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
    }
    
    function topText(text, dc){
    	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.1, Gfx.FONT_LARGE, text, Gfx.TEXT_JUSTIFY_CENTER);
    }
    
    function bottomText(text, dc){
    	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.8, Gfx.FONT_LARGE, text, Gfx.TEXT_JUSTIFY_CENTER);
    }
    
    function largeText(text, dc){
    	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.25, Gfx.FONT_NUMBER_THAI_HOT, text, Gfx.TEXT_JUSTIFY_CENTER);
    }
    
    function middleText(text, dc){
    	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.4, Gfx.FONT_LARGE, text, Gfx.TEXT_JUSTIFY_CENTER);
    }


}
