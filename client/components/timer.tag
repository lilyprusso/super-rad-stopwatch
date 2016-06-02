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
		font-size: 20px;
		font-family:Baskerville;
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
		<br>
		<button onclick={ toggleTimer }>{ controlName }</button>
		<button onclick={ reset }>Reset</button>
		<button onclick={ addFinish } if={ timerActive }>Finish</button> 
		<br>
		<br>
		<button onclick={ saveTime }>Save</button>
		<br>
		<br>
		<div>
			<span>{ finish.length } Runner<span if={ finish.length !== 1 }>s</span> Finished</span>
		</div>
	</div>


	<script>



	var self = this;

	self.controlName = 'Start';
	self.finish = [];
	var _start = 0;
	var _elapsed = 0;

	self.toggleTimer = function () {
		self.timerActive = !self.timerActive;
		if (!self.timerActive) {
			_elapsed = (new Date() - _start)/10 + _elapsed;
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
			self.update();
		}, 10);
	};

	self.killTimer = function () {
		clearInterval(self.interval);
	};

	self.reset = function () {
		_start = new Date();
		_elapsed = 0;
		self.writeTime(0);
		self.update();
		self.killTimer();
		self.controlName = 'Start';
		self.timerActive = false
	};

	self.writeTime = function (time) {
		self.time = numeral(time).format('00:00:00:00');
		self.update();
	};

	self.addFinish = function () {
		self.finish.push(self.time);
		self.update();
	};

	self.saveTime = function(){
		// var name = prompt("Enter Timer Name")
		// self.killTimer();
		// self.controlName = 'Start';
		// self.timerActive = false;
		// var data = {
		// 	name: name,
		// 	time: self.time,
		// 	timestamp: new Date(),			
		// };
		// console.log(data)
	}

	self.writeTime(0);
		</script>
</timer>