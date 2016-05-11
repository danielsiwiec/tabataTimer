using Toybox.Timer as Timer;
using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;
using Toybox.ActivityRecording as ActivityRecording;
using Toybox.Sensor as Sensor;

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
	var sensors = Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
	var session = ActivityRecording.createSession({:sport => ActivityRecording.SPORT_TRAINING, :subSport => ActivityRecording.SUB_SPORT_CARDIO_TRAINING, :name => "Tabata"});

	function start(){
		session.start();
		startTime = Toybox.System.getTimer();
		timer.start(method(:onTimer), 1000, true);
		phaseTimer.start(method(:onPhaseTimer), REST_TIME*1000, false);
		started = true;
		buzz(1000);
		Ui.requestUpdate();
	}

	function onTimer(){
		Ui.requestUpdate();
	}

	function onPhaseTimer(){
		if (phase == :rest){
			if (round == TOTAL_ROUNDS) {
				done = true;
				session.stop();
				session.save();
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
		var vibrateData = [ new Attention.VibeProfile(  100, duration ) ];
	    Attention.vibrate( vibrateData );
			Attention.playTone(Attention.TONE_TIME_ALERT);
	}

	function timerString(){
		var minutes = 0;
		var secondsOfAMinute = 0;
		if (started){
			var seconds = (Toybox.System.getTimer() - startTime) / 1000;
	    	seconds = (REST_TIME - seconds).abs();

			minutes = seconds/60;
		    secondsOfAMinute = seconds - minutes * 60;

		} else {
			secondsOfAMinute = REST_TIME;
		}
		return minutes.format("%d") + ":" + secondsOfAMinute.format("%02d");
	}
}
