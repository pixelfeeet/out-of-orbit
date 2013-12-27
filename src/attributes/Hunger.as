package attributes {
	/**
	 * ...
	 * @author Christopher Ferris
	 */
	public class Hunger extends Attribute {
		// Number of ticks between drops in hunger
		private var _timeout:int;
		
		// Number of ticks between health penalties
		// once health has dropped to zero
		private var _penaltyTimeout:int;
		
		private var _timer:int;
		
		public function Hunger(character:Character, min:int = 0, max:int = 10, timeout:int = 60, penaltyTimeout:int = 60) {
			super(character, min, max);
			_timeout = timeout;
			_penaltyTimeout = penaltyTimeout;
		}
		
		public function update():void {
			if (_timer == 1) timeup();
			if (_timer > 0) _timer--; 
		}
		
		private function timeup():void {
			_timer = _timeout;
			if (_current > _min) change(-1);
			else _character.takeDamage(10);			
		}
		
	}

}