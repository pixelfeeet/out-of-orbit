package {
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Christopher Ferris
	 */
	public class Main extends Engine {
		
		public function Main() {
			super(Settings.CANVAS_WIDTH, Settings.CANVAS_HEIGHT, Settings.FRAMERATE, false);
			FP.world = new GameWorld();
		}
		
	}
	
}