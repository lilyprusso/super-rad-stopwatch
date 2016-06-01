<timer>
	<style type="text/css">
	.wrapper {
		max-width: 250px;
		margin: 0 auto;
	}

	ul li {
		text-align: left;
	}

	ul {
		margin: 0 50px;
	}
	h1{
		color:white;
		font-family: Baskerville;
	}
	button{
		width:70px; 
		height:40px;
		border-radius:8px;
		background-color: Transparent;
		background-repeat:no-repeat;
    	border: 2px solid white;
    	color:white;
    	cursor:pointer;
    	overflow: hidden;
    	outline:none;
    	font-size: 15px
}
	button:hover{
		background-color:white;
		color:black;
	}
	span{
		color:white;
		font-size: 30px;
	}
	h2{
		color:white;
		font-family:Baskerville;
	}
	ul {
		list-style-type: none;
	}
	li {
		text-align:center;
		color: #fff;
	}

	</style>
	<div class="wrapper">
		<span>{ time }</span>
		<br>
		<span>{ lap }</span>
		<br>
		<br>
		<button onclick={ toggleTimer }>{ controlName }</button>
		<button onclick={ reset }>Reset</button>
		<button onclick={ addLap } if={ timerActive }>Lap</button> 

		<h2>laps</h2>
		<ul id="laps">
			<li if={ !laps.length }></li>
			<li each={ o, i in laps }>&bull; { o }</li>
		</ul>		
	</div>

	<script>
	var self = this;

	self.controlName = 'Start';
	self.laps = [];
	var _start = 0;
	var _elapsed = 0;
	var _lap_elapsed = 0;
	var _lap = 0;

	self.toggleTimer = function () {
		self.timerActive = !self.timerActive;
		if (!self.timerActive) {
			_elapsed = (new Date() - _start)/10 + _elapsed;
			_lap_elapsed = (new Date() - _lap)/10 + _lap_elapsed;
			self.controlName = 'Start';
			self.killTimer();
		} else {
			_start = new Date();
			_lap = _start;
			self.controlName = 'Stop';
			self.runTimer();
		}
	};

	self.runTimer = function () {
		self.interval = setInterval(function () {
			self.writeTime((new Date() - _start)/10 + _elapsed);
			self.writeLap((new Date() - _lap)/10 + _lap_elapsed);
			self.update();
		}, 10);
	};

	self.killTimer = function () {
		clearInterval(self.interval);
	};

	self.reset = function () {
		_start = new Date();
		_elapsed = 0;
		_lap_elapsed = 0;
		self.writeTime(0);
		self.writeLap(0);
		self.laps = [];
		self.update();
	};

	self.writeTime = function (time) {
		self.time = numeral(time).format('00:00:00:00');
		self.update();
	};

	self.writeLap = function (time) {
		self.lap = numeral(time).format('00:00:00:00');
		self.update();
	};

	self.addLap = function () {
		self.laps.push(self.lap);
		_lap = new Date();
		_lap_elapsed = 0;
		self.lap = 0;
		self.update();
	};

	self.writeTime(0);
	self.writeLap(0);
	</script>
</timer>