﻿package  {		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;	public class SnakeEgg extends MovieClip {				private var _main:Main;		public function SnakeEgg(main:Main) {				this._main = main;			addEventListener(MouseEvent.CLICK, playMe);		}		private function playMe(evt:Event):void{			removeEventListener(MouseEvent.CLICK, playMe);			this.play();			addEventListener(Event.ENTER_FRAME, checkIfDone);		}		private function checkIfDone(evt:Event):void{			if (this.currentFrame == this.totalFrames-1){				removeEventListener(Event.ENTER_FRAME, checkIfDone);				this.stop();				_main.spawnSnake();			}		}	}	}