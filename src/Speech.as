package {
	import flash.geom.Point;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Christopher Ferris
	 */
	public class Speech extends Text {
		
		// offset from Player's x and y coordinates
		private var _offset:Point;
		
		// # of ticks before the text disappears
		private var _timeout:int;
		
		private var _timer:int;
		
		// Alias variables
		private var _player:Player;
		
		public function Speech():void {
			_player = Registry.player_;
			
			_offset = new Point(0, -10);
			_timeout = 60;
			
			super("", _player.x + _offset.x, _player.y + _offset.y);
		}
		
		public function say(_text:String):void {
			text = _text;
			_timer = _timeout;
		}
		
		override public function update():void {
			super.update();
			if (_timer == 1) timeup();
			if (_timer > 0) _timer--;
		}
		
		private function timeup():void {
			text = "";
		}
		
	}
	
}