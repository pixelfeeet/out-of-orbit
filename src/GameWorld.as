package {
	import net.flashpunk.World;
	/**
	 * ...
	 * @author Christopher Ferris
	 */
	public class GameWorld extends World {
		
		public function GameWorld():void {
			Registry.level_ = new Level();
			add(Registry.level_);
		}
	}
	
}