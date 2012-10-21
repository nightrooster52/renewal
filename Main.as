﻿package {	import flash.events.*;	import flash.ui.Mouse;	import flash.geom.ColorTransform;	import fl.motion.Color;	import flash.filters.*;	import flash.display.Shape;	import flash.display.Sprite;	public class Main extends Sprite {				var snake:Snake;		var snakeEgg:SnakeEgg;		var tileArray:Vector.<Tile >  = new Vector.<Tile > (0);		var tileSize:int = 1000;		var currentTile:Tile;		var xOffset:int;		var yOffset:int;		var maxSpeed:int = 20;		var speed:int = 20;		var scene:Sprite = new Sprite();		public function Main() {			addEventListener(Event.ADDED_TO_STAGE, init);		}		private function init(evt:Event):void {			removeEventListener(Event.ADDED_TO_STAGE, init);			//make snake egg			this.snakeEgg = new SnakeEgg(this);			snakeEgg.scaleX = .8;			snakeEgg.scaleY = .8;			snakeEgg.x = CONSTANTS.STAGEWIDTH/2;			snakeEgg.y = CONSTANTS.STAGEHEIGHT/2 - 50;			snakeEgg.stop();						//make starting eggs									this.snake = new Snake();						addChild(scene);												tileArray.push(new Tile(this, 0, 0));			currentTile = tileArray[0];			scene.addChild(tileArray[0]);						var nest:Nest = new Nest();						nest.x = CONSTANTS.STAGEWIDTH/2;			nest.y = CONSTANTS.STAGEHEIGHT/2;			scene.addChild(nest);									scene.addChild(snake);			snake.visible = false;			scene.addChild(snakeEgg);			snakeEgg.buttonMode = true;						makeEggs();			addEventListener(MouseEvent.CLICK, snakeGrow);		}		private function makeEggs(){			for (var i:uint = 0; i < 6; i++){				var egg:Egg = new Egg(this);				egg.x = Math.random()*400+200;				egg.y = Math.random()*400+200;				egg.rotation = Math.random()*360;				scene.addChild(egg);							}		}		private function snakeGrow(evt:Event):void{			snake.grow();		}		public function spawnSnake():void{			snake.visible = true;			for(var i:uint = 0; i < 3; i++){				snake.grow();			}			scene.addChild(snakeEgg);			snakeEgg.mouseEnabled = false			scene.addChild(snake);			addEventListener(Event.ENTER_FRAME, update);		}		private function update(evt:Event):void {			updateMovement();		}		public function populateNeighbors(tile):void {			var targetX:int;			var targetY:int;			var tileX:int = tile.x / tileSize;			var tileY:int = tile.y / tileSize;			var top:Boolean = false;			var bottom:Boolean = false;			var left:Boolean = false;			var right:Boolean = false;			var tl:Boolean = false;			var tr:Boolean = false;			var bl:Boolean = false;			var br:Boolean = false;			for (var i:uint = 0; i < tileArray.length; i++) {				targetX = tileArray[i].x / tileSize;				targetY = tileArray[i].y / tileSize;				if (tileX == targetX && tileY -1 == targetY) {					top = true;				} else if (tileX == targetX && tileY +1 == targetY) {					bottom = true;				} else if (tileX +1 == targetX && tileY == targetY) {					right = true;				} else if (tileX -1 == targetX && tileY == targetY) {					left = true;				} else if (tileX -1 == targetX && tileY -1 == targetY) {					tl = true;				} else if (tileX +1 == targetX && tileY -1 == targetY) {					tr = true;				} else if (tileX -1 == targetX && tileY +1 == targetY) {					bl = true;				} else if (tileX +1 == targetX && tileY +1 == targetY) {					br = true;				}			}						var newTile:Tile;			if (!top){				newTile = new Tile(this, (tileX)*tileSize, (tileY-1)*tileSize);				scene.addChild(newTile);				tileArray.push(newTile);			}			if (!bottom){				newTile = new Tile(this, (tileX)*tileSize, (tileY+1)*tileSize);				scene.addChild(newTile);				tileArray.push(newTile);			}			if (!right){				newTile = new Tile(this, (tileX + 1)*tileSize, (tileY)*tileSize);				scene.addChild(newTile);				tileArray.push(newTile);			}			if (!left){				newTile = new Tile(this, (tileX-1)*tileSize, (tileY)*tileSize);				scene.addChild(newTile);				tileArray.push(newTile);			}			if (!tl){				newTile = new Tile(this, (tileX-1)*tileSize, (tileY-1)*tileSize);				scene.addChild(newTile);				tileArray.push(newTile);			}			if (!tr){				newTile = new Tile(this, (tileX+1)*tileSize, (tileY-1)*tileSize);				scene.addChild(newTile);				tileArray.push(newTile);			}			if (!bl){				newTile = new Tile(this, (tileX-1)*tileSize, (tileY+1)*tileSize);				scene.addChild(newTile);				tileArray.push(newTile);			}			if (!br){				newTile = new Tile(this, (tileX+1)*tileSize, (tileY+1)*tileSize);				scene.addChild(newTile);				tileArray.push(newTile);			}			scene.addChild(snake);			//trace(tileArray.length);		}		public function removeTile(tile:Tile):void{			var delIndex:int = tileArray.indexOf(tile);			scene.removeChild(tile);			//tileArray[delIndex].visible = false;			tileArray.splice(delIndex, 1);			//trace("tile Removed");			//trace(tileArray.length);									}				public function snakePause():void{				speed = 0;				addEventListener(Event.ENTER_FRAME, increaseSpeed);		}		private function increaseSpeed(evt:Event):void{			if (speed < maxSpeed){				speed += 1;			}else{				removeEventListener(Event.ENTER_FRAME, increaseSpeed);			}		}		public function updateMovement():void {			//motion between 0-1, proportionate to distance from center of screen			var xMotion:Number = (CONSTANTS.STAGEWIDTH/2 - stage.mouseX)/(CONSTANTS.STAGEWIDTH/2);			var yMotion:Number = (CONSTANTS.STAGEHEIGHT/2 - stage.mouseY)/(CONSTANTS.STAGEHEIGHT/2);			xOffset +=  xMotion * speed;			yOffset +=  yMotion * speed;			scene.x = xOffset;			scene.y = yOffset;			var snakeXgoal:int =  -xOffset + stage.mouseX;			var snakeYgoal:int =  -yOffset + stage.mouseY;			snake.nose.x +=  (speed/maxSpeed)*(snakeXgoal - snake.nose.x) / 10;			snake.nose.y +=  (speed/maxSpeed)*(snakeYgoal - snake.nose.y) / 10;		}	}}