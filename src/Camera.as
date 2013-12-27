package  {
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	public class Camera extends Entity {
		
		private var _speed:Point;
		private var _offset:Point;	
		private var _level:Level;
		
		// Alias variables
		private var _player:Player;
		private var _tilesize:int;
		
		public function Camera() {
			_offset = new Point(
				FP.screen.width * 0.4,
				FP.screen.height * 0.4
			);
		
			_player = Registry.player_;
			_tilesize = Settings.TILESIZE;
			_level = Registry.level_;
		}
		
		override public function added():void {
			adjustToPlayer();
		}
		
		override public function update():void {
			_speed = new Point(
				(_player.velocity.x * FP.elapsed) * FP.sign(_player.velocity.x),
				(_player.velocity.y * FP.elapsed) * FP.sign(_player.velocity.y)
			);
			
			followPlayer();
		}
		
		public function followPlayer():void {
			// Horizontal scrolling
			if(_player.x - FP.camera.x < _offset.x) {
				if (FP.camera.x > 0) FP.camera.x -= _speed.x;
			} else if ((FP.camera.x + FP.width) - (_player.x + _player.width) < _offset.x) {
				if (FP.camera.x + FP.width < _level.w * _tilesize) FP.camera.x += _speed.x;
			}
			
			// Vertical scrolling
			if (_player.y - FP.camera.y < _offset.y) {
				if (FP.camera.y > 0) FP.camera.y -= _speed.y;
			} else if ((FP.camera.y + FP.height) - (_player.y + _player.height) < _offset.y) {
				if (FP.camera.y + FP.height < _level.h * _tilesize) FP.camera.y += _speed.y;
			}
		}
		
		public function adjustToPlayer():void {
			var newCoordinates:Point = new Point(
				(_player.x + _player.width / 2) - FP.width / 2,
				(_player.y + _player.height/2) - FP.height / 2
			);
			
			// Make sure camera doesn't go outside of level bounds
			// x
			if (newCoordinates.x < 0) newCoordinates.x = 0;
			else if (newCoordinates.x + FP.width > _level.w * _tilesize) newCoordinates.x = _level.w * _tilesize - FP.width;

			// y
			if (newCoordinates.y < 0) newCoordinates.y = 0;
			else if (newCoordinates.y + FP.height > _level.h * _tilesize) newCoordinates.y = _level.h * _tilesize - FP.height;
			
			FP.camera.x = newCoordinates.x;
			FP.camera.y = newCoordinates.y;
		}
	}
}