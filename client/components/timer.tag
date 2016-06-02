<timer>
    <style type="text/css">
    .wrapper {
        max-width: 900px;
        margin: 0 auto;
    }

    ul li {
        text-align: left;
    }

    ul {
        margin: 0 100px;
    }
    h1{
        color:white;
        font-family: Baskerville;
        font-size:50px;
    }
    button{
        width:140px; 
        height:80px;
        border-radius:16px;
        background-color: Transparent;
        background-repeat:no-repeat;
        border: 4px solid white;
        color:white;
        cursor:pointer;
        overflow: hidden;
        outline:none;
        font-size: 30px
}
    button:hover{
        background-color:white;
        color:black;
    }
    span{
        color:white;
        font-size: 40px;
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
        <span style="font-size:90px">{ time }</span>
        <br>
        <br>
        <button onclick={ toggleTimer }>{ controlName }</button>
        <button onclick={ reset }>Reset</button>
        <button onclick={ addFinish } if={ timerActive }>Finish</button> 
        <br>
        <br>
        <form method="POST" action="/export" target="_blank">
            <input type="hidden" name="finishers" />
            <button onclick={ saveTime }>Save</button>
        </form>
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

    document.onkeyup = function (e) {
        if (e.keyCode == 32) {
            console.log("**space**");
            self.addFinish();
        }
    };

    self.runTimer = function () {
        self.interval = setInterval(function () {
            self.writeTime((new Date() - _start)/10 + _elapsed);
            self.update();
        }, 10);
    };

    self.killTimer = function () {
        self.controlName = 'Start';
        self.timerActive = false;
        clearInterval(self.interval);
        self.update();
    };

    self.reset = function () {
        _start = new Date();
        _elapsed = 0;
        self.writeTime(0);
        self.update();
        self.killTimer();
        self.finish =[]
    };

    self.writeTime = function (time) {
        self.time = numeral(time).format('00:00:00:00');
        self.update();
    };

    self.addFinish = function () {
        if(self.timerActive === false){
            alert("Timer must be running in order to finish a runner");
            return;
        }
        self.finish.push(self.time);
        self.update();
    };

    self.saveTime = function(e){
        self.killTimer();
        self.finishers.value = self.finish;
        e.parent.submit();
    }

    self.writeTime(0);
        </script>
</timer>