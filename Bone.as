﻿package {	import flash.display.Sprite;	import flash.geom.Point;	public class Bone {		public var head:Sprite;		public var tail:Sprite;		public var len:Number;		protected var diffx:int;		protected var diffy:int;		public function Bone(head:Sprite, tail:Sprite) {			this.head = head;			this.tail = tail;			len = 20;		}		public function update():void {			diffx = head.x - tail.x;			diffy = head.y - tail.y;			followHead();			rotate();		}		private function distance():Number {						return Math.sqrt((diffx*diffx) + (diffy*diffy));		}		private function followHead():void {			var distance:Number = distance();						var movement:Number = distance - this.len;			movement = Math.floor(movement);			tail.x += (movement * diffx/distance)			tail.y += (movement * diffy/distance)		}		private function rotate():void {			tail.rotation = rotDegrees();		}		private function rotDegrees():Number {			var diffx:int = head.x - tail.x;			var diffy:int = head.y - tail.y;			return (Math.atan2(diffy, diffx)*57.2957795 +90);		}	}}