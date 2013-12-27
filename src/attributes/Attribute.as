package attributes {
	
	/**
	 * ...
	 * @author Christopher Ferris
	 */
	public class Attribute {
		
		protected var _character:Character;
		protected var _min:int;
		protected var _max:int;
		protected var _current:int;
		
		public function Attribute(character:Character, min:int = 0, max:int = 10) {
			_character = character;
			_min = min;
			_max = max;
			_current = _max;
		}
	
		public function change(value:int):void {
			if (value > 0) {
				if (_current < _max && _current + value <= _max) _current += value;
				else _current = _max;
			} else {
				if (_current > _min && _current + value > _min) _current += value;
				else _current = _min;
			}	
		}
		
		public function get min():int { return _min }
		public function get max():int { return _max }
		public function get current():int { return _current }
	}
	
}