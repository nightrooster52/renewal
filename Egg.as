﻿package  {		import flash.display.MovieClip;	import flash.events.Event;			public class Egg extends MovieClip {				private var _main:Main;		public function Egg(main:Main) {			this._main = main;			addEventListener(Event.ENTER_FRAME, update);		}		private function update(evt:Event):void{			checkSnakeHit();		}				public function checkSnakeHit():void{			if (_main.snake != null){				if (hitTestObject(_main.snake.head)){					removeEventListener(Event.ENTER_FRAME, update);					parent.removeChild(this);					_main.snake.grow();				}			}					}	}	}