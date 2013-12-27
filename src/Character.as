package{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	import attributes.Health;
	import attributes.Hunger;

	public class Character extends Entity {
		
		protected var SPEED:int;
		protected var JUMP:int;
		
		// Modified versions of the constans, e.g. by water or wind
		protected var vSpeed:int;
		protected var vGravity:int;
		protected var vJump:int;
		
		protected var acceleration:Point;
		public var velocity:Point;
		
		// Health
		protected var health:Health;
		protected var hunger:Hunger;

		protected var onGround:Boolean;
		
		protected var xSpeed:int;
		protected var ySpeed:int;
		
		public var lightRadius:int;
		
		// Alias variables
		protected var _tilesize:int;
		
		public function Character(_position:Point , _health:int = 100, _hunger:int = -1) {
			super();
			
			x = _position.x;
			y = _position.y;
			
			acceleration = new Point();
			velocity = new Point();
			
			vGravity = Settings.GRAVITY;
			vSpeed = SPEED;
			vJump = JUMP;

			onGround = false;
			
			//ESSENTIALS
			health = new Health(this, 0, _health, 60);
			hunger = new Hunger(this, 0, _hunger, 60);
			
			_tilesize = Settings.TILESIZE;			
		}
		
		override public function update():void {
			updateMovement();
			updateCollision();
			updateGraphic();
			
			if (health.max != -1) checkForDamage();
			if (hunger.max != -1) hunger.update();
			
			super.update();
		}
		
		protected function updateGraphic():void {}
		
		protected function updateCollision():void {

			//HORIZONTAL MOVEMENT
			x += velocity.x * FP.elapsed;
			
			if(collide("level", x, y)){
				if(FP.sign(velocity.x) > 0){
					//moving to the right
					velocity.x = 0;
					
					x = Math.floor(x / _tilesize) * _tilesize;
					while (!collide("level", x + 1, y)) x++;
				} else {
					//moving the left
					velocity.x = 0;
					x = Math.floor(x / _tilesize) * _tilesize + _tilesize;
				}
			}
			
			// VERTICAL MOVEMENT
			y += velocity.y * FP.elapsed;
			
			if(collide("level", x, y)){
				if (FP.sign(velocity.y) > 0){
					//moving down
					calcFallDamage(velocity.y);
					velocity.y = 0;
					y = Math.floor(y / _tilesize) * _tilesize;
					while (!collide("level", x, y + 1)) y++;
					
					if (!onGround) land();
				} else {
					//moving up
					velocity.y = 0;
					y = Math.floor(y / _tilesize) * _tilesize + _tilesize;
					onGround = false;
				}
			}
			
		}
		
		protected function land():void {
			onGround = true;
		}
		
		protected function calcFallDamage(_v:int):void { }

		/**
		 * TODO: if hunger is at 100, stay there for a while
		 * and regenerate the players health
		 */
		private function updateHunger():void {

		}
		
		protected function updateMovement():void{
			vGravity = Settings.GRAVITY;
			vSpeed = SPEED;
			vJump = JUMP;

			velocity.x = xSpeed;

			acceleration.y = Settings.GRAVITY;
			velocity.y += acceleration.y;
		}
		
		protected function checkForDamage():void {
			/*var bullet:Projectile = collide("bullet", x, y) as Projectile;
			
			if (bullet) {
				bullet.destroy();
				takeDamage(bullet.getDamagePoints());
			}*/
			
			/*if (player.meleeAttacking &&
				cLength(new Point(x, y), new Point(player.x, player.y)) < 100 &&
				this.type != "Player") {
				var dist:int = 0;
				if (player.facingLeft()) {
					dist = player.x - x;
					if (0 <= dist && dist < 100) takeDamage(player.weapon.getDamage());
				} else {
					dist = x - player.x;
					if (0 <= dist && dist < player.weapon.getRange()) takeDamage(player.weapon.getDamage());
				}
			}*/
			
		}
		
		//ACTIONS
		protected function jump():void {
			if (onGround){
				velocity.y = -JUMP;
				onGround = false;
			}
		}
		
		//ATTACK
		/*protected function shoot():void {
			var bullet_speed:int = 100;
			var initPos:Point = new Point(0,0);
			var destination:Point = new Point (x, y);
			var speed:Point = new Point(destination.x - initPos.x, destination.y - initPos.y);
			
			var len:Number = cLength(initPos, destination);
			speed.x = (speed.x / len) * bullet_speed;
			speed.y = (speed.y / len) * bullet_speed;
			FP.world.add(new Projectile(initPos.x, initPos.y, speed.x, speed.y));
		}*/
		
		public function takeDamage(damage:int):void{
			health.change(-damage);
		}
		
		// setter functions
		public function set position(p:Point):void {
			x = p.x;
			y = p.y;
		}

	}
}