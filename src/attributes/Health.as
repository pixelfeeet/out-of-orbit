package attributes {
	/**
	 * ...
	 * @author Christopher Ferris
	 */
	public class Health extends Attribute {
		
		private var _locked:Boolean;
		
		private var _timer:int;

		// Number of ticks after the Character gets hurt that
		// no damage will be inflicted		
		private var _timeout:int;
		
		public function Health(character:Character, min:int = 0, max:int = 10, timeout:int = 0) {
			super(character, min, max);
			_locked = false;
			_timeout = timeout;
		}
		
		public function update():void {
			if (_timer == 1) timeup();
			if (_timer > 0) _timer--;
		}
		
		public function takeDamage(amount:int):void {
			if (_locked) return;
			
			change(amount);
			_locked = true;
		}
		
		private function timeup():void {
			_locked = false;
		}
		
		public function get locked():Boolean { return _locked }
	}

}