package  {
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	
	public class Background extends Entity {	
		private var _color:uint;

		// Aliases
		private var _tilesize:int;
		
		public function Background(color:uint) {
			super();
			
			_color = color;			
			_tilesize = Settings.TILESIZE;
		
			layer = 100;
			graphic = Image.createRect(Registry.level_.w * _tilesize, Registry.level_.h * _tilesize, _color);
		}
	}
}