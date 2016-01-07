using Toybox.Timer as Timer;
using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;

class Model{

	const WORK_TIME = 20;
	const REST_TIME = 10;
	const TOTAL_ROUNDS = 8;
	
	var started = false;
	var round = 0;
	var phase = :rest;
	var done = false;
	var phaseTimer = new Timer.Timer();
	var startTime;
	var timer = new Timer.Timer();
	var minutesFromStart = 0;
	var secodsFromStart = 0;

	function start(){
		startTime = Toybox.System.getTimer();
		timer.start(method(:onTimer), 1000, true);
		phaseTimer.start(method(:onPhaseTimer), REST_TIME*1000, false);
		started = true;
		buzz(1000);
		Ui.requestUpdate();
	}
	
	// show elapsed time
	function onTimer(){
		Ui.requestUpdate();
	}
	
	function onPhaseTimer(){
		if (phase == :rest){
			if (round == TOTAL_ROUNDS) {
				done = true;
				timer.stop();
				phaseTimer.stop();
				buzz(1500);
			} else {
				resetTimer(WORK_TIME);
				phase = :work;
				round = round + 1;
				buzz(500);
			}
		} else {
			resetTimer(REST_TIME);
			phase = :rest;
			buzz(500);
		}
		Ui.requestUpdate();
	}
	
	function resetTimer(seconds){
		phaseTimer.start(method(:onPhaseTimer), seconds*1000, false);
	}
	
	function buzz(duration){
		//Toybox.System.println("Buzzed on: " + timerString());
		var vibrateData = [ new Attention.VibeProfile(  100, duration ) ];
	    Attention.vibrate( vibrateData );
	}
	
	function timerString(){
		if (started){
			var elapsedMillis = Toybox.System.getTimer() - startTime;
	    	var seconds = elapsedMillis / 1000;
	    	var minutes = seconds/60;
	    	var secondsOfAMinute = seconds - minutes * 60;
	    	return minutes.format("%d") + ":" + secondsOfAMinute.format("%02d");
		} else {
			return "0:00";
		}
		
	}
}