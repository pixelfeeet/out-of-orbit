package {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Character {

		private var _body:Spritemap;
		private var _speech:Speech;
		
		public var display:Graphiclist;
		private var legsMap:Spritemap;
		
		private var _state:String;
		
		private var input:Point
		private var xInput:int;
		private var yInput:int;
		private var debugFlying:Boolean;
		
		public function Player(_position:Point = null) {
			if (!_position) _position = new Point(0, 0);			
			super(_position, 100, 100);
			
			SPEED = 300;
			vSpeed = SPEED;
			JUMP = 580;
			
			//Input Definitions
			Input.define("Left", Key.A);
			Input.define("Right", Key.D);
			Input.define("Jump", Key.W);
			Input.define("Down", Key.S);
		}
		
		override public function added():void {
			super.added();
			type = "player";
			
			// Player
			_body = new Spritemap(Assets.PLAYER, 33, 57);
			_body.x = 0;
			_body.y = 0;
			
			_body.add("running", [0, 1, 2, 3, 4, 5], 18);
			_body.add("standing", [0]);	
			_body.add("jumping", [6]);
			
			// Speech
			_speech = new Speech();
			_speech.say("hello");
			
			display = new Graphiclist(_body, _speech);
			graphic = display;
			
			setHitbox(33, 57, 0, 0);
			
			layer = -500	
		}
		
		override public function update():void {
			super.update();
			
			updateState();
			updateMovement();
			updateGraphic();
			
			_speech.update();
			//checkForEnemyCollision();
			//updateSpeech();
		}

/*		private function onUse():void {
			var contents:Array;
			for (var i:int = 0; i < inventory.items.length; i++) {
				if (!inventory.items[i].active) continue;
				contents = inventory.items[i].contents;
				if (contents.length > 0) {
					contents[0].onUse();
					// This should be in the Inventory class
					if (contents[0].isStackable()) {
						contents.pop();
					}
				}
			}
		}*/
		
		protected function checkForEnemyCollision():void {
			/*var enemy:Enemy = collide("enemy", x, y) as Enemy;
			if (enemy) getHurt(10);*/
		}
		
		private function updateState():void {
			if (FP.sign(velocity.x) != 0) {
				_state = "running";
			} else {
				_state = "standing";
			}
		}

		override protected function updateGraphic():void {
			if (_state == "running") {
				_body.play("running");
			} else {
				_body.play("standing");
			}
			
			if (FP.sign(velocity.x) != 0) flipGraphic();
		}
		
		private function flipGraphic():void {
			for (var i:int = 0; i < display.count; i++) {
				// don't flip speech bubble
				if (i == display.count - 1) break;	
				Image(display.children[i]).flipped = (FP.sign(velocity.x) < 0);
			}			
		}
		
		public function facingLeft():Boolean {
			return Input.mouseX < x + halfWidth - FP.camera.x;
		}
		
		override protected function updateMovement():void {
			super.updateMovement();
			xInput = 0;
			yInput = 0;
			
			if (Input.check("Left")) xInput -= 1;
			if (Input.check("Right")) xInput += 1;
			
			defaultMovement();
			
			velocity.x = vSpeed * xInput;
		}
		
		private function defaultMovement():void {
			jump();
			vSpeed = SPEED;
			acceleration.y = Settings.GRAVITY;
			//Image(display.children[2]).color = 0xffffff; //debug
		}
		
		override protected function land():void {
			if (!onGround) {
				calcFallDamage(velocity.y);
				onGround = true;
			}
		}
		
		override protected function jump():void {
			if (Input.check("Jump") && onGround) {
				velocity.y = -JUMP;
				onGround = false;
			}
		}
		
		override protected function calcFallDamage(_v:int):void {
			var damageVelocity:int = 700;
			var totalDamage:int = 0;
			
			if (_v - damageVelocity > 0 ) {
				_v -= damageVelocity;
				while(_v > 0) {
					totalDamage += 5;
					_v -= 50;
				}
			}
			
			velocity.y = 0;
		}
	}
}